# Gait-frame target-projection promotion

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and semantic `capture`.  The two
  copies of the assigned v27 parent reproduce `23.6390 T`, mean distance
  `2.44217 L`, and score `-0.54451` exactly.
- I inspected the top-down vorticity and oblique Lambda2 rows from release to
  termination for the strongest sample, the v28 gait-frame target projection,
  and the most informative mixed regression, the v28 quiescent posterior-wave
  start.  Both are self-propelled: compact startup structures become a
  coherent alternating posterior wake, with no imposed flow available for
  advection.  The gait-frame policy visibly commits to the target-signed arc
  earlier and reaches the capture circle at `20.5315 T`; the posterior-start
  policy remains nearly straight longer and captures at `24.2220 T`.
- Trajectory and diagnostic data agree with the images.  Gait-frame projection
  improves distance over v27 from `11.8178` versus `11.9855 L` at `4 T` to
  `1.1210` versus `3.2546 L` at `20 T`, lowers mean distance from `2.44217` to
  `2.18697 L`, and improves score from `-0.54451` to `-0.29558`.  It raises
  mean/max speed from `0.553/0.810` to `0.628/0.894 L/T`, while peak planar
  force and yaw moment rise only from `0.02974/0.01484` to
  `0.03056/0.01525`; any-joint acceleration-limit residence falls from
  `48.21%` to `46.32%`, although head residence rises to `35.95%` as tail
  residence falls to `10.37%`.  Those are measurable load and robustness
  boundaries, not evidence to weaken the large route gain in this candidate.
- The posterior-start branch proves that better launch distance alone is not
  enough.  It beats v27 at `2--16 T` and slightly improves mean distance to
  `2.42365 L` and score to `-0.52481`, but delays capture by `0.5830 T`, is
  behind at `20 T`, and raises peak planar force/yaw moment to
  `0.03442/0.01717`.  Its coherent wake survives, so the regression is route
  phase/topology rather than failed propulsion.  The inherited transferred
  carrier's approach-then-diverge `left_domain` rollout remains the semantic
  failure boundary; completion-gated redirect release, common-mode derivative
  rejection, and carrier-first projection therefore remain protected.

## One-candidate policy hypothesis

Promote the completed v28 gait-frame target-projection policy exactly as the
single candidate.  Keep the proven large-error redirect on raw normalized
body-frame target geometry.  For proportional route feedback, subtract the
redirect's bounded expected anterior mean from observed head-joint angle and
use the existing joint-state carrier coefficient to rotate target bearing and
target-vector angle into the gait frame.  This makes angle and rate rejection
semantically consistent while leaving the state-feedback oscillator,
posterior lag, completion gate, half-cycle steering, and carrier-first command
projection unchanged.  Do not add the sampled posterior-start term: its early
closure did not survive as faster capture and materially increased load peaks.

This candidate has already demonstrated capture at `20.5315 T`, mean distance
`2.18697 L`, and score `-0.29558` in the sampled CFD; no performance claim is
made for any later or held-out evaluation.  Falsify the reusable mechanism if
a changed initial pose or hydrodynamic condition loses capture, returns to the
inherited approach-then-diverge topology, destroys the coherent two-view wake,
or materially worsens acceleration-limit residence, normalized force, or yaw
moment.  Treat the higher speed and anterior saturation as explicit held-out
robustness checks.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual control over rhythmic locomotion
source_mechanism: separate observed gait-synchronous carrier motion from persistent direction feedback while retaining the propulsive oscillator
transferable_invariant: target feedback should reject an observed carrier common mode without cancelling the deliberate mean curvature that changes the route
nontransferable_details: published gains, clocked phase, robot geometry, species-specific kinematics, dimensional cadence, exact vortex phases, and prescribed task routes
policy_translation: retain raw normalized body-frame target geometry for redirect selection, subtract its bounded expected anterior-joint mean from observed joint angle, and use the existing joint-state carrier estimate to project proportional bearing and target-vector angle into a gait frame under the two-joint state-feedback contract
falsification: reject if held-out evaluation loses capture or route closure, loses the coherent alternating posterior wake, or materially worsens acceleration-limit residence, normalized force, or yaw moment

## Evidence boundary

The numerical and visual claims above come only from completed sampled CFD,
the assigned parent, and inherited optimizer notes.  Formal evaluation after
this worker exits becomes evidence for a later worker.
