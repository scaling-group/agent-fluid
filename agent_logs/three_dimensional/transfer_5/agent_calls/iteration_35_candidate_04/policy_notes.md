# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled rollouts are finite captures from direct uniform still water
with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. They share
the same trajectory through the first `3L` crossing at `20.129997T`, so their
useful comparison is the final authority handoff. The full progress release
captures at `23.375013T` with score/mean/final distance
`-0.505158/2.402131/0.748882L`. The assigned-parent monotone distance handoff
is the informative weaker capture: it regresses to
`-0.505421/2.402386/0.749093L`. A middle-band distance window recovers some of
that loss at `-0.504742/2.401955/0.748290L`, while the course-demand handoff is
the strongest finite sample at `-0.503415/2.400748/0.747085L` with the same
`23.375013T` capture time as full release.

I inspected the combined keyframe sheets of the strongest demand-handoff
rollout and the assigned-parent distance-handoff regression from release to
termination. In both top-down mid-plane-vorticity rows and oblique
body/Lambda2 rows, the fish self-propels from quiescence on a smooth curved
target approach, leaves an ordered alternating wake with compact 3D
structures, and reaches the capture sphere. Neither sheet shows passive
advection, collision, domain exit, wake collapse, or numerical instability;
the controller difference is below keyframe resolution.

Trajectory and load histories therefore decide the remaining trade. Relative
to full release, the demand handoff improves final distance and reduces the
inside-`3L` peak yaw from `3.29199` to `3.27552 rad/T`, while mean yaw is nearly
unchanged (`1.71255` versus `1.71472 rad/T`) and peak moment rises from
`0.014507` to `0.014923`. The middle and monotone schedules reduce more yaw or
load but give back radial progress. This supports stabilization demand as the
handoff trigger, but not a larger unconditional withdrawal. The assigned
parent and inherited logs specifically show that monotone removal coasts in
the final `1L`: mean radial closing fell from `0.6907U` to `0.6251U` and mean
cross-track speed rose from `0.3075U` to `0.3752U` in its earlier completed
comparison.

## Single candidate hypothesis

Start from the evaluated course-demand handoff, preserving the normalized
body-frame progress-qualified carrier, response-released C-bend, anterior-only
continuous course observer, distributed phase observer, posterior traveling
wave, steering, and smooth command projection. Change only the authority
arbitration: multiply the bounded course-brake handoff by the existing
target-progress fraction before it acts on the small cadence reserve. Extra
cadence then yields only when terminal stabilization is active and translation
is already target-radial; if radial closing deteriorates, the handoff releases
automatically and the reserve returns. The base cadence remains active
everywhere. This is a conjunctive state-feedback mechanism, not a new gain,
clock, route state, or distance threshold.

The rollout should preserve the demand sample's pre-`3L` trajectory and
coherent wake, retain its score/final-distance advantage over full release,
and protect final radial/cross-track motion from the distance-fade regression.
Reject the mechanism if capture is delayed, score or mean/final distance
regresses to full release, inside-`3L` peak yaw exceeds `3.29199 rad/T`, peak
moment exceeds `0.014923`, wake coherence changes, or joint/command exposure
worsens.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal approach control
source_mechanism: sensory arbitration between an established traveling-wave propulsion carrier and measured stabilization demand
transferable_invariant: yield only reserve propulsion during active stabilization when target-radial progress is already established, and restore it when closing quality deteriorates
nontransferable_details: published gains, dimensional frequencies and speeds, clocked phase, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: gate the absolute normalized terminal course-brake demand by the existing normalized body-frame target-progress fraction before subtracting it from only the small progress cadence reserve
falsification: reject if CFD delays capture, loses the demand sample's score or final-distance advantage, repeats terminal coasting, worsens yaw or moment beyond the sampled bounds, changes the coherent wake, or worsens actuator feasibility

## Validation plan

Do not run formal CFD. After materializing the single candidate and durable
guidance update, invoke the configured check runner, run its prescribed non-CFD
checks, audit every direct `params.FIELD` reference, and run the lightweight
Julia contract smoke only if a Julia runtime is available.

## Validation status

The configured check runner was invoked, but its pinned `gpt-5.4-mini` model is
unsupported on this account and failed before workspace inspection. Its
prescribed checks were therefore run directly. The guidance checker first
found the assigned parent duplicated in the rendered workspace `README.md`;
removing only that duplicate marker repaired the metadata, and the rerun
passes. The solver edit-boundary check passes.

Julia is not installed, so the lightweight runtime smoke cannot start. A
deterministic static audit finds exactly one nonempty canonical candidate,
both public functions exactly once, and `70` unique direct `params.FIELD`
references among `72` returned fields with no undeclared reference; only
`version` and `control_period` are metadata. No explicit time/step state,
randomness, file I/O, cylinder or wake-position cue, or mutable global state is
present. Candidate SHA-256:
`608ba0ba7e555e663b949a8cea39a75eaf7356d22457e5f6a5b695870792ed92`.
No formal CFD was run.
