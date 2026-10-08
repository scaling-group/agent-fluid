# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot, and no numerical
  failure. The combined keyframe sheets show self-propulsion: each top-down
  row retains an alternating caudal vorticity street, and each oblique row
  retains compact three-dimensional Lambda2 structures through the approach.
  The shared failure is route control, not advection or loss of propulsion.
- `solver_24724bc7bb0b` is the strongest finite approach. Its whole-body
  half-cycle redirect reaches `3.691L` at `20.46T`, with true and folded target
  errors both `1.364 rad` while the target is still ahead. After the target
  passes abeam, its folded bearing falls to `0.091 rad` while the true
  head-relative error grows to `3.050 rad`; the redirect and tail relief are
  therefore released into false alignment, and the fish exits the lower
  boundary at `33.27T` and `9.294L`.
- The prefilled anterior redirect plus symmetric tail relief
  (`solver_5f29dca2aca2`) follows the same visible lower-going trajectory and
  reaches only `4.018L`. Its exit has the same observation mismatch
  (`0.201 rad` folded versus `2.941 rad` full error). Posterior half-cycle
  redistribution is therefore retained from the stronger sample rather than
  replaced by another scalar relief or curvature change.
- `solver_dac1edc233b4` is the informative semantic failure. Replacing folded
  bearing with `atan(target_body_y, -target_body_x)` preserves its inherited
  `3.909L` pre-abeam approach exactly and keeps the late redirect gate active,
  but it still exits low at `33.23T`, `9.320L`, with `2.752 rad` true error.
  Its top-down and oblique wakes remain coherent, so the negative result is
  specific: a correct full target angle does not add yaw authority to a gait
  that has only the bounded anterior center and posterior half-cycle relief.
- The sampled commands frequently meet the actuator envelope (roughly
  `13--14%` anterior and `5--6%` posterior rate-cap occupancy, with clipped
  acceleration requests common), while peak force and moment are similar
  across samples. This rejects indiscriminate drive or gain escalation. The
  useful controlled comparison is to combine the evidenced anterior
  phase-selective yaw residual with the corrected target semantics.

## One candidate hypothesis

Start from the `3.691L` whole-body half-cycle policy and make one semantic
completion: compute steering, redirect gating, and posterior half-cycle
selection from the full signed head-relative target angle
`atan(state.target_body_L[2], -state.target_body_L[1])`. While the target is
more than `0.25L` ahead—including the sampled closest approach—this is
identical to folded bearing, so the coherent early wake and strongest approach
should be preserved. Near and after abeam it keeps the target-signed anterior
acceleration residual active—strengthening the requested stroke and braking
the return—while retaining more posterior carrier only on the useful stroke.
The mechanism releases continuously only on genuine body-frame alignment.

The falsifiable expectation is unchanged pre-abeam behavior through about
`3.691L`, followed by target-side yaw and decreasing full error instead of the
common lower exit. Reject the combination if it loses the alternating early
wake, fails to improve the `3.691L` approach, retains a lower exit without a
post-abeam error decrease, materially worsens the sampled rate/load envelope,
or chatters when the target lies exactly on the rearward angle branch.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish asymmetric flapping and biological burst redirection
source_mechanism: persistent full target error redistributes work toward the turn-producing half-cycle while posterior drive yields until genuine alignment
transferable_invariant: use observed gait phase and full body-frame target geometry to strengthen desired-yaw motion, unload its cancelling return, and restore symmetric propulsion only after true alignment
nontransferable_details: published gains, clock-driven CPG phase, robot linkage geometry, species-specific kinematics, prescribed C-start timing, exact vortex phase, and task-specific routes
policy_translation: the full signed angle from normalized target_body_L gates a target-signed anterior acceleration residual and posterior carrier redistribution; normalized anterior joint rate identifies the half-cycle
falsification: reject if the 3.691L approach or coherent wake is lost, rear-target error does not decrease, the lower exit remains unchanged, saturation or loads worsen materially, or the rear-axis angle branch causes chatter
