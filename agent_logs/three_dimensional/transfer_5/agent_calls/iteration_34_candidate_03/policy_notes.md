# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver artifacts are finite direct-uniform still-water
rollouts with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and
capture termination. Three candidate texts reproduce the progress-qualified
split-observer behavior at `23.37501T`, score `-0.50515772`, and final distance
`0.748882L`; the fourth is the completed terminal reserve fade, which captures
later at `23.45752T`, scores `-0.50554000`, and finishes at `0.748845L`.

I inspected the combined keyframe sheets for the progress-qualified carrier and
the terminal-fade regression, including both the top-down mid-plane-vorticity
row and the oblique body/Lambda2 row from release through capture. Both fish
self-propel from quiescence on the same smooth target-directed arc, form an
ordered alternating wake, and retain compact three-dimensional structures
through the final bend. Neither shows passive advection, wake collapse,
collision, boundary exit, or instability. The policy difference is below the
keyframe resolution, so the trajectory, force/moment, joint, and command
histories decide the comparison.

The inherited fade supplies a useful but incomplete terminal mechanism. It
leaves the trajectory unchanged through the first `3L` crossing at
`20.129997T`, then removes the small progress-qualified frequency reserve
throughout the remaining approach. Relative to the full progress release, it
reduces inside-`3L` mean/peak absolute yaw from `1.71255/3.29199` to
`1.67618/3.22576 rad/T` and mean/peak absolute moment from
`0.006591/0.014507` to `0.006348/0.013529`. It nevertheless delays capture by
`0.08250T`, worsens peak target-cross-track speed from `0.61953` to `0.62705U`,
and slightly increases joint-speed-cap residence. The failure is localized:
inside the final `1L`, removing the reserve lowers mean target-radial closing
from `0.6907` to `0.6251U` while raising mean cross-track speed from `0.3075`
to `0.3752U`. In contrast, the largest progress-policy yaw and moment occur in
the `1--2L` band. Thus monotone removal improves rotation/load but coasts too
soon for the final crossing.

## Single candidate hypothesis

Retain the evaluated target-progress-qualified carrier, response-released
C-bend, anterior-only continuous course observer, distributed rate cue only
for phase classification, phase-selected anterior residual, posterior
traveling wave, and component-wise smooth command projection. Change only the
terminal schedule of the small progress cadence reserve. Use the existing
normalized terminal proximity to form a bounded middle-window handoff
`4p(1-p)`: it is zero where terminal control opens at `3L`, rises continuously
to one in the `1--2L` region where yaw/load peak, and returns to zero at the
existing terminal-full distance so the target-directed reserve re-engages for
the final crossing. Baseline cadence remains active everywhere.

This tests whether the terminal fade's yaw/load benefit can be retained where
the defect is largest without repeating its final radial-progress and
cross-track regression. The rollout should preserve the progress candidate's
pre-`3L` arrival and coherent wake, improve yaw or moment in the `1--2L` band,
and recover final radial closing, cross-track behavior, and capture timing
toward the full-release sample. Reject the mechanism if capture is lost or
delayed beyond the monotone fade, score or mean/final distance gives back the
middle-course gain, yaw and moment do not improve over full release, final
cross-track/radial motion remains at the fade regression, or joint/command
feasibility worsens.

bookshelf_consulted: true
source_domain: fish terminal capture scheduling and closed-loop robotic-fish CPG modulation
source_mechanism: reduce excess drive during a measured near-target stabilization regime without removing the established traveling-wave carrier or coasting through final capture
transferable_invariant: hand a bounded propulsion reserve to terminal stabilization only where measured yaw/load require it, then restore target-directed propulsion when continued closing is necessary
nontransferable_details: published gains, dimensional frequencies, clocked oscillator phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: apply a smooth bell-shaped gate from existing normalized target-distance proximity to only the progress-qualified cadence reserve; preserve the base cadence, body-frame steering observers, and posterior wave
falsification: reject if direct-uniform or held-out CFD loses or delays capture beyond the monotone fade, gives back the progress score gain, fails to improve middle-terminal yaw/load, retains the fade's final radial/cross-track regression, changes wake coherence, or worsens actuator feasibility

## Validation plan

Do not run formal CFD in this worker. After updating the single candidate and
durable guidance, invoke the configured check runner, execute its prescribed
non-CFD checks if necessary, audit every direct `params.FIELD` reference, and
run the lightweight Julia contract smoke only if the runtime is available.

## Validation status

The configured check runner was invoked, but its pinned `gpt-5.4-mini` model is
unsupported on this account and failed before workspace inspection. Its
prescribed checks were therefore executed directly. The guidance materiality
check initially found the assigned parent marked twice in the rendered
workspace `README.md`; removing only the duplicate marker made the assignment
unambiguous, and the rerun passes. The solver edit-boundary check passes, and
exactly one nonempty `candidate_target_policy.jl` exists.

Julia is not installed, so the lightweight runtime smoke cannot launch. A
deterministic static audit finds `70` unique direct `params.FIELD` references
among `72` returned fields, with no undeclared reference; only `version` and
`control_period` are metadata. Both public functions occur exactly once, and
the policy contains no explicit state clock or step input, randomness, file
I/O, cylinder cue, mutable global state, or memorized route. Offline replay of
the new proximity window on the sampled progress trajectory retains all of the
reserve outside `3L`, retains a mean `0.1735` in the `1--2L` band, and rises to
a mean `0.7840` inside the final `1L`, reaching full re-engagement at the
terminal-full boundary. Candidate SHA-256:
`b1f53fd18894633ead366a016d166d7c5e8b8291dbf788fe6b264d5e0ee7ad35`.
No formal CFD was run.
