from __future__ import annotations

from datetime import datetime, timezone
import json
from pathlib import Path
import time
from typing import Any

from stable_baselines3.common.callbacks import BaseCallback
from stable_baselines3.common.vec_env import VecNormalize

from .checkpointing import save_checkpoint


class EpisodeBudgetCallback(BaseCallback):
    def __init__(
        self,
        *,
        episode_budget: int,
        checkpoint_interval: int,
        output_root: str | Path,
        completed_episodes: int = 0,
        cfd_episodes_consumed: int = 0,
        prior_training_wall_time_s: float = 0.0,
        attempt_wall_start: float | None = None,
        worker_episode_counts: dict[int, int] | None = None,
        verbose: int = 1,
    ) -> None:
        super().__init__(verbose=verbose)
        self.episode_budget = int(episode_budget)
        self.checkpoint_interval = int(checkpoint_interval)
        self.output_root = Path(output_root)
        if self.episode_budget < 1 or self.checkpoint_interval < 1:
            raise ValueError("episode budget and checkpoint interval must be positive")
        self.completed_episodes = int(completed_episodes)
        self.cfd_episodes_consumed = int(cfd_episodes_consumed)
        self.prior_training_wall_time_s = float(prior_training_wall_time_s)
        self.training_wall_start = attempt_wall_start
        self.worker_episode_counts = dict(worker_episode_counts or {})
        self.next_checkpoint = (
            (self.completed_episodes // self.checkpoint_interval) + 1
        ) * self.checkpoint_interval
        self.episode_log = self.output_root / "episodes.jsonl"
        self.checkpoint_root = self.output_root / "checkpoints"

    def _on_training_start(self) -> None:
        self.output_root.mkdir(parents=True, exist_ok=True)
        self.checkpoint_root.mkdir(parents=True, exist_ok=True)
        if self.training_wall_start is None:
            self.training_wall_start = time.perf_counter()

    def _training_wall_time_s(self) -> float:
        if self.training_wall_start is None:
            return self.prior_training_wall_time_s
        return self.prior_training_wall_time_s + (
            time.perf_counter() - self.training_wall_start
        )

    def _save_checkpoint(self, label: str) -> Path:
        environment = self.model.get_env()
        if not isinstance(environment, VecNormalize):
            raise TypeError("PPO checkpoint requires a VecNormalize environment")
        return save_checkpoint(
            model=self.model,
            environment=environment,
            checkpoint_root=self.checkpoint_root,
            label=label,
            completed_episodes=self.completed_episodes,
            cfd_episodes_consumed=self.cfd_episodes_consumed,
            training_wall_time_s=self._training_wall_time_s(),
            next_checkpoint_episode=self.next_checkpoint,
            worker_episode_counts=self.worker_episode_counts,
        )

    def _write_episode(self, info: dict[str, Any]) -> None:
        record = {
            "completed_episode": self.completed_episodes,
            "training_episode": self.completed_episodes,
            "cfd_episode_total": self.cfd_episodes_consumed,
            "training_wall_time_s": self._training_wall_time_s(),
            "timestamp_utc": datetime.now(timezone.utc).isoformat(),
            "training_timesteps": int(self.num_timesteps),
            "worker_id": info.get("worker_id"),
            "worker_episode": info.get("worker_episode"),
            "raw_score": info.get("raw_score"),
            "shifted_score": info.get("shifted_score"),
            "distance_integral_score": info.get("distance_integral_score"),
            "target_reached": info.get("target_reached"),
            "termination": info.get("termination"),
            "release_elapsed": info.get("release_elapsed"),
            "cfd_steps": info.get("steps"),
            "action_count": info.get("action_count"),
            "action_repeat": info.get("action_repeat", 1),
            "policy_steps": info.get("policy_steps"),
            "realized_cfd_steps_per_policy_step": info.get(
                "realized_cfd_steps_per_policy_step"
            ),
        }
        with self.episode_log.open("a", encoding="utf-8") as handle:
            handle.write(json.dumps(record, sort_keys=True) + "\n")

    def _on_step(self) -> bool:
        dones = self.locals.get("dones", ())
        infos = self.locals.get("infos", ())
        # All vector environments have already advanced when the callback is
        # entered. Capture every completed worker episode before an interval
        # checkpoint is written so a crash cannot make resumed workers reuse
        # an existing CFD output directory.
        for done, info in zip(dones, infos, strict=False):
            if not bool(done):
                continue
            worker_id = int(info.get("worker_id", -1))
            worker_episode = int(info.get("worker_episode", 0))
            if worker_id >= 0:
                self.worker_episode_counts[worker_id] = max(
                    worker_episode,
                    self.worker_episode_counts.get(worker_id, 0),
                )
        for done, info in zip(dones, infos, strict=False):
            if not bool(done):
                continue
            self.completed_episodes += 1
            self.cfd_episodes_consumed += 1
            self._write_episode(dict(info))
            while self.completed_episodes >= self.next_checkpoint:
                # Save at the requested episode boundary. PPO parameters and
                # optimizer state are stable during rollout collection. A
                # resumed run intentionally discards only the unfinished
                # rollout buffer and restarts CFD from the shared prewarm.
                checkpoint_episode = self.next_checkpoint
                self.next_checkpoint += self.checkpoint_interval
                self._save_checkpoint(f"episode_{checkpoint_episode:04d}")
        return self.completed_episodes < self.episode_budget

    def _on_training_end(self) -> None:
        self._save_checkpoint(f"episode_{self.completed_episodes:04d}_final")
