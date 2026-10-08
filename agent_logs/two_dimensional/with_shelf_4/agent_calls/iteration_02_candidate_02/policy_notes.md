# Multi-wake candidate diagnosis

## Evidence read before the edit

The assigned parent is the horizon-surviving bearing-to-mean-curvature policy
from `solver_a66c54c2f79d`.  Its released keyframes show a useful semantic
change from the target-blind seed: instead of sustaining the seed's nearly
vertical bottom exit, the fish turns, stays in the domain for the full `300`
released time units, and limits cross-stream head displacement to `-3.785L`
(the target requires approximately `-4.5L` from release).  Its joint extrema
also remain below the hard envelope: `0.489/0.436 rad` angle,
`2.533/2.708 rad/time` speed, and `18.665/20.127 rad/time^2` acceleration.

That survival is not target-reaching propulsion.  The yellow trajectory loops
near the right side of the released sheets and never enters the developed
second-row wake corridor around the target.  The parent moves only `-1.187L`
upstream in `300` units, has mean body speed components close to zero, and
finishes `10.484L` from the target after getting no closer than `10.276L`.
By contrast, the target-blind seed moved `-3.545L` upstream in `50.127` units
and briefly reached `8.615L`, but coupled that thrust to `-13.300L` lateral
escape, actuator saturation, and a bottom-domain exit.  The two other sampled
mean-curvature variants (`solver_04f3a7bc23b6` and
`solver_6b08d1b9142f`) reverse immediately into downstream/rightward exits
after only `16.632` and `19.866` units.  Across all sampled results, a large
static curvature center is therefore not yet evidence of a usable pursuit
mechanism: it either destroys net upstream travel or produces a short wrong-way
turn even though the underlying traveling bend can propel.

## Candidate hypothesis

Preserve the parent's realizable state-feedback oscillator and posterior lag,
but remove the persistent curvature center.  Convert the same bounded
body-frame bearing request into tail half-cycle amplitude asymmetry: amplify
the posterior bend when its instantaneous sign agrees with the requested turn
and attenuate the opposite half-cycle by the same bounded fraction.  This
retains a zero-centered anterior propulsive rhythm and supplies a same-sign
average posterior bend without replacing the traveling wave with static
curvature.  Bearing-window rate remains a small damping term, not a route or
external phase signal.

The next evaluation should preserve full-horizon/domain survival while making
upstream displacement and closest distance materially better than the parent.
Falsify the mechanism if it reproduces the parent's right-side loop and weak
upstream travel, reverses the correct steering sign, restores a bottom exit,
or drives the tail into persistent angle/speed/acceleration saturation.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and duty-ratio turning layered on rhythmic propulsion
source_mechanism: target-feedback modulation that strengthens one tail-beat half-cycle and weakens the other
transferable_invariant: persistent body-frame direction error can create bounded turning asymmetry while the alternating traveling bend continues to supply thrust
nontransferable_details: published gains, dimensional beat frequency, robot linkage and species kinematics, clock-driven CPG phase, exact vortex phase, and source-task routes
policy_translation: map bounded body-frame bearing plus bearing-rate damping to a signed tail-wave amplitude multiplier inferred from the current lagged joint-state wave; keep the anterior oscillator centered and the multiplier finite
falsification: reject if upstream travel and target approach do not improve together without loss of domain survival, or if turn sign, joint-envelope occupancy, loads, collision, or instability worsen

## Pre-evaluation contract audit

A joint-only deterministic integration of the exact candidate equations (not
CFD and not outcome evidence) tested constant bearings of `-0.5`, `0`, and
`+0.5 rad`.  The signed tail mean reversed as intended (`-4.72`, `-0.38`, and
`+3.97 deg`), while the half-cycle multiplier stayed within
`[0.714, 1.286]` for those requests.  Worst-case joint angle, speed, and raw
acceleration were approximately `25.95 deg`, `162.45 deg/time`, and
`1356.05 deg/time^2`, below the `45/260/1800` envelope.  This verifies the
bounded state-feedback construction and intended asymmetry sign only; the
post-worker CFD evaluation must determine hydrodynamic turn sign, propulsion,
loads, trajectory, and target progress.
