from __future__ import annotations

import json
import os
from pathlib import Path
import subprocess
from typing import Any

import gymnasium as gym
import numpy as np


PROTOCOL_PREFIX = "PPO_JSON\t"
DEFAULT_OBSERVATION_HISTORY_LENGTH = 8
OBSERVATION_BASE_DIM = 108
OBSERVATION_HISTORY_STEP_DIM = 6


def observation_dimension(history_length: int) -> int:
    history_length = int(history_length)
    if history_length < 1:
        raise ValueError("observation history length must be a positive integer")
    return OBSERVATION_BASE_DIM + OBSERVATION_HISTORY_STEP_DIM * history_length


# Retain the historical public constant for callers using the frozen default.
OBSERVATION_DIM = observation_dimension(DEFAULT_OBSERVATION_HISTORY_LENGTH)


class JuliaWorkerError(RuntimeError):
    """Raised when the persistent Julia CFD worker exits or violates protocol."""


class JuliaDogfishEnv(gym.Env[np.ndarray, np.ndarray]):
    metadata = {"render_modes": []}

    def __init__(
        self,
        *,
        testbed_root: str | Path,
        config_path: str | Path,
        output_root: str | Path,
        worker_id: int,
        gpu_id: str,
        rollout_horizon: float,
        episode_offset: int = 0,
        action_mode: str = "residual",
        emit_seed_action: bool = False,
        action_repeat: int = 1,
        observation_history_length: int = DEFAULT_OBSERVATION_HISTORY_LENGTH,
        julia_bin: str = "julia",
        worker_script: str | Path | None = None,
        policy_bridge: str | Path | None = None,
        seed_policy: str | Path | None = None,
    ) -> None:
        super().__init__()
        self.testbed_root = Path(testbed_root).resolve()
        self.config_path = Path(config_path).resolve()
        self.output_root = Path(output_root).resolve()
        self.worker_id = int(worker_id)
        self.gpu_id = str(gpu_id)
        self.rollout_horizon = float(rollout_horizon)
        self.action_mode = str(action_mode).lower()
        if self.action_mode not in {"residual", "absolute"}:
            raise ValueError(
                f"action mode must be 'residual' or 'absolute', got {action_mode!r}"
            )
        self.emit_seed_action = bool(emit_seed_action)
        self.action_repeat = int(action_repeat)
        if self.action_repeat < 1:
            raise ValueError("action repeat must be a positive integer")
        self.observation_history_length = int(observation_history_length)
        self.observation_dim = observation_dimension(
            self.observation_history_length
        )
        self.julia_bin = str(julia_bin)
        experiment_root = Path(__file__).resolve().parents[1]
        self.worker_script = Path(
            worker_script or experiment_root / "julia" / "ppo_env_worker.jl"
        ).resolve()
        self.policy_bridge = Path(
            policy_bridge or experiment_root / "julia" / "residual_policy_bridge.jl"
        ).resolve()
        self.seed_policy = Path(
            seed_policy
            or self.testbed_root
            / "cases"
            / "dogfish_2d_shape_policy"
            / "candidate_target_policy.jl"
        ).resolve()

        self.action_space = gym.spaces.Box(-1.0, 1.0, shape=(2,), dtype=np.float32)
        self.observation_space = gym.spaces.Box(
            low=-np.inf,
            high=np.inf,
            shape=(self.observation_dim,),
            dtype=np.float32,
        )
        self._process: subprocess.Popen[str] | None = None
        self._stderr_handle: Any = None
        self._episode = int(episode_offset)
        if self._episode < 0:
            raise ValueError("episode offset cannot be negative")
        self._last_observation = np.zeros(self.observation_dim, dtype=np.float32)
        self._observation_names: tuple[str, ...] | None = None
        self._teacher_action_normalized: np.ndarray | None = None
        self._idle = True
        self._episode_policy_steps = 0

    def _worker_environment(self) -> dict[str, str]:
        environment = os.environ.copy()
        environment.update(
            {
                "CUDA_VISIBLE_DEVICES": self.gpu_id,
                "PPO_TESTBED_ROOT": str(self.testbed_root),
                "DOGFISH_MEMORY_BACKEND": "cuda"
                if self.gpu_id not in {"", "-1", "cpu"}
                else "cpu",
                "DOGFISH_MULTIWAKE_TARGET_CONFIG": str(self.config_path),
                "DOGFISH_TARGET_POLICY_PATH": str(self.policy_bridge),
                # The episode runner owns the CFD horizon while the policy
                # bridge uses the same value to normalize dense rewards.  Set
                # both names here so every caller, including BC collection and
                # smoke jobs, advances exactly the requested physical horizon.
                "DOGFISH_WAKE_HORIZON": str(self.rollout_horizon),
                "PPO_SEED_POLICY_PATH": str(self.seed_policy),
                "PPO_ROLLOUT_HORIZON": str(self.rollout_horizon),
                "PPO_WORKER_ID": str(self.worker_id),
                "PPO_ACTION_MODE": self.action_mode,
                "PPO_EMIT_SEED_ACTION": "1" if self.emit_seed_action else "0",
                "DOGFISH_WAKE_OBSERVATION_HISTORY_LENGTH": str(
                    self.observation_history_length
                ),
                "PPO_OBSERVATION_HISTORY_LENGTH": str(
                    self.observation_history_length
                ),
            }
        )
        return environment

    def _start_worker(self) -> None:
        if self._process is not None:
            return
        self.output_root.mkdir(parents=True, exist_ok=True)
        stderr_path = self.output_root / f"worker_{self.worker_id:02d}.stderr.log"
        self._stderr_handle = stderr_path.open("a", encoding="utf-8")
        julia_project = os.environ.get("PPO_JULIA_PROJECT", str(Path(__file__).resolve().parents[1] / "environment"))
        command = [
            self.julia_bin,
            f"--project={julia_project}",
            "--startup-file=no",
            str(self.worker_script),
        ]
        self._process = subprocess.Popen(
            command,
            cwd=self.testbed_root,
            env=self._worker_environment(),
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=self._stderr_handle,
            text=True,
            encoding="utf-8",
            errors="replace",
            bufsize=1,
        )
        ready = self._read_event(expected_type="ready")
        if int(ready.get("observation_dim", -1)) != self.observation_dim:
            raise JuliaWorkerError(
                "Julia/Python observation dimensions disagree: "
                f"{ready.get('observation_dim')} != {self.observation_dim}"
            )
        if (
            int(ready.get("observation_history_length", -1))
            != self.observation_history_length
        ):
            raise JuliaWorkerError(
                "Julia/Python observation history lengths disagree: "
                f"{ready.get('observation_history_length')} != "
                f"{self.observation_history_length}"
            )
        runtime_metadata = {
            "schema_version": "agent-fluid.ppo-worker-runtime.v1",
            "worker_id": self.worker_id,
            "gpu_id": self.gpu_id,
            "action_mode": ready.get("action_mode"),
            "seed_policy_loaded": ready.get("seed_policy_loaded"),
            "seed_action_emitted": ready.get("seed_action_emitted"),
            "action_repeat": self.action_repeat,
            "observation_history_length": int(
                ready["observation_history_length"]
            ),
            "observation_dim": int(ready["observation_dim"]),
        }
        (self.output_root / "worker_runtime.json").write_text(
            json.dumps(runtime_metadata, indent=2, sort_keys=True) + "\n",
            encoding="utf-8",
        )

    def _send(self, payload: dict[str, Any]) -> None:
        if self._process is None or self._process.stdin is None:
            raise JuliaWorkerError("Julia worker is not running")
        self._process.stdin.write(json.dumps(payload, separators=(",", ":")) + "\n")
        self._process.stdin.flush()

    def _read_event(self, *, expected_type: str | None = None) -> dict[str, Any]:
        if self._process is None or self._process.stdout is None:
            raise JuliaWorkerError("Julia worker is not running")
        while True:
            line = self._process.stdout.readline()
            if line == "":
                return_code = self._process.poll()
                raise JuliaWorkerError(
                    f"Julia worker {self.worker_id} closed stdout (return code {return_code})"
                )
            if not line.startswith(PROTOCOL_PREFIX):
                continue
            try:
                event = json.loads(line[len(PROTOCOL_PREFIX) :])
            except json.JSONDecodeError as error:
                raise JuliaWorkerError(f"invalid Julia protocol line: {line!r}") from error
            event_type = event.get("type")
            if expected_type is not None and event_type != expected_type:
                raise JuliaWorkerError(
                    f"expected Julia event {expected_type!r}, received "
                    f"{event_type!r}: {event}"
                )
            return event

    def _observation_from_event(self, event: dict[str, Any]) -> np.ndarray:
        observation = np.asarray(event["observation"], dtype=np.float32)
        if observation.shape != (self.observation_dim,):
            raise JuliaWorkerError(
                f"worker returned observation shape {observation.shape}, "
                f"expected {(self.observation_dim,)}"
            )
        if not np.isfinite(observation).all():
            raise JuliaWorkerError("worker returned a non-finite observation")
        names = event.get("observation_names")
        if names is not None:
            if len(names) != self.observation_dim:
                raise JuliaWorkerError("observation name count does not match vector length")
            names_tuple = tuple(str(name) for name in names)
            if self._observation_names is None:
                self._observation_names = names_tuple
            elif self._observation_names != names_tuple:
                raise JuliaWorkerError("observation schema changed between episodes")
        self._last_observation = observation
        teacher_action = event.get("seed_action_normalized")
        if teacher_action is None:
            self._teacher_action_normalized = None
        else:
            teacher_array = np.asarray(teacher_action, dtype=np.float32)
            if teacher_array.shape != (2,) or not np.isfinite(teacher_array).all():
                raise JuliaWorkerError("worker returned an invalid seed action")
            self._teacher_action_normalized = np.clip(teacher_array, -1.0, 1.0)
        return observation

    def teacher_action_normalized(self) -> np.ndarray:
        if self._teacher_action_normalized is None:
            raise JuliaWorkerError(
                "seed action is unavailable; construct the environment with "
                "emit_seed_action=True"
            )
        return self._teacher_action_normalized.copy()

    def reset(
        self,
        *,
        seed: int | None = None,
        options: dict[str, Any] | None = None,
    ) -> tuple[np.ndarray, dict[str, Any]]:
        super().reset(seed=seed)
        self._start_worker()
        self._episode += 1
        episode_root = self.output_root / f"episode_{self._episode:06d}"
        self._send(
            {
                "type": "reset",
                "episode": self._episode,
                "seed": seed,
                "output_root": str(episode_root),
            }
        )
        event = self._read_event(expected_type="observation")
        self._idle = False
        self._episode_policy_steps = 0
        observation = self._observation_from_event(event)
        return observation, {
            "worker_id": self.worker_id,
            "worker_episode": self._episode,
            "distance_L": event.get("distance_L"),
        }

    def step(
        self, action: np.ndarray
    ) -> tuple[np.ndarray, float, bool, bool, dict[str, Any]]:
        action_array = np.asarray(action, dtype=np.float32)
        if action_array.shape != (2,):
            raise ValueError(f"expected action shape (2,), received {action_array.shape}")
        action_array = np.clip(action_array, self.action_space.low, self.action_space.high)
        self._episode_policy_steps += 1
        reward_sum = 0.0
        for cfd_steps_advanced in range(1, self.action_repeat + 1):
            self._send({"type": "action", "action": action_array.tolist()})
            event = self._read_event()
            event_type = event.get("type")
            reward_sum += float(event.get("reward", 0.0))
            if event_type == "observation":
                observation = self._observation_from_event(event)
                if cfd_steps_advanced < self.action_repeat:
                    continue
                return observation, reward_sum, False, False, {
                    "worker_id": self.worker_id,
                    "worker_episode": self._episode,
                    "distance_L": event.get("distance_L"),
                    "simulation_time": event.get("time"),
                    "action_repeat": self.action_repeat,
                    "cfd_steps_advanced": cfd_steps_advanced,
                    "policy_steps": self._episode_policy_steps,
                }
            if event_type == "terminal":
                self._idle = True
                info = dict(event)
                info.pop("type", None)
                info["worker_id"] = self.worker_id
                info["worker_episode"] = self._episode
                info["is_success"] = bool(event.get("target_reached", False))
                info["action_repeat"] = self.action_repeat
                info["cfd_steps_advanced"] = cfd_steps_advanced
                info["policy_steps"] = self._episode_policy_steps
                cfd_step_count = int(
                    info.get("action_count") or info.get("steps") or 0
                )
                if cfd_step_count > 0:
                    info["realized_cfd_steps_per_policy_step"] = (
                        cfd_step_count / self._episode_policy_steps
                    )
                # The paper's score defines a finite episodic task. Treat all
                # final states as terminal so SB3 does not bootstrap beyond the
                # horizon. Rewards from held CFD substeps are undiscounted here;
                # PPO applies one discount per policy decision.
                return self._last_observation.copy(), reward_sum, True, False, info
            raise JuliaWorkerError(f"unexpected Julia event type {event_type!r}")
        raise AssertionError("positive action repeat produced no environment event")

    def close(self) -> None:
        process = self._process
        if process is None:
            return
        try:
            if process.poll() is None and self._idle:
                self._send({"type": "close"})
                process.wait(timeout=10)
            elif process.poll() is None:
                process.terminate()
                process.wait(timeout=10)
        except (BrokenPipeError, OSError, subprocess.TimeoutExpired):
            if process.poll() is None:
                process.kill()
                try:
                    process.wait(timeout=10)
                except subprocess.TimeoutExpired:
                    pass
        finally:
            if process.stdin is not None:
                try:
                    process.stdin.close()
                except OSError:
                    pass
            if process.stdout is not None:
                try:
                    process.stdout.close()
                except OSError:
                    pass
            if self._stderr_handle is not None:
                self._stderr_handle.close()
            self._process = None
            self._stderr_handle = None
