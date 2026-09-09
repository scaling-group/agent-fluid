# Net-steering half-cycle LOS candidate

## Prior evidence diagnosis

- No inherited optimizer log files are present in this workspace. The assigned
  parent guidance therefore supplies the lineage history, and the four sampled
  solver artifacts supply the current rollout evidence below.
- All four sampled rollouts are valid direct-uniform still-water runs with
  `U_infinity=(0,0,0)` and all capture. The combined sheets show self-propelled
  motion rather than advection: an alternating top-down vortex street grows
  behind the fish, while the oblique row retains separated three-dimensional
  Lambda2 structures through the broad turn and terminal arc. There is no
  visible wake collapse or instability before capture.
- The prefilled half-cycle course redirect captures at `20.207T`, with a raw
  trajectory distance integral of `152.080 L*T`. Its velocity-course error is
  still about `-0.443 rad` at `1L`, so it reaches the capture circle on a
  visibly oblique terminal path.
- The two functionally identical closing-gated LOS-lead policies capture at
  `19.706T` and `20.036T`, with raw distance integrals of `150.565` and
  `152.299 L*T`. Despite that rollout spread, both reduce the `1L` course-error
  magnitude to about `0.02--0.10 rad`. Their maximum joint angles remain
  `30.4--34.2 deg`, maximum commands remain `30.36--30.72 rad/T^2`, and RMS
  force/moment bands are essentially unchanged from the prefill. The sampled
  `8L` redirect instead captures at `20.124T` and does not supply the same
  consistently aligned terminal course.
- In the inherited controller, half-cycle asymmetry is aligned only with the
  slow route command, even when the LOS/course redirect supplies the dominant
  terminal turn. Thus the supported phase-shaping actuator can reinforce a
  different direction from the net mean-curvature request near capture.

## Policy hypothesis

Retain the captured carrier, distance/closing allocator, bounded LOS lead, and
all existing authority limits. Form a bounded net steering-phase request from
the route command plus the weighted course redirect; use it to choose the
strong half-cycle, and apply the half-cycle scale to the complete route-plus-
redirect tail tangent. This should preserve the coherent carrier while making
phase allocation follow the actual terminal turn, improving or stabilizing
the lead policy's approach without increasing scalar steering authority.

Falsification: reject the composition if it loses capture, does not beat the
sampled LOS range in arrival/distance integral, restores large course error at
`1L`, disrupts the alternating/3D wake, or increases joint/velocity/command
residence, force, or moment beyond the sampled bands.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and simulated fish prey capture
source_mechanism: sensor feedback modulates the useful half-cycle of a low-dimensional propulsive rhythm
transferable_invariant: align bounded phase-dependent steering with the current observed net turn request while retaining the traveling carrier
nontransferable_details: published gains, clocked oscillator phases, species kinematics, learned routes, and exact vortex timing
policy_translation: combine normalized body-frame route and velocity-course/LOS feedback, then use joint velocity to allocate the stronger half-cycle across both tail-turn contributions
falsification: reject if capture, terminal course alignment, wake coherence, actuator residence, or load histories regress
