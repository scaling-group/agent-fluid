# Candidate diagnosis and hypothesis

## Evidence read before editing

All four sampled evaluations report direct uniform still-water initialization,
`U_infinity=0`, no cylinders, and a finite `left_domain` termination. The
combined top-down/oblique sheets for the strongest finite sample and the
distance-envelope failure both show self-propulsion and a coherent alternating
3D wake. They also show the same useful-then-failing trajectory: early travel
toward the target, a powered lateral pass below it, rotation into an almost
vertical downward track, and lower-boundary exit. This is not passive advection
or wake collapse.

The best sample reached `2.443L` at `17.869T` and survived to `31.097T`, but its
full body-frame target direction grew from `0.341 rad` at `4.0L` to `0.704 rad`
at `3.0L` and `1.421 rad` at minimum distance. Over the same approach its
approximately one-period closing response fell from `0.721` to `0.465` and then
`-0.052 L/T`; it still had about `0.669U` translational speed at the minimum.
The full-direction-only sample (`2.494L`), distance-only energy envelope
(`2.845L`), and return-half-cycle brake (`2.501L`) retained the same lower-exit
class. Thus neither acute-bearing repair, proximity-only drive relief, nor one
half-cycle modifier supplies the missing late redirect. The best rollout also
clamped joint accelerations for about `0.746/0.354` of its samples (joint 1/2),
so indiscriminate effort is not a credible remedy.

## Policy hypothesis

Preserve the evidenced `7 deg` anterior mean-curvature cruise and lagged
posterior carrier. Derive target direction from normalized `target_body_L` so
front/back geometry is retained. Add one continuous burst-redirect residual:
only the conjunction of material full-direction error and inadequate measured
closure grows an extra bounded C-bend; gross misalignment attenuates the
traveling posterior wave, and a corrective measured yaw response releases the
residual. No distance threshold, clock, route, world coordinate, force, or wake
phase enters the policy. The candidate should match the parent in the far field
but begin a stronger correct-sign redirect as closing response degrades near
the lateral pass.

Falsification: reject the mechanism if it degrades the established early
approach, creates a short-wake tight curl, preserves the lower-boundary exit and
roughly `2.4--2.9L` closest approach, or increases either joint's acceleration
clamp residence. A better closest approach without a different useful
trajectory is insufficient evidence of successful transfer.

bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG turning
source_mechanism: large observed heading error commands a bounded strong bend, then measured turn response releases back into the propulsive rhythm
transferable_invariant: combine persistent body-frame target misalignment with inadequate closing response to gate a temporary redirect while preserving aligned cruise
nontransferable_details: species kinematics, published gains, dimensional beat timing, open-loop burst duration, exact vortex phase, and task-specific routes
policy_translation: normalized full target direction and closing speed gate an extra bounded two-joint mean bend; measured yaw response releases it and alignment controls posterior-wave authority
falsification: early-progress loss, a short-wake curl, unchanged powered lower exit, no semantic closest-approach improvement, or greater acceleration-limit residence

## Pre-CFD contract sanity

Replaying the completed approach observations through the gate (without
claiming a new hydrodynamic result) gives median redirect weights of only
`0.000--0.002` outside `4L` and `0.024--0.044` between `3--4L`, rising to
`0.858--0.890` only inside `2.7L` across the three closest samples. This
supports the intended cruise/redirect separation. A mirrored body-frame target,
joint state, and yaw rate produced exactly sign-mirrored finite joint commands.
