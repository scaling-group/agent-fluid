# Intercept-supported terminal command coordination

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 evidence contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. The
  assigned prefill is the `v40_intercept_unsupported_carrier_recovery` sample
  at `19.783508 T`, score `-0.262141399`, mean distance `2.151902620 L`, and
  final distance `0.749028981 L`.
- The evaluated `v39` parent and both attempts to recover carrier on an
  intercept deficit all cross `4/3/2/1 L` on the same stored solver steps and
  capture at `19.783508 T`. Increasing complementary carrier recovery from
  `3.5%` to `6%` improves score only from `-0.262179959` through
  `-0.262163153` to `-0.262141399`, while path length grows slightly from
  `13.035441 L` to `13.035461 L`; their below-`4 L` high-command counts remain
  exactly `318/373`. This is an active but non-semantic scalar response, not
  evidence that terminal cadence recovery is the useful mechanism.
- The alternative `v40_intercept_supported_terminal_posture` is the clear
  sampled winner. It preserves the `15.444014/16.620995 T` crossings of
  `4/3 L`, reaches `2/1 L` at `17.809002/19.162004 T`, and captures at
  `19.684490 T` with score `-0.261384287`, mean distance `2.151092787 L`,
  final distance `0.748302400 L`, and path length `12.951133 L`. Relative to
  `v39`, it removes `89/71` anterior/posterior high-command samples below
  `4 L` and has no joint-angle stop dwell. It is therefore the evidence-backed
  starting point for this candidate rather than the assigned prefill.
- I inspected the combined keyframe sheets for the strongest posture sample
  and the assigned carrier-recovery contrast from release through capture,
  including the top-down mid-plane-vorticity and oblique body/Lambda2 rows.
  Both fish visibly self-propel from quiescent water along a compact
  target-directed path, form a coherent alternating posterior wake, and retain
  finite localized three-dimensional structures. Neither is passively
  advected and neither shows a loop, boundary precursor, wake collapse,
  collision, or out-of-plane instability. The sheets are nearly identical at
  their coarse sample times; the quantitative distinction is the posture
  candidate's shorter late path and earlier crossing, not a different wake
  family.
- The posture winner still has `229/302` anterior/posterior commands above
  `30 rad/T^2` below `4 L`. Its maximum force and moment, about
  `0.03052/0.01567`, occur near `3.029 L` when both reported commands are at
  the software acceleration cap. The coherent wake, successful posture
  handoff, and absence of joint stops argue against more cadence, mean
  curvature, or authority; the remaining testable deficit is command-ratio
  loss when the terminal carrier is independently clipped.

## Policy hypothesis

Start from the evaluated intercept-supported posture policy, preserving its
state-feedback oscillator, geometry-agreed outer allocator, target residual,
mean bend, closure preview, crossflow relief, intercept corridor, posture
handoff, and acceleration limit. Add one terminal coordination mechanism:
while actual body-frame target range is inside the existing `4 L` band,
closure is supported, and center translation lies in the existing intercept
corridor, blend a small fraction of independently clipped rhythmic commands
toward their common-scaled two-joint direction. The blend is additionally
conditioned on measured clipping-direction distortion, so it is exactly zero
for unsaturated commands and for clipping that preserves the requested ratio.

This translates the traveling-bend invariant into an actuator-envelope
response without changing cadence, phase, mean curvature, turn sign, route, or
total authority. The mechanism should preserve the winning outer trajectory
and posture transition while reducing ratio-flattened terminal commands and
their load peak. Support it only if it is independently active on the winner's
stored states, exactly inactive at and beyond `4 L`, finite and bounded on a
state grid, and the later CFD rollout preserves capture while improving load,
distance integral, or arrival. Falsify it on dormancy, outer command changes,
more high-command incidence, weaker closure, delayed or lost capture, worse
mean/final distance, a loop, joint-stop dwell, material load growth,
instability, or degradation of either wake view. The new CFD evaluation occurs
after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion and sensor-modulated robotic-fish CPG approach control
source_mechanism: preserve coordinated posterior-lag body-wave actuation while handing rhythmic propulsion to a bounded target-relative posture
transferable_invariant: when a supported terminal intercept permits reduced rhythm, actuator limiting should retain the requested two-joint traveling-bend direction instead of independently flattening it
nontransferable_details: published gains, dimensional cadence, species-specific envelopes and kinematics, full-body waveforms, exact vortex or beat phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: under normalized body-frame proximity, positive-closure, and center-intercept support, use clipping-direction distortion to blend a bounded share of the two raw joint commands toward their common-scaled direction; preserve the outer allocator, shared posture equilibrium, and command limit
falsification: reject on dormancy, any change at or beyond the terminal band or without closure/intercept support, increased terminal clipping or loads, slower or lost capture, worse distance integral, a loop, joint-stop dwell, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Replaying the evaluated posture winner and this candidate on reconstructed
  body-frame states from all four sampled traces changes `216` states on the
  winner and `206` on each carrier-recovery trace. On the winner, activity is
  confined to about `1.567--3.946 L`; no changed state is at or beyond `4 L`,
  lacks positive closure, or lacks center-intercept support. The maximum
  same-state command change is about `1.490 rad/T^2`. These are activity and
  noninterference checks, not a coupled-flow result.
- A deterministic `164025`-state grid spanning range, body-frame target and
  center-course angles, speed, closure, and both joint positions and rates has
  `5930` active differences, with a maximum change of about
  `1.626 rad/T^2`. Every output is finite and within the declared acceleration
  limit; all states at or beyond `4 L`, without positive closure, or without
  intercept support are exactly winner-identical.
- The lightweight two-output policy contract passes. The deterministic schema
  audit resolves all `89` direct `params.FIELD` references in the `90`-field
  object returned by `target_policy_params()`; only the version label is
  intentionally unused. No formal CFD was run in this workspace.
- The prescribed check-runner was invoked after the edits, but its pinned
  `gpt-5.4-mini` model is unsupported on this ChatGPT account and failed before
  executing a command. Its three configured non-CFD checks were therefore run
  directly and separately. The guidance check first exposed a duplicated
  assigned-parent marker in the rendered root `README.md`; removing only that
  duplicate repaired parent resolution. Guidance materiality, the lightweight
  policy contract, and the solver edit-boundary check all pass.
