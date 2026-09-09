#!/usr/bin/env bash
set -euo pipefail
umask 0002

wrapper_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
helper="$wrapper_dir/../dogfish_2d_wake_policy/run_inplace_gpu_batch.py"
physical_evaluator="$wrapper_dir/../dogfish_2d_wake_policy_secondrow_capture0p75_24x16/evaluation.sh"

export DOGFISH_WAKE_INPLACE_GPU=1
export DOGFISH_WAKE_PBS_EVAL=0
export DOGFISH_WAKE_INPLACE_BATCH_SIZE=4
export DOGFISH_WAKE_INPLACE_MAX_CONCURRENCY=4
export DOGFISH_WAKE_INPLACE_WAIT_FOR_BATCH=0

exec "${PYTHON:-python3}" "$helper" \
    --workspace-root "${EVE_WORKSPACE_ROOT:?EVE_WORKSPACE_ROOT is required}" \
    -- bash "$physical_evaluator"
