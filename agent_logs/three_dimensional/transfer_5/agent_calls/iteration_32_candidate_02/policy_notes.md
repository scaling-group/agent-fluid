# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver artifacts are finite, direct-uniform still-water
evaluations with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and
capture termination. They are one replicated behavior rather than four
independent outcomes: each captures at `23.83702T`, with score `-0.53501328`,
scoring mean distance `2.433468L`, final distance `0.746096L`, and `236`
moving-window shifts. Their combined keyframe sheets are byte-identical. Three
policy files are byte-identical v37 split observers; the fourth is the earlier
v34 spelling of the same role split and produces the same CFD trajectory.

I inspected the combined sheet from release through capture, including its
top-down mid-plane-vorticity row and oblique body/Lambda2 row. The fish moves
from quiescence under its own actuation along a smooth target-directed arc,
leaves an ordered alternating wake, and retains compact three-dimensional
vortices through the terminal bend. There is no passive advection, wake
collapse, collision, boundary exit, or instability. Inside `3L`, the measured
motion remains strongly beat-periodic: mean/peak absolute yaw are
`1.67938/3.19386 rad/T`, mean/peak target-cross-track speed are
`0.23868/0.56914U`, and peak absolute moment is `0.013581`. Those oscillations
coexist with monotone closing and capture, so suppressing them is not by itself
an improvement criterion.

No sampled artifact is an informative failure. The inherited optimizer logs
supply the comparison: the assigned-parent v41 middle-route drift bias lowered
yaw but delayed capture to `23.85352T`, regressed score/mean/final distance to
`-0.536326/2.434376/0.748282L`, worsened cross-track motion, and raised peak
moment. The later collision-cone course gate likewise lowered selected yaw
averages but delayed capture to `23.84802T`, regressed mean/final distance to
`2.433569/0.746175L`, and raised peak moment to `0.014020`. Earlier phase-lead,
envelope-redistribution, and local-crossflow gates also retained the visible
wake while regressing progress and/or load. Thus another terminal observer,
residual timing, mean route bias, or scalar compensation is not supported.

## Single candidate hypothesis

Select the directly evaluated v37 split course/phase observer as the one
candidate. It makes the surviving architecture explicit: normalized body-frame
target geometry and the anterior-only carrier-rejected rate retain continuous
course authority, while the distributed two-joint rate is scoped only to phase
classification of the bounded anterior residual. Preserve the response-released
C-bend, posterior traveling-wave target, cadence, approach structure, and
component-wise smooth acceleration projection. Adopt no new shelf primitive
because every recent intervention at the remaining terminal oscillation has
traded away progress or peak-load balance.

This evidence-backed selection should reproduce capture near `23.837T`,
mean/final distance near `2.433468/0.746096L`, the coherent alternating wake,
peak moment near `0.013581`, and the sampled feasible command envelope. Falsify
the selection if another direct-uniform evaluation loses capture, materially
departs from the repeated trajectory, or worsens progress, mixed terminal
yaw/cross-track/load balance, or actuator feasibility.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and feedback-modulated robotic-fish direction control
source_mechanism: preserve posterior-lagged rhythmic propulsion while separating slow target-course feedback from fast beat-side classification
transferable_invariant: retain the coherent directed traveling wave and scope fast joint-state observations to the smallest steering role supported by closed-loop evidence
nontransferable_details: published gains, dimensional frequencies, clocked CPG phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: select the evaluated normalized body-frame split observer with anterior-only continuous course response, distributed two-joint phase classification, and unchanged posterior propulsion
falsification: reject if repeat or held-out CFD loses split-observer-scale capture and progress, coherent wake topology, mixed terminal yaw/cross-track/load balance, or actuator feasibility

## Validation status

Formal CFD is intentionally deferred to EvE. The required configured
check-runner was invoked, but its pinned `gpt-5.4-mini` model is unsupported on
this account and failed before workspace inspection. Its prescribed checks
were then run directly and separately: guidance materiality and the solver
editable-boundary check pass. Julia is not installed, so the lightweight
runtime smoke cannot launch. A deterministic static schema audit finds `69`
unique direct `params.FIELD` references among `71` returned fields, no
undeclared reference, and only the `version` and `control_period` metadata
fields unreferenced. Both public functions are present, and the policy contains
no explicit clock/step input, randomness, file I/O, cylinder cue, mutable
global state, or memorized route.

Exactly one nonempty `candidate_target_policy.jl` exists. Its SHA-256 is
`e8dd4f34950bd011ceb6edb01df5d936d40aed672c0dc8e8b22d328238fb5b35`,
byte-identical to the directly evaluated v37 capture artifact.
