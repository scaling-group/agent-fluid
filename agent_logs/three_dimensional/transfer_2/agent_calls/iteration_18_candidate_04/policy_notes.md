# Steering-residual posterior coast candidate

## Evidence diagnosis before the policy edit

- All four assigned rollouts satisfy the frozen direct-uniform still-water
  contract (`U_infinity=[0,0,0]`, no cylinders, no prewarm). Three are
  byte-identical v34 posterior-coast captures at `25.0635T`, minimum/final
  distance `0.749973L`, mean distance `2.352216L`, and score `-0.452083`.
  The fourth is the v27 course-preview capture at `24.5795T`,
  minimum/final distance `0.746968L`, mean distance `2.360439L`, and score
  `-0.460673`.
- Both rows of the v34 and v27 combined keyframe sheets were inspected from
  release through capture. Their top-down rows start wake-free and show
  self-propelled diagonal progress, coherent alternating mid-plane vortex
  streets, and bounded redirects into the capture disk. Their oblique rows
  show compact three-dimensional Lambda2 structures persisting through the
  turns. v34 remains in the useful v27 trajectory family; its slightly wider
  terminal hook is not wake breakup, passive advection, or instability.
  No failed rollout image is present among this worker's four assigned solver
  artifacts, so the failure contrast is limited to inherited audited logs:
  the two dual-joint rate barriers retained coherent wakes but changed capture
  into upper/left exits after `0.933/0.848L` near misses.
- The metrics validate v34's narrow feasibility mechanism. Relative to the
  inherited v32 braking-reserve control, it preserves capture, zero sampled
  posterior hard-stop occupancy, and the low peak planar force/yaw-moment
  class (`0.0244/0.0337/0.0162`), while posterior/any-joint exact-rate
  occupancy falls from `5.806/15.163%` to `4.586/13.869%`. Three identical
  v34 samples replicate the semantic result. Raw acceleration-envelope
  exposure rises from `73.046%` to `73.930%`, capture is delayed by about
  `0.435T`, and anterior exact-rate occupancy remains `9.282%`; therefore
  v34 is posterior follower feasibility, not a general saturation cure.
- A fixed-state decomposition of the completed v34 trace finds 288 states in
  which the coast guard changes the posterior command, 283 above `6.5L`.
  In 275 cases posterior steering accelerates in the current velocity
  direction, so coasting the full net command is consistent with the guard.
  In 13 states clustered at `6.75--6.29L`, the carrier still pushes toward the
  rate boundary but the already-computed target steering opposes posterior
  velocity by `1.51--9.35 rad/T^2`; v34 suppresses that useful rate-reducing
  residual along with the carrier. This is an allocation conflict, distinct
  from the failed barriers' new full inward braking across both joints.

## Policy hypothesis

Preserve v34's anterior state-feedback phase anchor, posterior traveling-wave
target, course-preview route, steering-priority allocation, predictive stroke
gate, posterior braking reserve, and posterior-only coast band. Refine only
the coast allocation: when the final posterior command would increase an
already boundary-limited rate, taper the velocity-increasing remainder as in
v34, but let an existing rate-opposing posterior steering component define the
full-boundary residual. Do not synthesize a new brake, change the anterior
command, alter below-band states, or pass velocity-increasing steering through.

The expected result is capture with the established coherent route and v34
load class, zero posterior hard-stop occupancy, and no regression from v34's
`4.586/13.869%` posterior/total exact-rate occupancy. The sharper prediction
is earlier release from the two short posterior plateaus near `6.7L` and
`6.3L`, without the trajectory-scale phase disruption seen under dual-joint
braking. Falsify the mechanism if capture is lost, the far route or wake
changes materially, posterior hard-stop contact returns, loads leave the
roughly `0.035` class, rate occupancy rises, or the steering residual merely
recreates the inherited pass-and-turn topology. A lower rate statistic alone
is not an improvement.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: an anterior phase anchor organizes a traveling bend while bounded proprioceptive feedback adapts the phase-lagged posterior follower without discarding target steering
transferable_invariant: preserve the anterior phase reference and the signed steering contribution while removing only constraint-conflicted posterior carrier effort
nontransferable_details: published gains, dimensional cadence, species-specific envelopes and kinematics, full-body waveforms, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain v34 and use normalized posterior rate plus the owned rate and acceleration envelopes to taper only the velocity-increasing remainder, with the already-computed velocity-opposing posterior steering as a bounded residual
falsification: reject if capture, coherent route and wake, zero posterior hard-stop occupancy, or the v34 low-load and rate-occupancy classes are lost

## Pre-evaluation validation

- The prescribed public-contract state returns exactly two finite joint
  accelerations. All `84` direct `params.FIELD` references resolve among the
  `86` fields returned by `target_policy_params()`.
- A `501,061`-point direct guard grid over signed posterior rate, command, and
  steering is finite and mirror-equivariant to numerical equality. Below the
  `250 deg/T` band and for already rate-reducing final commands, v35 is exactly
  v34. At either signed `260 deg/T` boundary it still returns zero for
  velocity-increasing steering, while a velocity-opposing steering component
  is retained with the reflected sign and bounded by the owned acceleration
  envelope.
- Fixed-state application to all `4,557` rows of the completed v34 trace
  changes exactly `13` posterior outputs, from `13.013T` to `13.706T` and
  `6.748L` to `6.291L`; every anterior output and every below-band state is
  identical to v34. The maximum posterior delta is `8.915 rad/T^2`, below the
  owned `31.416 rad/T^2` envelope. This is an offline command audit, not a
  trajectory or CFD result.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Its three declared no-CFD checks were then
  run directly and separately: the reusable-guidance semantic check, exact
  Julia public-contract check, and solver editable-boundary audit pass. The
  rendered README initially duplicated the same assigned-parent marker; the
  duplicate line was removed so the semantic checker can identify its one
  parent. No formal CFD was run.
