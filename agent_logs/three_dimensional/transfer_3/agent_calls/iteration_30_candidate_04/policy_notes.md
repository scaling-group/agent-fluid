# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations are valid direct-uniform still-water rollouts:
  `initialization_mode=uniform_direct`, `flow_velocity_L_per_T=[0,0,0]`, no
  prewarm, and `termination=capture`. Thus their motion is self-propulsion,
  not imposed advection.
- The combined top-down/oblique sheets for the best sampled finite rollout
  (`solver_0288c0d51d57`, helpful-moment amplitude relief) and the most
  informative relative failure (`solver_d37d06b4c630`, opposing-moment
  residual) both show a coherent alternating vortex street from startup to
  capture and compact three-dimensional Lambda2 structures along the curved
  route. Neither shows wake collapse, collision, domain exit, or instability.
  Their nearly identical sheets make a large wake/gait change unsupported.
- The best rollout captures at `18.6560T`, score `-0.133208`, mean distance
  `2.02115L`, force/moment RMS `0.013277/0.006912`, and anterior/posterior
  acceleration-limit occupancy `40.7%/75.7%`. The opposing-moment rollout is
  slower at `18.8045T`, score `-0.136820`, mean distance `2.02499L`, with
  `0.013519/0.007041` loads and `42.6%/75.9%` occupancy. The no-moment sample
  lies inside that narrow band at `18.6725T`; the stress-gated moment residual
  reaches `18.7440T`. Local-flow RMS remains `0.0180--0.0181U` for all four.
- Assigned-parent guidance and inherited scores extend the same negative
  branch: moment-demodulated/amplitude allocators do not escape replication
  spread, while inherited completed captures score as low as `-0.14654` and
  `-0.15658`. Another moment term or scalar gain edit is therefore not a new
  supported mechanism.

## Policy hypothesis

Keep the normalized body-frame bearing/LOS-rate guidance, traveling carrier,
posterior mean curvature, response-reversing half-cycle asymmetry, and
actuator-consistent posterior phase recruitment. Remove the sampled
hydrodynamic-moment amplitude allocator. Change only the distributed C-bend's
anterior center: retain its geometry/route recruitment gate, but command its
signed curvature from recoil-conditioned yaw-rate error rather than from the
unresolved route demand itself. This implements a response-led redirect
release: a large route error recruits the anterior bend; once the measured yaw
response meets or outruns demand, anterior curvature continuously releases or
reverses while the posterior traveling wave remains active.

The expected signature is capture with the same coherent wake and route class,
but lower anterior limit occupancy and force/moment RMS than the sampled
no-moment band, without moving arrival outside roughly `18.66--18.80T`. Reject
the mechanism if capture is lost, arrival is materially delayed, the wake
weakens, anterior occupancy does not fall, or a rapid sign reversal creates a
new route oscillation.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG turning
source_mechanism: recruit bounded body curvature for large directional error, then release into the propulsive rhythm when observed turning response appears
transferable_invariant: steering curvature should depend on unresolved geometry-response error, so measured turn completion unloads the redirect without removing the traveling wave
nontransferable_details: species-specific C-start envelope, published robot gains and duty ratios, dimensional beat timing, exact vortex phase, and any prescribed route
policy_translation: retain normalized body-frame LOS guidance and two-joint carrier; replace anterior C-bend sign/magnitude from target yaw demand with recoil-conditioned yaw-rate error while preserving the geometry recruitment gate and posterior phase path
falsification: reject if the rollout loses capture or wake coherence, leaves the sampled 18.66--18.80T arrival band, creates repeated yaw reversals, or fails to reduce anterior saturation and loads relative to the no-moment baseline
