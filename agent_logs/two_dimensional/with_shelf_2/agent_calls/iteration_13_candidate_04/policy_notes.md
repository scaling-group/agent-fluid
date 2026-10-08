# Multi-wake policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common held fish at the upper-right
  release while four developed cylinder streets merge around the target. The
  released sheets therefore share one mature-wake initial condition; repeated
  success is materialization evidence, not robustness to changed wake phase.
- All four sampled rollouts are finite captures, so no sampled failure sheet is
  available. Their sheets preserve the useful topology: a body-generated
  traveling wake, active diagonal upstream/downward motion, and one broad
  correction through the merged wakes into the capture circle. The assigned
  parent is the strongest result: `target_reached` at `45.26`, `1.7153L` mean
  distance, score `0.165009`, total command energy `46642`, and `439/4342`
  force/moment RMS. Mean body velocity x is `-0.2415` versus `-0.1774` mean
  local flow x, confirming self-propulsion rather than passive advection.
- The sampled feedback allocations isolate useful structure. The ungated
  course residual reaches at `45.61`, with `1.7222L` mean distance, energy
  `46916`, and `453/4406` loads. Positive yaw-only gating reaches at `45.10`,
  with `1.7191L`, `46677`, and lower `416/4183` loads. Combining yaw and
  joint-rate headroom, as in the parent, improves mean distance and score but
  gives back some of the yaw-only load benefit. Replacing yaw separation with
  a near-target distance gate reaches at `45.61`, regresses loads to `475/4653`,
  and does not establish terminal scheduling as a useful substitute.
- Relative crossflow remains substantial in every successful sample (RMS
  `0.289--0.293`) while force/moment loads and route quality differ. Aggregate
  evidence does not establish a directional cancellation law, so a signed
  crossflow steering residual would be unjustified. It does support testing
  crossflow only as a normalized headroom signal on optional amplification.
  The inherited below-target collision at `58.93`, after a `1.872L` closest
  approach and `537/4995` loads, remains the nonvisual boundary against
  weakening route correction or broadly reallocating propulsion.

## Policy hypothesis

Preserve the parent's zero-centered oscillator, lagged posterior target,
predicted-bearing half-cycle steering, yaw-response gate, positive-closure
qualification, joint-rate headroom, full negative course correction, and
smooth limiter. Add one feedforward disturbance-separation mechanism: compute
the absolute lateral fraction of observed body-frame relative flow and use its
complement only to reduce positive course-convergence amplification. Thus an
approaching crossflow event can withhold extra tail motion before a large yaw
moment develops, without commanding a crossflow-cancelling turn or damping the
base wave. Missing flow observations leave the parent output unchanged.

The next CFD rollout falsifies the candidate if it loses `target_reached`,
meaningfully exceeds the parent's `1.7153L` mean-distance trajectory, arrives
later than `45.61` without a material load reduction, or recreates the inherited
low pass/collision. A fixed-snapshot success would still not establish
robustness to changed wake phase, inflow, geometry, or target.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish rhythmic control
source_mechanism: separate fast wake disturbance sensing from slow route modulation while preserving the propulsive rhythm
transferable_invariant: when normalized lateral relative flow is large, withhold only optional route-conditioned tail amplification rather than cancelling crossflow or weakening the base traveling wave and corrective suppression
nontransferable_details: published gains, dimensional flow scales, species-specific kinematics, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: form a bounded body-frame crossflow fraction from local relative-flow components and multiply only the positive course-convergence headroom gate by its complement; keep negative course correction and the two-joint base law intact
falsification: reject if capture or diagonal topology is lost, distance history or arrival regresses without lower load, or the gate provides no separation from the sampled yaw/rate response
