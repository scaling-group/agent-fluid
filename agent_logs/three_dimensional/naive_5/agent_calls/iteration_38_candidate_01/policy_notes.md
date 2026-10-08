# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent (`solver_64a9b2cc44b2`) and all three sampled
  comparisons satisfy the frozen rollout contract: direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm, and
  inertial moving-window transport. All four capture without contacting the
  angle, speed, or applied-acceleration limits, so the useful discriminants are
  route response, distance integral, wake organization, and loads rather than
  termination class alone.
- Both visual rows were inspected from release through capture for the strongest
  finite example (`solver_b3cc38ade37a`), the assigned parent, and the
  informative response-yield mechanism failure (`solver_f71a78911244`). The
  top-down sheets show genuine self-propulsion and an orderly alternating wake;
  the oblique body/Lambda2 sheets show compact coherent three-dimensional
  vortices through the terminal hook. There is no passive advection, boundary
  interaction, wake breakup, numerical instability, or moving-window-induced
  body rotation. The response-yield trace stays in the parent's visible route
  family, while the duty-ratio trace separates upstream toward the target and
  arrives earlier without destroying the carrier.
- The assigned parent captures at `0.748308L` and `25.8115T`, with score
  `-0.594050`, mean distance `2.496011L`, and peak planar force/yaw moment
  `0.01896/0.01010`. Scaling both joint commands during an adverse force phase
  (`solver_f71a78911244`) is a concrete negative comparison: it captures later
  at `25.9160T`, worsens score and mean distance to `-0.594758/2.496891L`, and
  leaves the `8/16/24T` distances at `10.431/6.102/1.709L`, essentially the
  assigned route. This agrees with inherited logs that additive posterior and
  instantaneous load-gated middle corrections form a closed shallow-hook
  branch.
- In contrast, the sampled anterior course-duty mechanism
  (`solver_b3cc38ade37a`) is a material semantic improvement over the assigned
  parent: score rises to `-0.556475`, capture advances by `0.3025T` to
  `25.5090T`, mean distance falls to `2.457773L`, and distance at `8/16/24T`
  falls to `10.308/5.898/1.475L`. Its top-down centerline is visibly displaced
  targetward while both visual rows retain the coherent carrier. It remains
  inside the hard envelope, but peak angle/rate/action increase from about
  `0.7635/4.5150/29.6580` to `0.7709 rad/4.5177 rad/T/29.8680 rad/T^2`, and
  peak planar force/yaw moment rise to `0.02063/0.01065`. Its crossing is still
  shallow (`0.748598L`), and instantaneous projected miss is worse than the
  parent at `16/24T` (`4.027/1.160L` versus `3.312/1.010L`). The evidence thus
  supports the duty mechanism as bounded upstream positional progress, not as
  proven intercept alignment or a reason to increase its scalar authority.

## Policy hypothesis

Promote exactly the sampled anterior duty-ratio mechanism into the assigned
parent while preserving its state-feedback traveling bend, posterior lag,
course/miss-triggered response-released redirect, target-line residual,
posterior vectoring, middle force response, capture modulation, coordinated
acceleration projection, and angle/rate viability guards. When normalized
body-frame course error exceeds body aim, translation is observable and
closing, and the redirect is released, joint angle supplies phase to reduce
anterior restoration on the requested bend side and strengthen it on the
opposite side. A continuous far-distance complement withdraws the mechanism
at the established middle-response boundary. This changes half-cycle
residence without a clock, fixed route, static curvature, or gain-only drive
increase.

The falsifiable expectation is deterministic reproduction of the sampled
upstream trajectory separation and material distance-integral/arrival benefit,
with capture, coherent two-view wake, and zero actuator contacts retained.
Reject promotion if the next evaluation does not reproduce lower
`8/16/24T` distance and earlier capture, if the trajectory collapses back into
the assigned response-yield cluster, or if wake coherence, capture, hard-limit
clearance, or loads degrade beyond the sampled duty-policy regime. Do not
interpret repeat fixed-pose success as held-out robustness, and do not tune the
duty scalar upward while projected miss and actuator/load margins remain worse
than the assigned parent.

bookshelf_consulted: true
source_domain: robotic-fish CPG steering and asymmetric flapping
source_mechanism: alter requested bend-side half-cycle residence while retaining a rhythmic propulsive carrier
transferable_invariant: persistent body-frame route error can drive bounded state-derived duty asymmetry without prescribing global phase or a route
nontransferable_details: published gains, dimensional frequencies, linkage geometry, species-specific kinematics, clock phase, exact vortex phase, and task-specific trajectories
policy_translation: normalized body-frame target/course geometry and closing response gate a joint-angle-derived anterior restoring-phase skew; the posterior state-feedback lag and all middle, terminal, and viability mechanisms remain intact
falsification: reject on failure to reproduce upstream distance/arrival improvement, lost capture or coherent three-dimensional wake, actuator contact, or load exposure beyond the sampled duty-policy regime

## Non-CFD audit after the policy edit

- The candidate byte-matches the sampled duty-policy artifact at SHA-256
  `4fa0470d42c3a6a60c9286aa9b4a3a1d957e53fb1478686b1d7ff746ee4d43ac`.
  This makes the next CFD evaluation a clean fixed-condition replication, not
  same-worker evidence of performance or held-out robustness.
- Every direct `params.FIELD` reference is owned by the returned 65-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations. A deterministic audit of 80,000 paired stress states spanning
  both lateral reflections, far/middle/near target geometry, negative/zero/
  positive closing response, beyond-limit joint angles/rates, and helpful or
  adverse loads remains finite and within the `30 rad/T^2` policy envelope;
  paired reflection command error is exactly zero.
- The material-guidance check, exact lightweight Julia contract check, and
  solver editable-boundary check all pass. The guidance check first exposed
  two identical copied-parent markers in the rendered workspace `README.md`;
  removing only the duplicate marker restored an unambiguous assigned parent.
  The required independent check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this ChatGPT account, so its three
  prescribed commands were run directly as the established inherited
  fallback. No formal CFD was run.
