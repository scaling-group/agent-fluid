# Candidate wake-policy diagnosis

## Evidence read before editing

- All four sampled solver examples contain the same `v41` policy, identical
  combined keyframe sheets, and the same deterministic capture at `24.640015T`
  and `0.748356L` with mean distance `2.347937L` and score `-0.448328283`.
  The assigned parent also carries five completed optimizer-step scores with
  exactly that termination, score, and terminal distance.  This is strong
  fixed-case repeatability but no semantic progress.  There is no sampled
  failure keyframe sheet in this workspace; the informative failures are the
  inherited v42 headroom redistribution and v43 coupled anti-windup results,
  both of which retained capture but reduced crossing margin and worsened
  distance/score without improving load class.
- The evidence confirms direct uniform still-water initialization with
  `U_infinity=(0,0,0)` and no prewarm snapshot.  The top-down row shows
  self-propelled diagonal progress with a coherent alternating vortex street,
  followed by a smooth terminal hook rather than advection or instability.
  The oblique Lambda2 row confirms a coherent three-dimensional chain through
  the hook and no visible wake collapse before capture.
- The trajectory cross-check agrees: sampled peak absolute planar force and
  yaw-moment coefficients are only `0.0230/0.0317/0.0156`, posterior hard-stop
  occupancy is zero, and exact-rate exposure is `9.196%` anterior,
  `4.643%` posterior, `13.839%` total.  Raw acceleration-envelope exposure is
  still `73.594%`, but inherited output projection proved that merely hiding
  it duplicates downstream clipping and does not change dynamics.
- A world-frame audit of the invariant constant-velocity geometry (used only
  to understand the recorded trace, not by the policy) first finds positive
  closing with projected miss inside the existing `0.60L` safe corridor at
  `22.302T`, distance `1.820L`, projected miss `0.598L`, and speed `0.749L/T`.
  It remains a useful intercept while the terminal state reaches yaw rate
  `1.887 rad/T`, speed `0.734L/T`, projected miss `0.632L`, and posterior angle
  about `-43.95 deg`.  Thus the observable gap is terminal heading-chasing
  after the velocity course is already capture-compatible, not weak thrust,
  wake incoherence, or missing steering magnitude.

## Policy hypothesis

Keep the evaluated carrier, posterior stroke/rate safety, phase-selective
terminal residual, and all far/middle route logic unchanged.  Add one
mirror-equivariant collision-course commitment gate from existing normalized
body-frame range, closing speed, course speed, and projected miss.  Inside the
safe corridor, taper only the additive route-steering share sent to the
anterior joint; do not damp or reshape the anterior oscillator and do not
transfer rejected steering to the posterior joint.  This should stop the head
joint from continuing to chase body bearing after inertial velocity already
intersects the capture region, while retaining posterior route authority and
the phase anchor.  The mechanism is continuously dormant outside the existing
`2.10L` approach neighborhood.

Falsify the candidate if CFD loses capture, worsens the `0.001644L` crossing
margin, changes the trajectory before the approach neighborhood, increases
projected miss after safe-corridor entry, or regresses the coherent-wake,
zero-posterior-hard-stop, low-load, or exact-rate classes.  Arrival time alone
is not sufficient evidence.

The post-edit recorded-state audit is diagnostic only, not new CFD evidence.
Against all `4480` sampled parent states, the mechanism changes `270` head
commands, first at `22.264T/1.851L`, changes no command at or beyond `2.10L`,
leaves the posterior command unchanged, reaches a maximum gate of `0.575`,
and changes head acceleration by at most `3.831 rad/T^2`.  Reflecting all
lateral inputs leaves the new scalar gate exactly unchanged, so the added
allocation introduces no new preferred side.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal approach hold
source_mechanism: separate the rhythmic phase anchor from a bounded sensor-driven steering residual, and release unnecessary direction tracking near a valid intercept
transferable_invariant: preserve the propulsive oscillator while body-frame range, positive closing, and velocity-to-target projected miss decide whether additive route steering is still needed
nontransferable_details: published CPG gains, robot hardware, species kinematics, dimensional cadence, exact wake phase, and source-task routes
policy_translation: use the existing normalized collision-course corridor to taper only anterior additive route steering, leaving oscillator acceleration and posterior allocation unchanged
falsification: reject if nominal capture or crossing margin is lost, the far route changes, projected miss grows after commitment, or wake, load, stroke, or rate-limit classes regress
