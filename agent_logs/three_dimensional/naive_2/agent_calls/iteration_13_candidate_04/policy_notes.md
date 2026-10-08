# Candidate diagnosis and policy hypothesis

## Visual and metric diagnosis before the edit

- All four sampled rollouts and both completed rollouts inherited from the
  assigned parent use direct uniform still water with `U_infinity=[0,0,0]`, no
  cylinders, and no prewarm. I inspected every combined keyframe sheet. The
  top-down rows show self-propelled leftward motion with alternating vortex
  streets, and the oblique rows retain tail-connected three-dimensional
  Lambda2 structures through the useful transit. The recurring upper-boundary
  exit is a route-response failure, not advection, wake collapse, or numerical
  instability.
- The sampled controllers all preserve essentially the same topology. Their
  closest approaches span `4.530--5.126L`, all retain speed at the miss, and
  all leave through the upper boundary around `20.86--21.72T`. The prefilled
  signed-agreement half-cycle policy reaches `4.743L` and exits at `21.05T`;
  distance relief, bearing-response release, and closure gating do not create
  a terminal redirect or a different termination class.
- The inherited actuator-calibrated yaw-response controller is the important
  semantic improvement: it preserves the carrier, reaches `2.299L`, and
  survives to `28.41T`. Adding response-deficit posterior half-cycle relief
  improves closest approach modestly to `2.169L`, final distance from `8.092L`
  to `7.727L`, and acceleration near-limit residence from `55.0%` to `52.4%`;
  peak force and moment remain comparable (`0.0335` and `0.0170`). It still
  exits through the same upper boundary at `28.04T`, so deeper tail-only
  attenuation is not supported as the next mechanism.
- At the stronger inherited rollout's closest approach (`18.453T`), the target
  is still slightly forward but strongly lateral in body coordinates
  (`[-0.738,-2.039]L`), speed is `0.767U`, and closure is approximately zero.
  The bounded route request is `-0.999`, corresponding under the established
  actuator mapping to requested physical yaw near `+0.800 rad/T`, while the
  measured short-window yaw is `-2.281 rad/T`. The target passes behind the
  head about `0.75T` later at `2.306L`, after which the bearing definition's
  absolute longitudinal denominator does not itself encode the need for a
  near-abreast redirect. Posterior mean curvature is already effectively
  saturated, and response-gated tail relief changed this miss by only `0.130L`.

## Single candidate hypothesis

Start from the stronger inherited response-deficit controller, preserving its
full anterior state-feedback oscillator, posterior lag, empirical
posterior-curvature-to-yaw mapping, bounded mean curvature, crossflow residual,
approach-aware course redistribution, and response-gated posterior half-cycle
relief. Add one distinct actuator use: when the normalized target is near or
behind the head's transverse plane, distance is small, forward speed is
established, and measured yaw is still short of the calibrated request, shift
the anterior oscillator center by a bounded additional curvature in the route
direction. The shift is continuous, remains inside the full oscillator rather
than reducing its amplitude, and becomes exactly silent when yaw response is
correct or excessive.

This is a response-released redirect, not another scalar increase in posterior
gain. Longitudinal and distance gates leave the inherited far transit nearly
unchanged; at the observed `2.169L` miss the proposed gates would request about
`4.2` of the available `5` degrees of extra anterior center, for a combined
course-plus-response center under `8` degrees. Expected behavior is an earlier
downward pivot before the target becomes rearward while retaining the coherent
carrier. Reject the mechanism if it worsens the `2.169L` approach, repeats the
same upper exit without a materially tighter or re-approaching arc, causes
persistent joint-limit contact, raises acceleration residence or loads
materially, or disrupts either wake view. Capture or a new termination class is
the strong semantic criterion; scalar score alone is not.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve a rhythmic carrier while large directional error and missing measured response trigger transient curvature that releases once the requested response appears
transferable_invariant: use calibrated request-versus-response error to recruit a distinct bounded steering actuator only near the failed maneuver, without suppressing the propulsive rhythm
nontransferable_details: published gains, maneuver timing, species curvature, robot geometry, dimensional beat frequency, exact vortex phase, and task-specific routes
policy_translation: combine normalized body-frame target longitudinal position and distance with speed-qualified posterior-request versus measured-yaw deficit; apply the bounded result as an additional anterior oscillator-center shift and leave posterior wave generation intact
falsification: reject if the inherited 2.169L approach or coherent wake is lost, the target still passes laterally without a re-approach, the upper-exit topology is unchanged, or joint limits, acceleration residence, force, or moment worsen materially

## Evaluation boundary

No CFD result is claimed for this candidate. Post-worker evaluation should
compare semantic termination and minimum distance first, then target body-frame
components at the miss, first longitudinal pass, re-approach, speed, calibrated
yaw response, joint-limit contact, acceleration residence, force/moment peaks,
and both visual rows against the inherited `2.169L` rollout.

An algebra-only replay on that completed trajectory (not a hydrodynamic
counterfactual) bounds the new anterior center shift at `4.254` degrees. Its
mean absolute value is `0.00007` degrees outside `8L` and `2.019` degrees
inside `3L`; at the closest-approach samples it contributes
`4.141--4.209` degrees and keeps the combined course-plus-response center
below `7.8` degrees (`8.028` degrees maximum over the trace). This verifies
localization and boundedness only; the later CFD evaluation must determine the
actual trajectory, wake, loads, and limit residence.
