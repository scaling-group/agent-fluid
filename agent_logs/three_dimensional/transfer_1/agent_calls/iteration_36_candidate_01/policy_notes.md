# Step 36 target-policy diagnosis

## Evidence read before editing

- All four sampled solver examples and the assigned parent's completed rollout
  satisfy the direct-uniform still-water contract: `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, and stable `capture` termination. The three exact
  speed-reserve samples capture at `0.74846--0.74953L` after
  `18.2875--18.6010T`; their combined sheets show a body-launched alternating
  top-down vorticity street and bilateral oblique Lambda2 structures continuing
  to capture, so motion is self-propelled rather than advection or coasting.
- The sampled `dogfish3d_outer_unsupported_bearing_v1` captures at `0.74986L`
  after `18.6560T`. The assigned parent's newly completed exact-byte repeat
  captures at `0.74881L` after `18.7440T`. Together with the inherited earlier
  `0.74975L`, `18.3205T` capture, this mechanism is now `3/3`. The new repeat's
  terminal speed is `0.8663L/T`; head/tail action clipping is
  `68.69%/70.80%`, speed-limit residence is `10.36%/11.27%`, and peak planar
  force/yaw-moment magnitudes are `0.03147/0.01643`, matching the sampled
  carrier envelope. Its two visual rows retain the same organized traveling
  wake through capture.
- The informative inherited failure is the response-released recovery bend.
  It closes to `1.17905L` but passes below, never returns, and exits at
  `10.22475L`. Its early wake is coherent, whereas the late top-down and
  oblique frames show much less newly shed alternating structure; after `20T`
  its mean absolute joint-speed sum is only `2.26 rad/T`, consistent with the
  inherited diagnosis of carrier loss. Its lower clipping (`45.3%/46.2%`) is
  therefore not useful interception evidence.

## Candidate hypothesis

Materialize one exact-byte `dogfish3d_outer_unsupported_bearing_v1` candidate
from the assigned parent. Relative to the prefilled speed-reserve controller,
the only added mechanism is a smooth, reflection-equivariant target-bearing
qualifier in the `2.75--4L` outer-terminal annulus. It is admitted only while
the achieved-course error is near zero, vanishes in the far field and inner
intercept corridor, and changes only the route request. Raw achieved-course
feedback, response/intercept guards, two-joint allocation, sparse outward
carrier reserve, and the posterior traveling bend remain unchanged.

Expected result: a fourth exact-policy capture with both wake views and the
repeat-backed speed, clipping, joint-limit, force, and moment envelope intact.
Falsify the qualifier as a robust repair if this repeat misses, rejoins the
lower branch, changes far-field closure, weakens either wake, or leaves that
envelope. A failure would argue for restoring the exact speed-reserve baseline,
not widening or scalar-tuning the qualifier.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking over a rhythmic CPG carrier
source_mechanism: bounded sensor feedback modulates direction while an independently sustained traveling rhythm remains the propulsive carrier
transferable_invariant: admit a target-side direction cue only when achieved-course feedback is locally uninformative without replacing or suppressing the posterior traveling bend
nontransferable_details: published gains, dimensional cadence, CPG phase equations, robot morphology, species kinematics, exact vortex phases, terminal timing, and task-specific routes
policy_translation: exactly repeat the normalized body-frame unsupported-bearing qualifier in the outer terminal annulus while preserving the two-joint carrier, allocation, speed reserve, raw course feedback, and inner intercept guard
falsification: reject robustness if the exact repeat misses, retains the lower branch, weakens either wake view, changes far-field closure, or leaves the repeat-backed actuator and load envelope
