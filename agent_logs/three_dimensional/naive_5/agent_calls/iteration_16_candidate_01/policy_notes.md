# Inertial line-of-sight response transplant

## Visual and trace diagnosis before the edit

- All sampled and inherited evaluations are contract-valid direct-uniform
  still-water rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm).
  Translation is accompanied by a body-attached alternating wake in both the
  top-down mid-plane vorticity row and the oblique body/Lambda2 row, so the
  useful motion is self-propelled rather than moving-window advection.
- The assigned `solver_12fc3441a636` parent maintains an organized wake but
  continues into the upper boundary.  It exits at `20.790T` after reaching
  only `6.267730L`; at termination its course projects a `6.263L` miss and
  radial closing has already reversed.  It also touches the angle and speed
  limits, with acceleration/speed cap residence about `33.8/21.7%` and peak
  planar force/yaw moment about `0.0566/0.0274`.  Its desired-yaw-rate closure
  therefore supplies neither a safe route nor useful translational-intercept
  feedback.
- The inherited counter-propulsive-wave result
  `solver_3db4d8584177` preserves the coherent broad approach but regresses to
  `0.912368L` and passes the target at `0.657L/T`; its projected miss at closest
  approach is `0.911L`.  Together with the sampled ordinary terminal wave
  `solver_b723810e389c` at `0.875770L`, this is direct negative evidence
  against another terminal wave-direction, braking, or scalar-gain edit.
- In contrast, sampled `solver_0ce6bb065e92` is a semantic success under the
  same contract: its top-down sheet shows an organized traveling wake followed
  by a sharp target-side turn between the `24T` and `27.60T` frames, and its
  oblique row retains coherent three-dimensional vortex structures through
  capture.  The trace confirms first crossing at `0.749769L` and `27.6045T`.
  Its inertial line-of-sight response residual is the architectural difference
  supported by this outcome.  Capture remains narrow: speed is `0.642L/T`,
  radial closing is nearly zero, and projected miss is `0.749768L` at the
  crossing; it touches the angle boundary and has peak planar force/yaw moment
  about `0.0340/0.0155`.  Preserve the proved controller exactly rather than
  improvise an unevidenced terminal patch.

## Policy hypothesis

Replace the failed assigned yaw-rate controller with the complete sampled
capture controller.  It preserves the state-feedback traveling bend and
same-sign two-joint C-redirect, qualifies redirect release with projected miss,
and adds one bounded anterior half-cycle residual only when an inertial
line-of-sight angular-rate request exceeds the observed phase-rejected yaw
response.  Speed, positive closing, joint phase, and angle headroom gate that
residual.  All geometry and motion signals are normalized/body-frame or
rotation-rate quantities; no clock, coordinate, route, or target identity is
used.

The evidence-backed expectation is reproduction of the sampled coherent route
and a first crossing within `0.75L`, a semantic improvement over the assigned
parent and inherited pass-by branches.  Reject the transfer if the new rollout
does not capture, if target-line rotation changes without rotating velocity,
if the far carrier or wake coherence changes, or if angle contact, load, and
actuator-limit residence prove too fragile to reproduce the crossing.  A later
worker should test robustness before changing any numerical parameter.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking combined with a bounded C-start redirect
source_mechanism: preserve a traveling-wave carrier while observed target-line rotation and measured turn response gate a phase-selective steering residual
transferable_invariant: add only the bounded steering response still demanded by line-of-sight rotation, and release it from observed response rather than elapsed phase or a fixed route
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, dimensional beat timing, exact vortex phases, world coordinates, and task-specific routes
policy_translation: body-frame bearing-window rate plus recent body turn reconstruct inertial line-of-sight rate; phase-rejected yaw, body-frame speed, closing speed, joint phase, and angle headroom gate a joint-1 half-cycle residual while joint 2 remains the lagged carrier follower
falsification: reject if capture is not reproduced, velocity does not rotate toward the target, the coherent far route changes, or joint-limit, load, and actuator-limit exposure materially worsen

## Non-CFD implementation audit

- The prescribed check-runner was invoked, but its pinned model was unavailable
  in this account.  Its three exact commands were then run directly: the
  guidance-semantic check, lightweight Julia policy-contract check, and solver
  editable-boundary check all pass.  No CFD was run.
- The solver contains exactly one `candidate_target_policy.jl`; it is byte-for-
  byte identical to the sampled captured controller and remains non-empty.
  Every direct `params.FIELD` reference is owned by `target_policy_params()`.
  These checks establish provenance, schema coverage, and contract validity;
  the historical capture remains prior evidence rather than a claim about the
  candidate's pending evaluation.
