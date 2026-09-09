# Multi-wake target-policy candidate notes

## Visual diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release while four developed, interacting vortex streets occupy the target
  corridor. It is common initial-condition evidence and supplies neither a
  candidate-specific wake phase nor a route.
- The strongest sampled release (`solver_e0f9cb7a46d7`) shows an immediate,
  zero-centered traveling body wave and a compact diagonal down-left transit.
  The fish crosses the merged streets with one broad correction and reaches
  the capture circle without approaching a cylinder. Its mean body velocity x
  of `-0.247` exceeds the local-flow magnitude `-0.185`, agreeing with visible
  self-propulsion rather than passive advection.
- The matched terminal course-mismatch damper is a material positive result
  over the time-to-go-capped parent: arrival improves from `45.221` to
  `44.121`, mean distance from `1.71458L` to `1.70618L`, and force/moment RMS
  from `439/4345` to `389/3909`, while the released sheet retains the same
  useful diagonal topology. Mean command energy rises slightly from `1030.39`
  to `1036.49`, however, and both joint rates still touch `4.538` rad/time
  while accelerations reach `28.79/28.39` near the candidate soft limit.
- The inherited line-of-sight-rate candidate is the informative negative
  comparison. Its sheet visibly takes a wide lower detour and curls sharply
  back into capture; arrival regresses to `70.790`, mean distance to `2.71465L`,
  and score to `-0.817366`. Its lower `200/2132` RMS loads and `893.96` mean
  command energy do not compensate for mean body x speed falling to `-0.156`
  and losing the compact route. Thus another signed bearing-rate decomposition
  or broad withdrawal of propulsion is not supported.

## Policy hypothesis

Preserve the successful oscillator, posterior lag, yaw-gated half-cycle
steering, positive-closure residual, course allocator, terminal time-to-go cap,
and course-mismatch damper. Add one smooth joint-state anti-windup mechanism at
the final actuator command: normalize each observed joint rate by the existing
candidate-owned oscillator rate reference and attenuate only acceleration whose
sign would increase an already large rate. Acceleration that brakes a joint is
untouched, and the gate is negligible at ordinary rates. This should remove
command effort that the hard rate envelope cannot realize without weakening
the traveling bend through most of the transit or changing target feedback.

Expected evidence is the same first-crossing diagonal capture and comparable
arrival/mean distance, with lower command-energy mean and no increase in
force/moment RMS or rate-cap contact. Reject the mechanism if it delays arrival
or worsens mean distance beyond the matched `44.121`/`1.70618L` reference
without a material effort or load reduction, loses the visible route topology,
or weakens upstream self-propulsion. Success on the fixed prewarm snapshot
would not establish changed-wake robustness.

bookshelf_consulted: true
source_domain: feedback-modulated robotic-fish oscillators and efficient undulatory swimming under actuator constraints
source_mechanism: preserve a traveling propulsive wave while sensor feedback withdraws drive that only pushes an already fast joint farther into its motion envelope
transferable_invariant: near an actuator-rate envelope, attenuate only same-sign outward acceleration and preserve braking acceleration, ordinary joint-state oscillation, posterior lag, and target feedback
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, robot linkage limits, exact vortex phases, cylinder coordinates, target coordinates, capture radius, and task-specific routes
policy_translation: normalize each joint rate by a candidate-owned multiple of oscillator frequency times amplitude, use a smooth high-order gate, and reduce only the post-limiter acceleration component aligned with that rate in the two-joint state-feedback output
falsification: reject if diagonal capture or upstream propulsion is lost, arrival or mean distance regresses without material effort or load relief, or commanded energy and rate-envelope contact do not decrease
