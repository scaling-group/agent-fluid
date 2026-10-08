# Convergence-partitioned outer response allocation

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite free-surge/sway/yaw moving-window dynamics, and
  capture. There is no failure termination, so the active lower-score capture
  is the informative control regression.
- Two sampled policies are exact copies of
  `v40_intercept_supported_terminal_posture`; a third adds a course/yaw branch
  but produces the identical trajectory and combined keyframe sheet. These
  three evaluations reproduce capture at `19.684490 T`, score
  `-0.261384287`, mean/final distance `2.151092787 L`/`0.748302400 L`, the
  same `4 L` crossing, and no joint-angle stop dwell. The alternate branch is
  therefore dormant, not a second positive mechanism.
- The sampled response-opposed terminal posture increment is independently
  active but worse. It delays capture to `19.722988 T`, regresses score and
  mean/final distance to `-0.261856310`, `2.151574012 L`, and
  `0.748641372 L`, and changes the terminal head crossing while retaining no
  joint-angle stop. Below `4 L` it slightly lowers anterior high-command and
  rate-cap counts but leaves posterior counts and peak loads comparable; lower
  command incidence alone does not validate more posture allocation.
- I inspected the complete combined sheets for the reproduced `v40` result and
  the active response-opposed regression, including all top-down mid-plane
  vorticity and oblique body/Lambda2 keyframes from release to capture. Both
  fish visibly self-propel from quiescent water along the same compact target
  arc, form a coherent alternating posterior wake, and retain localized finite
  three-dimensional structures. Neither shows passive advection, a loop,
  collision, boundary-exit precursor, wake collapse, numerical instability,
  or out-of-plane motion. The visible difference is too small to support a new
  propulsion or terminal disturbance-rejection mode; distance and command
  histories locate the regression in terminal allocation.
- The current `v40` trace still has a strongly oscillatory but productive
  middle approach: it progresses from about `9.875 L` at `8 T` to `3.517 L`
  at `16 T` while speed rises from about `0.749` to `0.894 L/T`, and the two
  views retain the same coherent wake. Inherited logs show that signed
  geometry/course agreement already improved the outer route, while current
  evidence and the inherited common-ratio regression reject additional
  terminal response or clipping allocation. The independently testable locus
  is therefore how the existing outer allocator distinguishes posterior
  tracking error that is resolving from error that is stalled or worsening.

## Policy hypothesis

Start from the reproduced `v40` policy and preserve its oscillator, mean-bend
targets, signed geometry/course agreement, closure preview, center-intercept
posture handoff, terminal carrier relief, and acceleration envelope. Add one
outer response-direction selector to its existing exclusive saturation
allocator. Project posterior joint velocity onto the signed error from its
already computed traveling-bend target and normalize positive convergence by
the declared oscillator amplitude and angular frequency. While the posterior
joint is stalled or moving away, retain the evaluated lag-error allocation to
coordinated common limiting. As measured motion converges, transfer that same
bounded share continuously to the already existing body-frame target residual.
No endpoint command or total authority is increased, and the outer saturation
gate makes every same-state command at and below `4 L` exactly `v40`-identical.

This is a response-partition mechanism rather than scalar-only gain tuning: it
uses the direction of observed posterior tracking, not another lag threshold,
course threshold, cadence, mean-curvature bias, or terminal hold increment.
The expected benefit is to stop reserving saturated authority for a traveling
bend that the posterior joint is already recovering, while preserving that
coordination during adverse response. Falsify the candidate if the selector is
dormant or effectively constant, changes any same-state command at or below
`4 L`, increases the declared authority, delays or loses capture, worsens the
distance integral, erases the compact middle trajectory, raises joint-stop
dwell or loads, becomes unstable, or degrades either wake view. The new CFD
evaluation occurs only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop CPG robotic-fish path following together with classical traveling-wave propulsion
source_mechanism: preserve posterior wave coordination under adverse measured response while releasing shared actuator priority to bounded route correction once posterior tracking is demonstrably converging
transferable_invariant: when rhythmic coordination and low-frequency steering share bounded actuators, signed oscillator response can select which existing command receives priority without increasing authority
nontransferable_details: published gains, dimensional cadence, species-specific wave envelopes, full-body kinematics, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: outside the normalized terminal band, project posterior joint velocity onto its lag-target error, normalize positive convergence by declared oscillator scales, and use that gate to transfer convex priority from the existing response-coupled limiter to the existing body-frame target residual
falsification: reject on dormancy or near-constant activation, terminal same-state interference, slower or lost capture, worse distance integral, changed useful topology, stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Replaying the candidate and evaluated `v40` in separate Julia modules on all
  four sampled state histories changes `1738` stored commands per history, all
  outside `4 L`, with maximum same-state difference about
  `2.6351 rad/T^2`. The convergence selector is nonzero on `1960/2807` outer
  states, spans its full smooth range, and has mean support about `0.543`; the
  four sampled outer histories are identical, while their terminal histories
  differ only after the candidate branch is exactly gated off. These checks
  establish activity and terminal same-state noninterference, not a coupled-flow
  improvement.
- A deterministic `21870`-state grid spanning range, target angle, center
  velocity, both joint positions, and both joint velocities produces `1453`
  active differences. All outputs are finite and within the declared
  `1750 deg/T^2` limit; no state at or below `4 L` changes, and no stalled or
  posterior-departing state changes. This confirms the intended signed-response
  selectivity and existing-authority bound, not CFD performance.
- The material-guidance check passes after removing one duplicated
  assigned-parent marker from the rendered workspace `README.md`; the
  lightweight two-output Julia contract and repository boundary check also
  pass. The deterministic schema audit resolves all `89` direct
  `params.FIELD` references in the `90`-field object returned by
  `target_policy_params()`; only the version label is intentionally unused by
  control algebra.
- The prescribed `check-runner` was invoked after the edits, but its pinned
  `gpt-5.4-mini` model is unavailable with this ChatGPT account and failed
  before running a command. Its three configured non-CFD commands were then
  run directly and separately, and all pass. No formal CFD was run in this
  workspace.
