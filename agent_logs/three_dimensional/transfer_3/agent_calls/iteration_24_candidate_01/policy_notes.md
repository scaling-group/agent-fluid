# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations use direct uniform initialization in still
  water (`U_infinity=(0,0,0)`) and terminate by capture. The fastest and best
  sampled policy is the persistent same-side actuator-consistent phase branch
  (`solver_8c5ed84c4bcd`): capture at `18.6725T`, score `-0.13362`, and mean
  distance `2.02129L`. The assigned parent (`solver_764defcc56f8`) releases
  phase recruitment when normalized yaw moment already helps; it remains a
  capture but arrives at `18.7880T` with score `-0.13976`.
- The combined keyframe sheets for all four samples show body-led translation,
  a coherent alternating top-down vortex street, and coherent oblique
  Lambda2 structures from release through capture. They show no passive
  advection or wake collapse. The fastest sample and the lowest-scoring
  current sample (`solver_6c54dcec8495`, `18.7495T`, `-0.14192`) have the same
  useful broad trajectory and wake topology, so their difference is a
  steering-allocation effect rather than a new route. No sampled rollout has
  a failure termination; inherited high-pass and same-hash miss lessons are
  therefore retained as robustness boundaries rather than mislabeling a
  current capture as a failure.
- Trajectory cross-checks agree with the images. Local-flow RMS is only
  `0.01798--0.01816U`; force/moment RMS spans
  `0.01306--0.01350` / `0.00679--0.00703`. The fastest persistent-phase branch
  has the highest sampled posterior limit occupancy (`76.11%`) and loads,
  whereas the parent's helping-moment release lowers them to `74.27%` and
  `0.01306/0.00679` but delays capture. Thus turning phase recruitment off is
  a rejected trade, while the measured moment remains potentially useful as
  response information.
- Across the four sampled trajectories, current normalized yaw moment predicts
  the next logged yaw-rate change with correlation `0.9716--0.9723`, RMS
  change `0.0900--0.0930 rad/T`, and fitted slope
  `12.85--12.88 (rad/T)/moment-unit`. The sign is consistent in every sample.
  This supports a bounded one-step anticipation signal, not a helping-moment
  authority-release gate.
- Inherited optimizer logs add captures at scores `-0.15198`, `-0.15441`,
  `-0.15029`, and `-0.14930`, while the durable parent guidance records prior
  left/high misses. The semantic priority remains retaining capture and route
  closure; small score changes cannot justify reopening a failed high-pass
  topology.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish rhythmic control and adaptive wake interaction
source_mechanism: preserve the propulsive oscillator while applying a small bounded sensor-feedback residual instead of cancelling all wake-induced lateral response
transferable_invariant: separate the slow target-route request from a fast observed hydrodynamic response, and let the bounded response anticipate rather than replace route authority
nontransferable_details: published CPG gains, species kinematics, exact vortex phase, dimensional frequencies, and source-task routes
policy_translation: restore the fastest sampled persistent phase-recruitment gate; map normalized body yaw moment through an evidence-scaled bounded one-step yaw prediction and subtract it only from the reversible beat-side yaw-error direction
falsification: reject if evaluation loses capture, arrives later than 18.788T, exceeds the fastest branch's 0.01350/0.00703 force/moment RMS or 76.11 percent posterior occupancy, breaks either-view wake coherence, or merely reproduces the slower helping-moment-release trajectory

## Candidate hypothesis

Start from the fastest actuator-consistent phase policy, not the assigned
parent's negative helping-moment release. Preserve its carrier, LOS-rate
C-bend guidance, mean-curvature paths, predicted-stress gate, and persistent
same-side phase recruitment exactly. Add one new mechanism: a bounded
one-sample hydrodynamic yaw-response prediction with small-signal gain matched
to the replicated `12.85--12.88` slope and saturation matched to the observed
`0.090--0.093 rad/T` next-step RMS. Use the anticipated error only to reverse
or soften posterior beat-side amplitude/phase response when the fluid is
already about to supply that yaw change. This should keep phase authority
available while reducing one-step over-command and should preserve capture
with load no worse than the fastest branch. The new CFD result is not yet
known and is not claimed here.
