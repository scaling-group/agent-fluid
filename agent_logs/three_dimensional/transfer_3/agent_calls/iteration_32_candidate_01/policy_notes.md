# Reproduced traveling-bend and intercept-posture candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite free surge/sway/yaw dynamics, and `capture`
  termination. The assigned-parent step-31 rollout satisfies the same
  contract and is the most informative completed failure because it preserves
  capture but radically worsens the useful trajectory.
- Three samples behaviorally reproduce the `v40` law. Two are byte-identical
  and a third has a dormant course-worsening branch; all capture at
  `19.684490 T`, score `-0.261384287`, and have mean/final distance
  `2.151092787 L`/`0.748302400 L`. The current response-permissive prefill
  retains the outer path through the `4 L` crossing but delays capture to
  `19.711988 T`, regresses score/mean/final distance to `-0.261822240`,
  `2.151500419 L`, and `0.748728991 L`, and lengthens the path from
  `12.9511 L` to `12.9849 L`. Thus measured outward motion does not justify
  retaining extra carrier inside the validated posture handoff.
- The inherited outer phase-lag governor shortened at most `6.07%` of the
  derivative-defined lag and changed fixed-trace commands by at most
  `0.7072 rad/T^2`, but its completed CFD result is a large semantic
  regression: capture moves to `46.145020 T`, score falls to `-0.915605503`,
  mean distance rises to `2.857986094 L`, and path length rises to
  `31.0127 L`. It first reaches `4 L` at `15.570506 T`, passes to
  `1.4310 L` by `19.998 T`, then moves away to about `5.0430 L` by
  `35.997 T` before returning. Its center spans `x=6.1770..21.0045 L` and
  `y=8.6380..14.4613 L`, versus the compact winner's
  `x=10.0515..21.0044 L` and `y=9.5076..14.0204 L`.
- I inspected the complete combined keyframe sheets for the reproduced `v40`
  winner and the inherited phase-lag failure, including every top-down
  mid-plane vorticity frame and oblique body/Lambda2 frame from release to
  termination. The winner visibly self-propels from quiescent water along a
  compact target-directed arc, sheds a coherent alternating posterior wake,
  and retains localized finite three-dimensional structures through capture.
  The phase-lag policy also self-propels and forms a coherent early wake, but
  the later sheets show the body following a broad orbit around the target
  rather than the compact intercept. There is no collision, passive
  advection, boundary exit, wake collapse, or numerical instability.
- Metrics and diagnostics support that visual diagnosis. The phase-lag policy
  has `2451` distance-increase steps versus `108` for `v40`, yet similar
  finite peak body-force/moment coefficients and a sustained speed near
  `0.69 L/T` around the loop. The failure is therefore loss of mean-course
  control after altering the propulsive phase relation, not inadequate thrust
  or actuator instability. Same-state terminal command identity did not
  establish realized-trajectory noninterference because the governor was
  active on most outer states.

## Policy hypothesis

Use the exactly reproduced `v40_intercept_supported_terminal_posture` law as
the single candidate. Relative to the current prefill, remove the active
outward-response carrier retention and restore the fixed `12%`
intercept-supported posture share. Relative to the assigned-parent experiment,
do not carry forward the widespread outer phase-lag governor. Preserve the
state-feedback oscillator, derivative-defined posterior lag, target-angle
redirect, response-conditioned coupled limiter, target-residual allocation,
closure preview, center-intercept corridor, and quiet terminal posture.

This is evidence-backed mechanism selection, not scalar-only gain tuning. It
adds no time, step count, route, target identity, world coordinate, force
cancellation, or reconstructed vortex phase. The expected result is the
reproduced compact path, coherent two-view wake, capture near `19.6845 T`,
score near `-0.2613843`, and no joint-stop dwell. Falsify the selection if the
exact controller does not reproduce, delays or loses capture, worsens the
distance integral, produces a loop or boundary exit, renews stop dwell or
material load growth, becomes unstable, or degrades either wake view. The new
CFD result occurs only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: traveling-wave swimming models and closed-loop coupled-oscillator robotic-fish control
source_mechanism: maintain a directed anterior-to-posterior bend while target feedback modulates mean course, because posterior phase is part of propulsion and turning rather than an isolated overload knob
transferable_invariant: preserve an evidenced state-feedback traveling-wave phase relation when it produces coherent thrust and a compact target course; reject even small widespread phase adaptation when completed rollout response changes the mean trajectory into an orbit
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: restore the reproduced normalized body-frame `v40` law, including its fixed derivative-defined posterior lag and response-conditioned coupled limiter, while removing the prefill's outward-response terminal carrier retention and excluding the inherited outer lag governor
falsification: reject on failed reproduction, slower or lost capture, worse distance integral, renewed looping or boundary exit, joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- The candidate is byte-identical to the two evaluated `v40` solver samples,
  with shared SHA-256
  `624f4cec48f1a4c8d2eada4f72269efd16c22d4785955a09cd208447208cd659`.
- The configured guidance check passes after removing only the duplicate
  assigned-parent marker from the rendered workspace `README.md`. The finite
  two-output Julia contract and solver edit-boundary checks pass.
- The deterministic schema audit resolves all `88` direct `params.FIELD`
  references against the `89` fields returned by `target_policy_params()`;
  only the version label is intentionally unused.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this ChatGPT account and failed before executing a
  command. Its three configured non-CFD commands were run directly and pass.
  No formal CFD was run in this workspace.
