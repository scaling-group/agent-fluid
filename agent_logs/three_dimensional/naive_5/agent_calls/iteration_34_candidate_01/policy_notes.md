# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before policy edit

- All four sampled summaries and diagnostics confirm direct uniform
  still-water initialization (`U_infinity=[0,0,0]`), with no prewarm and no
  cylinders. All four policies self-propelled from rest and captured; the
  moving window did not supply advection.
- In both the top-down vorticity and oblique Lambda2 rows, the assigned parent
  (`solver_fb7bddf12f80`) forms a coherent reverse-vortex street, translates
  steadily toward the target, and finishes with a late target-side hook. The
  three edited samples preserve that same productive three-dimensional wake;
  none shows thrust collapse, an incoherent tail wake, or a window artifact.
- The assigned parent captures at `0.748361L` and `26.1635T`, with mean
  distance `2.50987L`. Force-phase posterior modulation
  (`solver_3065fba218c6`) reaches `26.0920T` but worsens mean distance to
  `2.51220L`; conflict-tail reallocation (`solver_d10278aed649`) reaches
  `26.1250T` with mean distance `2.51040L`. Their sheets remain visually
  indistinguishable at the available cadence, so neither supports more
  force-phase or posterior-conflict tuning.
- The course-triggered, response-released redirect
  (`solver_c65157fcb0b0`) is the useful contrast: it captures at `0.749266L`
  and `25.9710T`, lowers mean distance to `2.49818L`, and improves score from
  `-0.607211` to `-0.596086`. It retains zero angle/rate contacts and zero
  policy-clamp rows; peak planar force/yaw moment (`0.01885/0.01010`) remains
  close to the parent's `0.01944/0.00987`. The visible topology is still the
  same late-hook capture, so this is evidence for earlier progress at the
  fixed pose, not geometric robustness or a new terminal-clearance result.

## Policy hypothesis

Use the sampled course-triggered redirect as the single candidate. Preserve
the coordinated traveling-bend carrier, terminal posterior modulation, and
viability guards. When translation is observable and closing, let the union
of body bearing and a jointly large normalized course error/projected miss
activate a bounded share of the existing same-sign redirect. Retain the
measured yaw/bend release, and withdraw only a conflicting target-line
residual in the middle approach so the direct route request is not cancelled.
This tests whether the sampled earlier progress reproduces without increasing
the command envelope or adding a second steering side.

bookshelf_consulted: true
source_domain: biological fast-start turning and sensor-modulated robotic-fish CPG control
source_mechanism: large observed route error engages bounded high-curvature redirection, then observed turn response releases back to the propulsive rhythm
transferable_invariant: separate a geometry-gated redirect from the traveling carrier and release it by measured response rather than elapsed phase or a memorized route
nontransferable_details: species-specific C-start posture, full-body kinematics, published gains and frequencies, exact vortex phase, and task-specific trajectories
policy_translation: normalized body-frame bearing, velocity-target cross product, projected miss, closing speed, joint-state phase, and phase-rejected yaw gate an existing two-joint same-sign redirect; all authority remains bounded by the inherited feasibility guards
falsification: reject if capture is lost, arrival or mean distance regresses to the parent, the coherent wake changes adversely, any actuator contact/clamp returns, peak load rises materially, or held-out geometry reveals that the fixed-pose gain was route-specific
