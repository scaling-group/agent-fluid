# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still-water initialization (`U_infinity=[0,0,0]`), no cylinders or
  prewarm, finite dynamics, and moving-window transport.  Their translation
  and wakes are self-generated rather than imposed advection.
- The top-down vorticity and oblique Lambda2 rows were inspected for all four
  combined sheets, with a closer comparison of the strongest finite example
  (`solver_0e39f9f53067`) and the assigned phase-selective failure
  (`solver_e3aa71fd7b95`).  Both retain a coherent alternating wake and compact
  three-dimensional structures through the approach.  The assigned parent
  reaches `3.033L` at `23.238T`, then continues west-southwest and exits the
  left boundary at `40.331T` with final distance `9.314L`.  The visible failure
  is route geometry, not absent thrust or imposed flow.
- The two mild children do not solve that route failure.  Persistent route-
  phase relief (`solver_74dbc2a53e94`) reaches `2.999L` and the `3 deg` abeam
  bend (`solver_a5440e0f837b`) reaches `3.035L`; both still exit left near
  `40T` with final distances `8.965L` and `8.999L`.  Their nearly coincident
  wake sheets and trajectories show that extending half-cycle authority or
  adding a small near-abeam bend is insufficient.
- The `7 deg` post-passage recapture child (`solver_0e39f9f53067`) is a useful
  semantic change despite essentially unchanged closest approach (`3.031L`).
  After the target passes behind, heading rotates from about `35 deg` at
  `24T` to `-113 deg` at `46T`, producing the visible hairpin and delaying exit
  to `49.319T`; final distance improves to `7.528L`.  However, reconstructed
  normalized body-frame geometry keeps the target behind and strongly lateral
  from the closest pass to termination.  The maneuver therefore turns but
  begins too late to intercept, traces a wide arc through its own wake, and
  exits above rather than reacquiring the target.
- The hairpin does not owe its topology change to more raw drive: peak raw
  acceleration remains `112.974 rad/T^2`, acceleration-envelope exposure is
  `92.77%` versus the parent's `93.63%`, and maximum speed is approximately
  `0.787U` in both.  Its larger peak local-flow magnitude (`0.0587U` versus
  `0.0243U`) occurs on the long turn-back trajectory and is a risk to monitor,
  not evidence for replacing target steering with wake cancellation.

## Policy hypothesis

Start from the strongest evaluated post-passage recapture child and retain its
joint-state oscillator, posterior lag, phase-selective relief, and bounded
posterior curvature magnitude.  Replace only the behind-target arming rule
with a pre-abeam intercept sector: ramp the signed posterior bend while the
normalized target vector becomes predominantly lateral and its forward
component falls toward abeam, and multiply it by a lateral-error gate that
releases continuously as alignment closes.  This keeps the intervention
dormant on the evidenced early centerline trajectory, uses no clock or route,
and spends the already-demonstrated turning authority before longitudinal
passage rather than after a `3L` miss.

Expected evidence is preservation of the coherent early wake followed by a
course rotation during the `14--22T` approach, falling lateral target error,
and a closer pass or capture instead of either sampled left exit or the late
upper hairpin.  Falsify the mechanism if it perturbs the initial centerline
response, recreates the inherited early upper exit, destroys propulsion,
increases limit/load exposure materially, or still leaves the target behind
near `3L` without a better termination class or useful trajectory.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG path following
source_mechanism: separate the propulsive rhythm from a strong bounded curvature maneuver armed by large observed route error and released on observed alignment
transferable_invariant: a transient redirect should spend bounded turning authority before overshoot and disappear with geometric recovery while the traveling-wave carrier remains active
nontransferable_details: species-specific C-start shape, published gains, motor timing, dimensional cadence, clock-driven phase, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame forward and lateral target components to ramp a mirror-equivariant posterior mean tangent in the pre-abeam sector and release it on lateral closure within the two-joint state-feedback carrier
falsification: reject the transfer if early progress or wake coherence is lost, actuation or loads worsen materially, an early upper exit returns, or the target still passes about three body lengths off-axis without capture or a useful topology change

## Pre-evaluation checks

- Reconstructing normalized body-frame target geometry on the assigned-parent
  trace leaves the new branch exactly dormant through `10T`; it first becomes
  nonzero at `11.985T`.  The requested posterior mean tangent ramps from
  approximately `-0.007 deg` at `12T` to `-0.807`, `-2.078`, `-2.845`,
  `-4.954`, and `-6.945 deg` at `14`, `16`, `18`, `20`, and `22T`.  Thus the
  edit spends negligible authority before the evidenced lateral sector and
  reaches the already-evaluated bound before target passage.
- A same-state replay over all `8,967` states of the strongest post-passage
  child changes no action through `10T`, bounds the action difference at
  `20.42 rad/T^2`, and leaves peak raw acceleration unchanged at
  `112.973 rad/T^2`.  Reconstructed exposure to at least one raw command above
  `1800 deg/T^2` rises modestly from `92.81%` to `93.36%`; this is not claimed
  as an improvement, and any larger closed-loop increase remains a
  falsification risk.  Fixed-state replay cannot predict the new trajectory;
  formal CFD remains deferred to EvE.
- All `64` direct `params.FIELD` references resolve among the `66` fields
  returned by `target_policy_params()`.  A `25,515`-state finite grid passes,
  the added forward/lateral gates are reflection invariant, their signed
  request is antisymmetric to machine precision, and the intervention is
  exactly zero for a target on the forward centerline.  The lightweight public
  contract also returns two finite joint accelerations.
- The required check-runner was invoked, but its pinned model is unavailable
  for this account.  Its three prescribed no-CFD commands were therefore run
  directly and separately.  The guidance check initially exposed a duplicated
  assigned-parent marker in the rendered workspace `README.md`; removing only
  that duplicate made the semantic guidance check pass.  The Julia public-
  contract check and solver editable-boundary audit also pass.
