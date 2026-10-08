# Candidate diagnosis and hypothesis

## Sampled evidence

All four sampled evaluations report `uniform_direct` initialization in still
water (`U_infinity=[0,0,0]`), zero cylinders, and stable capture. In every
combined sheet, the top-down row shows the fish translating under its own
alternating tail beat, turning smoothly down and left toward the target, and
shedding a coherent red/blue street rather than being passively advected. The
oblique row confirms compact alternating three-dimensional Lambda2 structures
persist from the caudal region through approach; there is no visible wake
collapse, out-of-plane escape, or numerical breakup. Gross trajectory and wake
topology are nearly indistinguishable across v23--v26, so the recent terminal
logic changes acted too weakly or at the wrong actuation layer to alter the
physical approach.

The phase-demodulated v24 course brake is the fastest sample: capture at
`23.831520T` with mean distance `2.434073L`. Its informative weakness is high
terminal oscillation: trajectory reduction gives `3.208 rad/T` peak yaw and,
inside `3L`, `1.684 rad/T` mean absolute yaw and `0.239U` mean absolute
target-transverse speed. Hard course/yaw consensus (v25) captures at
`23.859020T` while leaving the near-target values at `1.683 rad/T` and
`0.238U`; yaw-selected static correction (v26) captures at `23.853519T` and
leaves them at `1.687 rad/T` and `0.239U`. Thus neither sign arbitration nor a
different static-bend sign materially damps the approach. The older direct
course branch v23 is slower (`23.881021T`, mean distance `2.434313L`) but is a
useful cleaner comparison: peak yaw is `2.975 rad/T`, and inside `3L` mean
absolute yaw and transverse speed are `1.556 rad/T` and `0.225U`. Across all
four, joint angles remain below their hard limit, while both joint-speed traces
touch the velocity cap and projected acceleration commands repeatedly approach
the acceleration envelope. A new whole-body static bend would add command
pressure without addressing the phase-synchronous yaw visible in both views.
The available inherited step-8/9/10 optimizer logs likewise contain only
capture summaries, with scores spanning `-0.535919` to `-0.537914` and no
better termination class. Because those inherited entries lack trajectory and
wake diagnostics, they corroborate a plateau but do not justify scalar tuning
or a causal claim about their controller mechanisms.

## Policy hypothesis

Preserve v24's captured carrier, redirect release, continuous target-relative
course residual, and final smooth command projection. Remove only the terminal
residual's static anterior-center and posterior-tangent offsets. Reapply that
same bounded odd residual as a posterior half-cycle phase-lag modulation:
multiply it by the observed tail-bend side to form an even, reflection-safe
lag scale, increasing lag on one half-cycle and decreasing it on the other.
This changes caudal wave shape without a clock, route state, or persistent
whole-body curvature and leaves far-field propulsion exactly unchanged.

The candidate is supported if it retains capture and the coherent alternating
wake while keeping arrival below the cleaner v23 comparison (`23.881T`) and
materially lowering v24's inside-`3L` yaw/transverse-speed pair
(`1.684 rad/T`, `0.239U`) without worsening velocity-cap exposure. It is
falsified by loss of capture, arrival no better than v23, a visibly weakened or
disordered wake, unchanged terminal yaw/course measures, or higher joint-speed
or acceleration-envelope exposure.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric-flapping control and two-joint traveling-wave models
source_mechanism: target-driven half-cycle asymmetry applied through posterior phase lag while the propulsive carrier remains active
transferable_invariant: steer a traveling bend by state-synchronized posterior wave-shape asymmetry instead of replacing propulsion with persistent static curvature
nontransferable_details: published CPG gains, clock phase, species-specific envelopes, hardware frequencies, exact vortex phases, and task routes
policy_translation: use bounded body-frame terminal course/yaw residual times observed tail-bend side to modulate only the posterior lag coefficient within the existing two-joint state-feedback oscillator
falsification: reject if capture or wake coherence regresses, arrival is not better than v23, or terminal yaw, cross-track speed, loads, and joint-limit exposure fail to improve jointly
