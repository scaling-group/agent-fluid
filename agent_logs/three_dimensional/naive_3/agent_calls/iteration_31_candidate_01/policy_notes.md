# Candidate diagnosis and hypothesis

The four sampled evaluations satisfy the direct-uniform still-water contract
(`U_infinity=[0,0,0]`), are finite `100T` horizon rollouts, and contain both
visual views.  The strongest sample, `solver_6eb170b0d70a`, keeps a coherent
alternating top-down wake and compact three-dimensional Lambda2 structures
through repeated return loops.  It reaches `1.241L` at `97.09T` with speed
`0.669U`, course error `1.692 rad`, slightly receding course dot `-0.121`, and
an active joint state (`||phi_dot||=0.281`).  It therefore misses through
insufficient terminal course response, not loss of self-propulsion.

The assigned-parent sample `solver_4315960955af`, the prefill
`solver_b5de8ff4a388`, and the anterior-equilibrium burst
`solver_123b18cedff4` instead share a visually and numerically distinct
failure.  Their oblique rows show an organized wake at `24T` but only a faint
compact wake behind an almost fixed C-shaped body by `52--100T`; the top-down
rows show continued broad coasting arcs rather than powered return loops.
After `35T`, their mean joint-speed norms are only `0.009`, `0.007`, and
`0.011`, respectively, while speed remains about `0.67U`.  All three are
nearly parked in a common negative bend at their closest approach.  The
prefill's tighter coast lowers mean distance to `3.875L`, but it reaches only
`2.366L`, so residual body speed must not be treated as a healthy carrier.

Policy hypothesis: preserve the prefill's target-relative redirect,
posterior lag, curvature authority, and oscillator equilibrium.  Add one
bounded, reflection-equivariant phase-restart impulse only when (1) the target
is behind, (2) the measured course is nonclosing, (3) useful yaw response is
weak, and (4) normalized anterior phase radius has collapsed near the
oscillator equilibrium.  The impulse points along the already requested turn
and releases continuously as joint motion or useful yaw returns.  Unlike the
failed static burst, it does not move either joint equilibrium or alter the
normal carrier envelope.

bookshelf_consulted: true
source_domain: biological C-start release and sensor-modulated robotic-fish CPG control
source_mechanism: a large-error redirect is released into an active rhythmic carrier when measured response appears
transferable_invariant: gate a bounded nonsteady action by persistent body-frame geometry and measured gait/turn response, then release it on response rather than elapsed time
nontransferable_details: species kinematics, published gains and frequencies, exact C-start phases, prescribed routes, and vortex phase
policy_translation: use normalized target-ray/course geometry, heading rate, and joint-state phase radius to inject a small anterior acceleration impulse without moving the two-joint limit-cycle equilibrium
falsification: reject if the first approach changes, the joint-speed/wake collapse persists, clamp or load residence rises, the repeated orbit does not contract, or minimum/final distance fails to improve

Frozen-state localization check (not CFD evidence): replaying the sampled
states through the candidate gives exactly zero restart contribution at
release, at the prefill's `17.81T` first approach, and at the active scaffold's
`17.86T`, `42.14T`, and `97.09T` checkpoints.  It adds about
`-2.8 rad/T^2` only at the prefill's parked `40T` and `90.29T` states, well
inside the `28 rad/T^2` policy command reserve.  The later formal rollout must
still determine whether this local restart changes the coupled trajectory in
the predicted direction.
