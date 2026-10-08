# Wake-policy candidate notes

## Assigned-parent evidence

The only sampled rollout is the assigned transferred 2D champion
`solver_e496f399e09f` (score `-11.170165`, `left_domain`). It is also the only
available finite-progress/failure comparison; no inherited optimizer note file
was supplied. The evaluation confirms direct uniform still-water initialization
with `U_infinity=(0,0,0)`, no prewarm snapshot, and no cylinders.

In the combined keyframe sheet, the top-down row shows self-propelled motion and
a regular alternating wake from release through 16T. The fish closes from
12.33L to 4.78L at 17.85T, but its path keeps curving toward the lower boundary;
the 24T and 27.49T frames show the target-directed approach has become a
downward departure. The oblique Lambda2 row corroborates a coherent three-
dimensional wake rather than passive advection or loss of propulsion. Metrics
agree: final distance rebounds to 9.71L and the center exits at y=0.798L by
27.49T, while the run remains numerically stable.

The joint history supplies the missing control diagnosis. Joint angles stay
within 27.53 and 36.27 degrees, but both rates reach the 260 degree/T hard
limit. More importantly, the parent's raw acceleration requests exceed the
1800 degree/T^2 actuator envelope in 70.5% of joint-1 samples and 77.5% of
joint-2 samples. Thus its small acceleration-level steering residual and its
tail-curvature contribution are frequently hidden by the propulsive command's
clipping. The useful trajectory and coherent wake argue against changing the
drive rhythm first.

## Candidate hypothesis

Split the posterior acceleration into a traveling-wave component and a mean-
curvature steering component, then use a smooth steering-reserve allocator on
both joints. The reserve is driven only by the bounded body-frame target turn
request; at zero request the same state-feedback oscillator remains the sole
drive signal and is smoothly kept inside the envelope, while increasing target
error continuously trades command authority from propulsion to steering. This
should preserve the observed wake
but make the corrective half-cycle asymmetric enough to arrest the post-pass
downward curvature. It is not a claim about the unevaluated candidate.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and asymmetric flapping under actuator limits
source_mechanism: superpose a bounded target-feedback turning bias on the propulsive rhythm while retaining the oscillator
transferable_invariant: protect target-directed asymmetry from being erased when the rhythmic command consumes the actuator envelope
nontransferable_details: published gains, dimensional beat frequencies, robot hardware, species kinematics, exact phase schedules, and task routes
policy_translation: decompose the two-joint state-feedback acceleration into drive and curvature residuals, derive demand from normalized body-frame target geometry, and smoothly reserve a bounded fraction of the acceleration envelope for that residual
falsification: reject the allocation if the next rollout loses the coherent propulsive wake, increases effort or instability, preserves the same lower-boundary trajectory, or fails to improve heading recovery after the 4.78L-scale approach
