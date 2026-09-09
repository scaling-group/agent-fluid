# Candidate diagnosis and hypothesis

## Evidence diagnosis

All three finite sampled rollouts satisfy the experiment contract: direct
uniform initialization with `U_infinity=(0,0,0)`, no cylinders, and a working
integer-cell moving window. I inspected both the top-down vorticity row and the
oblique body/Lambda2 row in each combined keyframe sheet.

`solver_19f251537923` is the strongest propulsion example. Both views show a
coherent, planar, self-propelled alternating wake rather than advection. Its
transferred `0.55T`, `28 deg` carrier reduces distance from `12.328L` to
`6.138L` at `16.505T`, but then continues below the target and exits the lower
boundary at `26.147T` with distance `10.460L`. The trajectory confirms large
beat-scale yaw (`[-2.958,3.103] rad/T`) and raw acceleration beyond the
`1800 deg/T^2` envelope in 3346/4754 anterior and 3655/4754 posterior samples.
The useful wake is therefore coupled to persistent action clipping.

The prefilled `solver_97bc3c03d55b` simplifies steering to posterior mean
curvature but retains the same high-energy carrier. Its top-down and oblique
rows still show a coherent, self-propelled wake, and it decreases distance
monotonically to `9.175L`; however, the fish bends above the target and exits
the upper boundary at only `11.132T`. Raw acceleration still exceeds the
envelope in 830/2024 anterior and 628/2024 posterior samples, while heading
ranges from `0.663` to `-0.840 rad`. Thus the simpler feedback changes the exit
side but neither removes carrier clipping nor prevents oversteer.

The assigned-parent candidate `solver_e6325a747ec1` is the informative
envelope-compatible failure. Its `1.10T`, `10 deg` carrier has no acceleration
saturation, but the keyframes show only a short weak wake before a tight
wrong-way C-turn. It improves `12.328L` to just `12.323L`, then exits the upper
boundary at `9.394T` and `13.616L`; mean world velocity is `(0.017,0.128)U`.
This falsifies envelope compliance plus static tail curvature as sufficient:
the carrier lost useful surge and the mean bend dominated the wave. The fourth
sample, `solver_117f1b60a271`, failed before CFD because its parameter object
omitted the evaluator-required `control_period`; it supplies no physical
evidence but fixes a schema requirement for this candidate.

## Policy hypothesis

Use an intermediate, envelope-guarded traveling-bend carrier (`0.85T`, modest
anterior amplitude, posterior lag and emphasis) to recover more of the visible
propulsion without returning to the clipped `0.55T` regime. Replace static mean
curvature with one zero-cycle-mean posterior half-cycle shaping mechanism.
Compute its route request from the signed angle between measured swimming
velocity and the target vector; because both vectors are expressed in the body
frame, their relative angle cancels beat-scale body yaw. Blend back to bearing
only while speed is too small for course to be meaningful, and gate startup
authority accordingly. Positive target-side request uses the documented
positive-asymmetry/negative-yaw convention.

The mechanism is falsified if it fails to establish sustained negative-x surge,
if it again exits the upper boundary before the parent/prefill horizons, if the
course error does not decrease without a DC joint offset, if raw action remains
persistently clipped, or if the posterior wave loses a coherent alternating
wake. The later evaluator should compare progress beyond `9.175L`, the exit
class/horizon, saturation fraction, joint means, and both wake views; this
worker does not claim an unevaluated improvement.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and classical traveling-wave propulsion
source_mechanism: target-driven half-cycle amplitude asymmetry superposed on a posterior-emphasized traveling bend
transferable_invariant: steering can change the relative strength of opposite beat halves while retaining a directed, zero-mean propulsive wave instead of imposing persistent static curvature
nontransferable_details: published gains, dimensional frequencies, species-specific amplitudes, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: infer carrier phase from joint angle and velocity, map normalized body-frame target/velocity course error to bounded zero-mean posterior half-cycle shaping, and keep all carrier and steering parameters in target_policy_params
falsification: reject if thrust or wake coherence collapses, correct-sign course correction is absent, upper-boundary oversteer recurs, or persistent action clipping returns
