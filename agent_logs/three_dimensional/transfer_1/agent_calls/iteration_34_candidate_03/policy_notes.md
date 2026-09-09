# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned-parent policy is the posterior wave-shape pulse. Its sampled
  rollout captured at `0.7480L` after `18.1995T`, but inherited exact-repeat
  evidence gives the mechanism only `2/3` captures: the repeat retained an
  active wake yet passed below at `1.2589L` and exited. The inherited guidance
  therefore falsifies widening or scalar-tuning this pulse.
- The four current samples are direct-uniform still-water runs with
  `U_infinity=(0,0,0)`. Two exact speed-reserve rollouts captured at
  `0.7494--0.7495L` after `18.4525--18.6010T`; the posterior-pulse rollout
  captured at `0.7480L` after `18.1995T`; and the fixed anterior steering
  transfer captured at `0.7492L` after `18.7495T`. The sampled transfer did not
  improve arrival or the actuator envelope.
- Both the best-scoring exact-baseline combined sheet and the assigned-parent
  combined sheet show self-propulsion from quiescent water, a coherent
  alternating top-down vortex street, and bilateral oblique Lambda2
  structures through capture. Neither shows terminal carrier collapse or a
  visible wake reason to alter cadence, amplitude, or posterior lag. No
  sampled failure sheet is present in this workspace, so failure-topology
  claims are limited to the inherited diagnostics and logs.
- The inherited step-33 logs add two stable lower exits: the outer-terminal
  bearing rescue missed at `1.4107L`, and the progress-loss redirect missed at
  `1.2402L`. These negative results close off another bearing residual or
  post-pass redirect as the next evidence-backed edit.

## Policy hypothesis

Remove the posterior pulse and restore the exact
`dogfish3d_intercept_guarded_speed_reserve_v1` controller. This is a controlled
rollback, not a new robustness claim: it preserves the only sampled mechanism
with repeated captures, restores the posterior joint to its evidenced
propulsive role, and isolates the pulse's failed-repeat contribution without
stacking another terminal residual. The current rollout should match the
baseline's far-field closure, active traveling wake, load range, and actuator
envelope. Later workers should judge it by exact-policy repeat class; one more
threshold capture alone is insufficient evidence of robust success.

bookshelf_consulted: true
source_domain: classical elongated-body and traveling-wave propulsion
source_mechanism: directional body bend with posterior lag and posterior thrust emphasis
transferable_invariant: preserve the active posterior-lagged traveling bend while keeping route steering as a separate bounded state-feedback residual
nontransferable_details: published gains, species kinematics, dimensional cadence, exact wake phase, and prescribed routes
policy_translation: remove the terminal posterior wave-shape pulse and retain the normalized body-frame achieved-course, intercept guard, and sparse speed-reserve controller unchanged
falsification: reject the rollback as the useful isolation baseline if exact repeats retain the lower-exit branch, weaken either wake view, or leave the sampled actuator and load envelope; do not infer robustness from one capture
