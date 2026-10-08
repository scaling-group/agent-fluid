# Force-vetoed intercept-corridor response release

## Evidence and visual diagnosis before the policy edit

- All four sampled solvers satisfy the frozen Phase-2 contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no prewarm or
  cylinders, finite moving-window dynamics, and capture from `12.327720 L` at
  `25.118523 T`. Two v28 evaluations are exactly reproduced at score
  `-0.5281032175`, mean distance `2.4291077322 L`, and final distance
  `0.7461626530 L`. The separately evaluated adverse-force veto improves those
  quantities to `-0.5280861775`, `2.4290942804 L`, and `0.7461447120 L`; the
  assigned-parent intercept corridor is strongest at `-0.5280772274`,
  `2.4290872138 L`, and `0.7461352944 L`. All retain the same capture step, so
  these are small terminal-response differences rather than new routes.
- I inspected the complete combined keyframe sheets for the strongest parent
  and the weaker repeated v28 comparison. In both top-down rows the fish
  self-propels along the same compact target-directed arc and sheds a coherent
  alternating wake; it is not advected. The posterior street remains coherent
  through the outer approach, then body sweep and shedding subside into a
  quiet held-bend glide. Both oblique rows show finite three-dimensional
  Lambda2 packets without an out-of-plane instability, collision, loop, or
  domain-exit precursor. The sheets are visually indistinguishable at their
  resolution, so the small ranking is supported by terminal telemetry rather
  than vortex appearance alone.
- Inside `1.6 L`, the intercept parent keeps speed near `0.650 L/T`, contracts
  constant-velocity cross-track miss from `0.684971 L` to `0.227776 L`, and
  improves final course error from v28's `0.310311` to `0.310227 rad`. It has
  no joint-stop dwell or large commands: terminal maxima are about
  `0.09772/0.24610 rad/T^2`. Its peak force norm is `0.002193`, lower than
  v28's `0.002237`, and its mean absolute yaw moment is `0.00015971`, lower
  than v28's `0.00016037`. This supports preserving the intercept semantics,
  coupled allocation, and release budget.
- The adverse-force sibling provides independent completed evidence for a
  hydrodynamic veto: applied to v28's optional course release, it preserves
  the outer trajectory and capture step, improves score by `1.70e-5`, lowers
  final miss from `0.227844 L` to `0.227821 L`, and lowers peak terminal force
  norm from `0.002237` to `0.002182`. Its inherited replay found target-side
  lateral force adverse on `20` of `226` states below `1.6 L`, with exact
  noninterference on the other `206` helpful-force states and outside the
  terminal band. This is evidence for a veto on optional release, not for a
  new force steering residual.
- Completed negative boundaries remain binding: moving crossflow support onto
  shared mean-curvature unloading regressed to `-0.5295582789`, phase-selective
  carrier scaling regressed to `-0.5281232687`, posterior-only settled release
  regressed to `-0.530288`, and stacking extra release during unsettled bend
  formation regressed to `-0.530990`. The candidate must not enlarge release,
  change mean bend, choose a beat side, split the joints, or disturb the
  unsettled response.

## Policy hypothesis

Preserve the evaluated intercept-corridor parent in full, including its
state-feedback traveling carrier, posterior lag, target-angle redirect,
closure preview, shared two-joint equilibrium, helpful-crossflow support, and
`3.5%` paired-release ceiling. Add the one separately validated response
mechanism to that optional increment: project normalized body-frame lateral
force onto normalized body-frame target side and smoothly veto the intercept
release only while the force opposes target-side translation. Helpful or
neutral force leaves the parent unchanged; the validated base crossflow
release and mean curvature remain untouched.

This is a small compatible combination of two completed positive mechanisms,
not more authority or scalar-only gain tuning. It separates slow target/intercept
geometry from a bounded hydrodynamic response and uses force only to withhold
optional release. It should remain exactly command-invariant outside the
existing late settled-response gate, retain capture at the same step, and seek
the intercept parent's distance benefit with the sibling's lower force peak.
Reject it if replay shows a dormant or discontinuous veto, it changes helpful-
force or outer states, delays or loses capture, worsens mean/final distance or
predicted miss, creates a late loop, or restores oscillation, joint stops,
saturation, load growth, instability, or wake degradation.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish rhythmic control
source_mechanism: separate slow target-directed rhythm allocation from a bounded fast hydrodynamic response, preserving useful lateral motion rather than cancelling all crossflow
transferable_invariant: measured normalized target-opposing lateral load may withhold optional corrective release without adding steering authority or disturbing the proven propulsive scaffold
nontransferable_details: published gains, dimensional force thresholds, species kinematics, duty ratios, clock or vortex phase, cylinder geometry, capture radius, and task-specific routes
policy_translation: normalized body-frame target side and normalized body-frame lateral force form a smooth multiplicative veto only on the inherited intercept-conditioned paired release; base crossflow relief, shared mean bend, beat phase, and outer commands are preserved
falsification: reject if the force gate is inactive, affects target-helpful or outer states, enlarges authority, changes mean bend or beat phase, delays or loses capture, worsens distance or miss, or restores wake loss, saturation, joint stops, load spikes, or instability

## Non-CFD implementation audit

- The candidate is a single policy file and the returned parameter object owns
  the new force-veto scale. The lightweight state contract produces two finite
  accelerations; the formal schema and boundary checks are reported separately
  by the prescribed runner.
- Replaying the candidate and evaluated intercept parent algebra on all `4,567`
  stored parent states makes the veto active on `20` of `226` states below
  `1.6 L`, with four full-veto states. It overlaps an active intercept release
  on nine states, so the mechanism is not dormant. Candidate-parent replay
  command differences average about `0.000038/0.000089 rad/T^2` in the terminal
  band and peak at `0.00424/0.01006 rad/T^2`.
- The maximum candidate-parent replay command difference at and beyond
  `1.6 L` is exactly zero. This establishes activation, boundedness, finite
  output, and exact outer noninterference on stored states only. Capture,
  score, loads, trajectory, and wake for the combined candidate remain future
  CFD evidence.
- A supplemental failure-side audit inspected the inherited v27 mean-bend-
  unloading regression's complete combined sheet. Its top-down coherent wake,
  compact arc, and quiet terminal glide, and its finite oblique Lambda2 packets,
  remain visually indistinguishable from the parent at keyframe resolution.
  Metrics nevertheless regress to score `-0.529558`, mean distance
  `2.430257 L`, final distance `0.747693 L`, and final predicted miss
  `0.234759 L` despite smaller terminal command and load maxima. This confirms
  that lower actuation/load alone is not a capture-quality improvement and
  supports leaving shared mean curvature unchanged.
