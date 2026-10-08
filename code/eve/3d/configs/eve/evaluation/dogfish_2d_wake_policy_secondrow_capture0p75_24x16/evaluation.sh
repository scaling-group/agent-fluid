#!/usr/bin/env bash
set -euo pipefail
wrapper_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Fix the physical case at the experiment boundary.  The shared evaluator
# remains unchanged so historical and ablation configs can coexist on main.
export DOGFISH_FREE_SWIM_WAKE_CONFIG="configs/free_swim_multiwake_target_secondrow_capture0p75_l64.toml"

exec bash "$wrapper_dir/../dogfish_2d_wake_policy/evaluation.sh"
