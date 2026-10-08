# Response-gated redirect candidate

## Visual and quantitative diagnosis recorded before the policy edit

- The assigned prefill, `solver_87b1054daf2c`, and all four sampled results
  satisfy the experiment contract: direct uniform still-water initialization,
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and finite dynamics.
  Every sample nevertheless ends by leaving the upper virtual boundary rather
  than by capture.
- The prefill's top-down row develops an alternating red/blue caudal wake and
  its oblique Lambda2 row confirms coherent three-dimensional shedding, so its
  motion is self-propulsion rather than advection. It turns into a persistent
  positive-y course and exits at `13.178T`, improving only to `8.515L`. Its
  posterior action is on the acceleration limit in `55.8%` of trajectory
  samples.
- The strongest sample, `solver_324d10ed189d`, keeps an equally clear
  alternating top-down wake and discrete three-dimensional oblique vortex
  train while its one-sided posterior wave relief carries it much farther
  left. Relative to the otherwise matching continuous course-bias sample
  `solver_ab59732b5ad0`, it lowers posterior action-limit residence from
  `60.8%` to `35.9%`, improves closest approach from `6.218L` to `5.144L`, and
  delays upper exit from `16.879T` to `18.975T`. This is positive evidence for
  preserving rather than replacing the phase-relief scaffold.
- The best trajectory still exposes a response defect. At `12.001T`, before
  the terminal boundary is close, the body-frame target bearing is about
  `-0.166 rad` while inertial course angle is `+0.666 rad`; center y has already
  reversed upward to `13.008L`. The bounded cruise request is corrective, but
  the opposed posterior wave still cancels much of its mean bend. The path
  reaches its `5.144L` minimum at `15.312T`, then rises to center y=`15.203L`
  with `0.632 U` positive-y velocity. Thus coherent propulsion and partial
  wave relief are useful, while continuously swimming through a large
  target-versus-course mismatch is not.
- Inherited logs rule out two superficially similar changes: the two-sided
  half-cycle scaler regressed to `11.778L` minimum distance and `8.800T`, while
  one-sided acceleration-lobe gating reached only `11.448L` at `9.053T`.
  They also warn that the available bearing/yaw-rate history spans only about
  `0.033T`, so it is not an evidenced cycle-scale response estimate.

## Policy hypothesis

Start from the sampled best target-versus-course controller and retain its
anterior oscillator, posterior lag, posterior-only cruise curvature, and
one-sided wave relief. Add one response-gated redirect mode driven by the
speed-reliable exact difference between body-frame target bearing and inertial
course. Small mismatch leaves the evidenced cruise law unchanged. A large
mismatch smoothly increases posterior mean curvature and nearly removes only
the opposing wave lobe; alignment makes the gate release without a timer or
hidden stage. This is a state-feedback translation of a burst redirect, not a
frequency/amplitude gain sweep.

Expected downstream evidence is the same coherent wake and early x progress,
followed by an earlier course reversal near the `12T` mismatch, center y safely
below the upper margin, and either a better termination class or closest
approach below `5.144L`. Reject the mechanism if redirect gating destroys the
alternating wake, raises persistent posterior limit residence, triggers on
low-speed release noise, or repeats the positive-y upper exit without better
distance.

bookshelf_consulted: true
source_domain: biological C-start or burst redirection and sensor-feedback robotic-fish direction tracking
source_mechanism: gate a strong bounded redirect by observed direction error, then release it when the measured motion responds
transferable_invariant: preserve steady propulsion for small motion error but temporarily prioritize curvature over the opposing propulsive half-cycle when target-versus-course error is large
nontransferable_details: species-specific C-start kinematics, dimensional thresholds, published CPG gains, clock phase, exact vortex phase, and task-specific routes
policy_translation: form a speed-reliable target-bearing-minus-course residual from normalized body-frame observations; use it to blend posterior cruise curvature into a bounded redirect and attenuate only the opposing joint-state wave lobe
falsification: reject if wake coherence or early x progress collapses, posterior saturation rises materially above 35.9%, the gate responds strongly before reliable translation, or the 5.144L and upper-exit benchmarks do not improve

The new candidate has no same-worker CFD result; these criteria are for the
downstream evaluator.

## Non-CFD verification

- The prescribed guidance-provenance, Julia policy-contract, parameter-schema,
  and solver-boundary checks pass.
- A deterministic `2,187`-state sweep verifies finite bounded accelerations
  and exact sign reversal when bearing, lateral velocity, joint angles, and
  joint rates are reflected together.
- As a counterfactual command audit only, replaying the new law on the sampled
  best trajectory raises posterior limit residence slightly from `35.9%` to
  `37.9%`, remains far below the matching continuous-bias result's `60.8%`, and
  gives a mean redirect gate of `0.110` before `6T` versus `0.451` overall.
  This confirms low-speed/early cruise separation but does not predict the new
  closed-loop trajectory.
