# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before candidate materialization

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. Three
  samples are executable-identical half-cycle envelope-redistribution
  controllers. They capture at `18.6505--18.8815T`, with mean distance
  `2.08855--2.09222L`. The prefilled broadside curvature-reserve controller
  captures at `18.7055T`, with mean distance `2.09386L`.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  for the best-score redistribution repeat and the broadside-reserve
  ablation, then cross-checked both against scores, diagnostics, trajectories,
  executable policy diffs, assigned-parent guidance, and inherited optimizer
  notes. Both are genuinely self-propelled from quiescent water: coherent
  alternating top-down streets bend toward the target, and compact caudal
  Lambda2 packets persist through first crossing. The reserve does not create
  a visibly distinct wake topology or numerical instability.
- The reserve is exercised rather than dormant. It first activates at
  `17.7045T` and `1.5945L`, when normalized body-frame lateral/forward target
  fractions are about `0.5526/0.8335`, and peaks at only `0.03851` of the
  curvature request at `18.4580T` and `0.9645L`. It therefore changes the
  terminal redirect while the target remains ahead. Its earlier arrival is a
  useful trajectory difference, but the worse distance integral means it is
  not a scalar-score improvement. An inherited executable-identical repeat
  also captures at `18.7440T`, mean distance `2.09873L`, with both coherent
  wake rows, but its maximum absolute lateral fraction is only `0.4525`; the
  `0.55`-onset reserve is exactly dormant throughout that trace. It establishes
  carrier non-interference, not a second exercised redirect result.
- Demand stays in the established capture class: across the exercised and
  dormant reserve repeats, acceleration contact is `60.65--60.84%`/
  `72.98--73.04%`, rate contact is `10.85--11.36%`/`14.67--14.99%`, and peak
  planar force/moment are `0.03273--0.03275`/`0.01704--0.01708`, versus
  redistribution ranges of roughly
  `60.85--61.00%`/`72.97--73.27%`, `11.01--11.07%`/`14.88--15.07%`, and
  `0.03066--0.03217`/`0.01603--0.01663`. The reserve is neither actuator
  relief nor a material demand regression, although its peak loads are the
  highest in this sampled set.
- Inherited evidence rejects stacking this reserve with full envelope
  redistribution: the compound kept energetic two-view wake structures but
  reached only `1.90495L`, then exited left at `31.1905T` and `9.45478L`.
  Two geometry-based arbitration attempts retained capture but worsened mean
  distance to `2.09850--2.09986L`. A clean executable-equivalent reserve
  replication is therefore more informative than another terminal, alignment,
  velocity, posterior-allocation, rate-barrier, or arbitration compound.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological burst redirects and closed-loop robotic-fish mean-curvature control
source_mechanism: large persistent direction error gates a bounded curvature reserve while the posterior-lagged traveling rhythm remains active, then correcting response releases the reserve
transferable_invariant: isolate one normalized body-frame redirect channel from the propulsive traveling wave and test it independently before composing gait modifiers
nontransferable_details: published gains, dimensional cadence, species-specific C-start shapes, robot geometry, prescribed beat phase, exact vortex phase, and task-specific routes
policy_translation: retain the sampled forward-qualified body-lateral smooth gate that adds a small target-signed anterior/posterior mean-curvature reserve outside the saturated route request; preserve displacement-only half-cycle steering, posterior lag, geometry-scheduled common envelope, one-sided response release, and acceleration projection
falsification: reject robust-benefit claims if an executable-equivalent repeat loses capture or either coherent wake row, fails to exercise the reserve, materially exceeds the sampled demand/load class, or reproduces no useful arrival or route difference beyond repeat variability
```

## Single-candidate policy hypothesis

Materialize exactly the prefilled broadside curvature-reserve policy as an
executable-equivalent replication. This is one small compatible mechanism on
the reliable geometry-scheduled carrier, not scalar-only gain tuning: a smooth
normalized body-lateral/forward gate bypasses the saturated route argument and
adds bounded target-signed mean curvature while the target remains ahead. It
preserves target-owned turn sign, correcting-yaw release, displacement-only
half-cycle steering, posterior lag, common amplitude relief, and exact final
acceleration projection.

No new distance stage, alignment deadband, instantaneous velocity residual,
posterior-specific allocation, gait arbitration, or pointwise rate barrier is
stacked onto the exercised mechanism. The file already contains the exact
selected architecture, so retaining it unchanged preserves executable identity
for a clean repeat. Formal CFD occurs only after this worker exits. Count the
candidate as stronger mechanism evidence only if capture and both wake views
repeat *and* the reserve is exercised; credit it beyond non-interference only
if the earlier terminal route persists without a worse integral or load class.
Another dormant capture is a carrier replication, not evidence for the reserve.
