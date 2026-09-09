# Range-conditioned two-joint steering handoff candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts and the assigned parent's completed rollout report
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. In both visual rows, the longer runs shed a
  coherent alternating top-down street and compact three-dimensional Lambda2
  structures behind a translating fish. Motion is self-propelled; the common
  failure is route topology rather than advection, wake collapse, or numerical
  instability.
- Raw score alone is misleading here. The phase-conditioned sampled candidate
  has the best score (`-7.550`) because it exits the upper boundary at
  `16.77T`, but never gets closer than `5.658L`. The line-of-sight-rate sampled
  parent retains a coherent wake through `30.12T`, reaches `3.369L`, and
  crosses the target x station at `y=12.994L`; it is the stronger useful route
  mechanism despite its lower score.
- The assigned parent's opposed two-joint allocation is a semantic improvement
  but an overcorrection. It is the first inherited trajectory to enter `3L`
  and improves closest approach from `3.369L` to `2.232L`, yet changes the
  target-station pass from `3.494L` high to `2.907L` low (`y=6.593L`) and then
  exits left with final range `11.487L`. At ranges `5L`, `4L`, and `3L`, its
  head is respectively at `y=10.394L`, `9.734L`, and `8.916L`: early opposed
  allocation obtains the missing redirect, but keeping its anterior share
  during approach carries the fish through the target line before capture.
- The assigned rollout preserves a strong alternating wake, so the low pass is
  not a propulsion loss. Its actual raw acceleration-envelope occupancy rises
  to `69.2%` anterior and `75.1%` posterior, versus `57.7%` and `74.0%` for
  posterior-only line-of-sight release. This also falsifies the inherited dry
  replay expectation that anterior occupancy would remain unchanged and rules
  out increasing the opposed share.
- Range-only carrier damping on posterior-only release lowers acceleration
  occupancy but repeats essentially the same route (`3.392L` minimum and
  `y=12.992L` target-station crossing). Thus drive relief alone is not the
  missing correction; range must change where the steering residual is
  expressed.

## Policy hypothesis recorded before editing

Preserve the assigned parent's normalized bearing, rotation-invariant
line-of-sight rate, phase-conditioned yaw residual, and coherent traveling-bend
carrier. Preserve its `0.30` opposed anterior allocation outside the approach
zone because that is the only completed mechanism to enter `3L`. As range
falls continuously through a `5L`-centered transition, hand the same bounded
steering request back from the anterior oscillator center to the posterior
target. The request itself and its sign do not change; only its allocation
does. This uses the observed fact that the assigned route is already near the
target y-coordinate around `4L` range, and removes the anterior authority that
then drives the low overshoot. At zero steering the carrier is exactly
unchanged, and the schedule uses normalized range rather than a clock, stage,
world coordinate, target identity, or memorized route.

Expected evidence is the assigned parent's coherent wake and first entry into
`3L`, followed by a target-station crossing between the parent's high
`12.994L` and the assigned rollout's low `6.593L`, preferably capture. Reject
the handoff if it loses entry into `3L`, repeats either boundary pass, weakens
the alternating wake, or does not reduce the assigned rollout's elevated
anterior saturation. That would show that memoryless range-conditioned
allocation cannot release the redirect soon enough and favor a genuinely
beat-scale response estimator or a different carrier.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and biological terminal approach
source_mechanism: preserve a rhythmic propulsive carrier while sensory geometry continuously redistributes bounded steering authority between broad pursuit and approach
transferable_invariant: once broad target-directed motion works, use normalized approach geometry to release excess whole-body steering authority without removing the propulsive wave or the route-response loop
nontransferable_details: published gains, robot linkage geometry, dimensional frequencies, clock-driven phases, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: retain body-frame bearing and rotation-invariant line-of-sight response, keep opposed two-joint allocation far away, and continuously hand the same bounded residual back to the posterior joint as normalized range enters the evidenced approach zone
falsification: reject if the controller no longer enters `3L`, retains a greater-than-`2L` high or low pass, fails to reduce anterior saturation, or loses the coherent self-propelled wake

## Dry validation after the edit

- The required guidance materiality, Julia policy contract and parameter
  schema, and solver-boundary checks pass locally and in the dedicated
  check-runner. No CFD was run.
- A deterministic mirrored-state check passes: reflecting target lateral
  geometry, lateral velocity, yaw rate, joint state, and joint rate negates
  both acceleration commands to floating-point tolerance.
- The allocation schedule has the intended bounded limits: anterior share is
  approximately `0.30` at `8L`, `0.15` at `5L`, and zero by `2L`. Zero steering
  leaves the state-feedback traveling-bend carrier unchanged. Only downstream
  CFD can test the route, wake, capture, and saturation falsification criteria.
