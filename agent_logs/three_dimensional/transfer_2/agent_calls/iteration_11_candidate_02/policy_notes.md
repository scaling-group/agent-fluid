# Candidate wake-policy notes

## Evidence diagnosis before the policy edit

- The four sampled rollouts are valid direct-uniform still-water releases:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, finite moving-window shifts,
  stable dynamics, and `capture` termination. They capture in
  `19.706--20.207T`, with scores from `-0.21598` to `-0.22712`; there is no
  semantic failure in the sampled batch.
- Both visual rows were inspected for the strongest sampled controller and the
  slower LOS-free half-cycle comparator. The top-down sheets show coherent
  alternating vorticity from release into a smooth left/down intercept, and
  the oblique sheets show compact three-dimensional Lambda2 structures
  following the body through capture. The fish is self-propelled rather than
  advected, and neither view shows wake collapse, collision, or instability.
  The current problem is incremental route efficiency, not propulsion.
- Metrics support preserving the prefilled LOS-led half-cycle scaffold. It
  reaches `6.426L` at `12T`, `3.615L` at `16T`, and captures at `0.747L` and
  `19.706T`, with score `-0.21598`. Removing LOS lead delays capture to
  `20.207T`; course-gated carrier relief captures at `19.949T`; and releasing
  redirect curvature when yaw responds captures at `19.850T`. All retain the
  same coherent wake and approximately `0.025/0.013` planar-force/yaw-moment
  peak class, so neither carrier relief nor response release beats the current
  trajectory.
- The assigned parent's completed candidate is a concrete negative result that
  postdates its hypothesis. Applying the half-cycle factor to posterior LOS
  redirect curvature preserved capture and both wake rows, but regressed to
  score `-0.24199`, capture at `20.168T`, and `6.551L` at `12T` versus the
  prefill's `6.426L`. It also raised posterior angle peak to `0.602rad` without
  lowering command-bound residence enough to justify the slower route.
  Therefore the redirect remains a slow mean C-bend; it will not be
  phase-scaled again.
- A signal audit exposes a narrower testable boundary. The policy calls
  `bearing_window_rate + turn_rate_recent` an inertial LOS rate, but during the
  approach that sum is often dominated by beat-scale yaw. Along the winning
  trajectory it is about `-3.47rad/T` at `14T` while the instantaneous
  body-frame target/velocity cross product gives only `+0.02rad/T`; at `16T`
  the signs also disagree. They agree during useful late steering near
  `18--19T`, then disagree again near `19.5T` as the target crosses the nose.
  This provides an observation-level reason to reject inconsistent lead
  bursts while retaining the independently positive LOS mechanism.

## One-candidate hypothesis

Preserve all evaluated propulsion, route, distance/closing allocation,
velocity-course redirect, LOS-lead, half-cycle route steering, and smooth
actuator bounds. Add one reflection-equivariant LOS-coherence gate. Compute a
second inertial LOS-rate cue from the normalized body-frame target vector and
body velocity cross product, and admit the existing history/yaw lead only when
the two rates agree in sign with sufficient magnitude. This changes no route,
clock, morphology, or actuator channel; it separates slow collision-course
information from alternating body-yaw contamination before the same bounded
two-joint C-bend map.

Expected signature: preserve capture and the coherent top-down/oblique wake,
match the prefill's early progress, avoid the parent's `6.55L` middle-field
regression, and reduce distance integral or capture time by suppressing
wrong-sign redirect bursts without weakening the agreeing lead at `18--19T`.
Falsify the candidate if capture is lost; arrival moves outside the sampled
`19.7--20.2T` class; it falls back toward the `20.207T` LOS-free trajectory;
or command residence, joint limits, force, moment, or either wake row worsens.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and wake-disturbance residual control
source_mechanism: separate persistent target-course feedback from fast alternating yaw or crossflow before modulating a propulsive rhythm
transferable_invariant: retain a bounded navigation lead only when an independent body-frame kinematic cue supports the same turn, while leaving the traveling-wave carrier intact
nontransferable_details: published gains, clocked CPG phase, species-specific bends, dimensional update rates, exact vortex phase, wake routes, and source-task coordinates
policy_translation: compare history/yaw LOS lead with the normalized target-vector/velocity cross-product LOS rate, smoothly gate only their agreeing component, and feed it into the existing approach-gated two-joint mean-curvature redirect
falsification: reject if the gated lead loses capture or reverts toward LOS-free timing, fails to reduce wrong-sign terminal steering, disrupts wake coherence, or worsens command, joint, force, or moment limits
