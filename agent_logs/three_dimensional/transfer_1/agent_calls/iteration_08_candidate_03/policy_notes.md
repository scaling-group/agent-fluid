# Phase-neutral yaw-response candidate

## Evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm), remain finite, and capture.
  Three are behaviorally identical evaluations of the progress-gated posterior-
  thrust policy: they capture at `26.0425 T`, score `-0.69471683`, and have mean
  distance `2.59751 L`.  The distinct completion-gated parent captures at
  `26.4110 T`, scores `-0.71050181`, and has mean distance `2.61340 L`.  Since
  the sample contains no semantic failure, that slower capture is the most
  informative weaker control; inherited logs additionally rule out the aligned
  cadence residual and outward joint-speed guard.
- In the inspected combined sheets for both distinct policies, the top-down row
  shows self-propelled motion along a continuous closing arc with an alternating
  red/blue wake established by `8 T`.  The oblique row confirms compact,
  alternating three-dimensional Lambda2 structures behind the posterior body
  through capture.  The stronger sample preserves this topology while arriving
  `0.3685 T` earlier, raising mean/max speed from `0.5013/0.6669` to
  `0.5081/0.7170 L/T`, and not increasing the sampled lateral-force/yaw-moment
  extrema (`0.0297/0.0148`).  Its first-`2 T` distance is slightly worse, so the
  demonstrated gain is whole-route posterior thrust rather than better launch.
- Both top-down trajectories also expose remaining steering waste: the fish
  first aligns with the target near `4 T`, then sweeps past that direction and
  carries a large opposite-side body-frame target angle through roughly
  `8--12 T` before recovering into the successful terminal arc.  This broad
  excursion is compatible with the controller treating within-beat body yaw as
  macroscopic steering response.
- The trajectory histories support that diagnosis.  From `2 T` onward, the
  evaluator's short-window yaw rate is anticorrelated with head-joint velocity
  at `r=-0.971` for the posterior-thrust capture and `r=-0.973` for the parent;
  least-squares slopes are `-0.421` and `-0.414`.  The relation remains between
  `-0.395` and `-0.462` in four route segments.  Adding `0.42*phi_dot[1]` to the
  measured yaw rate reduces RMS from `1.321` to `0.314 rad/T` in the best sample
  and from `1.297` to `0.298 rad/T` in the parent.  The raw signal is therefore
  dominated by repeatable carrier phase, not only net route curvature.

## Policy hypothesis

Retain the evaluated v24 completion-gated redirect, posterior-thrust residual,
half-cycle steering, state-feedback oscillator, and final acceleration
projection.  Add one observation-semantic mechanism: estimate phase-neutral
turn response as short-window body yaw plus a parameter-owned, dimensionless
fraction of observed head-joint velocity.  Use this estimate for target turn-
rate feedback, redirect response, recovery, and centerline braking; keep the
raw yaw available only as a diagnostic return.  A conservative `0.40`
coefficient lies inside the stable segmentwise evidence range and does not
encode time, route, target identity, or vortex phase.

Expected result: remove carrier-locked sign reversals from route feedback so
the first alignment is held more cleanly, shortening the broad early excursion
while preserving posterior wake coherence and the proven terminal capture.
Falsify the mechanism if capture is lost or delayed beyond `26.411 T`, mean
distance exceeds `2.61340 L`, the early target-angle sweep is not reduced, the
turn sign reverses, or joint-limit residence, force, moment, or wake coherence
materially worsens.  Formal CFD for this candidate occurs only after exit.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and state-feedback turning
source_mechanism: separate rhythmic carrier motion from the slower steering response before closing the route-feedback loop
transferable_invariant: route feedback should react to body-frame macroscopic turn response rather than a repeatable within-beat yaw component attributable to observed joint motion
nontransferable_details: published CPG gains, clock phase, robot-specific yaw models, species kinematics, dimensional frequencies, exact vortex phases, and prescribed routes
policy_translation: subtract the evidenced carrier-locked yaw component using a bounded linear combination of normalized yaw rate and head-joint velocity, then use that phase-neutral rate in the existing target-relative feedback and redirect gates
falsification: reject if early alignment, capture time, or mean distance does not improve, or if terminal steering, wake coherence, actuator-limit residence, force, or moment materially regresses
