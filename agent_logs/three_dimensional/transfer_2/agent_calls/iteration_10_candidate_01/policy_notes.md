# Course-preview candidate diagnosis

## Evidence read before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=[0,0,0]`, no cylinders, no prewarm).  Their top-down rows and
  oblique Lambda2 rows show self-propulsion and a coherent alternating wake,
  rather than background-flow advection.
- The assigned parent, `terminal_priority_bridge`, keeps the useful carrier
  but misses below and left of the target: minimum distance `1.0923L` at
  `25.955T`, head `(8.216,8.740)L`, then an unrecovered northward arc and
  upper/left-domain exit at `37.493T`.  Its `74.33%` raw acceleration-envelope
  exposure, `0%` joint-rate-limit exposure, and finite force/moment histories
  rule out instability, but do not show a terminal authority improvement.
- The sibling steering-priority and carrier-relief branches preserve the same
  topology: minima `1.0760L` and `1.1483L`, followed by the same northern
  runout and domain exit.  Merely reallocating authority after the miss is
  therefore not supported.
- The sampled `course_preview_sector_recapture` controller is the decisive
  counterexample.  It preserves the same coherent carrier but adds a bounded
  body-frame course/target cross-product before passage, reaching the capture
  radius at `24.580T` and `0.7470L`.  Raw acceleration-envelope exposure falls
  slightly to `72.84%`, joint-rate-limit exposure stays `0%`, and peak planar
  force/moment (`0.323`, `0.143` in logged normalized units) are below the
  assigned parent's (`0.474`, `0.216`).  The visual path bends into the target
  sphere before the failure policies begin their post-miss turn.
- No inherited optimizer log was present under `logs/optimize/`; the assigned
  guidance and all four sampled solver artifacts are the available history.

## Policy hypothesis

Replace the failed terminal-priority bridge with the already evaluated
course-preview mechanism exactly, retaining the demonstrated traveling-wave,
sector-intercept, half-cycle allocation, and target-behind recapture behavior.
The only architectural change relative to the assigned parent is a bounded,
mirror-equivariant course error derived from normalized body-frame target and
velocity directions.  Range, speed, closing, and posterior-release gates keep
the preview dormant until a trajectory exists, admit it before the terminal
miss, and prevent it from becoming a memorized route.  Exact behavioral replay
is preferred over combining the one successful branch with terminal mechanisms
whose sampled outcomes all lost capture.

Falsification: reject the transfer if formal evaluation does not reproduce a
capture-class approach, if it perturbs the early coherent wake, if the target
passes behind before capture, or if acceleration/rate/load exposure materially
exceeds the evaluated course-preview rollout.

## Bookshelf transfer record

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking
source_mechanism: sensor feedback modulates a low-dimensional rhythmic carrier instead of replacing the carrier
transferable_invariant: preserve a productive traveling rhythm and inject bounded route correction from observed target-motion mismatch
nontransferable_details: published oscillator gains, robot geometry, clock phase, species kinematics, and task-specific routes
policy_translation: blend a normalized body-frame course/target cross-product into unused signed sector-request headroom while keeping joint-state phase and posterior lag
falsification: reject if the coherent carrier degrades, the early route changes before course evidence exists, capture is lost, or command/load exposure grows

The shelf supports the separation between rhythmic propulsion and bounded
feedback modulation, but the sampled capture—not the literature family—is the
evidence for selecting this controller.
