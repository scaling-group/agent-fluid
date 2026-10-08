# Wake-policy diagnosis and candidate hypothesis

## Evidence read before editing

- Assigned parent: the prefilled course-priority line-of-sight-response policy,
  sampled as `solver_examples/solver_e07c5232a21a`. It captured at
  `0.748591L` in `26.2405T`, with mean distance `2.518917L`.
- Strong finite comparator: `solver_examples/solver_8e7135ef9173`. It used
  translational target geometry only to influence steering side and captured at
  `0.748338L` in `26.2460T`, with mean distance `2.518971L`.
- Informative weaker mechanism comparator:
  `solver_examples/solver_730e610b0618`. Its response-gated carrier relief
  retained capture but was the slowest sample (`26.3615T`) and had the largest
  mean distance (`2.519735L`).
- Replication comparator: `solver_examples/solver_7f1d02b1e9e9`. It retained the
  posterior terminal modulation without the parent's conflict arbitration and
  captured at `0.748829L` in `26.2955T`.
- All four diagnostics confirm direct uniform still-water initialization,
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot.

## Visual diagnosis

The combined sheets were inspected from release through termination, including
both their top-down mid-plane-vorticity rows and oblique body/Lambda2 rows. All
four fish self-propel along nearly the same target-directed centerline, leave a
coherent alternating wake through `8T`, `16T`, and `24T`, and execute the same
late upward hook into the capture circle. The oblique rows retain compact
three-dimensional tail vortices and a continuous trailing filament during the
turn; there is no visible advection, wake collapse, or instability. The
carrier-relief comparator is therefore a negative mechanism result despite
capture: it preserves the visual topology while delaying arrival. The common
actuator extrema reinforce that reading: all four reach about `0.77236 rad`,
`4.51281 rad/T`, and `29.72585 rad/T^2`; peak planar force is `0.01883`, while
peak yaw moment is `0.00979--0.00990`. Another carrier or terminal-amplitude
retune is not supported.

## Signal audit and hypothesis

Reconstructing the policy's seven-step bearing-window-plus-body-turn signal
from the parent trace exposes a route-observer problem that the sparse visual
frames cannot show. In the `4.5--1.75L` middle band its RMS magnitude is
`3.173 rad/T`, versus `0.141 rad/T` for the coordinate-free translational
target-line rate `(velocity x target)/distance^2`; their signs disagree in
`54.7%` of samples and the history-based desired-yaw request is saturated in
`91.6%`. Inside `1.75L`, the corresponding values are `1.764` versus
`0.464 rad/T`, `39.6%` disagreement, and `79.7%` saturation. The sampled
translation-side-only variant improves the scalar by only `6.8e-6` and leaves
the visible topology unchanged because the contaminated history magnitude
still sets response demand.

The candidate will preserve the parent carrier, redirect, posterior allocation,
and feasibility guards, but smoothly fuse navigation rate itself toward the
translational line-of-sight rate once translation is observable and the target
is within the audited middle band. This rejects gait-frequency observer motion
from both steering side and response magnitude while retaining the existing
history observation at low speed and far range. Expected evidence is capture
with the same coherent wake and zero actuator contacts, fewer alternating
navigation corrections in the middle approach, and no slower arrival or higher
load than the parent. Falsify the mechanism if capture is lost, the late hook or
3D wake destabilizes, actuator/load exposure rises, or the result remains only
a milliscale-equivalent route.

A frozen-state replay of the assigned-parent trace reproduces logged parent
commands within `0.00170 rad/T^2`. The candidate changes `944` sampled command
rows, including `586` in the audited middle band, with mean changed peak-joint
delta `0.307 rad/T^2` and maximum `1.699 rad/T^2`. This confirms a material but
bounded observer intervention; it is not a CFD outcome and does not establish
improvement.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish control and wake-interaction control
source_mechanism: separate persistent target geometry from fast alternating gait or crossflow response before modulating a rhythmic carrier
transferable_invariant: navigation demand should follow an observable inertial target-line trend while gait-frequency lateral motion is not automatically cancelled
nontransferable_details: published CPG gains, species kinematics, exact vortex phases, dimensional frequencies, and prescribed routes
policy_translation: fuse normalized body-frame translational line-of-sight rate into the existing state-feedback navigation observer, leaving the two-joint traveling bend and feasibility guards intact
falsification: reject if the fused observer loses capture, degrades the coherent top-down or oblique wake, increases limits or loads, or produces no meaningful trajectory change
