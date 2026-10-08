# Candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled rollouts satisfy the frozen direct-uniform still-water
contract (`U_infinity=[0,0,0]`, no cylinders or prewarm), remain finite, and
capture. I inspected the combined top-down mid-plane-vorticity and oblique
Lambda2 rows for the assigned-parent stabilization-envelope handoff
`solver_ba129a83ae98` and the strongest finite sample
`solver_a95f7416a3de` from release through capture. Both fish self-propel on
the same broad target-directed arc and shed a compact, coherent alternating
three-dimensional wake; neither view shows passive advection, wake collapse,
or a new trajectory class. The two course-only samples
`solver_04760fa01847` and `solver_e584ff748453` are bit-identical relative
regressions at score `-0.503415`, confirming that the small sampled differences
are deterministic controller effects rather than a visual wake event.

The parent captures at `23.375013T`, score `-0.502603`, and scoring mean/final
distance `2.400102/0.746257L`. Replacing its negligible body-lateral route
term with a speed-gated, target-line course residual after anterior-carrier
rejection improves score and mean distance to `-0.501691/2.399184L`. It also
reduces inside-`3L` mean absolute yaw from `1.70656` to `1.68733 rad/T`, mean
absolute head-to-target-line cross-track speed from `0.23432` to `0.22592U`, and
mean/peak absolute moment from `0.006564/0.015118` to
`0.006393/0.013886`. Joint angles and projected acceleration remain inside
their limits, while recorded speed-cap residence is essentially unchanged.
This is positive evidence for the normalized slow-course observation.

The result is mixed near capture. The course observer reaches `6L` earlier
(`15.306512T` versus `15.367012T`) but crosses `3/2/1L` later and captures
`0.066T` later at `23.441015T`; final distance worsens narrowly to
`0.746948L`, peak yaw rises from `3.28817` to `3.34971 rad/T`, and the final
`<1L` band has worse signed and absolute target-line cross-track motion. The
sampled edit used the same course residual both in the main route command and
in the desired-yaw reference that classifies terminal yaw excess. Because the
latter only actuates inside the existing `3L` stabilization band, that shared
scope is a concrete explanation to test for the early-benefit/late-regression
split without discarding the useful observer.

## Policy hypothesis

Adopt the sampled normalized, carrier-rejected target-course observation in
the slow main geometric request, but retain the assigned parent's original
body-lateral term solely in the independently calibrated terminal desired-yaw
reference. Preserve the C-bend carrier, posterior lag, bounded stabilization-
envelope cadence handoff, distributed phase classifier, anterior phase-
selected correction, and smooth acceleration projection. This signal-role
partition is inactive in terminal actuation outside `3L`, so it should retain
the sampled observer's earlier `6L` progress while preventing the route cue
from redefining excess yaw during final capture. Falsify it if the coherent
wake or capture is lost, pre-`3L` progress regresses toward the parent, capture
remains delayed without an offsetting distance/load improvement, peak yaw or
moment grows, or actuator-limit exposure worsens.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and residual path following
source_mechanism: sensor feedback supplies a slow directional command while the coupled oscillator and bounded residual feedback retain distinct rhythmic and stabilization roles
transferable_invariant: separate a normalized slow target-course observation from fast carrier rejection and terminal stabilization before changing the two-joint oscillator mean
nontransferable_details: published gains, dimensional cadence, robot morphology, duty ratio, oscillator phase, species-specific kinematics, and prescribed paths
policy_translation: feed speed-gated body-frame target-line course residual into the main route request only; preserve the parent carrier-rejected target reference for terminal yaw-excess classification and all existing two-joint actuation layers
falsification: reject if CFD loses capture or wake coherence, gives back the sampled pre-terminal progress and mean-distance benefit, fails to recover terminal arrival/yaw/load, or worsens joint-speed and projected-command feasibility

## Validation status

No formal CFD was run. The prescribed guidance and solver-boundary checks pass.
A deterministic schema audit finds `74` returned parameter fields, `72` unique
direct `params.FIELD` references, and no undeclared reference; each public
policy function is defined exactly once. Julia is not installed in this
workspace environment, so the lightweight executable contract smoke could not
launch. The mandated check-runner was invoked, but its pinned `gpt-5.4-mini`
model is unsupported by this account and failed before inspecting the
workspace; the prescribed non-CFD checks were therefore run directly.
