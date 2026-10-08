# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solver rollouts and the completed assigned-parent rollout
  satisfy the direct-uniform still-water contract: `U_infinity=[0,0,0]`, no
  cylinders, no prewarm snapshot, and no numerical instability. In the
  combined sheets, the top-down rows retain alternating red/blue caudal wakes
  and the oblique rows retain discrete three-dimensional Lambda2 structures
  through closest approach and boundary exit. The fish are self-propelled;
  their common failure is planar route control rather than advection or wake
  collapse.
- `solver_24724bc7bb0b` remains the strongest sampled finite approach. Its
  whole-body half-cycle redirect reaches `3.691L` at `20.46T`, passes the
  target abeam at `21.19T`, and then exits the lower boundary at `33.27T` and
  `9.294L`. The sampled symmetric relief, anterior-only redirect, and
  posterior half-cycle variant reach only `4.233L`, `4.018L`, and
  `3.909L`, respectively, with the same lower-going topology. Their coherent
  visual wakes and roughly `5%` posterior rate-cap occupancy make more drive,
  relief, or phase-asymmetry gain an unsupported response.
- The assigned parent's rear-aware whole-body redirect is the decisive new
  negative result. Giving the `3.691L` mechanism a full-angle activation gate
  preserves its pre-abeam trajectory exactly and extends survival from
  `33.27T` to `33.65T`, but does not create recovery: full target error grows
  from `1.60 rad` just after abeam to `2.54 rad` at the lower exit, while score
  falls to `-10.4096`. From `28--32T`, mean anterior/posterior joint angles are
  still opposite-signed (`+0.207/-0.081 rad`), mean heading rate is only
  `0.018 rad/T`, and full error rises from `2.23` to `2.42 rad`. Correct gate
  semantics therefore keep the old actuator mechanism active but do not turn
  its alternating, S-shaped carrier into sustained target-side yaw.
- The visual and trace evidence support preserving the early anterior-center
  trajectory and its three-dimensional propulsive wake. They do not support
  another observation substitution or scalar change to the existing
  redirect. The missing test is a hydrodynamically distinct large-error body
  shape that makes the posterior joint reinforce, rather than oppose, the
  requested anterior curvature.

## One candidate hypothesis

Start from the assigned parent's rear-aware whole-body half-cycle controller
so behavior through the strongest `3.691L` approach has an evidence-backed
basis. Add one smooth large-error C-bend recovery primitive: when the full
normalized head-relative target angle exceeds the sampled near-miss regime,
move the posterior joint toward a bounded offset with the same sign as the
target-requested anterior bend. Below that regime the offset is exactly zero,
so the traveling carrier and its early wake are unchanged. At large error the
offset converts the observed opposite-mean S shape into whole-body curvature;
alignment continuously removes the offset and restores the inherited gait.

This is a new yaw-producing actuator primitive, not gain tuning of relief or
phase asymmetry. It is falsified if the `3.691L`-level approach or coherent
early wake is lost, the posterior mean does not become target-signed during
large error, full error fails to decrease after abeam, the same lower exit is
not meaningfully delayed or avoided, or posterior rate-cap occupancy and yaw
loads materially exceed the sampled envelope.

bookshelf_consulted: true
source_domain: biological C-start redirection and closed-loop robotic-fish mean-curvature turning
source_mechanism: persistent large target error recruits a bounded whole-body bend, then observed realignment releases the maneuver back to a propulsive traveling wave
transferable_invariant: a large-error redirect needs target-signed curvature distributed across the available body joints rather than continued alternating motion with cancelling joint means
nontransferable_details: species-specific C-start shapes, published gains, dimensional frequencies, robot linkage geometry, prescribed burst duration, exact vortex phase, and task-specific routes
policy_translation: full angle from normalized `target_body_L` gates a smooth same-sign posterior curvature target; lateral target displacement supplies a continuous reflection-equivariant turn sign while joint state retains the inherited carrier phase
falsification: reject if the early 3.691L approach or wake degrades, rear-target error does not fall, lower exit persists without meaningful delay, same-sign posterior curvature is not realized, or rate and yaw-load envelopes worsen materially
