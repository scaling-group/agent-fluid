# Drift-qualified route-feedback candidate

## Evidence reviewed before the policy edit

- Read the assigned parent guidance, all four sampled `score.yaml`,
  `wake_observation.md`, `wake_metrics.csv`, `wake_diagnostics.json`, and
  trajectories, plus the inherited step-8 through step-10 policy notes. All
  sampled diagnostics confirm direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, stable dynamics,
  and capture termination.
- Inspected both the top-down mid-plane vorticity row and oblique Lambda2 row
  of the combined sheets for the best finite policy (`solver_c668b8e0b865`)
  and the weakest sampled capture (`solver_ea4eb1868930`) as an informative
  negative control. The other two best-score samples are trajectory-identical
  reruns, so they establish deterministic evidence rather than new mechanisms.

## Visual and quantitative diagnosis

Both sheets show self-propulsion from quiescent water: a coherent alternating
vorticity street develops behind the fish and the oblique view retains compact
three-dimensional posterior/caudal Lambda2 structures through capture. There
is no passive advection, wake breakup, collision, or out-of-plane instability.
The visible carrier is therefore a behavior to preserve; route-feedback
qualification, rather than propulsion or actuator attenuation, separates the
sampled outcomes.

The weaker unqualified line-of-sight controller captures at `17.8750T` with
mean distance `1.973290L`, center path `12.9663L`, maximum straight-line head
cross-track `0.5454L`, approach alignment `0.8137`, and final alignment
`0.1134`. The error-qualified controller is repeated exactly by three samples
and improves capture to `17.7265T`, mean distance to `1.967391L`, path to
`12.8468L`, maximum cross-track to `0.5120L`, approach alignment to `0.8993`,
and final alignment to `0.6010`. It reaches the `2.1L` approach boundary only
`-0.0183L` off the initial head-to-target line, confirming that early release
to the existing near controller is useful.

A smaller route defect remains. The best trajectory first bows to about
`-0.49L` cross-track near `6L` distance, then returns to the direct line before
approach. Its line-of-sight residual is multiplied only by instantaneous
body-frame bearing/vector error. During a target-error zero crossing that gate
can withdraw even while the separately measured, co-windowed inertial
line-of-sight rate remains nonzero. Offline reconstruction of the recorded
observations finds this condition on about `14%` of rows where the far/middle
distance gate has authority; it is a feedback-release defect, not evidence for
more carrier energy or a direct terminal course command. Inherited logs also
show that three terminal-only course/load changes improved alignment slightly
but worsened mean distance, so this candidate leaves approach unchanged.

## One policy hypothesis

Preserve the posterior-priority state-feedback oscillator, lagged tail wave,
odd curvature map, half-cycle steering, direction-selective rate governor,
and the current smooth release to zero at `2.10L`. Make one architectural
change to the route observer: qualify its bounded correction by the maximum
of current normalized body-frame target error and the magnitude of its own
normalized co-windowed inertial sightline drift. Thus feedback persists
through a geometric zero crossing only while the target line is still moving,
then releases continuously when both route error and route drift vanish. No
new direct course, load, clock, coordinate, case identity, or carrier term is
introduced.

Expected evidence is retention of the coherent two-view wake and the
`17.73T` capture scale while reducing the far/middle lateral bow or shortening
its recovery without reintroducing the unqualified controller's late crossing.
Falsify the mechanism if capture, mean distance, path, approach alignment,
load class, or wake coherence regresses; if the maximum cross-track is not
reduced; or if held-out/reflected conditions show persistent steering after
both body error and line-of-sight drift have centered.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and response-gated fish turning
source_mechanism: sensor-qualified modulation of a stable rhythmic carrier with feedback authority released by observed error response rather than an open-loop stage
transferable_invariant: preserve the propulsive rhythm and withdraw bounded route correction only after both normalized route error and measured route drift have contracted
nontransferable_details: published gains, dimensional frequencies, duty ratios, species-specific kinematics, exact vortex phases, target coordinates, and task-specific routes
policy_translation: use the maximum of current body-frame target-error magnitude and bounded co-windowed inertial line-of-sight-rate magnitude to gate the existing two-joint route correction outside approach
falsification: reject if capture, distance integral, route directness, approach state, actuator-load class, reflection symmetry, or either visual wake view worsens
