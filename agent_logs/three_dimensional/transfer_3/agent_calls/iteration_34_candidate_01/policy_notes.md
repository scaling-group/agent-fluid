# Restore the evaluated actuator-consistent route

## Evidence diagnosis recorded before candidate selection

- All four sampled solver rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  dynamics, and capture. I inspected the best-score actuator-consistent sheet
  (`solver_ed121cf46867`) and the slower stress-gated residual sheet
  (`solver_bdf6dd947707`) from release through termination. Both top-down rows
  show body-led translation and a coherent alternating caudal-vorticity street;
  both oblique rows show compact Lambda2 structures forming behind the moving
  tail. Neither shows passive advection, growing lateral waste, wake breakup,
  collision, boundary approach, or instability. The stress gate instead
  delays capture to `18.7440T` and has the worst sampled mean distance
  (`2.02198L`), while its load and limit occupancy overlap the plain route.
- The plain `dogfish3d_actuator_consistent_tail_phase_v1` policy has two
  current same-hash captures at `18.6725T`, scores `-0.13362` and `-0.13219`,
  and mean distances `2.02129L` and `2.02018L`. Two inherited exact-policy
  evaluations also capture at `18.7275T` and `18.7935T`. Across those inherited
  and current traces, anterior/posterior acceleration-limit occupancy is
  `40.68--42.15% / 74.04--76.11%`, force/moment RMS is
  `0.01314--0.01350 / 0.00684--0.00703`, and local-flow RMS is
  `0.01806--0.01821U`. This is the replicated route envelope, not evidence that
  clipping is solved.
- The assigned parent translated an offline centered-`0.55T` yaw-fit into a
  normalized reflection-odd anterior joint-phase recoil observer. Its post-exit
  evaluation is a decisive negative result: capture remains finite, but moves
  to `22.0110T`, mean distance rises to `2.31828L`, and score falls to
  `-0.42356`, outside the parent's own `18.656--18.744T` falsification band.
  At `4T` its speed is only `0.267U`, versus `0.536--0.539U` for the exact-route
  references, and it remains about `1.2L` farther from the target at `12T`.
- The parent sheet makes the failure mechanism visible. Its top-down and
  oblique wakes remain coherent and body-led through capture, but initial
  translation and route closure are delayed, followed by a larger late turn.
  The metrics agree: posterior limit occupancy falls to `60.62%` and
  force/moment RMS to `0.01177/0.00612`, but anterior occupancy rises to
  `48.30%`. Thus the phase observer traded away productive early route/carrier
  coupling for load relief; it did not expose a better causal yaw response.
  A low offline error against a centered beat average is not sufficient
  evidence for an instantaneous observer because that average uses future
  samples and is not the closed-loop quantity being controlled.

## Candidate hypothesis recorded before policy selection

Retain the prefilled `dogfish3d_actuator_consistent_tail_phase_v1` policy
exactly as one controlled rollback candidate. It preserves normalized
body-frame bearing and LOS-rate guidance, the recoil-conditioned C-bend,
state-feedback traveling carrier, response-reversing half-cycle steering,
persistent same-side feasible-action recruitment, bounded posterior phase
rotation, and componentwise acceleration projection. It adds no nonlinear
joint-phase recoil terms and no instantaneous moment/stress allocator. This is
an evidence-led recovery after a falsified mechanism, not a same-worker claim
of CFD improvement.

Support requires capture inside the inherited exact-policy
`18.6725--18.7935T` band, a coherent wake in both views, mean distance no
greater than `2.03024L`, anterior/posterior limit occupancy inside
`40.68--42.15% / 74.04--76.11%`, and force/moment RMS no greater than
`0.01350/0.00703`. Falsify the rollback if it loses capture, leaves that route
band, weakens either wake, or exceeds those load bounds. A future response
observer should wait for a causal beat-scale state/history signal and must
preserve early propulsion; do not scalar-tune the failed odd phase features.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG sensor feedback and wake-interaction signal separation
source_mechanism: condition a productive rhythmic carrier on measured response while separating slow route demand from fast recoil
transferable_invariant: preserve the directed posterior-lagged traveling bend and admit a response observer only when its causal closed-loop route benefit separates from carrier recoil
nontransferable_details: published CPG gains, dimensional frequencies, species or robot kinematics, exact vortex phase, centered offline beat averages, and task-specific routes
policy_translation: remove the falsified instantaneous odd phase observer by retaining the evaluated normalized LOS route, two-joint carrier, linear recoil proxy, persistent phase actuator, and physical limits
falsification: reject the rollback on lost or delayed capture, weaker wake, mean distance above 2.03024L, or load and occupancy outside the replicated exact-policy envelope; reconsider phase conditioning only with a causal beat-scale observation that preserves early propulsion

The current candidate's CFD result is produced only after this worker exits
and is not used as evidence here.
