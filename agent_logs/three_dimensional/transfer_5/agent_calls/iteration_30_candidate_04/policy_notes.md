# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled rollouts are finite direct-uniform still-water evaluations
with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and capture
termination. The strongest sampled behavior is the role-separated v37
split observer: three examples are bit-identical, capture at `23.83702T`, and
score `-0.53501328` with scoring mean/final distance
`2.433468/0.746096L`. The v33 comparator captures slightly later at
`23.84252T`, with score `-0.53509095` and mean/final distance
`2.433543/0.746165L`.

I inspected both the top-down mid-plane-vorticity and oblique body/Lambda2
rows from release through capture for the replicated v37 baseline and the
inherited v40 local-crossflow-gate regression. In both, the fish moves from
quiescence under its own actuation, follows the same smooth target-directed
arc, develops an ordered alternating wake, and retains compact three-
dimensional structures through the terminal bend. There is no passive
advection, wake collapse, collision, boundary exit, or instability. The
policy difference is below keyframe resolution, so the distance, yaw,
cross-track, moment, joint, and command histories decide the comparison.

The inherited evidence closes the recent fast-signal/half-cycle branch.
Displacement-rate phase anticipation, anterior envelope redistribution, and
the local-crossflow consistency gate all retained the same capture topology
but regressed score and mean/final distance. In particular, v40 changed the
split baseline from `-0.535013/2.433468/0.746096L` to
`-0.536241/2.434443/0.747358L`, worsened mean/peak cross-track speed and peak
moment, and only marginally lowered peak yaw. Thus another phase lead,
envelope share, instantaneous flow gate, or scalar retune of those mechanisms
is not supported.

The remaining terminal observation has a distinct structural mismatch. The
current course brake normalizes carrier-rejected target-transverse velocity
by a fixed speed scale and activates it with total swimmer speed. Total speed
does not distinguish radial target closing from lateral or receding motion.
On the replicated rollout, distance falls monotonically from `3L` to capture
while the carrier-rejected transverse component oscillates and reaches about
`0.295U` at termination; this supports testing a target-relative velocity
direction rather than adding authority to the rejected residual branch.

## Single candidate hypothesis

Retain v37's response-released C-bend, continuous anterior-only course brake,
distributed rate cue only for phase classification, posterior traveling wave,
cadence, steering gains, and component-wise smooth command projection.
Replace only the terminal course observation with a normalized collision-cone
signal: use the angle between carrier-rejected target-transverse velocity and
positive smoothed radial closing speed, and activate it with radial closing
rather than total swimmer speed. A small radial floor keeps the angle bounded
as closing tends to zero; a separate smooth gate suppresses the term when the
fish is not closing. No world coordinate, clock, task identity, or route state
is introduced.

This predicts that the terminal course bend will remain active for genuine
closing motion while no longer treating lateral gait speed as approach
evidence. The direct-uniform rollout should retain v37-scale capture,
progress, wake coherence, and actuator feasibility while improving final
course alignment, final distance, or the mixed yaw/load boundary. Reject the
mechanism if capture is delayed or lost, scoring mean/final distance regresses,
the ordered wake changes, peak yaw and moment worsen together, or joint and
smoothly projected command envelopes degrade.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal approach scheduling
source_mechanism: preserve the rhythmic carrier while steering from normalized target-relative feedback whose authority changes continuously with approach state
transferable_invariant: separate radial target closing from transverse motion before modulating a near-target course response, while leaving the thrust-producing posterior wave intact
nontransferable_details: published CPG gains, dimensional speeds, clocked oscillator phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: form a bounded body-frame collision-cone angle from carrier-rejected transverse speed and smoothed positive closing speed; use it only in the existing terminal course brake and preserve the split phase observer and posterior carrier
falsification: reject if replicated still-water CFD loses or delays capture, regresses mean or final distance, changes wake coherence, worsens yaw and moment together, or increases joint and command-limit exposure

## Non-CFD validation

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account and failed before inspecting the workspace.
- Its guidance-materiality command initially found the assigned parent twice
  in the rendered workspace `README.md`. Removing the duplicate marker made
  the assignment unambiguous; the rerun passes and confirms that these notes
  exist and `control_experience.md` has a material reusable update.
- Its solver-boundary command passes. Exactly one nonempty
  `candidate_target_policy.jl` exists, with SHA-256
  `b6bd495f6ecd86fb28fc1b34916458ccb14a14343a9a637879f08cd33038d2cd`.
- The prescribed Julia smoke command cannot start because no Julia executable
  is installed. A deterministic static audit finds `71` unique direct
  `params.FIELD` references among `73` returned fields, with no undeclared
  reference; only `version` and `control_period` are metadata. The policy has
  no explicit time/step input, random source, file I/O, cylinder state,
  mutable global state, or memorized route. No formal CFD was run.
