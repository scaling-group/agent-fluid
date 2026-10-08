# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- All four sampled examples use the certified held-fish prewarm. Their prewarm
  sheets are byte-identical and show the four staggered vortex streets growing
  into a developed, asymmetric merged wake while the fish remains held at the
  upper-right release pose. This is common initial-condition evidence, not a
  policy difference.
- The three `tail_lag_gain=0.75` examples have byte-identical policy files,
  released keyframes, and physical metrics. They reach the target in `38.049`,
  with mean distance `1.802L`, command energy `52895`, power proxy `3965`,
  relative-crossflow RMS `0.2249`, force/moment RMS `42.01/653.13`, and joint
  peaks `0.496/0.521` rad. Exact replication supports repeatability only for
  this wake phase and start pose.
- The only distinct sampled rollout changes posterior lag from `0.75` to
  `0.80`, with the same fraction-`0.35`, gain-`1.7`, period-`0.55`, and
  28-degree gait. It also captures safely, but later at `38.362`, with worse
  mean distance `1.812L`, command energy `53487`, and power `4007`. It has
  nearly unchanged crossflow (`0.2244`) and posterior peak (`0.521` rad), while
  force/moment are lower at `40.73/637.79`. Both variants reach the identical
  rate and acceleration maxima, so the navigation improvement at `0.75` is not
  evidence of repaired saturation or reduced load.
- Visually, both distinct policies turn toward the target immediately after
  release, establish a coherent self-generated alternating wake, and propel
  along nearly the same diagonal track. They approach the strongest merged
  cylinder wake only near the target and show no collision, domain-exit, or
  unstable precursor. The anchor's mean velocity `(-0.2853,-0.1198)` versus
  mean local flow `(-0.1687,-0.1692)` corroborates active propulsion rather
  than passive advection. The `0.75`/`0.80` difference is too small to diagnose
  reliably from sheet geometry alone, so the distance, effort, joint, and load
  diagnostics control the comparison. No sampled failure keyframe exists; the
  older target-blind domain exit and mixed-feedback instability are available
  only as inherited recorded results and are not treated as current visuals.

## Single candidate hypothesis

Keep the replicated bearing controller, fraction `0.35`, gain `1.7`, gait,
limits, and damping unchanged. Test only `tail_lag_gain=0.70`, a bounded
continuation of the observed `0.80 -> 0.75` navigation/effort direction. A
slightly smaller posterior velocity lag may preserve the early turn and
self-propelled diagonal topology while advancing capture and reducing command
effort. The test is falsified by loss of capture, arrival later than `38.049`,
mean distance above `1.802L`, effort above `52895/3965`, or material force and
moment growth beyond the anchor's `42.01/653.13` envelope. Because the prior
step traded higher load for navigation and effort, a lower lag must not be
credited as a general load-reduction or saturation-repair mechanism even if it
captures.
