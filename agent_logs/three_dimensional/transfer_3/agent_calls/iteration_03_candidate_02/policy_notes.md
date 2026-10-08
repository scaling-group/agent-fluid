# Candidate diagnosis and policy hypothesis

## Evidence read before the policy edit

- The assigned parent is `optimizer_5af97227a533`. Its first completed child
  tested a loss-of-closure-gated velocity-course C-bend and failed early:
  `solver_52c0e4a32139` reached only `11.8646L` and left the upper boundary.
  The inherited note makes the boundary concrete: course feedback dominated
  at release/low speed and lower command occupancy did not preserve useful
  propulsion. Velocity course is therefore not a valid replacement for the
  geometry controller or an ungated release signal.
- All four sampled rollouts have the required direct-uniform still-water start,
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. Their top-down
  motion and oblique Lambda2 structures are self-generated, not advection.
- The strongest sampled policy, `solver_a1253ad45bc8`, is the prefilled
  terminal curvature-reallocation controller. Its combined sheet shows an
  organized alternating wake through the approach, followed by a smooth
  target-crossing arc rather than the broad recovery loop in the informative
  failure `solver_cc8652ccb895`. It captures at `25.2615T` and `0.7469L`,
  whereas the otherwise identical large-error redirect reaches `1.1347L` at
  `26.7795T` and then exits upper-left at `41.8385T`. Thus the two-joint
  terminal allocation is a demonstrated mechanism and must be preserved.
- The successful terminal segment is stable and has unused actuator margin.
  From the first crossing of `4L` to capture, acceleration is at the command
  envelope on only `0.29%/0.00%` of samples, neither joint approaches its
  `45 deg` angle stop, and force/moment coefficient maxima for the complete
  rollout are `0.0283/0.0150`. This contrasts with the unreallocated near miss,
  whose maxima are `0.2637/0.1188` and whose tail reaches its stop.
- The remaining opportunity is directional rather than propulsive. Over the
  successful inside-`4L` segment, speed averages `0.634U`, closing speed
  averages `0.516L/T`, and the absolute signed angle between world velocity
  and the head-to-target vector averages `0.599 rad`. At the `4L`, `3L`, and
  capture samples that course lag is respectively `0.728`, `0.772`, and
  `0.410 rad`; the fish reaches the capture circle on its edge while still
  moving at `0.650U`. The existing geometry-to-curvature equilibrium turns in
  the correct direction but does not use velocity direction to tighten the
  glide.
- `solver_e7a7bd0d3fe2` is a useful negative comparator for terminal scheduling:
  its closing-conditioned approach hold also captures, but only at `51.645T`
  after a long loop, with larger force/moment maxima (`0.1644/0.0744`). This
  does not support repeatedly releasing terminal allocation based on closure;
  the fast successful reallocation should remain the carrier/steering split.

## Policy hypothesis

Preserve the sampled winner exactly outside its existing `4L` terminal band.
Within the already active geometry-gated curvature allocation, add one bounded
speed-qualified course-alignment residual to the desired total two-joint
curvature. The residual compares normalized body-frame target and velocity
directions. It strengthens the same signed bend only while translational speed
is sufficient to make course observable, decays continuously as the velocity
aligns, and is bounded so the damped equilibrium retains joint excursion.

This specifically avoids the inherited failed architecture: velocity course
cannot activate at release, cannot replace target geometry, and cannot create a
redirect by itself. Expected evidence is an unchanged coherent approach to
`4L`, less terminal course lag, and capture no later than `25.2615T` without
restoring tail-stop dwell or load spikes. Falsify the residual if the capture
is lost or delayed, the path becomes a terminal loop, the early approach
changes, or terminal acceleration/angle/load occupancy materially rises.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal target capture
source_mechanism: sensor feedback modulates a bounded curvature command while the rhythmic propulsive scaffold is retained, with near-target yaw/slip correction conditioned on observable motion
transferable_invariant: when a finite-speed swimmer already has correct target-directed curvature and spare terminal authority, use body-frame target-to-velocity course error as a bounded residual that decays with alignment rather than replacing the propulsive or geometric controller
nontransferable_details: published gains, dimensional speed thresholds, species-specific kinematics, exact CPG phase, prescribed routes, and exact vortex timing
policy_translation: inside the existing normalized distance-and-geometry allocation only, a speed gate on `velocity_body_U` scales a bounded course-error addition to the damped two-joint total-curvature target; the carrier and geometry redirect remain unchanged
falsification: reject if behavior outside `4L` changes, capture is later or lost, course lag does not fall, or joint-limit occupancy and force/moment spikes return

## Non-CFD implementation audit

An isolated Julia comparison against the sampled parent confirms exact output
identity for a representative state outside `4L`; inside the terminal band,
the new residual activates and remains bounded. Replaying only the completed
winner's recorded head, heading, and velocity observations through the new
course calculation gives a full speed gate throughout its inside-`4L` segment,
with mean absolute residual `6.70 deg`, maximum `7.86 deg`, and `5.77 deg` at
capture. Direct schema extraction finds every `params.FIELD` reference in the
69-field returned parameter object, and the added course residual is odd under
body-frame reflection while its speed gate is even. These are activation,
boundedness, and contract checks only; they do not advance fish/fluid dynamics
or claim that the pending CFD rollout improves.
