# Wake-policy candidate notes

## Visual and numerical diagnosis before the policy edit

All four sampled rollouts and both inherited assigned-parent rollouts use the
required direct uniform still-water initialization with `U_infinity=(0,0,0)`,
no cylinders, no prewarm snapshot, finite dynamics, and `capture`
termination. The complete sheet for `solver_43e27134a723` shows a curved,
self-propelled approach behind a coherent alternating mid-plane street, with
discrete oblique Lambda2 structures still present at `8T`, `16T`, `24T`, and
capture. Its byte-identical numerical replicate `solver_c85ef8d2aea3` has the
same top-down route but a blank oblique row, so it is repeatability evidence,
not a second three-dimensional wake observation. The translation-alignment
sample and the latest assigned-parent sample also have blank oblique rows.

The response-plus-anterior-stroke policy remains the strongest sampled
candidate: it captures at `24.310009T`, with mean distance `2.223959L`,
crossing distance `0.749162L`, peak normalized force/moment
`0.031649/0.016385`, and an active carrier through capture. Broad closing-
deficit relief is later at `24.326511T/2.224097L`; replacing the closing
response with normalized translation alignment is later at
`24.343010T/2.224020L`. The assigned parent's carrier-reinforcement
intersection is also later at `24.326511T/2.224136L`. Its subsequent
posterior-joint-rate union keeps the same `24.310009T` terminating step and
unchanged peak load envelope, but worsens mean/crossing distance to
`2.224193/0.749469L`. The latter two results bound the phase refinement:
neither narrowing nor extending the evidenced anterior-stroke interval using
an inferred downstream phase improves the terminal crossing.

On the best trace below `1.5L`, folded bearing reverses between convergent and
divergent short-window trends (`-2.032` to `+2.427 rad/T`) while one-step
closing speed remains beat-sensitive (`0.110` to `0.658L/T`). The current
closing-deficit/anterior-phase product averages about `0.108`. Thus the
remaining testable signal is measured target-relative angular response, not a
fourth proxy for actuator phase. Positive target-signed bearing trend means
the folded target error is opening on its current side; this is the condition
under which continuing the full posterior mean load is least defensible near
capture.

## One candidate hypothesis

Preserve the reproduced-best traveling carrier, target geometry, reactive-
rudder sign, closing-deficit pathway, anterior useful-stroke allocation, and
20% relief ceiling. Add a near-target response-damping branch: inside a smooth
`1.5--1.0L` approach window, form a bounded gate from normalized
`geometric_turn * bearing_window_rate`. Smoothly unite positive bearing
divergence with the existing closing-deficit demand, then retain the existing
anterior-stroke multiplier. This changes no pre-approach command, never
unloads the carrier, never expands relief into the posterior or return stroke,
and only removes posterior mean steering when measured target-relative
rotation is diverging.

A replay on the completed best trace, which is diagnostic rather than a
coupled-CFD prediction, raises the mean relief phase factor below `1.5L` only
from about `0.108` to `0.134` and changes it materially on about 20% of those
samples. Falsify the candidate if capture is lost or later than `24.310009T`,
mean distance exceeds `2.223959L`, crossing distance exceeds `0.749162L`, the
trajectory changes before `1.5L`, or carrier wake, saturation, effort, force,
or moment envelopes worsen. A fixed-pose improvement would not establish pose
or hydrodynamic robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and terminal capture control
source_mechanism: sensory damping of a steering residual during approach while the rhythmic propulsive carrier continues
transferable_invariant: use measured target-relative angular response to bound near-target steering authority without damping or replacing the traveling bend
nontransferable_details: published gains, robot linkage kinematics, species envelopes, clock phase, exact vortex phases, maneuver timing, and task-specific routes
policy_translation: smoothly unite positive normalized body-frame bearing divergence with the evidenced closing-deficit demand only inside 1.5L, then retain the successful target-side anterior-stroke gate and 20% posterior-rudder relief ceiling
falsification: reject if capture is later than 24.310009T or lost, mean or crossing distance exceeds 2.223959L or 0.749162L, pre-1.5L motion changes, or wake, saturation, effort, force, or moment envelopes worsen
