# Coupled outer reversal-reserve candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite free planar dynamics, and capture. Three
  samples reproduce the `v40_intercept_supported_terminal_posture` trajectory
  exactly, including capture at `19.684490 T`, score `-0.261384287`,
  mean/final distance `2.151092787 L`/`0.748302400 L`, and no joint-angle-stop
  dwell. The nominal `v41` course/yaw branch is one of those exact
  reproductions and is therefore dormant, not a new positive mechanism.
- The weakest current sample, `v42_response_permissive_intercept_posture`,
  preserves capture and the same visible wake family but arrives at
  `19.711988 T` and regresses to score `-0.261822240`, mean distance
  `2.151500419 L`, and final distance `0.748728991 L`. Together with the
  inherited response-opposed and terminal command-ratio regressions, this
  rejects another allocation change inside the validated late posture
  handoff.
- The assigned parent's completed outer phase-lag feasibility governor is a
  stronger negative result than the current terminal variants. Shortening at
  most `6.07%` of the derivative-defined posterior lag on the sampled `v40`
  states delayed the `8/4/3/2 L` crossings from
  `10.5435/15.4440/16.6210/17.8090 T` to
  `10.6150/15.5705/17.0280/18.8760 T`; it then missed the direct approach,
  returned as far as `5.178 L` after first entering `4 L`, and captured only
  at `46.1450 T` with score `-0.915606` and mean distance `2.857986 L`.
  Path length grew from `12.951 L` to `31.013 L`, while outer rate-contact and
  large-command counts changed little. Directly reshaping the established
  posterior lag is therefore causally unsafe even when bounded and
  response-gated.
- I inspected the complete combined keyframe sheets for the reproduced `v40`
  winner, the current response-permissive regression, and the assigned-parent
  phase-lag failure, including every top-down mid-plane-vorticity and oblique
  body/Lambda2 frame. The first two self-propel along the same compact arc,
  shed a coherent alternating posterior wake, and retain finite localized 3D
  structures; their visual similarity does not rescue the slower terminal
  allocator. The phase-lag governor still sheds a finite wake, but after the
  initially similar approach the fish visibly sweeps around the target in a
  large loop before returning. There is no passive advection or numerical
  instability: the semantic failure is loss of the compact target-course
  topology.
- Metrics localize a narrower actuator-response opportunity without requiring
  a new wave target. Above `4 L`, reproduced `v40` exceeds
  `30 rad/T^2` on `1139/1671` anterior/posterior commands and reaches the
  `260 deg/T` rate envelope on `218/349` samples. At those contacts,
  `206/341` commands still accelerate in the direction of joint velocity.
  The wake and capture nevertheless remain useful, so clipping incidence
  alone does not justify attenuation. A safer experiment is to preserve the
  full oscillator, lag, curvature, and terminal law, and act only when the
  measured two-joint response already agrees that the requested wave is
  reversing.

## Policy hypothesis

Start from evaluated `v40` without changing its oscillator, derivative-defined
posterior lag, target guidance, mean curvature, course-residual allocator,
coupled limiter, terminal intercept/posture handoff, cadence, or command cap.
Add one outer-only coupled reversal reserve after the existing carrier
allocation. Normalize each joint rate by a declared policy-owned rate scale.
When at least one joint is near that scale *and both* allocated commands oppose
their respective measured joint velocities, smoothly release one small share
of the existing coupled-limit blend toward the independently clipped raw
two-joint request. Requiring both velocity-command products to be negative
distinguishes an already requested traveling-wave reversal from the prevalent
outward command at the rate stop. The target is not new authority: it is the
same bounded drive-plus-turn vector already computed before the coupled
limiter. The gate is exactly zero at and below `4 L`, when either joint is
still being driven outward, or when either allocated command is zero.

This tests response-confirmed phase reversal rather than changing phase lag or
globally attenuating rate-limited motion. On the recorded `v40` trace, both
joints are braking while at least one exceeds `90%` of the rate envelope on
`63` outer states, so the proposed locus is independently active but far
narrower than the failed phase-lag governor's `2460` changed outer states.
Expected benefit is a slightly earlier reversal of the existing directed bend,
less rate-stop dwell, and faster progress without changing the compact route
or quiet terminal posture. Falsify the candidate if the branch is dormant or
effectively constant, changes any same state at or below `4 L`, strengthens an
outward rate-stop command, rotates the allocated command beyond the small
declared release toward the pre-existing independently clipped request, delays
or loses capture, worsens the distance integral, raises joint-stop dwell or
force/moment loads, creates a loop or instability, or degrades either wake
view. The new CFD result occurs only after this worker exits and is not claimed
here.

bookshelf_consulted: true
source_domain: closed-loop coupled-oscillator robotic-fish control and reactive traveling-wave swimming
source_mechanism: preserve a directed anterior-to-posterior bend while using measured oscillator response to support the reversal portion of the established cycle
transferable_invariant: when rhythmic actuators share a traveling-wave command, a bounded release of conservative command coupling should occur only after observed joint velocities confirm a common reversal, rather than altering the wave target or forcing motion farther into a rate boundary
nontransferable_details: published gains, dimensional cadence, species-specific amplitude and rate envelopes, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: above the normalized terminal range only, combine smooth joint-rate utilization with negative velocity-command products for both joints and release a small share of the coupled carrier toward its already computed independently clipped request while leaving lag, curvature, target residual, and terminal equations unchanged
falsification: reject on dormancy or broad activation, any terminal or outward-driving activation, direction change beyond the bounded pre-existing request, slower or lost capture, worse distance integral, looped topology, joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Replaying reconstructed body-frame states from each of the four current
  sampled trajectories changes `100` states relative to evaluated `v40`
  (`100/3579` on each exact `v40` reproduction). Every change is above `4 L`
  (approximately `4.178--12.292 L`), both returned
  commands oppose their measured joint velocities, maximum component change is
  `0.14248 rad/T^2`, and maximum command-direction change is about
  `0.00353 rad`. The assigned-parent loop trace produces `109` active outer
  states and no terminal or outward-driving activation. These equal-state
  checks establish selectivity, not coupled-flow improvement.
- A deterministic `36450`-state grid spanning range, target angle, closure,
  body-frame translation, both joint positions, and both joint rates finds
  `3024` active differences. All candidate outputs are finite and within the
  declared command limit; no state at or below `4 L` changes and no changed
  output accelerates either joint along its measured velocity. Maximum grid
  component and direction changes are `0.39318 rad/T^2` and `0.00751 rad`.
- The prescribed `check-runner` was invoked after the material edits, but its
  pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account and
  failed before executing a command. Its three configured commands were run
  directly and separately: the material-guidance check, exact lightweight
  Julia two-output contract, and solver edit-boundary check all pass. The
  deterministic schema audit resolves all `93` direct
  `params.FIELD` references against the `94` fields returned by
  `target_policy_params()`; only the version label is intentionally unused.
  No formal CFD was run in this workspace.
