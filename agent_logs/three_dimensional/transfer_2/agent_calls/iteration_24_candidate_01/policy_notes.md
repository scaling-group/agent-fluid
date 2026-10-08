# Candidate diagnosis and hypothesis

## Evidence diagnosis

- The assigned v39 parent is replicated by `solver_f57016524aaa`,
  `solver_7ff22ebf1c63`, and `solver_445e7e9a573f`: all three policy files,
  combined keyframe sheets, and trajectories are byte-identical apart from
  evaluation-path metadata. They capture at `24.678516T`, with mean/final
  distance `2.348207828/0.748602271L` and score `-0.448571249`.
- In both the top-down mid-plane row and oblique Lambda2 row, v39 is visibly
  self-propelled rather than advected: it lays down a coherent alternating
  wake, sustains leftward progress, and bends through the target neighborhood
  without a wake breakup or unstable body excursion. The diagnostics confirm
  direct uniform still-water initialization at `U_infinity=(0,0,0)`, no
  prewarm snapshot, and capture rather than boundary or instability
  termination.
- The v40 sampled competitor (`solver_c90a7d32e098`) has the same visible wake
  and route topology but gates post-passage course support with constant-
  velocity perpendicular miss. It captures three solver steps (`0.016502T`)
  earlier, lowers mean distance by `0.00003436L`, and improves score by
  `0.000000519`; final distance is only `0.00000417L` farther out, still a
  valid capture. This is a small allocation improvement, not evidence for a
  new gait or for scalar retuning.
- Inherited evidence bounds the choice: a sign-only course-consistency veto
  was a nominal no-op, terminal carrier holds regressed score/load or crossing
  margin, and synthesized posterior reference-velocity feedforward changed the
  far route and lost capture. The v40 change instead leaves the carrier,
  anterior phase anchor, posterior braking reserve, and coast guard intact.

## Policy hypothesis

Promote the evidenced v40 projected-miss corridor as the single candidate.
Use normalized body-frame velocity and target direction to estimate the
constant-velocity perpendicular miss. During positive closing after body-axis
passage, retain the already bounded course-preview and coupled-turn residual
only while the projected miss remains outside a smooth target-scale corridor;
release them when the inertial course already intersects that corridor. This
should reproduce the captured coherent route while avoiding unnecessary late
alignment effort. Falsify the mechanism if formal evaluation loses capture,
changes the far trajectory or wake class, worsens mean distance materially,
or regresses the established posterior hard-stop, rate, raw-command, or load
classes.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and residual path following
source_mechanism: preserve the rhythmic locomotor carrier while bounded state feedback modulates only the route-correction residual
transferable_invariant: separate propulsion from target-relative correction and release correction when observed motion already satisfies the geometric intercept objective
nontransferable_details: published CPG gains, clock phase, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: preserve the two-joint state-feedback carrier and safety filters; gate only the existing course residual with normalized body-frame projected miss during positive near-range closing
falsification: reject if capture, far-route invariance, coherent wake, mean distance, or the inherited load and saturation classes regress
