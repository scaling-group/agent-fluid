# Steering-priority recapture-handoff candidate

## Evidence diagnosis before the policy edit

All four sampled evaluations are finite, direct-uniform still-water rollouts
with `U_infinity=0`, no cylinders, and no prewarm.  Both required rows of the
combined keyframe sheets were inspected for the strongest finite sample and
the persistent-route recapture failure.  The top-down views show alternating
vorticity laid behind the translating fish, and the oblique Lambda2 views show
coherent three-dimensional shedding through approach and turning.  The fish is
self-propelled; missing capture is a controller-handoff problem rather than
advection, wake collapse, or numerical instability.

The sampled posterior-recapture family remains a concrete negative result.
Persistent route relief reaches `2.996L` and carrier-unloaded recapture reaches
`3.024L`; both make the same broad late hairpin and leave the upper boundary
near `49.4T` at `7.42--7.52L`.  The sector-intercept/recapture parent improves
that pass to `2.579L`, but still follows an upper-exit arc at `45.331T`.

The assigned steering-priority sample introduces the only new semantic
trajectory in this population.  It preserves the common path through about
`16T`, then turns across the target neighborhood, reaches `1.076L` at about
`25.98T`, and improves mean/final distance to `6.178/6.307L`.  Its raw
acceleration-envelope exposure falls from the sector parent's `82.76%` to
`74.65%`.  At closest approach, however, speed is still about `0.76L/T`; the
target is posterior and lateral in the normalized body frame, the recapture
request reconstructed from the recorded state is about `0.97`, and closing
speed is near zero so the intercept-gated allocator is releasing.  The fish
then continues north and leaves at `37.823T`.  This sample also spends `13.86%`
of its trace at a joint position limit (the sector parent spends none) and has
isolated force/moment coefficient spikes of about `0.466/0.211` when the
posterior joint is on its `45 deg` hard stop.  Those loads make simply enlarging
curvature or extending a raw bias unsupported.

## Policy hypothesis

Preserve the evaluated steering-priority sector interception exactly, including
its state-feedback traveling carrier, normalized body-frame pulse, recapture
curvature, and existing acceleration bound.  Change only the allocator handoff:
for each joint, extend the closing-sector gate with the magnitude of the
target-behind recapture request, subject to a smooth joint-state headroom guard
when its steering acceleration would push a near-limit joint farther into the
same position stop.  Thus bounded steering retains first claim on the existing
acceleration envelope after closing reverses, but added handoff authority cannot
intensify a same-side hard stop.  Ordinary carrier allocation returns when
body-frame target geometry is reacquired or lateral recapture error closes.  No
steering magnitude, oscillator gain, target coordinate, clock, route, or stored
mode is added.

An initial unguarded fixed-state audit justified the headroom condition before
the final policy edit: at the recorded `24.002T` state, with posterior angle
already at `-45 deg`, extending recapture priority would have changed its raw
acceleration from about `-7.0` to `-29.5 rad/T^2`, directly contradicting the
load falsification boundary.  The guard leaves the evaluated intercept gate in
control there and becomes transparent once the joint has moved away from the
stop or steering points back toward its interior.  The same headroom also fades
the final same-side outward command only while recapture is active.  At the
exact position stop the fixed actuator integrator discards that acceleration
and resets outward rate to zero, so removing it cannot remove useful joint
motion; inward recovery and every target-ahead command remain unchanged.

Expected result: retain the `1.076L` interception and use the existing
recapture bend consistently enough to cross the `0.75L` capture circle, while
not increasing raw acceleration exposure.  Falsify the mechanism if the
pre-intercept path changes, minimum distance worsens, the same northbound exit
remains, the coherent traveling wake is lost, or joint hard-stop exposure and
force/moment spikes are not reduced below the assigned parent's class.

bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish turning
source_mechanism: large observed route error receives bounded reorientation authority until measured response or geometric reacquisition releases it back to the propulsive rhythm
transferable_invariant: a redirect should hand off on observed body-frame response rather than lose steering authority merely because range stops closing
nontransferable_details: species-specific C-start shapes, published gains and timing, dimensional beat settings, exact vortex phases, full-body kinematics, and task-specific routes
policy_translation: extend each joint's existing steering-first acceleration allocator from the normalized closing sector through mirror-equivariant target-behind recapture, while joint-state headroom withholds added priority and fades only discarded same-side outward acceleration near a position stop
falsification: reject if the `1.076L` pass is lost, recapture does not cross the capture radius or improve exit topology, pre-sector commands change, or position-limit exposure and hydrodynamic load spikes persist or worsen

## Pre-evaluation checks

- The prescribed reusable-guidance check passes and confirms a material
  semantic change from the assigned parent.  The public Julia contract and
  editable-boundary audit also pass; no CFD was run.
- All `75` direct `params.FIELD` references resolve among the `77` fields
  returned by `target_policy_params()`.
- A deterministic `20,736`-state comparison with the evaluated steering-
  priority parent spans mirrored target geometry, closing speed, bearing
  trend, yaw rate, and joint phase.  Every output is finite; all `12,960`
  zero-recapture states preserve the parent command exactly, while `6,912`
  target-behind states exercise the new handoff.  Signed component grids
  confirm reflection equivariance of the allocator, joint-headroom gate, and
  final outward-command guard, including zero same-side outward command at a
  full recapture hard stop and full authority for steering back toward the
  interior.  These are fixed-state algebraic checks, not a claim about the
  unevaluated closed-loop result.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its three specified no-CFD commands were
  therefore executed directly and passed.
