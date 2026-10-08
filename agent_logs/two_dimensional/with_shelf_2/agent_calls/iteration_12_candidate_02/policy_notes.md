# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while the four cylinder streets develop and merge around the
  target. The mature wake and initial pose are therefore common evidence, not
  a controller difference.
- Every current sampled solver reaches the target. Their released sheets show
  active self-propulsion: the fish immediately lays down a traveling wake,
  follows a continuous diagonal down-left path through the interacting streets,
  and makes a broad late correction before capture. For the strongest sampled
  course-convergence policy, upstream displacement divided by release time is
  about `-0.242`, exceeding the mean local-flow x component `-0.174`; the route
  is not passive advection. No sampled failure sheet is available, so failure
  topology below is taken only from inherited notes and metrics, not presented
  as a newly inspected visual result.
- The prefilled course-convergence controller reaches at `45.61` with score
  `0.158830`, mean distance `1.72215L`, total/mean command energy
  `46916/1028.61`, and force/moment RMS `453/4406`. The inherited evaluated
  joint-rate-headroom variant keeps the same visible diagonal capture, arrives
  earlier at `45.10`, holds mean distance to `1.72267L`, lowers total energy to
  `46677`, and lowers force/moment RMS to `414/4104`. Its slightly lower score
  `0.157432` and higher per-time command-energy mean `1034.97` make this a
  route/load tradeoff, not evidence for more amplitude, but the shallower
  `-4.38L` lateral displacement versus `-4.73L` agrees with reduced over-turn.
  Wake diagnostics also show slightly smaller peak bend and acceleration, but
  both policies still touch both `4.538` joint-rate caps; headroom scheduling is
  not yet evidence of rate-limit avoidance.
- A sibling that instead multiplied the entire course residual by the existing
  yaw-moment steering gate is a concrete negative comparison: it still reaches,
  but regresses to score `0.150759`, arrival `45.84`, mean distance `1.72999L`,
  and force/moment RMS `460/4433`. Reusing one load gate indiscriminately across
  steering and posterior progress feedback is therefore not supported.
- The most informative inherited hard failure remains broad propulsive-priority
  allocation: it passed below capture and collided at `58.93`, with `1.872L`
  closest approach and `537/4995` force/moment RMS. A closure-conditioned phase
  shift also retained capture but regressed arrival/mean distance to
  `46.22/1.735L`. These boundaries rule out weakening route composition or
  another posterior timing edit from the present evidence.

## Candidate hypothesis

Materialize the evaluated joint-rate-headroom architecture as the single
candidate. Preserve the zero-centered anterior oscillator, lagged posterior
wave, predicted-bearing half-cycle steering, yaw-magnitude steering gate,
body-speed-normalized positive-closure residual, and smooth acceleration limit.
Normalize the larger observed joint-rate magnitude by the candidate-owned
`omega * amplitude` scale and smoothly withdraw only positive course-convergence
amplification as rate usage rises. Negative course trend continues to suppress
the small closure-earned tail residual fully; high joint-rate use never earns
more propulsion, and neither the base wave nor target-steering authority is
reduced.

The post-worker CFD rollout falsifies this materialization if it loses
`target_reached` or the diagonal topology, materially exceeds the simpler
positive-closure `1.724L` mean-distance baseline, fails to retain the inherited
headroom variant's earlier arrival and lower load relative to the prefill, or
returns the below-target collision topology. Fixed-snapshot success would not
establish robustness to changed wake phase, inflow, cylinder layout, or target.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and wake-interaction control
source_mechanism: preserve the propulsive rhythm while normalized feedback schedules a small auxiliary residual according to available actuator headroom
transferable_invariant: withdraw only extra route-progress amplification when observed joint-state usage is high, while preserving the base traveling wave and corrective steering
nontransferable_details: published gains, dimensional rates, robot linkage geometry, species-specific kinematics, exact vortex phases, cylinder locations, and task-specific routes
policy_translation: normalize maximum joint rate by the candidate's oscillator rate-amplitude scale and gate only positive bearing-convergence amplification of the closure-earned posterior residual; retain worsening-course suppression and the two-joint base law
falsification: reject if capture or the useful diagonal route regresses, if mean distance exceeds the simpler closure baseline, or if earlier arrival and lower hydrodynamic load do not survive without new limit symptoms
