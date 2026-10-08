#!/usr/bin/env bash
set -euo pipefail
umask 0002

: "${EVE_WORKSPACE_ROOT:?EVE_WORKSPACE_ROOT is required}"
: "${EVE_SOLVER_ROOT:?EVE_SOLVER_ROOT is required}"
: "${EVE_EVAL_LOG_ROOT:?EVE_EVAL_LOG_ROOT is required}"
: "${EVE_PYTHON:?EVE_PYTHON is required}"
: "${EVE_RENDER_PYTHON:?EVE_RENDER_PYTHON is required}"
: "${EVE_RENDER_REQUIREMENTS_FILE:?EVE_RENDER_REQUIREMENTS_FILE is required}"
: "${EVE_RENDER_CHECK_SCRIPT:?EVE_RENDER_CHECK_SCRIPT is required}"

control_python="$EVE_PYTHON"
render_python="$EVE_RENDER_PYTHON"
render_requirements="$EVE_RENDER_REQUIREMENTS_FILE"
render_check_script="$EVE_RENDER_CHECK_SCRIPT"
DOGFISH3D_EVE_CONFIG_REL="${DOGFISH3D_EVE_CONFIG_REL:-configs/fish3dtarget_eve_2daligned_stillwater_h100_l64_4x3_3d.toml}"
DOGFISH3D_EXPECTED_FLOW_X="${DOGFISH3D_EXPECTED_FLOW_X:-0.0}"
DOGFISH3D_EXPECTED_FLOW_Y="${DOGFISH3D_EXPECTED_FLOW_Y:-0.0}"
DOGFISH3D_EXPECTED_FLOW_Z="${DOGFISH3D_EXPECTED_FLOW_Z:-0.0}"
export DOGFISH3D_EVE_CONFIG_REL DOGFISH3D_EXPECTED_FLOW_X DOGFISH3D_EXPECTED_FLOW_Y DOGFISH3D_EXPECTED_FLOW_Z
test -x "$control_python"
test -x "$render_python"
test -s "$render_requirements"
test -s "$render_check_script"

wrapper_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
artifact_root="$EVE_WORKSPACE_ROOT/artifacts/moving_window3d_episode"
runtime_root="$artifact_root/runtime"
score_path="$EVE_EVAL_LOG_ROOT/score.yaml"
score_json_path="$EVE_EVAL_LOG_ROOT/score.json"
error_path="$EVE_EVAL_LOG_ROOT/error.txt"
pbs_stdout="$runtime_root/pbs_child.stdout.log"
pbs_stderr="$runtime_root/pbs_child.stderr.log"
pbs_exit_status="$runtime_root/pbs_child.exit_status"
pbs_job_id_path="$runtime_root/pbs_job_id.txt"
pbs_audit="$runtime_root/pbs_flexible_submission.json"
mkdir -p "$runtime_root" "$EVE_EVAL_LOG_ROOT"

write_failure_score() {
    local message="$1"
    printf 'score: -100.0\nsummary: %s\n' \
        "$("$render_python" -c 'import json,sys; print(json.dumps(sys.argv[1]))' "$message")" \
        >"$score_path"
}

on_exit() {
    local rc="$?"
    if [[ "$rc" -ne 0 && ! -s "$score_path" ]]; then
        write_failure_score "3D moving-window evaluation command failed"
        printf 'evaluation exited with status %s\n' "$rc" >"$error_path"
    fi
}
trap on_exit EXIT

if [[ "${DOGFISH3D_MOVING_WINDOW_PBS_EVAL:-0}" == "1" && "${DOGFISH3D_MOVING_WINDOW_PBS_CHILD:-0}" != "1" ]]; then
    pbs_script="$runtime_root/moving_window3d_child.pbs"
    pbs_name="$(printf 'd3-%s' "$(basename "$EVE_WORKSPACE_ROOT" | cksum | awk '{print $1}')" | cut -c1-15)"
    eval_source="$wrapper_dir/evaluation.sh"
    pbs_julia_bin="${EVE_EVAL_PBS_JULIA_BIN:?parent must pass EVE_EVAL_PBS_JULIA_BIN}"
    pbs_depot="${EVE_EVAL_PBS_JULIA_DEPOT_PATH:?parent must pass EVE_EVAL_PBS_JULIA_DEPOT_PATH}"
    pbs_render_python="${EVE_EVAL_PBS_RENDER_PYTHON:?parent must pass EVE_EVAL_PBS_RENDER_PYTHON}"
    test -x "$pbs_julia_bin"
    test -d "$pbs_depot"
    test -x "$pbs_render_python"
    cat >"$pbs_script" <<EOF
#!/bin/bash
#PBS -P ${EVE_EVAL_PBS_PROJECT:?Set EVE_EVAL_PBS_PROJECT}
#PBS -q ${EVE_EVAL_PBS_QUEUE:?Set EVE_EVAL_PBS_QUEUE}
#PBS -N $pbs_name
#PBS -l select=1:ncpus=16:mem=225gb:ngpus=${EVE_EVAL_PBS_GPUS:-1}${EVE_EVAL_PBS_GPU_MODEL:+:gpu_model=$EVE_EVAL_PBS_GPU_MODEL}
#PBS -l walltime=${EVE_EVAL_PBS_WALLTIME:-02:00:00}
#PBS -j oe
#PBS -k oed
#PBS -W umask=0002
set -euo pipefail
umask 0002
unset LD_LIBRARY_PATH
export PATH=$(printf '%q' "$PATH")
export JULIA_BIN="$pbs_julia_bin"
export EVE_INPLACE_JULIA_BIN="$pbs_julia_bin"
export JULIA_DEPOT_PATH="$pbs_depot"
export JULIA_NUM_THREADS="${JULIA_NUM_THREADS:-2}"
export EVE_PYTHON="$control_python"
export EVE_RENDER_PYTHON="$pbs_render_python"
export EVE_RENDER_REQUIREMENTS_FILE="$render_requirements"
export EVE_RENDER_CHECK_SCRIPT="$render_check_script"
export EVE_EVAL_PBS_JULIA_BIN="$pbs_julia_bin"
export EVE_EVAL_PBS_JULIA_DEPOT_PATH="$pbs_depot"
export EVE_EVAL_PBS_RENDER_PYTHON="$pbs_render_python"
export EVE_WORKSPACE_ROOT="$EVE_WORKSPACE_ROOT"
export EVE_SOLVER_ROOT="$EVE_SOLVER_ROOT"
export EVE_EVAL_LOG_ROOT="$EVE_EVAL_LOG_ROOT"
export DOGFISH3D_MOVING_WINDOW_PBS_EVAL=0
export DOGFISH3D_MOVING_WINDOW_PBS_CHILD=1
export DOGFISH3D_EVE_RUNTIME_L="${DOGFISH3D_EVE_RUNTIME_L:-64}"
export DOGFISH3D_EVE_HORIZON="${DOGFISH3D_EVE_HORIZON:-100.0}"
export DOGFISH3D_EVE_MIDPLANE_FRAMES="${DOGFISH3D_EVE_MIDPLANE_FRAMES:-101}"
export DOGFISH3D_EVE_HERO_FRAMES="${DOGFISH3D_EVE_HERO_FRAMES:-26}"
export DOGFISH3D_EVE_CONFIG_REL="$DOGFISH3D_EVE_CONFIG_REL"
export DOGFISH3D_EXPECTED_FLOW_X="$DOGFISH3D_EXPECTED_FLOW_X"
export DOGFISH3D_EXPECTED_FLOW_Y="$DOGFISH3D_EXPECTED_FLOW_Y"
export DOGFISH3D_EXPECTED_FLOW_Z="$DOGFISH3D_EXPECTED_FLOW_Z"
cd "$EVE_WORKSPACE_ROOT"
test -x "$pbs_julia_bin"
test -d "$pbs_depot"
test -x "$pbs_render_python"
PYVISTA_OFF_SCREEN=true "$pbs_render_python" "$render_check_script" \
  --requirements "$render_requirements" \
  --json-output "$runtime_root/child_render_runtime_preflight.json"
JULIA_DEPOT_PATH="$pbs_depot" "$pbs_julia_bin" --project="$EVE_SOLVER_ROOT" --startup-file=no \
  -e 'using WaterLily, CUDA, JLD2, JSON; CUDA.functional() || error("CUDA is not functional in PBS child"); println(Base.active_project())' \
  >"$runtime_root/child_julia_runtime_preflight.log" 2>&1
printf '%s\n' \
  "PBS_JOBID=\${PBS_JOBID:-unset}" \
  "EVE_INPLACE_JULIA_BIN=$pbs_julia_bin" \
  "JULIA_DEPOT_PATH=$pbs_depot" \
  "EVE_RENDER_PYTHON=$pbs_render_python" \
  "EVE_RENDER_REQUIREMENTS_FILE=$render_requirements" \
  >"$runtime_root/child_runtime_environment.txt"
set +e
bash "$eval_source" >"$pbs_stdout" 2>"$pbs_stderr"
rc=\$?
printf '%s\n' "\$rc" >"$pbs_exit_status"
exit "\$rc"
EOF
    job_id="$("$control_python" "$wrapper_dir/submit_flexible_pbs_child.py" \
        --script "$pbs_script" \
        --audit "$pbs_audit" \
        --job-id-path "$pbs_job_id_path" \
        --job-name "$pbs_name" \
        --project "${EVE_EVAL_PBS_PROJECT:?Set EVE_EVAL_PBS_PROJECT}" \
        --walltime "${EVE_EVAL_PBS_WALLTIME:-02:00:00}" \
        --max-user-jobs "${DOGFISH3D_PBS_MAX_USER_JOBS:-5}" \
        --queue-wait-seconds "${DOGFISH3D_PBS_QUEUE_WAIT_SECONDS:-30}" \
        --candidate "${EVE_EVAL_PBS_QUEUE:?Set EVE_EVAL_PBS_QUEUE},${EVE_EVAL_PBS_GPU_MODEL:-},${EVE_EVAL_PBS_GPUS:-1}")"
    echo "Submitted flexible 3D moving-window child $job_id"
    cleanup_child() {
        "${EVE_PBS_BIN:+${EVE_PBS_BIN}/}qdel" "$job_id" >/dev/null 2>&1 || true
    }
    trap cleanup_child INT TERM
    while "${EVE_PBS_BIN:+${EVE_PBS_BIN}/}qstat" "$job_id" >/dev/null 2>&1; do
        sleep "${EVE_EVAL_PBS_POLL_S:-10}"
    done
    for _ in 1 2 3 4 5; do
        [[ -s "$score_path" || -s "$pbs_exit_status" ]] && break
        sleep 2
    done
    if [[ ! -s "$score_path" ]]; then
        write_failure_score "3D moving-window PBS child produced no score"
        {
            printf 'job=%s\n' "$job_id"
            [[ -s "$pbs_stderr" ]] && tail -n 160 "$pbs_stderr"
        } >"$error_path"
    fi
    exit 0
fi

cd "$EVE_SOLVER_ROOT"
julia_bin="${EVE_INPLACE_JULIA_BIN:?EVE_INPLACE_JULIA_BIN is required}"
case_root="$EVE_SOLVER_ROOT/cases/dogfish_3d_shape_policy"
engine="$case_root/projected_multiwake_policy_smoke3d_hero_v3_moving_window.jl"
if [[ -n "${DOGFISH3D_EVE_CONFIG:-}" ]]; then
    config="$DOGFISH3D_EVE_CONFIG"
elif [[ "$DOGFISH3D_EVE_CONFIG_REL" == /* ]]; then
    config="$DOGFISH3D_EVE_CONFIG_REL"
else
    config="$case_root/$DOGFISH3D_EVE_CONFIG_REL"
fi
policy="$case_root/candidate_target_policy.jl"
renderer="$case_root/render3d/render_midplane_rollout3d.py"
renderer_3d="$case_root/render_reference_moving_frame.py"
test -s "$engine"
test -s "$config"
test -s "$policy"
test -s "$renderer"
test -s "$renderer_3d"

policy_sha="$(sha256sum "$policy" | awk '{print $1}')"
runtime_l="${DOGFISH3D_EVE_RUNTIME_L:-64}"
rollout_horizon="${DOGFISH3D_EVE_HORIZON:-100.0}"
midplane_frames="${DOGFISH3D_EVE_MIDPLANE_FRAMES:-101}"
hero_frames="${DOGFISH3D_EVE_HERO_FRAMES:-26}"
success_radius_L="${DOGFISH3D_EVE_SUCCESS_RADIUS_L:-0.75}"
export DOGFISH3D_EVE_SUCCESS_RADIUS_L="$success_radius_L"
nvidia-smi -L >"$runtime_root/nvidia_smi.txt"
"$julia_bin" --version >"$runtime_root/julia_version.txt"
printf '%s\n' "$policy_sha" >"$runtime_root/policy.sha256"

unset DOGFISH3D_PREWARM_SNAPSHOT
set +e
env \
    DOGFISH3D_INITIALIZATION_MODE=uniform_direct \
    DOGFISH3D_ROLLOUT_CONFIG="$config" \
    DOGFISH3D_ROLLOUT_L="$runtime_l" \
    DOGFISH3D_WORLD_INITIAL_CENTER_X_L=21.0 \
    DOGFISH3D_WORLD_INITIAL_CENTER_Y_L=14.0 \
    DOGFISH3D_TARGET_X_L=9.0 \
    DOGFISH3D_TARGET_Y_L=9.5 \
    DOGFISH3D_MOVING_WINDOW=true \
    DOGFISH3D_MOVING_WINDOW_THRESHOLD_CELLS=4 \
    DOGFISH3D_VIRTUAL_DOMAIN_ENABLED=true \
    DOGFISH3D_VIRTUAL_DOMAIN_X_L=24.0 \
    DOGFISH3D_VIRTUAL_DOMAIN_Y_L=16.0 \
    DOGFISH3D_VIRTUAL_DOMAIN_CENTER_MARGIN_L=0.8 \
    DOGFISH3D_FRAME_ANCHOR_X_L=1.5 \
    DOGFISH3D_FRAME_ANCHOR_Y_L=1.5 \
    DOGFISH3D_POLICY_FILE="$policy" \
    DOGFISH3D_POLICY_EXPECTED_SHA256="$policy_sha" \
    DOGFISH3D_ROLLOUT_OUTPUT="$artifact_root" \
    DOGFISH3D_CONTROL_MODE=candidate_policy \
    DOGFISH3D_ROLLOUT_HORIZON="$rollout_horizon" \
    DOGFISH3D_ROLLOUT_MAX_STEPS=100000 \
    DOGFISH3D_ROLLOUT_DT=0.0055 \
    DOGFISH3D_REFERENCE_MODEL=actual_superellipse_centroid \
    DOGFISH3D_BODY_GEOMETRY=june13_superellipse_fan \
    DOGFISH3D_BODY_HEIGHT_SCALE=1.0 \
    DOGFISH3D_CAUDAL_FIN_ENABLED=true \
    DOGFISH3D_FIN_X_START=0.80 \
    DOGFISH3D_FIN_X_END=1.07 \
    DOGFISH3D_FIN_UPPER_HEIGHT=0.11 \
    DOGFISH3D_FIN_LOWER_HEIGHT=0.11 \
    DOGFISH3D_FIN_HALF_THICKNESS=0.012 \
    DOGFISH3D_FIN_MATERIAL_DENSITY=1.0 \
    DOGFISH3D_FIN_ADDED_MASS_SCALE=1.0 \
    DOGFISH3D_BODY_ADDED_INERTIA_SCALE=1.0 \
    DOGFISH3D_INITIAL_HEADING_OVERRIDE_DEG=29 \
    DOGFISH3D_INITIAL_PHI1_OVERRIDE_DEG=8 \
    DOGFISH3D_INITIAL_PHI2_OVERRIDE_DEG=-8 \
    DOGFISH3D_INITIAL_YAW_RATE_RAD_PER_T=0 \
    DOGFISH3D_PROPULSION_ONLY_SURGE=false \
    DOGFISH3D_REFLECTION_EQUIVARIANT_IBM=true \
    DOGFISH3D_ROLLOUT_MIDPLANE=true \
    DOGFISH3D_ROLLOUT_MIDPLANE_FRAMES="$midplane_frames" \
    DOGFISH3D_ROLLOUT_CROPPED_VOLUME=false \
    DOGFISH3D_ROLLOUT_CROPPED_VOLUME_WINDOW_L=2.5 \
    DOGFISH3D_ROLLOUT_HERO_VOLUME=true \
    DOGFISH3D_ROLLOUT_HERO_VOLUME_FRAMES="$hero_frames" \
    DOGFISH3D_ROLLOUT_HERO_VOLUME_STRIDE_X=2 \
    DOGFISH3D_ROLLOUT_HERO_VOLUME_STRIDE_Y=2 \
    DOGFISH3D_ROLLOUT_HERO_VOLUME_STRIDE_Z=2 \
    DOGFISH3D_ROLLOUT_VTK=false \
    DOGFISH3D_ALLOW_SCIENTIFIC_FAILURE=true \
    DOGFISH_MEMORY_BACKEND=cuda \
    "$julia_bin" --project="$EVE_SOLVER_ROOT" --startup-file=no "$engine" \
    >"$runtime_root/episode.stdout.log" 2>"$runtime_root/episode.stderr.log"
episode_rc="$?"
set -e
printf '%s\n' "$episode_rc" >"$runtime_root/episode.exit_status"
if [[ "$episode_rc" -ne 0 || ! -s "$artifact_root/summary.json" ]]; then
    write_failure_score "3D moving-window CFD episode failed"
    tail -n 160 "$runtime_root/episode.stderr.log" >"$error_path" || true
    exit 0
fi

if ! "$render_python" "$renderer" --run-dir "$artifact_root" --fps 8 --width 960 --height 720 \
    >"$runtime_root/render.stdout.log" 2>"$runtime_root/render.stderr.log"; then
    write_failure_score "3D moving-window video render failed"
    tail -n 160 "$runtime_root/render.stderr.log" >"$error_path" || true
    exit 0
fi

if ! PYVISTA_OFF_SCREEN=true "$render_python" "$renderer_3d" "$artifact_root/hero_volume3d" \
    --trajectory "$artifact_root/trajectory.csv" \
    --output "$artifact_root/render_oblique" \
    --target-x 9.0 --target-y 9.5 --target-z 0.75 --target-radius "$success_radius_L" \
    --fps 4 --width 1280 --height 720 \
    --title "L${runtime_l} 3D moving-window EvE candidate | oblique Lambda2 view" \
    --stage-mode closed_loop --output-stem moving_window3d_oblique \
    >"$runtime_root/render_oblique.stdout.log" 2>"$runtime_root/render_oblique.stderr.log"; then
    write_failure_score "3D moving-window oblique render failed"
    tail -n 160 "$runtime_root/render_oblique.stderr.log" >"$error_path" || true
    exit 0
fi

"$render_python" - "$artifact_root/render_midplane/projected_multiwake_target3d_keyframes.jpg" \
    "$artifact_root/render_oblique/moving_window3d_oblique_keyframes.jpg" \
    "$artifact_root/multimodal_keyframes.jpg" <<'PY'
import sys
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

sources = [("TOP-DOWN MID-PLANE VORTICITY", Path(sys.argv[1])),
           ("OBLIQUE 3D BODY + LAMBDA2 WAKE", Path(sys.argv[2]))]
target = Path(sys.argv[3])
width = 1600
header = 54
rows = []
try:
    font = ImageFont.load_default(size=24)
except TypeError:
    font = ImageFont.load_default()
for label, path in sources:
    image = Image.open(path).convert("RGB")
    scale = width / image.width
    image = image.resize((width, max(1, round(image.height * scale))))
    row = Image.new("RGB", (width, header + image.height), "white")
    draw = ImageDraw.Draw(row)
    draw.text((20, 14), label, fill=(20, 20, 20), font=font)
    row.paste(image, (0, header))
    rows.append(row)
canvas = Image.new("RGB", (width, sum(row.height for row in rows)), "white")
y = 0
for row in rows:
    canvas.paste(row, (0, y))
    y += row.height
canvas.save(target, quality=92)
PY

"$render_python" - "$artifact_root" "$score_path" "$score_json_path" "$error_path" <<'PY'
import csv
import json
import math
import os
import shutil
import sys
from pathlib import Path

root = Path(sys.argv[1])
score_path = Path(sys.argv[2])
score_json_path = Path(sys.argv[3])
error_path = Path(sys.argv[4])
observation = score_path.parent / "agent_observation"
observation.mkdir(parents=True, exist_ok=True)

try:
    summary = json.loads((root / "summary.json").read_text(encoding="utf-8"))
    required = {
        "runtime_resolution": int(__import__("os").environ.get("DOGFISH3D_EVE_RUNTIME_L", "64")),
        "Re": 1000.0,
        "control_mode": "candidate_policy",
        "moving_window": True,
        "initialization_mode": "uniform_direct",
        "direct_uniform_initial_condition": True,
        "body_geometry": "june13_superellipse_fan",
        "caudal_fin_enabled": True,
        "reflection_equivariant_ibm_enabled": True,
    }
    for key, expected in required.items():
        if summary.get(key) != expected:
            raise ValueError(f"{key}: expected {expected!r}, got {summary.get(key)!r}")
    if summary.get("prewarm_snapshot") is not None:
        raise ValueError("direct run unexpectedly loaded a prewarm snapshot")
    expected_l = int(__import__("os").environ.get("DOGFISH3D_EVE_RUNTIME_L", "64"))
    if summary.get("domain_dims") != [4 * expected_l, 3 * expected_l, round(1.5 * expected_l)]:
        raise ValueError("domain dimensions drifted")
    expected_anchor = [1.5, 1.5]
    actual_anchor = [float(x) for x in summary.get("frame_anchor_local_L", [])]
    if len(actual_anchor) != 2 or not all(
        math.isclose(a, b, abs_tol=1e-10) for a, b in zip(actual_anchor, expected_anchor)
    ):
        raise ValueError("moving-window local anchor drifted")
    expected_origin = [19.5, 12.5]
    actual_origin = [float(x) for x in summary.get("initial_frame_origin_L", [])]
    if len(actual_origin) != 2 or not all(
        math.isclose(a, b, abs_tol=1e-10) for a, b in zip(actual_origin, expected_origin)
    ):
        raise ValueError("moving-window initial origin drifted from integer cells")
    expected_horizon = float(__import__("os").environ.get("DOGFISH3D_EVE_HORIZON", "100.0"))
    if not math.isclose(float(summary.get("horizon", math.nan)), expected_horizon, abs_tol=1e-8):
        raise ValueError("rollout horizon drifted")
    if [float(x) for x in summary.get("target_L", [])[:2]] != [9.0, 9.5]:
        raise ValueError("world target drifted")
    if [float(x) for x in summary.get("fish_initial_center_L", [])[:2]] != [21.0, 14.0]:
        raise ValueError("world initial center drifted")
    if not math.isclose(float(summary.get("fish_initial_heading_deg", math.nan)), 29.0, abs_tol=1e-12):
        raise ValueError("initial heading drifted")
    if [float(x) for x in summary.get("fish_initial_joint_angles_deg", [])] != [8.0, -8.0]:
        raise ValueError("initial joint state drifted")
    expected_inflow = [
        float(os.environ["DOGFISH3D_EXPECTED_FLOW_X"]),
        float(os.environ["DOGFISH3D_EXPECTED_FLOW_Y"]),
        float(os.environ["DOGFISH3D_EXPECTED_FLOW_Z"]),
    ]
    actual_inflow = [float(x) for x in summary.get("flow_velocity_L_per_T", [])]
    if len(actual_inflow) != 3 or not all(
        math.isclose(a, b, abs_tol=1e-6) for a, b in zip(actual_inflow, expected_inflow)
    ):
        raise ValueError("configured background flow drifted")
    moving_contract = summary.get("moving_window_contract") or {}
    actual_entering = [float(x) for x in moving_contract.get("entering_velocity", [])]
    if len(actual_entering) != 3 or not all(
        math.isclose(a, b, abs_tol=1e-6) for a, b in zip(actual_entering, expected_inflow)
    ):
        raise ValueError("newly exposed moving-window cells do not use the configured background flow")
    expected_success_radius = float(__import__("os").environ["DOGFISH3D_EVE_SUCCESS_RADIUS_L"])
    if not math.isclose(
        float(summary.get("success_radius_L", math.nan)), expected_success_radius, abs_tol=1e-12
    ):
        raise ValueError("target success radius drifted")
    virtual_domain = summary.get("virtual_domain") or {}
    if [float(x) for x in virtual_domain.get("domain_L", [])] != [24.0, 16.0]:
        raise ValueError("24L x 16L virtual domain drifted")
    if not math.isclose(float(virtual_domain.get("center_margin_L", math.nan)), 0.8, abs_tol=1e-12):
        raise ValueError("virtual-domain center margin drifted")
    if virtual_domain.get("exit_termination") != "left_domain":
        raise ValueError("virtual-domain termination contract drifted")
    score = float(summary["score"])
    if not math.isfinite(score):
        raise ValueError("non-finite score")
    topdown_manifest = json.loads((root / "render_midplane/visual_manifest.json").read_text(encoding="utf-8"))
    oblique_manifest = json.loads((root / "render_oblique/render_manifest.json").read_text(encoding="utf-8"))
    topdown_video = Path(topdown_manifest["video"])
    oblique_video = Path(oblique_manifest["video"])
    topdown_keyframes = Path(topdown_manifest["keyframes"])
    oblique_keyframes = Path(oblique_manifest["keyframes"])
    combined_keyframes = root / "multimodal_keyframes.jpg"
    for visual in (topdown_video, oblique_video, topdown_keyframes, oblique_keyframes, combined_keyframes):
        if not visual.is_file() or visual.stat().st_size <= 0:
            raise ValueError(f"required multimodal artifact missing: {visual}")
except Exception as exc:
    score_path.write_text('score: -100.0\nsummary: "failed 3D moving-window acceptance contract"\n', encoding="utf-8")
    error_path.write_text(f"acceptance failure: {exc}\n", encoding="utf-8")
    raise SystemExit(0)

termination = str(summary.get("termination", "unknown"))
message = (
    f"L{expected_l} 3D moving-window episode; termination={termination}; "
    f"min_distance_L={summary.get('minimum_distance_L')}; "
    f"final_distance_L={summary.get('final_distance_L')}"
)
metrics = {
    "score": score,
    "summary": message,
    "termination": termination,
    "captured": bool(summary.get("captured")),
    "initial_distance_L": summary.get("initial_distance_L"),
    "minimum_distance_L": summary.get("minimum_distance_L"),
    "final_distance_L": summary.get("final_distance_L"),
    "progress": (summary.get("score_metrics") or {}).get("progress"),
    "wall_seconds": summary.get("wall_seconds"),
    "steps": summary.get("steps"),
    "moving_window_shift_count": summary.get("moving_window_shift_count"),
    "initialization_mode": summary.get("initialization_mode"),
    "flow_velocity_L_per_T": summary.get("flow_velocity_L_per_T"),
    "topdown_video": str(topdown_video),
    "oblique_video": str(oblique_video),
    "multimodal_keyframes": str(combined_keyframes),
}
score_path.write_text(
    f"score: {score:.17g}\nsummary: {json.dumps(message)}\n"
    f"termination: {json.dumps(termination)}\n"
    f"final_distance_L: {json.dumps(summary.get('final_distance_L'))}\n",
    encoding="utf-8",
)
score_json_path.write_text(json.dumps(metrics, indent=2) + "\n", encoding="utf-8")

shutil.copy2(root / "summary.json", observation / "summary.json")
shutil.copy2(root / "summary.json", observation / "wake_diagnostics.json")
shutil.copy2(root / "trajectory.csv", observation / "trajectory.csv")
shutil.copy2(topdown_video, observation / "wake_episode_topdown.mp4")
shutil.copy2(oblique_video, observation / "wake_episode_oblique.mp4")
shutil.copy2(topdown_keyframes, observation / "wake_keyframes_topdown.jpg")
shutil.copy2(oblique_keyframes, observation / "wake_keyframes_oblique.jpg")
shutil.copy2(combined_keyframes, observation / "wake_keyframes.jpg")
visual_manifest = {
    "schema": "dogfish3d.moving_window.multimodal.v1",
    "combined_keyframes": str(observation / "wake_keyframes.jpg"),
    "views": {
        "topdown_midplane": {
            "video": str(observation / "wake_episode_topdown.mp4"),
            "keyframes": str(observation / "wake_keyframes_topdown.jpg"),
            "source_manifest": str(root / "render_midplane/visual_manifest.json"),
        },
        "oblique_3d_lambda2": {
            "video": str(observation / "wake_episode_oblique.mp4"),
            "keyframes": str(observation / "wake_keyframes_oblique.jpg"),
            "source_manifest": str(root / "render_oblique/render_manifest.json"),
        },
    },
}
(observation / "visual_manifest.json").write_text(
    json.dumps(visual_manifest, indent=2) + "\n", encoding="utf-8"
)
with (observation / "wake_metrics.csv").open("w", newline="", encoding="utf-8") as handle:
    writer = csv.DictWriter(handle, fieldnames=list(metrics))
    writer.writeheader()
    writer.writerow(metrics)
(observation / "wake_observation.md").write_text(
    "# 3D moving-window rollout\n\n"
    f"- termination: `{termination}`\n"
    f"- score: `{score:.8g}`\n"
    f"- captured: `{summary.get('captured')}`\n"
    f"- minimum distance: `{summary.get('minimum_distance_L')} L`\n"
    f"- final distance: `{summary.get('final_distance_L')} L`\n"
    f"- direct uniform background velocity: `{summary.get('flow_velocity_L_per_T')}`\n"
    f"- moving-window shifts: `{summary.get('moving_window_shift_count')}`\n\n"
    "Inspect the combined `wake_keyframes.jpg`, both view-specific keyframe sheets, "
    "both MP4s, and `trajectory.csv` before changing the policy.\n",
    encoding="utf-8",
)
print(json.dumps(metrics, indent=2))
PY
