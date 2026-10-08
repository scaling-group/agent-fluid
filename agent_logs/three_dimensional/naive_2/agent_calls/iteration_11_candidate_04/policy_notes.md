# Route-conditioned yaw-response candidate

## Evidence diagnosis before the edit

All four sampled rollouts satisfy the released experiment contract: direct
uniform initialization in still water with `U_infinity=[0,0,0]`, no cylinders,
no prewarm, finite dynamics, and `left_domain` termination. The combined
keyframe sheets show self-propulsion rather than advection. By `4T` each
top-down row has begun shedding from the tail; the later panels retain an
alternating vortex street, and the oblique rows retain tail-connected 3D
Lambda2 structures through the terminal excursion. The carrier is productive.
The visible failure is planar course control: the best-score distance-relief
sample (`solver_4482d3d05d9c`) remains comparatively straight and reaches only
`5.126L`, while the assigned closure-conditioned posterior-relief parent
(`solver_37a652a3989e`) bends late, reaches `4.162L` at `17.506T`, then recedes
to `6.363L` and exits through the upper boundary with upward world velocity.
The two posterior half-cycle descendants keep the coherent wake but also exit
high, with closest approaches of `5.000L` and `4.743L`. Thus neither scalar
carrier relief nor the tested half-cycle schedulers changed the failure class.

The assigned guidance and inherited optimizer logs identify a stronger
full-wave, approach-redistribution scaffold: it reached `3.135L`, whereas
distance-only, course-damped, and closure-aware relief worsened approach to
`5.126L`, `6.397L`, and `3.926L`. That evidence supports restoring the full
posterior wave and the bounded `4 deg` approach-aware anterior redistribution,
not another propulsion gain or relief schedule.

The inherited direction-tracking log proposes reversing the course cross
product, but the observation and trace conventions falsify that algebra before
CFD. The episode defines the fish's forward axis as body `-x`. Reconstructing
body-frame target and velocity from all four trajectories shows that at every
sampled closest approach the current `target x velocity` course value and
bearing have the same sign: for the assigned parent they are `-1.257 rad` and
`-0.969 rad`; the other course values are `-1.364` to `-1.950 rad` with
bearings `-0.986` to `-1.304 rad`. Reversing the cross product would make the
course cue oppose target geometry precisely where every rollout misses high.

The response comparison itself remains useful. At the assigned parent's
closest approach, speed is `0.824U`, body lateral velocity is `+0.234U`, and
measured yaw is `-1.159 rad/T`, opposite the positive physical yaw implied by
the negative body-frame route request. Yet the present yaw term always damps
toward zero, including when correct-sign turning is required. The candidate
will instead derive a bounded desired physical yaw from the slow bearing and
course request and feed back measured-minus-desired yaw in the posterior
curvature convention. It reduces to ordinary yaw damping on an aligned route,
strengthens a lagging or wrong-sign response, and relaxes an excessive
correct-sign response. Crossflow remains a separate bounded slip residual.

## Policy hypothesis

Preserve the full state-feedback anterior oscillator, complete lagged
posterior wave, bounded crossflow residual, and the evidenced approach-aware
`4 deg` anterior course redistribution. Keep the existing course cross-product
order. Replace zero-yaw damping with route-conditioned desired-yaw response
tracking applied only to posterior mean curvature. This should begin correcting
the upward course before the prior `16--20T` divergence without weakening the
alternating wake or adding static curvature.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking
source_mechanism: sensor feedback compares requested and measured directional response while retaining a low-dimensional propulsive rhythm
transferable_invariant: preserve the rhythmic carrier and apply a bounded steering residual from desired-minus-measured body-relative turn response
nontransferable_details: published gains, dimensional frequencies, robot geometry, species kinematics, exact vortex phases, maneuver timing, and task-specific routes
policy_translation: map bounded bearing plus speed-qualified target-to-velocity course error to a desired physical yaw with the body-minus-x forward convention, compare it with measured recent yaw, and apply the signed residual only to posterior mean curvature while retaining the full two-joint wave
falsification: reject if the alternating top-down and tail-connected 3D wake weakens, the inherited 3.135L full-wave approach is lost, upward course is not reversed before the prior divergence, or upper exit, recession, acceleration residence, peak force, or peak moment fail to improve

## Evaluation boundary

No CFD outcome is claimed for this candidate. Evaluation should prioritize
capture and minimum distance, then the time and sign of course/yaw response,
post-minimum recession and termination, followed by acceleration-limit
residence and the sampled peak planar-force/yaw-moment envelope (about
`0.029--0.034` and `0.015--0.018`). A smaller final distance alone does not
rescue a worse closest approach or the same upper-exit topology.
