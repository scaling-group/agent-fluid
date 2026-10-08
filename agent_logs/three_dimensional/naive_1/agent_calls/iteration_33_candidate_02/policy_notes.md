# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four current samples are finite captures from the required direct-uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three executable-equivalent
  proximity-led descendants reproduce exactly `22.187000T` capture,
  `0.748118L` crossing, `2.106255L` scored mean distance, and score
  `-0.211504`. The assigned parent captures at `22.307997T`, with
  `0.748057L` crossing, `2.107401L` mean distance, and score `-0.212396`.
- Both visual rows of a reproduced best sample and the assigned parent were
  inspected from release through capture. Their top-down rows show
  self-propelled S-shaped approaches: alternating red/blue mid-plane
  structures grow behind the caudal region, remain attached to the rhythmic
  body wave, and persist through capture. Every current oblique row is black
  apart from frame labels, so these samples provide no new three-dimensional
  Lambda2 evidence. This is a render-evidence failure, not evidence of wake
  collapse; the inherited complete two-view result remains the applicable
  3D-wake bound.
- The current descendants preserve the parent's fixed one-cycle predicted
  posterior-recovery allocation and extend only the reactive-rudder prediction
  from one to one-and-a-half cycles as the existing `8.0--5.5L` proximity gate
  fills. They are already closer at `16/20/22T`
  (`3.983/1.872/0.830L` versus `3.993/1.884/0.876L`) and capture `0.121T`
  earlier. Peak normalized force/moment remain exactly
  `0.030897/0.015839`, and anterior/posterior exact-rate-cap occupancy remains
  about `11.53/6.40%`; mean action, however, rises from about `59.675` to
  `59.850`. The result supports state-dependent pursuit prediction, not more
  rudder magnitude or a larger recovery budget.
- Replaying the two rudder error gates on the sampled best trajectory shows
  what the two-sided adaptive predictor actually allocates after proximity
  begins: relative to the fixed lead, it raises the smooth rudder gate on 690
  samples when target-line motion reinforces current error and lowers it on
  760 samples when target-line motion opposes current error. Inherited matched
  evidence independently found that adding up to 20% rudder under closing
  deficit delayed capture, whereas qualified release was beneficial. That
  combination motivates isolating release from extra recruitment rather than
  performing another lead or rudder gain edit.

## One candidate hypothesis

Use a reproduced proximity-led descendant as the base. Preserve its
through-water course feedback, anterior speed recovery, full body-frame target
geometry, anterior redirect, phase-selective carrier, fixed one-cycle
posterior-recovery allocation, proximity-adaptive rudder prediction, rudder
sign and ceiling, and response-plus-stroke terminal relief. Compute both the
validated fixed-lead rudder error gate and the proximity-led error gate, then
select their minimum. The extra prediction can therefore release posterior
rudder when observed target-line motion is already correcting error, but it
cannot add rudder beyond the fixed-lead controller when the residual predicts
growing error.

This is one response-qualified actuator-allocation mechanism, not scalar
tuning. It retains the joint-state traveling carrier and every inherited
parameter value while using only normalized body-frame target geometry,
distance, and the measured de-yawed short-window target-line response. It adds
no clock, step count, coordinate, route memory, target identity, modeled vortex
phase, mutable state, or force/moment residual. The hypothesis is that the
useful part of proximity prediction is timely steering release: removing its
adverse-response recruitment half should retain the sampled route advantage,
reduce mean command effort, and avoid the previously harmful extra posterior
load.

Falsify the mechanism if capture is lost or not earlier than `22.187000T`,
scored mean distance is not below `2.106255L`, score does not exceed
`-0.211504`, or the inherited route advantage at `16/20/22T` disappears. Also
reject it if mean action is not below `59.850`, anterior/posterior rate-cap
occupancy materially exceeds `11.53/6.40%`, peak normalized force/moment
exceed `0.030897/0.015839`, the top-down alternating wake degrades, or a valid
oblique render fails to retain the inherited discrete 3D wake. Any positive
result would remain fixed-pose still-water evidence, not robustness to changed
pose, inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and distance-scheduled terminal capture
source_mechanism: preserve a posterior-delayed traveling carrier while measured route response continuously releases excess steering during target approach
transferable_invariant: bounded body-frame response may reduce a separately capped steering path once target-line motion is already corrective without suppressing the propulsive carrier
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, source prediction horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: retain fixed-lead posterior recovery and the proximity-led rudder signal, but cap its smooth rudder error gate by the validated fixed-lead gate so proximity can release and never augment posterior load
falsification: reject if capture is not earlier than 22.187000T, mean distance is not below 2.106255L, effort does not fall, or route, valid wake, saturation, force, or moment envelopes worsen
