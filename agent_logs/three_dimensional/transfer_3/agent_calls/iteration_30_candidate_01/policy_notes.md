# Actuator-consistent phase-route recovery candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled solver rollouts and the assigned-parent rollout satisfy the
  frozen contract: direct uniform `U_infinity=(0,0,0)` initialization, no
  cylinders or prewarm, finite dynamics, and capture. The sampled cohort
  captures at `18.6560--18.8045T`; the assigned parent's later
  LOS-response anterior-release candidate captures at `18.9310T`. There is no
  termination failure, so the latter is the informative route/allocator
  failure rather than a fabricated failure ranking from close capture scores.
- I inspected the combined top-down and oblique sheets for best-score
  `solver_0288c0d51d57`, weakest sampled `solver_d37d06b4c630`, and the
  inherited anterior-release rollout from release through capture. Their
  top-down rows show body-led translation with coherent alternating red/blue
  posterior vorticity streets. Their oblique rows independently show compact
  paired three-dimensional Lambda2 shedding behind the fish through target
  closure. None shows passive advection, growing wasteful sway, wake collapse,
  collision, boundary approach, or instability. Direct-zero initialization
  and local-flow RMS near `0.018U` confirm self-propulsion, so the weaker
  allocators fail by route cost rather than loss of the carrier or wake.
- The sampled actuator-consistent no-moment phase policy captures at
  `18.6725T`, score `-0.13362`, and mean distance `2.02129L`, with
  anterior/posterior acceleration-limit occupancy `42.24%/76.14%`, action RMS
  `24.95/28.85 rad/T^2`, and lateral-force/moment RMS
  `0.01256/0.00703`. Its inherited same-hash timing spread reaches about
  `19.008T`, so a few hundredths of a cycle do not establish an improvement.
- The prefilled stress-gated raw-moment residual remains a capture but is
  slower at `18.7440T` and has mean distance `2.02198L`. The sampled
  one-sided carrier-demodulated moment candidate is slower again at
  `18.8045T`; its inherited identical-hash result reaches `18.8980T`. Together
  with the failed bidirectional phase and amplitude residual replications in
  inherited logs, these outcomes do not support retaining an instantaneous
  hydrodynamic-moment allocator in this low-flow lane.
- The assigned parent's new LOS-response anterior release also fails its
  stated route bounds. It lowers acceleration-limit occupancy to
  `39.51%/73.74%`, action RMS to `24.24/28.50 rad/T^2`, and lateral-force/
  moment RMS to `0.01205/0.00675`, but captures only at `18.9310T`, raises
  mean distance to `2.04457L`, and scores `-0.15658`. Both wake views remain
  coherent and local-flow RMS is `0.01800U`; therefore instantaneous
  counter-LOS release removes route-useful anterior curvature rather than
  shedding only redundant load.

## Policy hypothesis recorded before editing

Recover the sampled actuator-consistent phase policy exactly. Preserve the
normalized body-frame bearing-plus-LOS-rate route, recoil-conditioned yaw
response, continuous two-joint C-bend, state-feedback traveling carrier,
response-reversing half-cycle steering, persistent same-side actuator gate,
coefficient-norm-preserving posterior phase rotation, and componentwise
feasibility projection. Remove both raw hydrodynamic-moment residual allocation
and instantaneous LOS-based anterior release. This is a semantic controller
selection from completed evidence: target geometry owns the slow route,
observed joint phase owns the rhythmic actuator, and the current low-flow
physical cues do not receive a second route-authority role.

Support requires capture inside the inherited successful `18.6725--19.0080T`
same-hash band, mean distance no greater than `2.02337L`, coherent wakes in
both views, posterior acceleration-limit occupancy no greater than `76.2%`,
and lateral-force/moment RMS no greater than `0.01256/0.00703`. Falsify this
recovery if the current replication loses capture, leaves those route/load
bounds, or weakens either wake; later workers should then test a genuinely
beat-scale response observation rather than reintroducing instantaneous
moment, LOS-release, or scalar authority tuning.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and phase-lag steering of a propulsive traveling wave
source_mechanism: preserve the primary rhythmic carrier and let bounded observed-state phase modulation implement steering without giving a fast physical cue ownership of the slow route
transferable_invariant: slow body-frame target geometry should own route demand, the productive posterior-lagged rhythm should remain intact, and only a bounded joint-state phase actuator should respond near persistent saturation
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, full-body waveforms, exact vortex phases, world-frame routes, and task-specific timing
policy_translation: use normalized target bearing and LOS rate for the route; use observed two-joint angle, velocity, previous action, and recoil-conditioned yaw error for response-reversing half-cycle and coefficient-norm-preserving posterior phase recruitment; omit instantaneous moment and anterior-release allocators
falsification: reject if capture leaves 18.6725--19.0080T, mean distance exceeds 2.02337L, either wake loses coherence, posterior acceleration occupancy exceeds 76.2%, or lateral-force/moment RMS exceeds 0.01256/0.00703

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
