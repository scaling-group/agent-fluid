# Candidate wake-policy notes

## Evidence diagnosis before candidate selection

All four sampled solver artifacts are finite, direct-uniform still-water
evaluations with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and
capture termination. They are one replicated behavior rather than four
independent mechanisms: every rollout captures at `23.83702T` with score
`-0.53501328`, scoring mean distance `2.433468L`, and final distance
`0.746096L`; their combined keyframe sheets are byte-identical. Three policy
files are byte-identical v37 split observers, while the fourth uses different
names for behaviorally equivalent split-observer algebra.

I inspected the combined sheet's top-down mid-plane-vorticity row and oblique
body/Lambda2 row from release through capture for this replicated baseline.
The fish self-propels from quiescent fluid along a smooth target-directed arc,
leaving a coherent alternating mid-plane wake and compact three-dimensional
vortices through the final bend. There is no passive advection, wake breakup,
collision, boundary exit, or instability. The captured path is therefore a
useful carrier/steering baseline, although inside `3L` it still has mean/peak
absolute yaw `1.67938/3.19386 rad/T`, mean/peak target-cross-track speed
`0.23868/0.56914U`, and peak absolute moment `0.013581`.

The inherited logs supply the informative failures missing from the sampled
set. The assigned-parent middle-approach interception bias normalized
collision-line drift by positive closing speed; it retained the visible wake
but delayed capture to `23.85352T`, regressed score/mean/final distance to
`-0.536326/2.434376/0.748282L`, worsened terminal cross-track speed, and raised
peak moment despite lower yaw. I also inspected both visual rows of the later
terminal collision-cone rollout. It has the same coherent physical topology,
but replacing the course brake's total-speed gate with a radial-closing angle
delayed capture to `23.84802T` and regressed score/mean/final distance to
`-0.535108/2.433569/0.746175L`. Its inside-`3L` mean/peak yaw fell to
`1.66457/3.14919 rad/T` and mean cross-track speed to `0.23815U`, but peak
cross-track speed rose to `0.57337U` and peak moment to `0.014020`. Thus two
different target-relative velocity constructions reduced selected averages
while trading away approach progress or peak-load balance.

## Single candidate hypothesis

Select the directly evaluated v37 split course/phase observer as the one
candidate. Preserve its response-released C-bend, continuous anterior-only
course brake, distributed two-joint rate cue only for phase classification of
the bounded anterior residual, posterior traveling-wave target, cadence, and
component-wise smooth command projection. Do not carry forward the falsified
middle-course drift bias or terminal collision-cone gate, and do not tune a
scalar merely to compensate for either regression.

This selection should reproduce capture near `23.837T`, scoring mean/final
distance near `2.433468/0.746096L`, the coherent alternating wake, and the
sampled load and actuator envelopes. Falsify it if another evaluation loses
capture, materially departs from that trajectory, or worsens terminal
progress, yaw/load balance, or command feasibility. A reduction in mean yaw or
cross-track motion is not an improvement if peak moment, final distance, or
arrival regresses.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal target capture
source_mechanism: preserve a thrust-producing rhythmic carrier while separating body-frame route feedback from beat-side correction and continuously scheduled approach feedback
transferable_invariant: scope fast joint-state cues to rhythmic phase and accept a target-relative velocity correction only when target progress, transverse motion, and load balance improve together
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, dimensional speeds and approach distances, exact vortex phases, and task-specific routes
policy_translation: retain the evaluated split observer with body-frame target geometry for continuous course response, distributed joint rate only for anterior half-cycle classification, and unchanged posterior traveling-wave propulsion; reject the two evaluated closing-normalized velocity gates
falsification: reject if repeated or held-out CFD loses split-baseline capture/progress, coherent wake topology, mixed terminal yaw/load balance, or actuator feasibility

## Validation status

No formal CFD was run in this workspace. The candidate is the nonempty,
directly evaluated v37 artifact with SHA-256
`e8dd4f34950bd011ceb6edb01df5d936d40aed672c0dc8e8b22d328238fb5b35`.
The mandated configured check runner was invoked, but its pinned
`gpt-5.4-mini` model is unsupported by this account and failed before file
inspection. Its prescribed checks were therefore run directly and separately:
the guidance-materiality and solver-boundary checks pass. Julia is not
installed, so the lightweight runtime smoke cannot launch. A deterministic
static schema audit finds `69` unique direct `params.FIELD` references among
`71` returned fields, no undeclared reference, and only the `version` and
`control_period` metadata fields unreferenced. The policy contains both public
functions and no explicit clock/step input, randomness, file I/O, cylinder
state, mutable global state, or memorized route.
