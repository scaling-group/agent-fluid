# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled rollouts are finite captures from the required direct uniform
still-water initialization (`U_infinity=(0,0,0)`, no cylinders, no prewarm).
I inspected every combined keyframe sheet from release through termination.
Both the top-down mid-plane-vorticity rows and the oblique body/Lambda2 rows
show self-propulsion on the same smooth target-directed arc, with a coherent
alternating three-dimensional wake and no passive advection, wake collapse,
domain exit, collision, or numerical instability. The candidate differences
are smaller than keyframe resolution, so the trajectory and load histories
provide the discriminating evidence.

The best sample is the two-demand stabilization-envelope handoff. It retains
the shared `23.375013T` capture while improving score, scoring mean distance,
and final distance from the full progress-release carrier's
`-0.505158/2.402131/0.748882L` to `-0.502603/2.400102/0.746257L`. It also
improves inside-`3L` mean absolute yaw, target-line cross-track speed, and
moment relative to the course-only handoff from
`1.71472 rad/T`, `0.23486U`, and `0.006597` to
`1.70656 rad/T`, `0.23432U`, and `0.006564`. The gain is mixed rather than a
complete stabilization result: peak yaw/cross-track/moment rise from the
course-only sample's `3.27552 rad/T`, `0.62108U`, and `0.014923` to
`3.28817 rad/T`, `0.62616U`, and `0.015118`.

Replaying the best policy's bounded feedback expressions against its recorded
trajectory localizes the mismatch. The present cadence envelope uses the
absolute phase-selected yaw demand on both tail half-cycles, although the
anterior yaw correction itself is active only when its sign and observed tail
side select the supporting half-cycle. At the `3.28817 rad/T` yaw peak the
phase demand magnitude is about `0.344`, but the observed tail side is
opposite and the actual phase-selected anterior correction is zero. Thus the
handoff can perturb the carrier when its paired stabilizing actuator is idle.
This is a controller-role mismatch, not evidence for another scalar gain,
distance threshold, local-flow gate, or stronger steering correction.

## Single candidate hypothesis

Start from the best sampled two-demand handoff and preserve its progress cue,
split observer, C-bend steering, posterior traveling wave, projection, and all
evaluated parameter values. Keep the continuous course-brake contribution to
the cadence handoff. For the phase-selected contribution only, reuse the same
observed tail-side/sign selection that activates the anterior correction, and
form the maximum envelope from course demand and this active-half-cycle demand.
Only the small progress cadence reserve yields; base cadence and both steering
roles remain unchanged.

This phase-local authority coordination should preserve the coherent route and
`23.375T`-scale capture while avoiding cadence changes on the non-supporting
half-cycle. Falsify it if score/mean/final distance loses the best sample's
progress, capture is delayed, peak yaw/cross-track/moment fails to recover
toward or below the course-only values, the wake topology changes, or joint
and smoothly projected command envelopes worsen.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop CPG modulation
source_mechanism: state-selected half-cycle actuation coordinates sensory modulation with the phase on which the corrective actuator is effective
transferable_invariant: modulate extra rhythmic authority only on the observed joint-state half-cycle that supports the paired correction, while preserving the base traveling-wave carrier
nontransferable_details: published gains, dimensional frequencies and speeds, clocked oscillator phase, species-specific envelopes, full-body kinematics, exact vortex phase, and task-specific routes
policy_translation: infer tail side from normalized two-joint bend state and admit the phase-yaw cadence handoff only when its sign selects the same supporting half-cycle as the existing anterior correction; retain continuous course demand in a bounded maximum envelope
falsification: reject if CFD loses the best sampled capture/progress, does not improve its mixed terminal peaks, changes the coherent alternating wake, or worsens actuator feasibility

## Validation plan

Do not run formal CFD. After atomically materializing the single canonical
candidate and revising durable guidance, invoke the configured check runner and
perform its non-CFD contract/schema checks. Run a lightweight Julia contract
smoke only if the runtime is available.

## Validation status

The configured check runner was invoked, but its pinned `gpt-5.4-mini` model is
unsupported by this account and failed before inspection. I therefore ran its
three prescribed non-CFD checks directly. The guidance checker initially found
the assigned parent marked twice in the rendered workspace `README.md`; removing
only the duplicate marker repaired the input, and the rerun passes with a
material reusable guidance update. The solver boundary check passes.

The prescribed Julia contract smoke was invoked but cannot start because no
Julia executable is installed. A deterministic static audit finds one nonempty
canonical candidate, both public functions exactly once, `70` unique direct
`params.FIELD` references among `72` returned fields, and no undeclared
reference; only `version` and `control_period` are metadata. The candidate has
no explicit clock/step cue, randomness, file I/O, cylinder or wake-position
cue, mutable global state, or memorized route. Candidate SHA-256:
`cdf9a69559bd10c624e9df14c3b59eda6681b107e03b876fd96016efd17862fa`.
No formal CFD was run.
