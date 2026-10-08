# Evidence-selected collision-course commitment candidate

## Visual diagnosis before editing

- The assigned parent and three sampled solvers use the byte-identical v41
  terminal phase-allocation policy.  Each direct-uniform still-water rollout
  captures at `24.640015T` and `0.748356L`, with mean distance `2.347937L`,
  score `-0.448328283`, and 284 moving-window shifts.  The remaining sampled
  solver is v44, which adds collision-course commitment and captures sooner at
  `24.557514T` and deeper at `0.747654L`; its mean distance is `2.347238L`, its
  score is `-0.447653764`, and it requires 283 window shifts.
- I inspected both combined keyframe sheets from release through capture.  In
  both, the top-down row starts wake-free, develops a coherent alternating
  vortex street behind sustained diagonal progress, and ends in a smooth
  transverse hook through the capture disk.  The oblique Lambda2 row retains
  compact three-dimensional structures through the hook.  With
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot, this is
  self-propulsion rather than advection; neither sheet shows wake collapse,
  out-of-plane escape, collision, or numerical instability.  The v44 edit is
  visually local to the terminal hook rather than a change to propulsion or
  the far route.
- The traces support that reading.  V44 first diverges from v41 at
  `22.2695T/1.8461L`, inside the established `2.10L` approach neighborhood.
  It improves terminal constant-velocity projected miss from `0.63193L` to
  `0.61213L`, crossing margin from `0.001644L` to `0.002346L`, and total
  exact-rate exposure from `13.839%` to `13.617%`.  Raw acceleration-envelope
  exposure falls slightly from `73.594%` to `73.393%`; peak planar
  body-force/yaw-moment coefficients remain in the same low class
  (`0.0229/0.0289/0.0156` for v44), and posterior hard-stop occupancy remains
  zero.
- No sampled or assigned-parent artifact contains a termination-failure
  keyframe sheet, so a visual success/failure comparison cannot be
  manufactured.  The informative inherited negative controls are v42
  headroom redistribution and v43 coupled anti-windup: both retained capture
  but reduced crossing margin and worsened mean distance and score without a
  better load class.  They bound the current edit away from transferring
  rejected posterior authority to the anterior joint or coupling the
  anterior phase anchor to posterior filtering.

## Policy hypothesis

Materialize exactly one candidate by selecting the evaluated v44 mechanism.
Preserve v41's state-feedback oscillator, posterior traveling-wave lag,
normalized body-frame target/course geometry, phase-selective terminal
residual, and joint-local posterior stroke/rate safety.  Once positive closing
and the body-frame velocity projection put the target inside the safe capture
corridor, continuously taper only additive route steering sent to the
anterior joint.  Keep the anterior oscillator and all posterior steering
unchanged.  This is a bounded actuator-allocation mechanism, not scalar gain
tuning, and it is dormant outside the terminal neighborhood.

The completed v44 sample is positive fixed-case evidence for this selection,
not evidence of held-out robustness.  Post-exit CFD should reproduce capture,
the unchanged far route and coherent two-view wake, a crossing margin at least
as large as v41's `0.001644L`, zero posterior hard-stop occupancy, and the same
low-load class.  Reject the mechanism if replication loses capture, changes
commands outside `2.10L`, worsens projected miss after commitment, or regresses
the load/rate envelope.  Reflected and perturbed releases remain the proper
test of mirror-equivariant generalization.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal approach hold
source_mechanism: preserve the rhythmic phase anchor while sensor feedback releases additive direction tracking after velocity already defines a valid intercept
transferable_invariant: separate propulsive rhythm from bounded steering, and withdraw only unnecessary steering using normalized range, positive closing, and body-frame projected miss
nontransferable_details: published CPG gains, robot hardware, dimensional cadence, species kinematics, exact wake phase, capture geometry, and source-task routes
policy_translation: retain the two-joint traveling-wave carrier and posterior allocation while the existing collision-course corridor tapers only anterior additive route steering
falsification: reject if capture or v41 crossing margin is lost, the far route changes, projected miss grows after commitment, or wake, load, hard-stop, or exact-rate classes regress

