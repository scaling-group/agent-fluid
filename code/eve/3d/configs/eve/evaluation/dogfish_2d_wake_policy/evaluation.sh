#!/usr/bin/env bash
set -euo pipefail
umask 0002

_wake_eval_script_source="${BASH_SOURCE[0]}"
if [[ "$_wake_eval_script_source" != /* ]]; then
    _wake_eval_script_source="$PWD/$_wake_eval_script_source"
fi
_wake_eval_script_dir="$(cd "$(dirname "$_wake_eval_script_source")" && pwd)"
_wake_visual_builder="$_wake_eval_script_dir/build_visual_observation.py"
_wake_policy_param_guard="$_wake_eval_script_dir/check_candidate_policy_params.py"
_wake_pbs_queue_selector="$_wake_eval_script_dir/select_pbs_queue.py"
_wake_failure_penalty_normalizer="$_wake_eval_script_dir/normalize_failure_penalty_summary.py"

: "${EVE_WORKSPACE_ROOT:?EVE_WORKSPACE_ROOT is required}"
: "${EVE_SOLVER_ROOT:?EVE_SOLVER_ROOT is required}"
: "${EVE_EVAL_LOG_ROOT:?EVE_EVAL_LOG_ROOT is required}"

# Keep heavy CFD output out of logs/evaluate. Latest core extracts that log
# tree into lineage storage, while evaluation_workspaces remain available for
# archival videos, trajectories, VTK fields, and raw runtime logs.
wake_artifact_root="$EVE_WORKSPACE_ROOT/artifacts/wake_episode"
runtime_root="$wake_artifact_root/runtime"
mkdir -p "$EVE_EVAL_LOG_ROOT" "$runtime_root"
export DOGFISH_WAKE_OUTPUT_ROOT="$wake_artifact_root"

score_path="$EVE_EVAL_LOG_ROOT/score.yaml"
score_json_path="$EVE_EVAL_LOG_ROOT/score.json"
error_path="$EVE_EVAL_LOG_ROOT/error.txt"
run_stdout="$runtime_root/wake_episode.stdout.log"
run_stderr="$runtime_root/wake_episode.stderr.log"
pbs_stdout="$runtime_root/wake_pbs_child.stdout.log"
pbs_stderr="$runtime_root/wake_pbs_child.stderr.log"
pbs_exit_status="$runtime_root/wake_pbs_child.exit_status"
visual_stdout="$runtime_root/wake_visual_observation.stdout.log"
visual_stderr="$runtime_root/wake_visual_observation.stderr.log"
policy_contract_stdout="$runtime_root/policy_param_contract.stdout.log"
policy_contract_stderr="$runtime_root/policy_param_contract.stderr.log"
penalty_normalization_stdout="$runtime_root/failure_penalty_normalization.stdout.log"
penalty_normalization_stderr="$runtime_root/failure_penalty_normalization.stderr.log"
penalty_normalization_provenance="$runtime_root/failure_penalty_normalization.json"
raw_main_summary="$runtime_root/summary.main_raw.json"

write_failure_score() {
    local summary="$1"
    printf 'score: -100.0\nsummary: "%s"\n' "$summary" >"$score_path"
}

on_exit() {
    local rc="$?"
    if [[ "$rc" -ne 0 && ! -s "$score_path" ]]; then
        write_failure_score "wake evaluation command failed"
        {
            printf 'wake evaluation failed with exit code %s\n' "$rc"
            if [[ -s "$run_stderr" ]]; then
                printf '\n--- stderr tail ---\n'
                tail -n 100 "$run_stderr"
            fi
        } >"$error_path"
    fi
}
trap on_exit EXIT

# Reject structurally invalid candidates before a PBS child or CFD rollout is
# created. This invokes Julia only to enumerate target_policy_params() fields;
# it does not execute target_policy or instantiate the CFD environment.
candidate_policy="$EVE_SOLVER_ROOT/cases/dogfish_2d_shape_policy/candidate_target_policy.jl"
contract_julia_bin="${JULIA_BIN:-${EVE_EVAL_PBS_JULIA_BIN:-julia}}"
if "${PYTHON:-python3}" "$_wake_policy_param_guard" \
    --policy "$candidate_policy" \
    --julia-bin "$contract_julia_bin" \
    >"$policy_contract_stdout" 2>"$policy_contract_stderr"; then
    echo "Candidate policy parameter contract passed"
else
    rc="$?"
    write_failure_score "candidate policy parameter contract failed"
    {
        printf 'candidate policy parameter contract failed with exit code %s\n' "$rc"
        if [[ -s "$policy_contract_stderr" ]]; then
            printf '\n--- contract stderr ---\n'
            cat "$policy_contract_stderr"
        fi
        if [[ -s "$policy_contract_stdout" ]]; then
            printf '\n--- contract stdout ---\n'
            cat "$policy_contract_stdout"
        fi
    } >"$error_path"
    exit 0
fi

if [[ "${DOGFISH_WAKE_PBS_EVAL:-0}" == "1" && "${DOGFISH_WAKE_PBS_CHILD:-0}" != "1" ]]; then
    pbs_project="${EVE_EVAL_PBS_PROJECT:?Set EVE_EVAL_PBS_PROJECT}"
    pbs_queue_primary="${EVE_EVAL_PBS_QUEUE:?Set EVE_EVAL_PBS_QUEUE}"
    pbs_queue_secondary="${EVE_EVAL_PBS_QUEUE_SECONDARY:-}"
    pbs_select="${EVE_EVAL_PBS_SELECT:-select=1:ncpus=8:mem=64gb:ngpus=1:gpu_model=H100}"
    pbs_walltime="${EVE_EVAL_PBS_WALLTIME:-01:00:00}"
    pbs_poll_s="${EVE_EVAL_PBS_POLL_S:-30}"
    pbs_julia_bin="${EVE_EVAL_PBS_JULIA_BIN:-julia}"
    pbs_julia_depot_path="${EVE_EVAL_PBS_JULIA_DEPOT_PATH:-${JULIA_DEPOT_PATH:-${HOME}/.julia}}"
    workspace_token="$(basename "$EVE_WORKSPACE_ROOT" | cksum | awk '{print $1}')"
    pbs_name="$(printf 'wake-%s' "$workspace_token" | cut -c1-15)"
    pbs_script="$runtime_root/wake_pbs_eval.pbs"
    pbs_job_id_path="$runtime_root/wake_pbs_job_id.txt"
    pbs_queue_audit="$runtime_root/wake_pbs_queue.json"
    queue_selector_args=(
        --primary "$pbs_queue_primary"
        --state-root "$(dirname "$EVE_WORKSPACE_ROOT")"
        --audit-path "$pbs_queue_audit"
    )
    if [[ -n "$pbs_queue_secondary" ]]; then
        queue_selector_args+=(--secondary "$pbs_queue_secondary")
    fi
    pbs_queue="$("${PYTHON:-python3}" "$_wake_pbs_queue_selector" "${queue_selector_args[@]}")"
    echo "Selected wake PBS route queue $pbs_queue for $EVE_WORKSPACE_ROOT"

    cat >"$pbs_script" <<EOF
#!/bin/bash
#PBS -P $pbs_project
#PBS -q $pbs_queue
#PBS -N $pbs_name
#PBS -l $pbs_select
#PBS -l walltime=$pbs_walltime
#PBS -j oe
#PBS -k oed
#PBS -W umask=0002

set -uo pipefail
umask 0002
export PATH="\$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/pbs/bin:\$PATH"
unset LD_LIBRARY_PATH
export JULIA_BIN="$pbs_julia_bin"
export JULIA_DEPOT_PATH="$pbs_julia_depot_path"

export EVE_WORKSPACE_ROOT="$EVE_WORKSPACE_ROOT"
export EVE_SOLVER_ROOT="$EVE_SOLVER_ROOT"
export EVE_EVAL_LOG_ROOT="$EVE_EVAL_LOG_ROOT"
export DOGFISH_WAKE_OUTPUT_ROOT="$wake_artifact_root"
export DOGFISH_WAKE_PBS_EVAL=0
export DOGFISH_WAKE_PBS_CHILD=1
export DOGFISH_MEMORY_BACKEND="${DOGFISH_MEMORY_BACKEND:-cuda}"
export DOGFISH_FREE_SWIM_WAKE_CONFIG="${DOGFISH_FREE_SWIM_WAKE_CONFIG:-configs/free_swim_multiwake_target_eve_l64.toml}"
export JULIA_NUM_THREADS="${JULIA_NUM_THREADS:-4}"
export PYTHON="${PYTHON:-python3}"
EOF

    while IFS='=' read -r name value; do
        case "$name" in
            DOGFISH_WAKE_PBS_EVAL|DOGFISH_WAKE_PBS_CHILD|DOGFISH_WAKE_OUTPUT_ROOT)
                continue
                ;;
        esac
        if [[ "$name" == DOGFISH_WAKE_* || "$name" == DOGFISH_FREE_SWIM_* ]]; then
            printf 'export %s=%q\n' "$name" "$value" >>"$pbs_script"
        fi
    done < <(env)

    cat >>"$pbs_script" <<EOF
cd "$EVE_WORKSPACE_ROOT"
set +e
bash "$0" >"$pbs_stdout" 2>"$pbs_stderr"
rc=\$?
printf '%s\n' "\$rc" >"$pbs_exit_status"
exit "\$rc"
EOF

    job_id="$(qsub "$pbs_script")"
    printf '%s\n' "$job_id" >"$pbs_job_id_path"
    echo "Submitted wake PBS evaluation job $job_id for $EVE_WORKSPACE_ROOT"

    cleanup_child_job() {
        qdel "$job_id" >/dev/null 2>&1 || true
    }
    trap cleanup_child_job INT TERM

    while qstat "$job_id" >/dev/null 2>&1; do
        sleep "$pbs_poll_s"
    done

    for _ in 1 2 3 4 5; do
        [[ -s "$pbs_exit_status" || -s "$score_path" ]] && break
        sleep 2
    done

    if [[ ! -s "$score_path" ]]; then
        write_failure_score "wake PBS evaluation did not produce score.yaml"
        {
            printf 'wake PBS evaluation job %s finished without score.yaml\n' "$job_id"
            if [[ -s "$pbs_exit_status" ]]; then
                printf 'child exit status: '
                cat "$pbs_exit_status"
            fi
            if [[ -s "$pbs_stderr" ]]; then
                printf '\n--- child stderr tail ---\n'
                tail -n 100 "$pbs_stderr"
            fi
        } >"$error_path"
    fi
    exit 0
fi

cd "$EVE_SOLVER_ROOT"

julia_bin="${JULIA_BIN:-julia}"
"$julia_bin" --project=. --startup-file=no -e "using Pkg; Pkg.instantiate()"

export DOGFISH_FREE_SWIM_WAKE_CONFIG="${DOGFISH_FREE_SWIM_WAKE_CONFIG:-configs/free_swim_multiwake_target_eve_l64.toml}"

if "$julia_bin" --project=. --startup-file=no cases/dogfish_2d_shape_policy/free_swim_wake_episode.jl >"$run_stdout" 2>"$run_stderr"; then
    echo "Wake episode completed; heavy artifacts: $wake_artifact_root"
else
    rc="$?"
    write_failure_score "wake episode failed"
    {
        printf 'wake episode failed with exit code %s\n' "$rc"
        if [[ -s "$run_stderr" ]]; then
            printf '\n--- stderr tail ---\n'
            tail -n 100 "$run_stderr"
        fi
    } >"$error_path"
    exit 0
fi

if "${PYTHON:-python3}" "$_wake_visual_builder" \
    --solver-root "$EVE_SOLVER_ROOT" \
    --artifact-root "$wake_artifact_root" \
    --observation-dir "$EVE_EVAL_LOG_ROOT/agent_observation" \
    --mode episode >"$visual_stdout" 2>"$visual_stderr"; then
    echo "Wake visual observation completed: $EVE_EVAL_LOG_ROOT/agent_observation"
else
    rc="$?"
    write_failure_score "wake visual artifact generation failed"
    {
        printf 'wake visual artifact generation failed with exit code %s\n' "$rc"
        if [[ -s "$visual_stderr" ]]; then
            printf '\n--- visual stderr tail ---\n'
            tail -n 100 "$visual_stderr"
        fi
    } >"$error_path"
    exit 0
fi

if "${PYTHON:-python3}" "$_wake_failure_penalty_normalizer" \
    --summary "$wake_artifact_root/summary.json" \
    --raw-copy "$raw_main_summary" \
    --provenance "$penalty_normalization_provenance" \
    >"$penalty_normalization_stdout" 2>"$penalty_normalization_stderr"; then
    echo "Wake failure-penalty contract normalized"
else
    rc="$?"
    write_failure_score "wake failure-penalty normalization failed"
    {
        printf 'wake failure-penalty normalization failed with exit code %s\n' "$rc"
        if [[ -s "$penalty_normalization_stderr" ]]; then
            printf '\n--- normalization stderr ---\n'
            cat "$penalty_normalization_stderr"
        fi
    } >"$error_path"
    exit 0
fi

"${PYTHON:-python3}" - "$wake_artifact_root/summary.json" "$score_path" "$score_json_path" "$error_path" <<'PY'
import csv
import json
import math
import os
import sys
from pathlib import Path

summary_path = Path(sys.argv[1])
score_path = Path(sys.argv[2])
score_json_path = Path(sys.argv[3])
error_path = Path(sys.argv[4])

try:
    summary = json.loads(summary_path.read_text(encoding="utf-8"))
    policy_params_source = summary.get("policy_params_source")
    if policy_params_source != "candidate_target_policy":
        raise ValueError(
            "wake episode did not use candidate-owned policy parameters: "
            f"{policy_params_source!r}"
        )
    if not isinstance(summary.get("policy_params"), dict):
        raise ValueError(
            "wake episode did not report effective candidate policy parameters"
        )
    penalty_semantics = summary.get("failure_penalty_semantics_version")
    if penalty_semantics != "dogfish.wake_failure_penalties.v1":
        raise ValueError(
            "wake episode did not apply the registered failure-penalty contract: "
            f"{penalty_semantics!r}"
        )
    termination = str(summary.get("termination") or "")
    if termination == "wall_time_limit":
        raise ValueError(
            "wake episode reached an infrastructure wall-time limit; rerun it "
            "instead of treating it as a scientific horizon miss"
        )
    score = float(summary["score"])
    if not math.isfinite(score):
        raise ValueError(f"non-finite score: {score!r}")
except Exception as exc:  # noqa: BLE001
    score_path.write_text(
        "score: -100.0\nsummary: failed to parse wake summary\n", encoding="utf-8"
    )
    error_path.write_text(f"failed to parse {summary_path}: {exc}\n", encoding="utf-8")
    raise SystemExit(0)

wake_diagnostics = summary.get("wake_diagnostics")
if not isinstance(wake_diagnostics, dict):
    diagnostics_path = summary.get("wake_diagnostics_path")
    if diagnostics_path:
        try:
            wake_diagnostics = json.loads(Path(diagnostics_path).read_text(encoding="utf-8"))
        except Exception:  # noqa: BLE001
            wake_diagnostics = {}
    else:
        wake_diagnostics = {}

agent_dir = Path(os.environ["EVE_EVAL_LOG_ROOT"]) / "agent_observation"
visual_manifest_path = agent_dir / "visual_manifest.json"
if not visual_manifest_path.is_file():
    raise ValueError(f"required wake visual manifest is missing: {visual_manifest_path}")
visual_manifest = json.loads(visual_manifest_path.read_text(encoding="utf-8"))
if visual_manifest.get("schema_version") != "dogfish.wake_visual_observation.v1":
    raise ValueError("wake visual manifest has an unexpected schema")
episode_keyframes = Path(str(visual_manifest.get("keyframes") or ""))
if not episode_keyframes.is_file() or episode_keyframes.stat().st_size <= 0:
    raise ValueError(f"required episode keyframe sheet is missing: {episode_keyframes}")
shared_prewarm_value = visual_manifest.get("shared_prewarm_keyframes")
shared_prewarm_keyframes = Path(str(shared_prewarm_value)) if shared_prewarm_value else None
if shared_prewarm_keyframes is not None and (
    not shared_prewarm_keyframes.is_file() or shared_prewarm_keyframes.stat().st_size <= 0
):
    raise ValueError(f"shared prewarm keyframe sheet is missing: {shared_prewarm_keyframes}")
visual_video = Path(str(visual_manifest.get("video") or ""))
if not visual_video.is_file() or visual_video.stat().st_size <= 0:
    raise ValueError(f"required wake MP4 is missing: {visual_video}")

metrics = {
    "task_family": summary.get("task_family"),
    "status": summary.get("status"),
    "termination": summary.get("termination"),
    "score_schema_version": summary.get("score_schema_version"),
    "score_mode": summary.get("score_mode"),
    "failure_penalty_semantics_version": summary.get(
        "failure_penalty_semantics_version"
    ),
    "failure_penalty_total": summary.get("failure_penalty_total"),
    "left_domain_failure": bool(summary.get("left_domain_failure", False)),
    "collision_failure": bool(summary.get("collision_failure", False)),
    "unstable_failure": bool(summary.get("unstable_failure", False)),
    "horizon_miss_failure": bool(summary.get("horizon_miss_failure", False)),
    "configured_left_domain_penalty": summary.get(
        "configured_left_domain_penalty"
    ),
    "configured_collision_penalty": summary.get("configured_collision_penalty"),
    "unstable_dynamics_penalty": summary.get("unstable_dynamics_penalty"),
    "configured_horizon_miss_penalty": summary.get(
        "configured_horizon_miss_penalty"
    ),
    "policy_params_source": policy_params_source,
    "task_success": bool(summary.get("task_success", False)),
    "target_reached": bool(summary.get("target_reached", False)),
    "station_success": bool(summary.get("station_success", False)),
    "prewarm_with_fish": bool(summary.get("prewarm_with_fish", False)),
    "prewarm_horizon": summary.get("prewarm_horizon"),
    "requested_prewarm_horizon": summary.get("requested_prewarm_horizon"),
    "loaded_prewarm_snapshot": bool(summary.get("loaded_prewarm_snapshot", False)),
    "release_elapsed": summary.get("release_elapsed"),
    "total_horizon": summary.get("total_horizon"),
    "physical_total_horizon": summary.get("physical_total_horizon"),
    "final_distance_L": summary.get("final_distance_L"),
    "mean_distance_L": summary.get("mean_distance_L"),
    "min_distance_L": summary.get("min_distance_L"),
    "progress": summary.get("progress"),
    "distance_integral_L": summary.get("distance_integral_L"),
    "navigation_score": summary.get("navigation_score"),
    "success_score": summary.get("success_score"),
    "success_energy_metric": summary.get("success_energy_metric"),
    "success_energy_value": summary.get("success_energy_value"),
    "success_energy_envelope": summary.get("success_energy_envelope"),
    "success_energy_fraction": summary.get("success_energy_fraction"),
    "success_energy_efficiency": summary.get("success_energy_efficiency"),
    "base_score": summary.get("base_score"),
    "energy_bonus": summary.get("energy_bonus"),
    "energy_bonus_weight": summary.get("energy_bonus_weight"),
    "command_energy": summary.get("command_energy"),
    "command_energy_mean": summary.get("command_energy_mean"),
    "power_proxy": summary.get("power_proxy"),
    "power_proxy_mean": summary.get("power_proxy_mean"),
    "sim_time": summary.get("sim_time"),
    "prewarm_steps": summary.get("prewarm_steps"),
    "steps": summary.get("steps"),
    "L": summary.get("L"),
    "flow_speed": summary.get("flow_speed"),
    "target_x_L": summary.get("target_x_L"),
    "target_y_L": summary.get("target_y_L"),
    "success_radius_L": summary.get("success_radius_L"),
    "capture_mode": summary.get("capture_mode"),
    "capture_dwell_time": summary.get("capture_dwell_time"),
    "capture_first_entry_time": summary.get("capture_first_entry_time"),
    "capture_success_time": summary.get("capture_success_time"),
    "capture_max_contiguous_time": summary.get("capture_max_contiguous_time"),
    "capture_entry_count": summary.get("capture_entry_count"),
    "capture_left_after_entry": bool(summary.get("capture_left_after_entry", False)),
    "Re": summary.get("Re"),
    "cylinder_Re": summary.get("cylinder_Re"),
    "inflow_Re": summary.get("inflow_Re"),
    "inflow_cylinder_Re": summary.get("inflow_cylinder_Re"),
    "release_shedding_cycles_estimate": wake_diagnostics.get(
        "release_shedding_cycles_estimate"
    ),
    "tailbeat_to_shedding_frequency_ratio_estimate": wake_diagnostics.get(
        "tailbeat_to_shedding_frequency_ratio_estimate"
    ),
    "head_displacement_x_L": wake_diagnostics.get("head_displacement_x_L"),
    "head_displacement_y_L": wake_diagnostics.get("head_displacement_y_L"),
    "mean_local_flow_x": wake_diagnostics.get("mean_local_flow_x"),
    "mean_local_flow_y": wake_diagnostics.get("mean_local_flow_y"),
    "rms_relative_crossflow_y": wake_diagnostics.get("rms_relative_crossflow_y"),
    "rms_force_y": wake_diagnostics.get("rms_force_y"),
    "rms_moment_z": wake_diagnostics.get("rms_moment_z"),
    "wall_s": summary.get("wall_s"),
}
artifacts = {
    "root": str(summary_path.parent),
    "summary_json": str(summary_path),
    "trajectory_csv": summary.get("trajectory"),
    "wake_diagnostics": summary.get("wake_diagnostics_path"),
    "vtk_collection": summary.get("vtk_collection"),
    "vtk_latest_frame": summary.get("vtk_latest_frame"),
    "video": str(visual_video),
    "visual_manifest": str(visual_manifest_path),
    "wake_keyframes": str(episode_keyframes),
    "shared_prewarm_keyframes": (
        str(shared_prewarm_keyframes) if shared_prewarm_keyframes is not None else None
    ),
}
payload = {
    "score": score,
    "summary": f"multi-wake target score={score:.6f} termination={summary.get('termination')}",
    "metrics": metrics,
    "artifacts": artifacts,
}
score_json_path.write_text(
    json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8"
)

agent_dir.mkdir(parents=True, exist_ok=True)
(agent_dir / "wake_observation.json").write_text(
    json.dumps(
        {
            "score": score,
            "metrics": metrics,
            "wake_diagnostics": wake_diagnostics,
            "artifacts": artifacts,
        },
        indent=2,
        sort_keys=True,
    )
    + "\n",
    encoding="utf-8",
)
with (agent_dir / "wake_metrics.csv").open("w", newline="", encoding="utf-8") as handle:
    writer = csv.DictWriter(handle, fieldnames=list(metrics))
    writer.writeheader()
    writer.writerow(metrics)


def fmt(value):
    if value is None:
        return "na"
    if isinstance(value, float):
        return f"{value:.6g}"
    return str(value)


md_lines = [
    "# Wake Observation",
    "",
    f"- score: `{score:.6f}`",
    f"- task family: `{summary.get('task_family')}`",
    f"- termination: `{summary.get('termination')}`",
    "- released-episode flow keyframes: `agent_observation/wake_keyframes.jpg`",
    (
        "- shared held-fish prewarm keyframes: `agent_observation/shared_prewarm_keyframes.jpg`"
        if shared_prewarm_keyframes is not None
        else "- shared held-fish prewarm keyframes: `na`"
    ),
    f"- target reached: `{bool(summary.get('target_reached', False))}`",
    f"- prewarm with held fish: `{bool(summary.get('prewarm_with_fish', False))}`",
    f"- requested prewarm horizon: `{fmt(summary.get('requested_prewarm_horizon'))}`",
    f"- release horizon elapsed: `{fmt(summary.get('release_elapsed'))}`",
    f"- mean/final/min distance L: `{fmt(summary.get('mean_distance_L'))}` / `{fmt(summary.get('final_distance_L'))}` / `{fmt(summary.get('min_distance_L'))}`",
    f"- progress: `{fmt(summary.get('progress'))}`",
    f"- estimated release shedding cycles: `{fmt(wake_diagnostics.get('release_shedding_cycles_estimate'))}`",
    f"- estimated tailbeat/shedding frequency ratio: `{fmt(wake_diagnostics.get('tailbeat_to_shedding_frequency_ratio_estimate'))}`",
    f"- head displacement L: x=`{fmt(wake_diagnostics.get('head_displacement_x_L'))}`, y=`{fmt(wake_diagnostics.get('head_displacement_y_L'))}`",
    f"- mean local flow: x=`{fmt(wake_diagnostics.get('mean_local_flow_x'))}`, y=`{fmt(wake_diagnostics.get('mean_local_flow_y'))}`",
    f"- RMS relative crossflow y: `{fmt(wake_diagnostics.get('rms_relative_crossflow_y'))}`",
    f"- RMS force y / moment z: `{fmt(wake_diagnostics.get('rms_force_y'))}` / `{fmt(wake_diagnostics.get('rms_moment_z'))}`",
    f"- heavy artifact root: `{summary_path.parent}`",
    "",
    "Inspect the shared prewarm sheet first when present, then the released-episode sheet with the image tool.",
    "Use the pictures together with trajectory and force/flow metrics; do not infer policy quality from score alone.",
    "The MP4 and full VTK stream are archival; the compact keyframe sheets are the canonical agent visual input.",
    "",
    "Use this compact file as diagnostic evidence; the scalar score is unchanged.",
]
(agent_dir / "wake_observation.md").write_text("\n".join(md_lines) + "\n", encoding="utf-8")


def yaml_scalar(value):
    if value is None:
        return "null"
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, (int, float)):
        return repr(value)
    text = str(value).replace("\\", "\\\\").replace('"', '\\"')
    return f'"{text}"'


lines = [
    f"score: {score!r}",
    f"summary: {yaml_scalar(payload['summary'])}",
    "metrics:",
]
for key, value in metrics.items():
    lines.append(f"  {key}: {yaml_scalar(value)}")
lines.append("artifacts:")
for key, value in artifacts.items():
    lines.append(f"  {key}: {yaml_scalar(value)}")
score_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
PY
