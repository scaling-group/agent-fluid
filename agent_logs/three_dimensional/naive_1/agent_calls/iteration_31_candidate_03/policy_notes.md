# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. Three independently
  evaluated, executable-identical compositions reproduce exactly
  `22.500492T` capture, `0.749267L` crossing, `2.120233L` scored mean distance,
  and score `-0.225086`. The matched target-error allocation without the
  line-of-sight predictor captures later at `23.122009T`, with `0.749192L`
  crossing, `2.127679L` mean distance, and score `-0.231273`.
- Both visual rows were inspected from release through termination. Every
  top-down sheet shows self-propelled motion along the established S-shaped
  route, with an attached alternating red/blue caudal street rather than
  advection, wake collapse, or a static bend. One composition has a complete
  oblique row: discrete three-dimensional Lambda2 structures form behind the
  caudal region by `4T` and persist through capture. The other two composition
  rows and the no-predictor comparison are black oblique render artifacts, so
  they do not provide independent three-dimensional wake confirmation.
- The predictor composition is identical to the comparison through `8T`, is
  slightly ahead by `12T` (`6.201L` versus `6.203L`), and is materially closer
  at `20/22T` (`2.002/0.970L` versus `2.104/1.134L`). Reconstructing the policy
  signals from logged head pose over the same seven-sample observation window
  shows that `bearing_window_rate - turn_rate_recent` has the target-error
  reinforcing sign after rudder recruitment: it is about `0.09 rad/T` through
  `14--20T`, rises to `0.28 rad/T` by `22T`, and is about `0.51 rad/T` at the
  crossing. This supports the slow line-of-sight response as the cause of the
  later-route improvement rather than a launch or scalar-drive change.
- The improvement has bounded costs. Mean action rises from `58.990` to
  `59.671`, anterior/posterior exact rate-cap occupancy rises only from about
  `11.68/6.21%` to `11.73/6.38%`, and peak normalized force/moment remain
  exactly `0.030527/0.015817`. At about `20--21T`, however, the fixed one-cycle
  prediction still lets the smooth rudder-error gate fall to roughly
  `0.91/0.79` while the target line is rotating away. The current evidence
  supports testing a bounded approach allocation, not changing carrier gain,
  maximum rudder angle, or a phase-local recovery term.
- The inherited optimizer logs supply the informative negative controls. A
  target-side half-cycle redistribution delayed capture to `23.452015T` and
  raised load peaks; tail-rate unloading, angle-quadrature stacking, and an
  unqualified yaw-moment residual also regressed the captured route. Fitted
  beat-synchronous self-motion subtraction was worse: it retained a rhythmic
  two-view wake but converted capture into a `0.813329L` near miss and later
  domain exit. Thus visible wake persistence alone does not validate a route
  modifier, and the new test must remain confined to the already successful
  slow posterior-rudder path.

## One candidate hypothesis

Preserve the assigned parent's through-water course observation, anterior
oscillator recovery, full target geometry, target-error allocation of the
fixed `0.12` posterior recovery share, phase-selective carrier, reactive-rudder
sign and `16 deg` ceiling, and response-plus-stroke terminal relief. Change
only the pursuit prediction horizon: retain the evidenced one-cycle
line-of-sight lead at the outer rudder boundary, then smoothly add at most half
a carrier cycle as the existing normalized `8.0--5.5L` rudder-distance gate
fills. The same gate still multiplies rudder authority, so this is a bounded
approach allocation rather than a larger tail angle or carrier gain.

The hypothesis is that a fixed temporal lead under-allocates the independently
successful slow target-line response as angular sweep grows near the target.
Using the already validated proximity state to lengthen only that prediction
should keep the unchanged launch and coherent carrier, avoid the observed
`20--21T` error-gate dip, and advance capture without introducing another
actuator path. The controller continues to use only normalized body-frame
target geometry, water-relative velocity, response history, and joint state;
it adds no clock, coordinate, route memory, target identity, modeled vortex
phase, or scalar propulsion increase.

Falsify the mechanism if capture is lost or later than `22.500492T`, scored
mean distance exceeds `2.120233L`, score does not exceed `-0.225086`, or the
unchanged `0--8T` route and improved `20--22T` approach are not retained. Also
reject it if mean action exceeds `59.671`, anterior/posterior exact rate-cap
occupancy exceeds about `11.73/6.38%`, peak normalized force/moment exceed
`0.030527/0.015817`, or a valid two-view sheet fails to retain the established
alternating three-dimensional wake. Any win remains fixed-pose still-water
evidence, not held-out robustness.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and bounded terminal capture control
source_mechanism: preserve the rhythmic locomotor carrier while a slow measured target-line response continuously schedules a separate bounded steering path
transferable_invariant: directional prediction may be strengthened by normalized approach state without changing the carrier or maximum steering authority
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, robot calibration, source-task look-ahead horizons, exact vortex phases, fixed coordinates, and prescribed routes
policy_translation: retain the validated body-frame line-of-sight residual and smoothly add at most half a carrier cycle to its prediction horizon only as the existing rudder-distance gate fills
falsification: reject if capture is later than 22.500492T or lost, mean distance exceeds 2.120233L, or route, valid two-view wake, action, saturation, force, or moment envelopes worsen
