# Wake Policy Candidate Notes

## Evidence diagnosis

The shared prewarm sheet shows the fish held above and downstream of four
fully developed, interacting vortex streets; it is the common initial
condition, not candidate-specific evidence. All four sampled released sheets
terminate at the target, so this sample contains no visual failure to compare.
The useful finite contrast is between the current course-slip/raw-bearing
allocator and the half-cycle child built on the same carrier and allocator.

The current policy's released sheet shows a sharp initial targetward redirect,
then a long, nearly horizontal self-propelled traverse into the interacting
wake. It reaches in `45.727`, with mean distance `2.0543L`, total/mean command
energy `57829/1264.7`, RMS relative crossflow `0.2349`, and RMS force/moment
`49.36/799.31`. The half-cycle child preserves the same route topology and
capture but advances more quickly through every later sheet: arrival `36.471`,
mean distance `1.6860L`, and total command energy `48700`. Its higher mean
command energy `1335.3` and RMS force/moment `63.59/953.42` bound the benefit:
the mechanism improves redirect/propulsive effectiveness and route compactness,
not hydrodynamic load. Both touch the `30.0` acceleration and `4.5379` joint
speed limits, so increasing the envelope is not supported.

The raw-bearing reserve-only sibling arrives in `46.035` with mean distance
`2.0695L` and RMS force/moment `51.40/761.46`; the duplicate course-slip
samples reproduce the current result exactly. Thus the `9.26`-time-unit and
`0.368L` improvements of the half-cycle child are attributable to its one
structural change under the deterministic prewarm, rather than to a different
carrier, route, or scalar envelope. Inherited logs also show that feeding the
slip-corrected error into both steering and reserve regressed all major
metrics, so raw bearing must continue to own finite authority allocation.

## Candidate hypothesis

Preserve the validated `0.55` state-feedback traveling-bend carrier,
course-slip correction confined to the steering residual, raw-bearing reserve
scheduler, and `30.0` envelope. Add the sampled bounded half-cycle asymmetry:
infer beat side from normalized joint velocity and strengthen only the phase
already aligned with the requested body-frame turn. This should reproduce the
compact, faster target-reaching trajectory without introducing time, wake
phase, fixed coordinates, or another gain-only experiment.

bookshelf_consulted: true
source_domain: robotic-fish CPG steering and biological burst/asymmetric turning
source_mechanism: bounded half-cycle amplitude or duty asymmetry driven by a turn request
transferable_invariant: preserve the propulsive rhythm while moving a bounded share of steering authority toward the observed beat half-cycle already producing the requested curvature
nontransferable_details: published gains, clock phase, robot geometry, species kinematics, exact vortex phase, and task-specific routes
policy_translation: use body-frame bearing minus normalized course slip for turn direction, infer phase from each joint's velocity normalized by carrier speed, and asymmetrically modulate only the bounded steering residual before the existing allocator
falsification: reject the mechanism if the next CFD rollout loses capture, no longer improves arrival and mean distance over the `45.727`/`2.0543L` parent, or raises load without retaining a meaningful route or total-effort benefit
