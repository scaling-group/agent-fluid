# Raw data

`L` is body length, `U` is reference speed, and `T = L/U` is the reference time.
Coordinates and distances with the suffix `_L` are expressed in body lengths.
Trajectory headings are in radians; reported heading errors may use degrees as labelled.

| Field | Meaning |
| --- | --- |
| `score`, `online_score` | Objective used during optimization, including the task-specific rewards and penalties |
| `distance_integral_L` | Time integral of head-to-target distance, divided by `L` and the full evaluation horizon |
| `observed_distance_integral_L` | Contribution from the simulated portion of the evaluation, with the same normalization |
| `terminal_hold_integral_L` | Contribution from holding the final distance constant over the remaining evaluation time |
| `distance_integral_score`, `plotted_score` | Negative of `distance_integral_L`; larger values indicate better navigation |
| `final_distance_L` | Head-to-target distance at termination, divided by `L` |
| `termination` | Reason the evaluation ended |
| `captured`, `task_success`, `target_reached` | Task-success indicators used by the corresponding evaluator |
| `unstable` | Instability indicator used by the 3D scoring rule |

For evaluations that end early, `distance_integral_L` includes both the observed
and terminal-hold contributions, using the full requested horizon.

The extraction scripts convert the online objective to the navigation score used
in the figures. See the [2D extraction](../code/reproduction/extract_derived_data.py)
and [3D scoring rule](../code/reproduction/score_3d.py).
