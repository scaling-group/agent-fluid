# Inertial line-of-sight response adoption candidate

## Visual and trace diagnosis before the edit

- All four sampled rollouts report contract-valid direct-uniform still water
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm).  In the combined sheets
  for the assigned parent `solver_b723810e389c` and successful
  `solver_0ce6bb065e92`, both the top-down vorticity row and oblique
  body/Lambda2 row show translation with an organized body-attached alternating
  wake.  The moving window is therefore following self-propulsion; neither the
  parent's miss nor the successful sample is explained by advection, wake
  collapse, or numerical instability.
- The assigned terminal curved-gait parent reaches `0.875770L` near
  `27.269T` but does not cross the `0.75L` radius.  Its visible path straightens
  after the target-side bend, then carries the fish past the target and to a
  left-domain exit at `39.925T` with final distance `8.688L`.  At closest
  approach its speed is about `0.654L/T`; peak planar force and yaw moment over
  the trace are modest (`0.02142` and `0.00979`), so the failure is a remaining
  dynamic course-response deficit in a productive carrier, not insufficient
  thrust or a load instability.
- The sampled inertial line-of-sight response policy visibly continues the
  target-side path rotation through the last top-down and oblique frames and
  captures at `27.605T` and `0.749769L`.  Its trace retains comparable speed
  (`0.642L/T` at capture) and an organized 3D wake, with peak planar force and
  yaw moment still in the low-load class (`0.03397` and `0.01548`).  In
  contrast, the other sampled failures reach only `4.278L` and `6.268L` before
  domain exits.  Thus the only sampled semantic improvement is the new
  target-line-response mechanism, not another terminal oscillator, redirect
  threshold, or carrier gain.
- The successful trace does touch the `45 deg` angle envelope and the sampled
  parent approaches it (`43.4 deg`); both also reach the joint-speed cap.  This
  prevents claiming the capture as a generally robust optimum.  It does not
  support an unevaluated simultaneous safety rewrite in this candidate,
  because the successful mechanism's value is established only as the compact
  policy actually evaluated.

## Policy hypothesis

Replace the assigned parent's unevaluated terminal curved-gait reactivation
with the sampled, evaluated inertial line-of-sight-rate response closure.
Preserve the established traveling-bend carrier, sign-corrected body-frame
bearing/course selector, response-released same-sign redirect, terminal
projected-miss veto, posterior follower, and acceleration clamp.  Reconstruct
inertial target-line rotation by adding observed body-frame bearing-window rate
to recent body turn rate; compare the resulting bounded yaw request with
phase-rejected measured yaw, and put only the positive response deficit through
the evidenced anterior half-cycle channel.  Speed, positive closing, and joint
angle headroom gate the residual, so it augments a deficient turn without
cancelling an already adequate response or changing posterior allocation.

The falsifiable expectation is reproduction of the sampled capture topology:
a coherent low-load wake, unchanged broad approach, continued path rotation in
the target neighborhood, and a first crossing inside `0.75L`.  Reject the
transfer if the candidate instead reproduces the parent's straight pass-by,
fails to shrink target-line rotation and projected miss, loses carrier
propulsion, or materially worsens angle/speed-limit residence, force, or yaw
moment.  Later workers should specifically test whether a two-joint envelope
gate can retain capture while removing the observed boundary contact; that
safety change is not bundled into this evidence-adoption candidate.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and residual CPG control
source_mechanism: preserve rhythmic locomotion while measured target-line and turn response inject only the bounded steering residual still required
transferable_invariant: a productive traveling-wave carrier should remain intact while body-frame target-line rotation and observed yaw determine whether phase-selective anterior steering authority is deficient
nontransferable_details: published navigation gains, linkage geometry, species-specific kinematics, dimensional beat timing, exact vortex phases, world coordinates, and task-specific routes
policy_translation: normalize bearing-window rate plus recent body turn by the carrier frequency, compare its bounded line-of-sight yaw request with phase-rejected heading response, and gate a joint-1 half-cycle residual by body-frame speed, closing speed, and joint-angle headroom
falsification: reject if capture inside `0.75L` is not reproduced, target-line rotation or projected miss does not shrink, the far coherent carrier changes, or load and joint-limit exposure materially worsen

## Non-CFD implementation audit

- The resulting candidate byte-matches the sampled capture policy, while the
  prefilled solver had byte-matched the assigned near-miss parent.  This is one
  mechanism replacement, not a scalar-only carrier retune or a second sibling
  candidate.
- The guidance-semantic check, lightweight Julia policy contract, and solver
  editable-boundary check pass.  A separate deterministic scan confirms that
  all `37` directly referenced parameter fields are owned by
  `target_policy_params()`, and exactly one `candidate_target_policy.jl` exists
  under `solver/`.  No CFD was run; the current candidate's result remains for
  downstream evaluation.
