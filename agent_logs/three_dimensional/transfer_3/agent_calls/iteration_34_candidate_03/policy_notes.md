# Signed course-yaw terminal posture handoff

## Evidence and visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, finite moving-window dynamics, and capture. Three
  byte-identical `v40_intercept_supported_terminal_posture` samples reproduce
  capture at `19.684490 T`, score `-0.261384287`, mean/final distance
  `2.151092787 L`/`0.748302400 L`, and `243` moving-window shifts.
- The fourth sample contains the signed course/yaw allocation branch but is
  exactly trajectory-identical to `v40`, including the score, capture step,
  metrics, and combined keyframe sheet. Reconstructing its proposed support
  on the reproduced trace finds a maximum of only about `0.240`, below the
  existing terminal allocation support floor of `0.82`; its `max` composition
  therefore never changes a command. This is a concrete dormant-mechanism
  result, not evidence for tuning its thresholds.
- I inspected the complete combined sheets for the reproduced `v40` winner
  and the informative inherited phase-lag failure, including every top-down
  mid-plane-vorticity frame and oblique body/Lambda2 frame from release to
  capture. `v40` visibly self-propels from quiescent water along a compact
  target-directed arc, sheds a coherent alternating posterior wake, and keeps
  localized finite three-dimensional structures through capture. It shows no
  passive advection, collision precursor, boundary exit, out-of-plane motion,
  or instability. The phase-lag governor initially forms a similar wake but
  turns away into a large loop; its top-down wake becomes long curved paired
  bands and its late oblique structures become sparse and separated. Metrics
  confirm a stable control-topology failure: capture only at `46.145020 T`,
  score `-0.915605503`, mean distance `2.857986094 L`, path length
  `31.012702 L`, and `607` moving-window shifts. The outer traveling-bend lag
  must therefore remain unchanged.
- The inherited `v42_converging_posture_energy` result closes the suggested
  joint-response locus. Although its coupled error-energy gate was active on
  `93` same-state terminal commands, it does not advance capture and regresses
  score/mean/final distance to `-0.261772172`, `2.151409218 L`, and
  `0.748659670 L`. Together with the earlier outward-response variants, this
  rejects joint-error direction as a selector for more or less posture in the
  established approach.
- The sampled center-course sign has a different, independently observed
  interpretation. At the `1 L` crossing the signed course sine and yaw rate
  are both negative (`-0.6340`, `-0.2739 rad/T`), while distance is closing;
  that yaw is rotating toward the target course. At capture the signed course
  sine remains negative (`-0.8215`) but yaw has reversed positive
  (`0.4354 rad/T`), so their opposite signs identify rotation that is now
  enlarging the course miss. A body-response brake should act only on this
  late reversal, not on the useful target-correcting yaw before it.

## Policy hypothesis

Start from the reproduced `v40` controller and preserve its state-feedback
oscillator, posterior lag, target-angle redirect, geometry/course-agreed outer
allocator, center-intercept corridor, mean-bend equilibrium, carrier floor,
and command limit. Add one signed body-response allocation inside the existing
terminal law. Require a material observed center-course miss and yaw whose
sign is opposite the signed course correction; smoothly transfer at most four
additional percentage points from the carrier to the unchanged damped
two-joint posture. The increment is also bounded by actual terminal proximity
and the existing closure and posture gates. It adds no turn residual, changes
no equilibrium, infers no beat phase, and is exactly zero outside `4 L` or
while yaw is already correcting the course.

This tests a response-conditioned approach hold rather than a scalar-only gain
change. The expected trace-level effect is a small command change only after
the useful terminal yaw reverses, with the outer path and both wake families
unchanged. CFD falsification is dormancy or effectively constant activation,
any command change at or beyond `4 L`, action during target-correcting yaw,
slower or lost capture, worse distance integral or final distance, renewed
joint-stop dwell, material command/load growth, instability, or degradation of
either wake view. The new CFD evaluation occurs only after this worker exits
and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and continuous biological redirect-to-approach-hold transitions
source_mechanism: use measured body response to release rhythmic allocation toward a bounded target-owned posture only when rotation worsens the observed approach course
transferable_invariant: when propulsion and terminal posture share actuators, target geometry should own the posture while the sign of normalized course error relative to measured yaw determines whether a small continuous handoff damps harmful rotation or would suppress useful steering
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: combine body-frame center-course cross product with normalized recent yaw under the existing proximity and closure gates, then add one bounded coupled share of the unchanged two-joint damped posture only for opposite-sign course/yaw response
falsification: reject on dormancy, activation during target-correcting yaw or outside the terminal band, slower or lost capture, worse distance integral, renewed joint stops or load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Replaying the evaluated `v40` and candidate on reconstructed body-frame
  states from the sampled trajectory changes `17` commands, all in the narrow
  observed yaw-reversal interval from `0.77835 L` through capture at
  `0.74830 L`. The maximum equal-state command difference is
  `0.12635 rad/T^2`. No state at or beyond `4 L`, with nonpositive closure, or
  with same-sign target-correcting course/yaw changes. The raw opposite-sign
  response support is nonzero on `77` stored terminal states and reaches one;
  only the final `17` also have enough settled posture headroom to alter the
  allocation. This is deliberately late and selective, but independently
  active rather than the sampled branch's zero-command result.
- A deterministic `181440`-state audit spanning distance, target/course angle,
  yaw, closure, and settled two-joint position/velocity response finds `16080`
  active differences from `v40`, with maximum difference
  `0.22183 rad/T^2`. Every output is finite and inside the declared acceleration
  cap. No state outside the terminal band, without positive closure, or with
  same-sign course/yaw changes. These checks establish boundedness and gate
  selectivity only; they do not establish a coupled-flow improvement.
- The material-guidance validator, exact two-output Julia policy contract,
  deterministic parameter-schema guard, and solver edit-boundary check pass.
  The schema guard resolves all `92` direct `params.FIELD` references against
  the `93` fields returned by `target_policy_params()`; only the version label
  is intentionally unused. The prescribed `check-runner` was invoked after
  the material edits, but its pinned `gpt-5.4-mini` model is unsupported on
  this ChatGPT account and failed before executing a command. Its three
  configured checks were run directly and separately instead. No formal CFD
  was run in this workspace.
