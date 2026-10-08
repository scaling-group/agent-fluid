# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver rollouts are valid finite evaluations from direct
uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm
snapshot. They all capture on the same trajectory at `23.83702T`, with score
`-0.53501328`, scoring mean distance `2.433468L`, and final distance
`0.746096L`. Three carry the v37 split-observer text and the fourth carries an
earlier distributed-observer text, but their CFD trajectories and scores are
bit-identical. The repeat evidence therefore supports the controller behavior,
not a version label.

I inspected the combined sheets for the repeated split observer and the
inherited terminal collision-cone regression, including the top-down
mid-plane-vorticity row and the oblique body/Lambda2 row from release through
capture. Both fish self-propel from quiescent fluid along the same smooth
target-directed arc. Both form an ordered alternating wake with persistent
compact three-dimensional structures through the final bend. Neither sheet
shows passive advection, wake collapse, collision, boundary exit, or numerical
instability. Their difference is below keyframe resolution, so the trajectory
metrics decide the comparison.

The completed collision-cone rollout falsifies the inherited proposal to
replace total swimmer speed and signed transverse residual with radial-closing
activation and an intercept angle. Relative to the repeated split observer, it
delays capture to `23.84802T` and regresses score/mean/final distance to
`-0.535108/2.433569/0.746175L`. Inside `3L`, mean/peak absolute yaw improve
from `1.67938/3.19386` to `1.66457/3.14919 rad/T`, and mean target-cross-track
speed improves narrowly from `0.23868` to `0.23815U`; however, peak cross-track
speed worsens from `0.56914` to `0.57337U` and peak absolute moment rises from
`0.013581` to `0.014020`. The inherited middle-course closing-normalized bias
is a stronger regression: `23.85352T`, `-0.536326`, and
`2.434376/0.748282L`, with inside-`3L` cross-track speed worsening to
`0.24474/0.58775U` despite reduced mean yaw. Both retain the visible wake and
the same joint/command extrema, so their lower yaw is a trade against the
successful capture path rather than a new useful trajectory.

## Single candidate hypothesis

Select the evaluated v37 split course/phase observer as the one candidate.
Keep the response-released C-bend, continuous anterior-only course response,
distributed two-joint rate only for phase classification, phase-selected
anterior residual, posterior traveling wave, cadence, and component-wise
smooth command projection exactly as evaluated. Restore neither target-relative
velocity intervention and make no scalar gain change.

This is an evidence-backed restoration from the assigned-parent collision-cone
regression to the strongest sampled controller. It should reproduce capture
near `23.837T`, mean/final distance near `2.433468/0.746096L`, the coherent
alternating wake, peak moment near `0.013581`, and the sampled feasible command
envelope. Falsify the selection if another deterministic direct-uniform rollout
loses capture, materially departs from the repeated trajectory, or worsens the
mixed terminal yaw/load or actuator envelope.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and feedback-modulated robotic-fish direction control
source_mechanism: preserve the thrust-producing posterior-lagged carrier while assigning slow route control and fast beat-side classification to separate feedback roles
transferable_invariant: retain a directed posterior traveling wave and scope fast joint-state feedback to the smallest steering role that has survived closed-loop evidence
nontransferable_details: published gains, dimensional frequencies, clocked oscillator phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: select the evaluated normalized body-frame split observer, with anterior-only continuous target-course response, distributed two-joint phase classification, and an unchanged posterior wave
falsification: reject if repeat or held-out CFD loses split-observer-scale capture and progress, coherent wake topology, terminal yaw/load balance, or actuator feasibility

## Non-CFD validation

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account and failed before workspace inspection. Its
  prescribed guidance-materiality command was then run directly and passes.
- The prescribed Julia smoke command cannot launch because no Julia executable
  is installed. A deterministic static audit finds `69` unique direct
  `params.FIELD` references among `71` returned fields, with no undeclared
  reference; only `version` and `control_period` are metadata. Both public
  functions are present, and the policy contains no explicit time/step input,
  random source, file I/O, cylinder cue, mutable global state, or memorized
  route.
- The solver-boundary command passes. Exactly one nonempty candidate exists,
  with SHA-256
  `e18d0fd280a7df5be67374a4b8530831722fb883772feafafde7dcfe60e52b5b`.
  No formal CFD was run.
