# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver rollouts and the three inherited completed children are
finite direct-uniform still-water evaluations with `U_infinity=(0,0,0)`, no
cylinders, no prewarm snapshot, and capture termination. The repeated v37
split-course/phase observer is the strongest finite candidate: two independent
policy texts produce byte-identical trajectories and keyframes, capture at
`23.83702T`, and score `-0.53501328` with scoring mean/final distance
`2.433468/0.746096L`. The assigned v33 prefill is slightly weaker at
`23.84252T`, `-0.53509095`, and `2.433543/0.746165L`.

I inspected both rows of the combined sheets from release through capture for
the repeated v37 baseline and the informative inherited regressions, including
the assigned-parent v40 local-crossflow gate. In the top-down vorticity row the
fish moves from rest under its own actuation, follows the same smooth
target-directed arc, and leaves an ordered alternating wake. In the oblique
body/Lambda2 row compact three-dimensional structures persist through the
terminal bend. No rollout shows passive background advection, wake collapse,
collision, domain exit, or instability. The changes are below keyframe
resolution, so the distance, joint, yaw, cross-track, moment, and command
histories decide the comparison.

The inherited results reject the remaining beat-timing and hydrodynamic-proxy
branches. Relative to v37, displacement-rate phase lead regressed score and
mean/final distance to `-0.535363` and `2.433747/0.746448L`, and raised peak
moment from `0.013581` to `0.013888`, despite slightly lower peak yaw and
cross-track speed. Anterior half-cycle envelope redistribution regressed them
further to `-0.536347` and `2.434528/0.747467L`, with peak moment `0.013790`.
Most importantly, the assigned-parent v40 test falsifies the offline local-flow
correlation as a useful actuator gate: although baseline local crossflow inside
`3L` correlated `-0.8015` with moment and only `0.1255` with yaw, attenuating
the anterior residual when flow appeared helpful regressed score and
mean/final distance to `-0.536241` and `2.434443/0.747358L`. It also worsened
inside-`3L` mean/peak target-cross-track speed from `0.23868/0.56914U` to
`0.23894/0.57061U`, mean yaw from `1.67938` to `1.67952 rad/T`, and peak moment
from `0.013581` to `0.013650`; only peak yaw improved marginally from `3.19386`
to `3.19158 rad/T`. Correlation established signal scale, not a causal control
role.

## Single candidate hypothesis

Restore the directly evaluated v37 split observer as the one candidate. It
preserves the successful response-released C-bend carrier, continuous
anterior-only target-course brake, distributed two-joint rate cue only for
phase classification of the anterior residual, posterior traveling wave, and
smooth command projection. It removes the weaker v33 observation coupling and
does not carry forward the falsified phase lead, envelope redistribution, or
local-flow gate. No cadence, gain, route, or morphology parameter is tuned.

This candidate is supported by replicated CFD rather than an offline proxy: it
should reproduce capture near `23.837T`, scoring mean/final distance near
`2.433468/0.746096L`, coherent wake topology, and the recorded actuator
envelope. Falsify the selection if a repeat loses capture, materially departs
from that trajectory, or worsens yaw/load/command feasibility; a tiny peak-yaw
change without progress and load preservation is not improvement.

bookshelf_consulted: true
source_domain: feedback-modulated robotic-fish oscillators and wake-disturbance control
source_mechanism: preserve a traveling-wave carrier while separating slow target-course feedback from a fast joint-state phase cue
transferable_invariant: a fast rhythmic observation should remain scoped to beat-side classification and must not replace slow body-frame route feedback or posterior propulsion
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target geometry for the continuous course response and the distributed two-joint rate only for the bounded anterior half-cycle residual; retain the posterior traveling wave
falsification: reject if replicated still-water CFD loses split-baseline capture/progress, coherent wake topology, terminal yaw/load balance, or actuator feasibility

## Non-CFD validation

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account and failed before inspecting the workspace.
  Its prescribed guidance-materiality check passes after removing the duplicate
  assigned-parent marker from the rendered workspace `README.md`, and its
  solver-boundary check passes.
- The Julia smoke command cannot start because no Julia executable is
  installed. A deterministic static audit finds `69` unique direct
  `params.FIELD` references among `71` returned fields with no undeclared
  reference; only `version` and `control_period` are metadata. The policy has
  no explicit time/step input, random source, file I/O, cylinder state, mutable
  global state, or memorized route.
- Exactly one nonempty exact `candidate_target_policy.jl` exists. Its SHA-256
  is `e8dd4f34950bd011ceb6edb01df5d936d40aed672c0dc8e8b22d328238fb5b35`,
  byte-identical to the completed finite v37 rollout. No formal CFD was run.
