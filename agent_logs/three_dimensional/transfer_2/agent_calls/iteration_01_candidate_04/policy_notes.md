# Candidate diagnosis and hypothesis

The only sampled solver (`solver_e699ec5c28f1`) is exactly the prefilled
iteration-20 2D champion transfer.  It is an informative finite failure, not a
positive control: score `-12.215352`, `left_domain` at `26.18T`, distance
`12.33L -> 6.18L -> 10.60L`, and no capture.  No inherited optimizer log is
present in this fresh parent; the parent guidance contains only the lineage
contract, so the sampled rollout is the mechanism evidence available here.

Both required visual rows were inspected.  The top-down row starts from
uniform quiescent fluid and develops a strong, coherent alternating wake, and
the oblique Lambda2 row confirms a genuinely three-dimensional wake carried by
the freely moving body.  Thus the fish is self-propelled rather than advected.
The wake remains organized while the trajectory curls downward and leaves the
virtual field; missing thrust is not the primary failure.

The histories sharpen that diagnosis.  Speed reaches `0.841L/T`, but absolute
yaw rate reaches `3.118 rad/T`; joint 1 and joint 2 are at the `260 deg/T`
speed limit for about `8.6%` and `10.4%` of samples.  At the closest approach
(`17.16T`, `6.18L`) the body-frame target error is still `1.174 rad`, so the
minimum is an uncontrolled pass rather than aligned approach.  At `4T` the
target error is only `-0.022 rad` while yaw rate is already `-2.43 rad/T`; the
inherited asymmetric positive-turn curvature supplies too little braking.
Later, target error remains positive while yaw repeatedly swings between
large negative and positive rates and the fish continues toward the lower
boundary.

Policy hypothesis: preserve the evidenced state-feedback oscillator and
posterior lag, but replace the imported multi-branch 2D steering with one
reflection-symmetric response-gated mean-curvature redirect.  A normalized
body-frame target angle sets a bounded desired yaw rate.  The error between
measured recent yaw rate and that desired rate sets bounded total curvature;
because positive joint curvature produces negative yaw in the calibrated 3D
FSI model, `curvature ~ measured_rate - desired_rate`.  Large error therefore
redirects strongly, while an observed fast response automatically releases or
reverses curvature before geometric alignment is crossed.  No time, route,
world coordinate, vortex phase, or scalar-only frequency mutation is added.

Falsification: reject this translation if the next CFD result retains the
lower-boundary exit or multi-radian yaw swings, if closest approach remains a
large-angle pass, if symmetric braking destroys the coherent propulsive wake
or materially worsens progress, or if joint/action saturation increases.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish direction tracking
source_mechanism: response-gated curvature redirect with release into the propulsive rhythm
transferable_invariant: strong bounded curvature should decay or reverse when measured yaw response has already met the body-frame target-directed rate
nontransferable_details: published gains, species-specific C-start shapes, clocked CPG phases, exact vortex phases, and task-specific routes
policy_translation: map normalized target_body_L to a bounded desired yaw rate, map recent yaw-rate error to signed mean curvature, and retain the two-joint state-feedback traveling bend
falsification: the same domain exit or yaw oscillation, lost distance progress/coherent wake, or increased saturation disproves benefit in this lane
