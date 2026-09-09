# Unrealized-demand posterior phase candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture. No sampled failure sheet is available in this batch;
  the slowest capture and the inherited high-pass miss are therefore the
  informative negative comparators rather than being mislabeled as failures.
- In every combined sheet, the top-down row develops a body-led alternating
  vortex street from `4T` through capture, and the oblique row shows compact
  paired Lambda2 structures following the swimmer. The target-directed path is
  smooth and finite, with only tail-beat-scale lateral waviness: there is no
  passive advection, wake collapse, loop, collision, or boundary approach.
  The best actuator-consistent case is already closer at `7T`, and its lead
  grows through `18T` (`1.205L` versus `1.301--1.386L` for the other cases),
  so the performance difference is sustained route progress rather than a
  last-frame capture artifact.
- The sampled actuator-consistent phase gate is strongest: it captures at
  `18.67250T`, reaches mean score distance `2.02129L`, and scores `-0.13362`.
  The assigned-parent demand-lead policy captures at `18.78799T`,
  `2.02833L`, and `-0.14000`; current-demand recruitment captures at
  `18.79899T`, `2.03111L`, and `-0.14330`; the half-cycle-only comparator
  captures at `18.93099T`, `2.04175L`, and `-0.15357`. Thus releasing phase
  when current raw demand and previous feasible action oppose one another
  outperforms anticipating the next demand flank, continuous current-demand
  recruitment, and removing phase recruitment.
- The faster route is not free effort reduction. Relative to the parent, the
  actuator-consistent case raises posterior `99%`-limit occupancy from
  `75.67%` to `76.41%` and force/moment RMS from `0.01333/0.00694` to
  `0.01350/0.00703`, while local-flow RMS remains essentially unchanged
  (`0.01809U` versus `0.01808U`). It still stays within the inherited
  half-cycle bounds and far below the failed clipped branch's
  `0.01574/0.00810` load boundary. More phase exposure or scalar authority is
  therefore not supported; the next test should preserve the successful
  reversal semantics while making phase support conditional on demand the
  feasible actuator has not yet realized.

## Policy hypothesis recorded before editing

Start from the best sampled actuator-consistent policy, preserving its
normalized body-frame bearing and LOS-rate request, recoil-conditioned yaw
response, continuous distributed C-bend, response-reversing half-cycle,
coefficient-norm-preserving posterior phase rotation, and componentwise
physical projection.

Add one actuator-realization residual to the existing phase gate. Phase
recruitment remains possible only when raw posterior demand and the observed
previous feasible action remain on the same actuator side. Within that state,
compare their normalized magnitudes and smoothly retain phase only for the
positive demand deficit. This leaves the successful beat-reversal release
intact and additionally releases phase on a falling or already-realized demand
flank. It uses only current two-joint state and `previous_action`, with no
clock, mutable history, route coordinate, exact vortex phase, or gain increase.

Support requires capture no later than the assigned parent (`18.788T`), with
mean score distance no worse than `2.02833L`, while holding posterior occupancy
and force/moment load at or below the best sampled case's
`76.41%` and `0.01350/0.00703`. Falsify the mechanism if capture is lost,
arrival exceeds the half-cycle comparator's `18.931T`, the alternating wake
weakens, or load exceeds the inherited failed branch's `0.01574/0.00810`.
Because sampled local-flow RMS is only about `0.018U`, disturbance robustness
remains explicitly unclaimed.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and phase-lag steering
source_mechanism: sensory feedback recruits and releases posterior oscillator timing while preserving a traveling propulsive rhythm
transferable_invariant: retain the carrier and apply bounded phase modulation only while observed actuator response has not realized the current directional demand
nontransferable_details: published gains, clock phase, robot geometry, species-specific kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: gate the existing fixed-norm posterior phase rotation with normalized body-frame yaw response, two-joint phase, same-side previous feasible action, and the positive normalized raw-demand deficit
falsification: reject if capture is slower than the parent without material load relief, wake coherence degrades, posterior occupancy exceeds 76.41%, or force/moment RMS exceeds 0.01574/0.00810

The candidate's CFD result is not claimed here; it becomes evidence only after
this worker exits.
