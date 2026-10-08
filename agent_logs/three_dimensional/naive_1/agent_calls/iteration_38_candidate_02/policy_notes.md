# Wake-policy candidate notes

## Evidence diagnosis

The assigned parent and sampled rollouts all use direct uniform still-water
initialization (`U_infinity=0`) and capture. Two sampled copies of the
assigned-parent policy and one recovery-preview control reproduce
`22.154001T`, `2.105583L` mean distance, `0.748384L` crossing distance, and
score `-0.210952`; the matched policy without proximity preview on the
posterior half-cycle envelope captures one solver step later at `22.159500T`,
with `2.105808L` mean distance and score `-0.211168`.
The parent raises mean action only from about `59.830` to `59.932`, while both
variants retain peak normalized force/moment `0.030897/0.015839` and nearly the
same anterior/posterior exact-rate-cap occupancy (`11.49/6.41%` for the parent).

The parent and slower comparison have complete combined keyframe sheets. Their
top-down rows show the same self-propelled curved route and attached alternating
vorticity street from release through capture; their oblique rows show discrete
three-dimensional Lambda2 structures without visible wake collapse or
instability. The recovery-preview control has the same top-down sheet but a
blank oblique row, so it adds no 3D-wake evidence. The coarse visual sampling
cannot resolve the one-step parent improvement, but it rules out a different
route, passive advection, or a newly degraded wake as its explanation.
Numerically, the parent is unchanged through the launch and only separates
after proximity-dependent preview becomes active. The current
implementation uses the led full target error to schedule the magnitude of the
posterior half-cycle envelope, but still uses instantaneous lateral geometry to
decide which joint-observed half-cycle is useful. That mismatch is the narrow
remaining testable allocation gap.

## Policy hypothesis

Keep every evidenced carrier, slow-course, anterior redirect, recovery,
reactive-rudder, and terminal-relief path unchanged. On the posterior
half-cycle asymmetry path only, derive the target-side turn sign from the
already bounded proximity-led full target error and combine it with anterior
joint velocity to select the useful stroke. Keep the instantaneous
target-side stroke gate for anterior-qualified terminal rudder relief. This
changes neither an authority ceiling nor a gain: it makes the existing
predictive posterior envelope internally consistent about both when and on
which half-cycle to act.

Expected result: retain the launch, captured S-route, alternating 3D wake, and
load/saturation envelopes while improving on the parent boundaries of
`22.154001T`, `2.105583L`, and `-0.210952`. Falsify the transfer if capture is
later, mean distance or score regresses, the preterminal route changes, the
carrier wake weakens, or action, exact-cap occupancy, peak normalized force, or
peak moment exceeds the parent envelope without a task-level improvement.

bookshelf_consulted: true
source_domain: biological and robotic-fish turning control
source_mechanism: half-cycle amplitude asymmetry superimposed on a traveling propulsive bend
transferable_invariant: use observed joint phase and target-side demand to strengthen the useful half-cycle while preserving the alternating carrier
nontransferable_details: species-specific body waves, published gains and amplitudes, clock phase, exact vortex phase, and task-specific routes
policy_translation: combine bounded proximity-led body-frame target error with normalized anterior joint velocity only for posterior half-cycle selection; preserve all existing ceilings and the instantaneous terminal-relief gate
falsification: reject if it fails to beat the reproduced parent arrival and mean-distance boundaries or worsens route, wake coherence, effort, saturation, force, or moment
