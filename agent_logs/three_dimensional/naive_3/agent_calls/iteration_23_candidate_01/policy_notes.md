# Global posterior viability-projection candidate

## Evidence and visual diagnosis recorded before the policy edit

- All four sampled solver rollouts used direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. All captured at
  about `18.27T`. The best-scoring fixed-width guard is the informative
  mechanical failure: it reaches exactly `-45 deg` at the posterior joint and
  produces peak planar force and yaw-moment coefficients of `0.1718` and
  `0.0770` even though its score is `-0.247735`.
- The sampled fixed-width and stopping-risk sheets have the same useful visual
  topology. Their top-down rows show a regular alternating wake throughout the
  target approach, while their oblique rows retain compact three-dimensional
  Lambda2 structures near the caudal region through capture. Peak fish speed
  is `1.329U` versus only `0.0315U` peak local flow, so the approach is active
  propulsion rather than still-water advection.
- Both the target-distance-gated and globally active stopping-risk variants
  preserve capture, keep the posterior minimum near `-43.0 deg`, and reduce
  whole-trace peak planar force and yaw moment to `0.0372` and `0.0191`. The
  global `0.60`-onset result is effectively unchanged by adding an explicit
  return-value clamp, showing that the clamp faithfully exposes the downstream
  actuator envelope without claiming lower applied effort.
- The inherited smooth-demand envelope is a useful failure comparison. Its
  sheet still shows an alternating top-down street and three-dimensional
  caudal structures, but its compressed waveform lowers peak speed to
  `0.855U`, reaches only `6.211L`, and exits the left boundary. Eliminating raw
  exceedance by reshaping the productive carrier is therefore not supported;
  wake coherence alone does not establish target authority.

## Policy hypothesis

Preserve the captured full-quadrant target-ray/velocity-course observation,
zero-centered anterior oscillator, lagged posterior carrier, and terminal
steering reserve. Replace the prefilled fixed-width angle guard with the
sampled target-independent posterior stopping-risk projection. The normalized
risk compares kinetic stopping distance from posterior joint velocity with the
buffered margin to the approached angle boundary; it continuously lowers only
the acceleration directed toward that boundary and releases when risk clears.
Return both commands within the owned physical acceleration envelope, matching
the sampled actuator-feasible policy whose applied rollout is identical to the
successful global barrier.

Expected evidence is capture near `18.28T`, continued alternating shedding,
posterior clearance of about `2 deg`, and peak force/moment no worse than
`0.0372/0.0191`. Falsify the candidate if it loses capture or the broad route,
changes the carrier away from joint risk, contacts the posterior hard limit,
or restores the fixed-width guard's terminal load spike. Do not interpret raw
command feasibility as an effort or speed-limit-occupancy improvement.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: sensor feedback modulates a productive rhythmic carrier only when an observed mechanical constraint requires correction
transferable_invariant: preserve the propulsive rhythm and continuously project only dynamically unsafe joint motion toward a bounded viable set, releasing correction when measured risk clears
nontransferable_details: published gains, linkage geometry, species-specific kinematics, dimensional cadence, clock phase, exact vortex phase, source actuator ratings, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and the two-joint carrier; form posterior stopping risk from joint angle, joint velocity, and the owned acceleration envelope, then cap only acceleration toward the approached boundary without a task-distance safety gate
falsification: reject if capture or coherent shedding is lost, broad-route commands change without joint risk, posterior contact returns, or force and yaw-moment peaks exceed the sampled stopping-risk ceiling
```
