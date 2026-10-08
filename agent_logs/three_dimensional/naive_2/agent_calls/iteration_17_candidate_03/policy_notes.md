# Evaluated mean-preserving yaw-demodulation candidate

## Visual and metric diagnosis before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm, and finite capture. Three
  are exact replications of the prefilled raw-`q1` yaw demodulator, capturing
  at `16.6375T` with score `-0.119674`; the distinct
  `solver_5ef271950e5a` mean-preserving variant captures at `16.6320T` with
  the better score `-0.118307`. There is no sampled failure in this assigned
  set, so the informative controlled comparison is the replicated captured
  parent rather than a missing failure sheet.
- I inspected both rows of the combined keyframe sheets for the distinct best
  example and a replicated parent. In both, the top-down row shows
  self-propelled targetward translation with a coherent alternating wake from
  release through capture, while the oblique row shows finite,
  tail-connected three-dimensional Lambda2 structures. The nearly identical
  target-crossing arcs and wake topology show that the one-line demodulation
  change preserves the established propulsive and steering carrier.
- The trajectory and wake diagnostics agree with the images. Relative to the
  three identical raw-`q1` rollouts, mean-preserving demodulation lowers the
  scored distance integral from `2.003406L` to `2.001992L`, observed distance
  integral from `1.380093L` to `1.378485L`, maximum joint magnitudes from
  about `0.5500/0.5603 rad` to `0.5477/0.5557 rad`, speed-near-limit residence
  from `27.5%` to `27.3%`, and acceleration-near-limit residence from `74.0%`
  to `73.9%`. Peak planar force/moment also fall slightly from
  `0.03687/0.01856` to `0.03678/0.01827`. The gains are small, but every
  reported effort/load direction is favorable while capture and the wake are
  retained.
- Inherited logs establish the mechanism boundary. Before demodulation, the
  best phase-selective raw-yaw controller missed at `2.169L` and exited high;
  adding terminal anterior or posterior mean curvature worsened approach and
  the posterior burst contacted the joint limit. The raw recent-yaw signal
  was `93.3--99.7%` explained by anterior joint phase inside `6L`. The
  captured raw-`q1` demodulator fixed that response semantic, and the assigned
  child's completed result now shows that removing only the zero-mean carrier
  coordinate preserves the slow anterior course response and modestly
  improves the successful trajectory without scalar tuning.

## Single policy hypothesis

Promote the evaluated `solver_5ef271950e5a` policy as this workspace's sole
candidate. Preserve all propulsion, route, phase-selective relief, and
actuator parameters. Make exactly one semantic change to the prefilled
candidate: reconstruct carrier-correlated yaw from
`q1_carrier = q1 - head_course_center`, not raw `q1`, while retaining measured
`q1_dot` as the phase-rate cue. The yaw feedback then subtracts the fast
state-derived oscillatory component but retains the bounded slow approach
course center as directional response.

This is normalized body-frame, reflection-equivariant, clock-free feedback.
It adds no mean curvature, wave shedding, route memory, or gain tuning. The
completed comparison supports reproducing capture near `16.63T` with slightly
lower distance cost and effort/load metrics. Falsify reuse if capture is lost,
the target-crossing arc or connected 3D wake changes materially, carrier
correlation remains in the residual, or saturation, joint contact, force, or
moment rises outside the narrow completed advantage.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and fish turning by phase-compatible asymmetry
source_mechanism: preserve a rhythmic propulsive carrier while feedback acts on a separately measured slow directional response
transferable_invariant: remove only the mean-free joint-state-correlated carrier component before comparing body-frame route request with yaw response
nontransferable_details: published gains, robot or species geometry, dimensional beat timing, prescribed routes, maneuver duration, and exact vortex phase
policy_translation: form the anterior oscillatory coordinate by subtracting the bounded course center from joint angle, reconstruct carrier yaw from that coordinate and joint velocity, and retain the residual in the existing bounded posterior response channel
falsification: reject if nominal capture, distance integral, connected wake, or effort/load envelope worsens, or if the compensated yaw remains carrier-correlated

## Evaluation boundary

The favorable evidence above belongs to the completed sampled solver, not to
this unevaluated child. Later evaluation should compare semantic capture and
arrival first, followed by distance integral, target-relative trajectory,
raw-versus-compensated yaw phase correlation, acceleration and speed-limit
residence, joint contact, peak force/moment, and both wake views against the
replicated raw-`q1` parent.
