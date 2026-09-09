# Replicated route recovery after response-observer negatives

## Evidence diagnosis recorded before the policy edit

- All four current samples satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  dynamics, and capture at `18.6560--18.7440T`. Their combined sheets were
  inspected from release to capture in both the top-down vorticity and
  oblique Lambda2 rows. Each shows body-led translation, a coherent alternating
  wake formed by `4T`, and smooth target approach without passive advection,
  collision, wake breakup, boundary contact, or instability. Local-flow RMS
  is only `0.01807--0.01816U`, so the small current differences are controller
  semantics rather than environmental transport or loss of propulsion.
- The plain actuator-consistent phase route has two exact-policy samples.
  Both capture at `18.6725T`; their scores span `-0.13362-- -0.13219`, mean
  distance spans `2.02018--2.02129L`, anterior/posterior acceleration-limit
  occupancy spans `40.71--42.15% / 75.46--76.11%`, and force/moment RMS spans
  `0.01331--0.01350 / 0.00693--0.00703`. This is the replicated semantic
  baseline and also defines the size of unresolved one-run score/load spread.
- The assigned-parent helpful-moment relief reaches capture `0.0165T` sooner
  in the current sample, but inherited exact-policy evidence also records an
  approximately `18.9915T` repeat. Its apparent timing edge is therefore
  smaller than same-policy variability and does not support retaining an
  instantaneous moment allocator. The stress-confirmed moment residual is
  slower at `18.7440T`; its `41.46% / 75.44%` occupancy and
  `0.01343 / 0.00699` loads overlap the replicated baseline.
- The newest inherited optimizer result is the informative failure. A compact
  phase-conditioned recoil observer was motivated offline by a lower error
  against a centered-beat yaw average, but closed-loop CFD captures only at
  `22.0110T`, scores `-0.42356`, and raises mean distance to `2.31828L`.
  Its top-down and oblique sheets retain a coherent self-propelled wake but
  show a much longer, more curved route. Although it lowers posterior limit
  occupancy and force/moment RMS to `60.62%` and `0.01177 / 0.00612`, anterior
  occupancy rises to `48.30%`; the route penalty falsifies the offline proxy
  as a beneficial online yaw-response observer.
- The available `turn_rate_recent` and bearing window cover only about
  `0.0385T`, far shorter than the `0.55T` carrier. They cannot repair that
  failure as a genuine beat-history observation. The evidence now rejects
  both instantaneous physical-response allocation and an offline-fitted
  instantaneous phase observer in this low-flow lane.

## Policy hypothesis recorded before the policy edit

Produce exactly one recovery candidate by removing the assigned parent's
helpful-moment amplitude release and restoring the replicated
`dogfish3d_actuator_consistent_tail_phase_v1` response semantics. Preserve the
normalized body-frame bearing-plus-LOS-rate route, distributed C-bend,
state-feedback traveling carrier, response-reversing half-cycle steering,
persistent same-side feasible-action gate, coefficient-norm-preserving
posterior phase rotation, and componentwise acceleration projection. Do not
add another force, moment, flow, sub-beat-rate, fitted phase, or scalar residual
channel. This is an evidence-led exploitation candidate, not a same-worker
claim that its future CFD result has improved.

Support requires capture within the inherited `18.6725--19.0520T` replication
band with coherent wakes in both views and mean distance no greater than
`2.02129L`. Treat effort as improved only if a later exact-policy repeat falls
below the sampled lower bounds of `75.46%` posterior acceleration occupancy
and `0.01331 / 0.00693` force/moment RMS. Falsify the recovery if it loses
capture, leaves the timing band, weakens either wake, or exceeds the replicated
route/load envelope.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-adaptive swimming
source_mechanism: keep a productive directed rhythm primary and separate slow route feedback from fast physical-response modulation
transferable_invariant: preserve the posterior-lagged traveling bend and normalized body-frame LOS route; recruit a response channel only when completed closed-loop evidence distinguishes it from carrier recoil
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, cylinder geometry, and task-specific routes
policy_translation: retain the evaluated LOS C-bend and joint-state/previous-feasible-action phase path while removing the unsupported instantaneous yaw-moment release; do not replace it with the failed fitted phase observer or a sub-beat proxy
falsification: reject if recovery loses capture, leaves 18.6725--19.0520T, weakens either wake, exceeds mean distance 2.02129L, or moves outside the sampled route/load envelope; reopen response modulation only with a causally available beat-scale observable and replicated benefit

The current candidate's CFD result is produced only after this worker exits
and is not used as evidence here.
