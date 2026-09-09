# Step 37 target-policy diagnosis

## Evidence read before the edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, and `capture` at
  `0.74923--0.74986L`. The best finite score is the prefilled unsupported-
  bearing policy at `-0.14991`, `18.6560T`; two exact speed-reserve samples
  capture at `18.4525T` and `18.6010T`.
- In the best sampled combined sheet, the top-down row lays down a sustained
  alternating vortex street from release to capture and the oblique row keeps
  bilateral Lambda2 structures through the approach. Its terminal inertial
  speed is `0.8369L/T`, peak planar force coefficients are
  `0.01486/0.02864`, peak yaw-moment coefficient is `0.01648`, head/tail
  actions clip on `68.75%/70.70%` of rows, and speed-limit residence is
  `10.29%/11.29%`. Motion is self-propelled, coherent, and finite rather than
  advection, collision, coasting, or numerical instability.
- The assigned-parent response-released posterior recovery burst is the
  informative failure. Its top-down and oblique rows retain an active
  alternating wake after the first pass, but the fish turns onto the lower,
  target-separating branch, reaches only `1.60570L`, and exits at
  `10.03632L`. Terminal speed remains `0.7675L/T` and its force/moment peaks
  remain within the sampled carrier envelope, so the failure is recovery
  geometry rather than weak propulsion or instability.
- The inherited additive progress-loss burst supplies an independent negative
  result: it reaches `1.16080L`, lowers action clipping to about
  `53.12%/50.97%`, but also makes no second approach and exits at `9.84225L`.
  Together these outcomes reject widening or scalar-tuning a post-pass burst;
  measured loss of distance closure identifies separation too late to specify
  a useful redirect.
- Offline reconstruction of the evaluator's seven-row body-frame bearing
  window shows a pre-separation signature. During the first approach at
  `1.5--2.0L`, mean positive bearing-divergence product is
  `0.353--0.404 rad^2/T` in three sampled captures, versus
  `0.549--0.841 rad^2/T` in the four inherited lower-pass failures examined.
  This supports testing target-image divergence as a bounded derivative
  steering residual, not as another route gain.

## Candidate hypothesis

Restore the repeat-backed intercept-guarded speed-reserve carrier and remove
the rejected outer-terminal unsupported-bearing addition. Add exactly one new
mechanism inside the existing spatial steering allocation: once the existing
intercept distance gate is active, normalize the signed product of body-frame
target bearing and its seven-row bearing rate by the carrier frequency. If the
target is moving farther from the body axis, add a smooth target-signed
derivative residual bounded at `4 rad/T^2`; if bearing is stationary or
converging, the residual is zero. The mechanism does not change route gain,
release logic, carrier, cadence, allocation, fixed coordinates, time, or
mutable state, and the final actuator clamp remains unchanged.

The falsifiable expectation is a tighter first-pass path before distance
closure changes sign, while retaining the posterior traveling bend and the
repeat-backed actuator/load envelope. Reject it if it weakens either wake,
changes far-field closure, loses sampled capture, retains the lower exit,
raises clipping or loads outside that envelope, or if the short-window bearing
rate proves to be only a beat-phase artifact.

## Non-CFD checks and discarded alternative

- A release-veto translation of the same signal was rejected before finalizing
  the candidate. Counterfactual reconstruction found that the existing
  intercept/LOS guards had already made release zero on all four inherited
  lower-pass traces where target divergence was large; another veto would
  change none of those failures while perturbing sampled captures.
- Replaying the final residual over recorded state histories makes it exactly
  zero at and outside `2.75L`. Inside the intercept region its pre-closest-pass
  mean absolute magnitude is `0.90--1.07 rad/T^2` for the three inspected
  captures and `1.16--1.21 rad/T^2` for four inherited failures; specifically
  at `1.5--2.0L` those ranges separate to `0.92--1.04` versus
  `1.25--1.53 rad/T^2`. The configured peak is `4 rad/T^2`. This establishes
  boundedness and evidence selectivity, not an unevaluated CFD benefit.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking over a rhythmic CPG carrier
source_mechanism: measured target-direction evolution supplies a bounded corrective residual while an independent traveling rhythm sustains propulsion
transferable_invariant: preserve the propulsive carrier and use normalized body-frame target motion to add directional correction only while the observed error is diverging
nontransferable_details: published gains, clocked CPG phase, robot morphology, dimensional cadence, species kinematics, exact vortex phases, and task-specific routes
policy_translation: inside the existing intercept gate, use the signed seven-row body-frame bearing-rate product normalized by observed carrier frequency to add one bounded target-signed derivative residual through the existing two-joint allocation; leave route feedback, release logic, speed reserve, and carrier unchanged
falsification: reject if the qualifier changes far-field closure, weakens either coherent wake, loses capture, retains the lower branch, worsens the repeat-backed actuator or load envelope, or responds mainly to beat phase rather than target separation
