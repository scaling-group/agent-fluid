# Step 36 target-policy diagnosis

## Evidence read before the edit

- All four sampled solver runs satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and stable capture at
  `0.74846--0.74986L` after `18.2875--18.6560T`. Their top-down rows show a
  sustained alternating vorticity street and their oblique rows show bilateral
  Lambda2 structures through capture. Continued body undulation and inertial
  advance in stationary water establish productive self-propulsion rather than
  advection or terminal coasting.
- Three sampled runs are exact bytes of the prefilled intercept-guarded
  speed-reserve baseline and capture at `18.2875--18.6010T`. These positive
  samples preserve the useful carrier, but inherited exact replays include
  three active-wake lower exits at closest passes of `1.6463L`, `1.4642L`, and
  `1.4107L`, so the available baseline record is only `4/7`. The informative
  failure retains propulsion at about `0.82L/T`; its defect is first-pass path
  geometry rather than weak drive.
- The fourth sample and the assigned parent use exact
  `dogfish3d_outer_unsupported_bearing_v1` bytes. They capture at `0.74986L`,
  `18.6560T` and `0.74881L`, `18.7440T`; inherited logs add the original exact
  capture at `0.74975L`, `18.3205T`. This makes the narrowly gated mechanism
  `3/3`. The two available detailed traces retain terminal speed
  `0.8369--0.8663L/T`, head/tail action clipping `68.69--68.75%/70.70--70.80%`,
  speed-limit residence `10.38--10.45%/11.35--11.41%`, peak planar force
  `0.03143--0.03147`, and peak yaw moment `0.01643--0.01648`, all within the
  repeat-backed carrier envelope. Both visual rows remain coherent and active.
- The assigned parent's preceding response-released recovery bend is the
  contrasting failure: it detects a lost pass but reaches only `1.1790L`, sheds
  much less new alternating wake after the pass, never makes a second approach,
  and exits at `10.2248L` final distance. Its lower clipping does not compensate
  for the unchanged lower-exit topology. Do not restore or tune that mechanism.

## Candidate hypothesis

Replace the prefilled unqualified baseline with the exact evaluated
`dogfish3d_outer_unsupported_bearing_v1` policy. Preserve its raw achieved-course
feedback, posteriorly lagged traveling carrier, inner intercept guard, additive
steering allocation, and sparse outward-only carrier reserve. Its sole added
mechanism admits reflection-equivariant body-frame target bearing only in the
outer terminal annulus while achieved-course error is nearly zero; it is zero
in the far field, when course feedback is informative, and inside the capture
corridor.

This is a fourth reliability trial of a `3/3` mechanism, not scalar tuning or a
new stacked residual. Confirm usefulness only if the exact repeat captures while
preserving both wake views and the stated actuator/load envelope. Falsify it as
a robust repair if it misses, follows the lower branch, changes far-field
closure, weakens the traveling wake, or leaves that envelope. Do not respond to
a failed repeat by widening or gain-tuning the bearing gate.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking over a rhythmic CPG carrier
source_mechanism: target-vector feedback modulates direction while an independently sustained traveling rhythm remains the propulsive carrier
transferable_invariant: admit a bounded target-side cue only when achieved-course feedback is momentarily uninformative without replacing or suppressing the posterior traveling bend
nontransferable_details: published gains, dimensional cadence, CPG phase equations, robot morphology, species kinematics, exact vortex phases, terminal timing, and task-specific routes
policy_translation: exactly repeat the normalized body-frame unsupported-bearing qualifier in the outer terminal annulus while preserving the two-joint carrier, allocation, speed reserve, raw course feedback, and inner intercept guard
falsification: reject robustness if the exact repeat misses, retains the lower branch, weakens either wake view, changes far-field closure, or leaves the repeat-backed actuator and load envelope
