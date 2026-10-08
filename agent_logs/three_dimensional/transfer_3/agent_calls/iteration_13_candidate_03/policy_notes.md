# Course-error half-cycle carrier candidate

## Evidence and visual diagnosis before the policy edit

- All four current solver examples satisfy the frozen physical contract:
  direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, active moving-window
  transport, finite dynamics, and capture. Three are byte-identical copies of
  the assigned v26 parent and reproduce score `-0.5281078349`, capture at
  `25.1185226 T`, mean distance `2.429111372 L`, and final distance
  `0.746167541 L`; the fourth is the v23 baseline at score `-0.5283387731`,
  mean distance `2.429293780 L`, and final distance `0.746410191 L`.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  from release through termination for the best v26 rollout and the inherited
  informative v27 mean-bend-unloading regression. Both are visibly
  self-propelled rather than advected, follow the same compact target-directed
  arc, shed a coherent alternating posterior wake through the outer approach,
  and transition to a quiet held-bend terminal crab without collision,
  domain-exit precursors, wasteful flailing, or numerical instability. The
  terminal difference is too small for the coarse sheets to rank, so the
  causal comparison rests on the trajectory and load histories.
- The assigned parent preserves the baseline capture step while slightly
  increasing final speed from `0.65387` to `0.65403 L/T`, reducing terminal
  peak force norm from about `0.002264` to `0.002135`, and deepening capture.
  Its late body-frame target angle falls from `0.8824` to `0.7113 rad`, while
  its body-frame velocity course remains targetward but offset: target-course
  mismatch falls from `0.4431` to `0.3102 rad` between `1.6 L` and capture.
  Thus productive translation already exists; the remaining observable is a
  direction error between target vector and velocity, not a request for more
  static curvature.
- The sampled v27 result supplies the decisive negative boundary. Moving the
  same crossflow/closure cue from carrier allocation to a `1.5%` reduction of
  redirect mean bend keeps capture at the same step and lowers peak action,
  but regresses score to `-0.5295582789`, mean distance to `2.430256795 L`,
  final distance to `0.747692645 L`, final speed to `0.65235 L/T`, and final
  course mismatch to `0.3194 rad`. Together with the inherited anterior
  redistribution and yaw-curvature regressions, this rejects another total-
  bend or bend-location correction for the current candidate.

## Policy hypothesis

Preserve the complete evaluated v26 carrier, target-angle redirect, closure
preview, two-joint mean-curvature equilibrium, response-conditioned paired
release, crossflow/closure cue, and command limits. Add one bounded terminal
course mechanism: form the signed angle from body-frame velocity direction to
the body-frame target direction, require positive speed, late proximity,
continued closure, target-helpful crossflow, and settled joints, then use the
observed tail-bend side to apply a small half-cycle gain to both existing
carrier accelerations. The phase sign weakens restoration on the target-bent
side and strengthens it on the opposite side, while the inherited equilibrium
targets, total redirect mean, and carrier/equilibrium allocation remain
unchanged.

This is a state-derived half-cycle asymmetry, not a clocked gait, added mean
curvature, joint-role split, frequency gain, or world-frame course. It should
leave every command outside the final gate identical, retain the coherent
outer wake, and rotate terminal translation modestly toward the target without
the speed loss seen under mean-bend unloading. Reject it if the stored-state
gate is dormant or unbounded, pre-terminal commands change, capture is delayed
or lost, mean/final distance or course mismatch regresses, or coherent wake,
joint clearance, saturation, force, moment, and stability margins worsen. A
smaller body-heading error alone is not acceptance evidence.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG direction tracking
source_mechanism: use observed target error to bias alternating carrier half-cycles while preserving the underlying rhythmic scaffold
transferable_invariant: when a proven traveling carrier and mean bend already close range, a bounded state-phase asymmetry can redirect velocity without replacing the carrier or increasing static curvature
nontransferable_details: published gains, duty ratios, dimensional frequencies, species-specific joint envelopes, clock phase, exact vortex phase, full-body kinematics, and task-specific routes
policy_translation: normalized body-frame target and velocity angles define course error; speed, range, closure, helpful relative crossflow, settled response, and observed tail-bend side gate a small common multiplier on the existing two-joint carrier acceleration only
falsification: reject if the gate changes the outer path, acts at low speed or without closure and helpful crossflow, loses or delays capture, worsens distance/course metrics, or restores wake loss, saturation, joint stops, load spikes, or instability

## Non-CFD implementation audit

- The returned parameter object owns all 78 directly referenced policy fields,
  and the configured lightweight state returns two finite commands.
- Replaying the candidate and evaluated v26 parent algebra on every stored v26
  state gives exactly zero command difference at and beyond `1.6 L`. The new
  gate is active on all 226 stored states inside that range; its carrier gain
  stays in `[0.98141, 1.00000]`, its mean/max per-joint command difference is
  `0.00146/0.00913 rad/T^2`, and its final replay changes the parent command
  from about `(0.09797, 0.24640)` to `(0.09351, 0.23727) rad/T^2`. The
  observed terminal state remains on the target-bent half-cycle; the declared
  complementary gain is bounded to `[0.90, 1.10]` if the opposite side is
  encountered.
- The guidance semantic-difference check, lightweight Julia contract check,
  and solver boundary check pass. These checks establish schema completeness,
  finite output, bounded activation, exact outer noninterference, and edit
  scope only; they do not establish a coupled-flow improvement.

The current worker's CFD evaluation occurs only after exit and is not claimed
as evidence here.
