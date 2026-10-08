# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and reproduce the exact
  `22.154001T` capture, `0.748384L` crossing, `2.105583L` mean distance, and
  `-0.210952` score. Three sampled policies are executable-identical to the
  prefill; the fourth adds a recovery-preview expression that is trajectory-
  inert. The complete `solver_e00ec3b50664` sheet shows a continuously beating
  fish following the target-directed S-route, an attached alternating
  mid-plane vorticity street, and discrete oblique three-dimensional Lambda2
  structures through capture. Two other oblique rows are blank render
  artifacts and are not additional evidence of 3D-wake preservation.
- The inherited full-vector target-line-rate variant is the most informative
  complete-view regression. It changes only the predictor driving posterior
  half-cycle allocation, retains the same visible route class and coherent
  top-down/oblique wake, but captures later at `22.230999T`, raises mean
  distance to `2.106262L`, and lowers score to `-0.211406`. Mean action,
  anterior/posterior exact-rate-cap occupancy, and peak normalized
  force/moment remain comparable at `59.911`, `11.28/6.38%`, and
  `0.030897/0.015839`. The loss is therefore a posterior phase-timing failure,
  not advection, wake collapse, load growth, or instability.
- Assigned-parent logs give two further boundaries. Previewing the anterior
  redirect is reproduced as a regression as late as `22.258499T` with
  `2.107164L` mean distance, while proximity-previewing posterior recovery is
  trajectory-inert. The incremental proximity prediction is useful on the
  slow course request and posterior half-cycle envelope; its extension should
  not be spread to another actuator path or replaced by a less faithful rate
  estimate.
- A retrospective partition of the sampled parent trace supplies a distinct
  joint-state phase observation. From `8T` through capture, target-signed
  normalized yaw moment averages about `+0.00415` when the signed anterior
  carrier bend `(q1 - curvature_center)` is on the helping side and
  `-0.00465` on the other side. The current signed anterior-rate partition
  separates the same samples only to about `+0.00083/-0.00096`. The bend
  coordinate and target-signed moment also have correlation about `0.86`,
  versus `0.24` for rate. This does not validate moment feedback or a published
  phase; it identifies which normalized observed carrier half-cycle produced
  the measured yaw-load sign in this rollout.

## Visual diagnosis

The sampled parent is self-propelled in quiescent water: a compact red/blue
street develops behind the caudal region by `4T`, follows the smooth S-route,
and remains present at capture, while the complete oblique row shows separated
three-dimensional wake structures behind the traveling body wave. The
full-vector-rate regression preserves those structures and the route topology,
so there is no visual case for more drive, rudder, recovery, or static bend.
The remaining testable mismatch is that the posterior asymmetry calls the
`q1_dot` half-cycle "useful" even though measured target-signed yaw load is
organized primarily by the centered `q1` bend half-cycle.

## One candidate hypothesis

Preserve the through-water course loop, proximity prediction, anterior
redirect and speed recovery, posterior recovery allocation, reactive rudder,
terminal response relief, carrier, and every authority ceiling. Change only
the phase selector used by the already capped posterior asymmetry: smoothly
select the target-helping half-cycle from normalized anterior carrier bend
`(q1 - curvature_center) / oscillator_amplitude`. Keep the existing
target-signed `q1_dot` gate unchanged for terminal rudder relief, because that
response-plus-stroke qualification has separate positive evidence. Thus the
candidate tests one state-feedback duty-allocation mechanism without adding
tail authority, moment feedback, a clock, coordinates, route memory, target
identity, or prescribed wake phase.

Falsify this translation if capture is lost or later than `22.154001T`, mean
distance exceeds `2.105583L`, score falls below `-0.210952`, the unchanged
`4/8T` launch (`11.300/8.629L`) or S-route degrades, or a complete two-view
wake no longer preserves the traveling carrier. Also reject it if mean action,
exact-rate occupancy, or peak normalized force/moment materially exceed the
sampled `59.932`, `11.49/6.41%`, and `0.030897/0.015839` envelopes. A positive
fixed-pose result would not establish robustness to pose, inflow,
hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and asymmetric flapping
source_mechanism: preserve a rhythmic propulsive carrier while steering by redistributing bounded posterior effort across an observed oscillation phase
transferable_invariant: use measured body state to allocate existing oscillatory authority to the phase that produces target-signed turning without increasing the carrier or adding static bend
nontransferable_details: published gains, clock phase, duty ratios, robot linkage geometry, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: retain the bounded predictive target-error envelope but select its posterior helping half-cycle from normalized target-signed anterior carrier bend; retain the independently evidenced rate-based terminal-relief qualification
falsification: reject if arrival or mean distance fails to beat 22.154001T/2.105583L, launch or route changes adversely, or the complete wake, action, saturation, force, or moment exceeds the sampled parent bounds
