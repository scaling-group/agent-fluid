# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is the certified common initial
  condition, not evidence that any candidate selected a wake phase or is
  robust to a changed phase.
- All four sampled released sheets reach the target on the same compact
  diagonal. They show immediate targetward redirection, a persistent
  posterior-traveling body wake, ample cylinder clearance, and nose-first
  entry into the `0.75L` capture circle. For the best sampled branch, mean fish
  velocity `(-0.3362,-0.1404)` versus mean local flow
  `(-0.1961,-0.1918)` and head displacement
  `(-10.9149,-4.2375)L` confirm active upstream propulsion rather than
  passive advection. No released failure keyframe is sampled in this
  workspace; inherited downstream-exit results are therefore textual
  falsification boundaries, not new visual evidence.
- Three byte-identical trajectory-supervised headroom samples reproduce the
  strongest current result: target capture at `32.340`, mean distance
  `1.63773L`, score `0.234663`, force/moment RMS `65.12/888.56`, and maximum
  posterior excursion `0.57530 rad`. The prefilled combination of that
  supervisor with response-confirmed mean-curvature release also captures,
  but is slower at `32.4555`, has worse mean distance `1.64548L`, lower score
  `0.226804`, higher force/moment RMS `67.83/914.09`, and larger posterior
  excursion `0.58180 rad`. Its keyframes show no compensating route,
  clearance, or capture-topology difference.
- The inherited optimizer logs make the comparison causal enough for branch
  selection: progress supervision and response-confirmed curvature release
  each improved earlier controls independently, but their reproduced
  composition is worse than either component on navigation and loads. Both
  sampled branches still touch the joint velocity and acceleration ceilings,
  so neither the current metrics nor the visual trajectory supports adding
  authority. Inherited failures further rule out unrestricted bearing-rate
  recentering, blanket physical-limit damping, and another positive posterior
  burst.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation interpreted through posterior reactive propulsion
source_mechanism: retain a persistent traveling rhythm while slow sensory feedback supervises one optional tail residual
transferable_invariant: target geometry owns mean turn direction, the base traveling wave remains continuously active, and feedback may withdraw only bounded incremental steering authority during coherent targetward motion
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator ratings, source-task routes, and fixed approach distances
policy_translation: keep the filtered body-frame bearing and distributed mean-curvature request outside one normalized target-window trajectory-efficiency supervisor; use that supervisor only to permit turn-congruent posterior speed or acceleration pressure to reduce the optional eight-percent half-cycle residual
falsification: reject if target capture or the compact self-propelled diagonal is lost, arrival or mean distance regresses without a compensating load benefit, the base traveling bend weakens, or a changed wake exposes switching, saturation residence, or propulsion loss

## Candidate hypothesis

Produce exactly one candidate by promoting the three-times-reproduced
trajectory-supervised posterior-headroom branch and removing the prefilled
response-confirmed mean-curvature release. Preserve the filtered body-frame
bearing, bounded `12 deg` total-curvature request, bearing-conditioned
`40/60 -> 35/65` allocation, anterior state-feedback oscillator, posterior
lag and damping, and maximum `8%` target-helping half-cycle residual.

The sole slow supervisor normalizes nonnegative history-window closing speed
by total body-frame target-vector rate. Only coherent closure allows posterior
speed or previous-acceleration pressure, normalized by gait-owned scales and
checked for residual-reinforcing direction, to withdraw the optional residual.
Redirection, lateral target-vector motion, stalled closure, recession, absent
observations, and early padded history restore the successful ungated
residual. The mechanism cannot alter mean curvature or suppress the unit-gain
traveling wave. This is evidence-backed branch selection; downstream CFD must
evaluate the materialized candidate, and no same-worker improvement or
held-out wake robustness is claimed.
