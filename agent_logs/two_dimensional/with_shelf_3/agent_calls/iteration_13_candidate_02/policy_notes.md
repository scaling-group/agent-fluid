# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. It is the certified common
  initial condition and does not establish candidate-specific wake selection
  or robustness to a different shedding phase.
- The two ungated samples are behavior-equivalent: both immediately redirect
  toward the target, sustain a posterior-traveling body wake, clear the
  cylinders, and cross the `0.75L` target circle on one compact diagonal at
  `32.472` release time. Head displacement `(-10.912,-4.332)L` greatly exceeds
  mean local flow `(-0.197,-0.189)`, confirming self-propulsion rather than
  passive advection. Their mean distance is `1.64761L`, score is `0.224538`,
  and force/moment RMS are `68.70/931.60`.
- The response-release sample preserves the same visible productive topology
  while capturing at `32.1365`, improving release time by `1.03%`, mean
  distance by `0.65%`, and score by `4.48%` relative to the ungated samples.
  Force/moment RMS also fall by `2.15%/2.59%`. This is positive evidence that
  verified targetward heading plus shrinking bearing can safely withdraw a
  bounded part of distributed mean curvature after the gait develops.
- The trajectory-supervised posterior-headroom sample also preserves the
  direct route and captures at `32.3400`; it has the best sampled score
  (`0.234663`) and reduces force/moment RMS by `5.20%/4.62%` from the ungated
  controller. Nearly unchanged relative crossflow (`0.24372` versus `0.24511`)
  and similar head displacement rule out simple wake avoidance or coasting.
  It instead supports yielding only the optional `8%` posterior asymmetry when
  coherent closure and reinforcing actuator motion are both observed.
- All three mechanisms still touch both velocity and acceleration limits, so
  aggregate peak values do not establish improved saturation residence. No
  failure keyframe is present; the adverse boundary remains the inherited
  unrestricted bearing-trend controller, which erased the traveling bend and
  exited downstream, plus the extra-posterior-burst result, which arrived
  later with higher loads.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking combined with posterior reactive-propulsion models
source_mechanism: modulate slow steering offsets and an optional asymmetric residual from measured route response while preserving a lagged posterior traveling rhythm
transferable_invariant: persistent body-frame target geometry should set turn direction, and verified targetward response may withdraw optional steering authority, but the unit-gain traveling wave and posterior lag must remain active
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator ratings, prescribed maneuver timing, and source-task routes
policy_translation: combine the evidenced response gate on distributed mean curvature with the evidenced trajectory-supervised actuator-headroom gate on only the target-helping posterior residual; use normalized bearing, joint-state, previous-action, and body-frame target-history scales
falsification: reject if capture or the compact diagonal topology is lost, release time exceeds `32.3400`, mean distance exceeds `1.63773L`, loads exceed the response-release branch without a navigation benefit, or later wake phases expose switching, propulsion loss, or increased saturation residence

## Candidate hypothesis

Produce exactly one candidate as a small combination of the two independently
successful yielding mechanisms. Start from the response-release controller,
which has the fastest sampled capture, and add the trajectory-supervised
posterior-headroom gate that produced the best sampled score and lowest loads.
The first gate can withdraw at most `18%` of the bounded distributed curvature
only after developed-gait, correct-sign heading, and shrinking-bearing checks.
The second can withdraw only the optional target-helping posterior gain when
target-vector motion is coherent closure and posterior state/action already
reinforce the requested wave.

The filtered bearing, `12 deg` total-curvature envelope, bearing-conditioned
`40/60 -> 35/65` allocation, anterior state-feedback oscillator, posterior lag
and damping, and unit-gain posterior wave remain unchanged. The combination
does not add a burst, alter the gait from elapsed time, use fixed geometry, or
suppress base propulsion. Downstream CFD must determine whether the two
one-sided gates retain the response branch's early capture while recovering
the headroom branch's load reduction; no same-worker outcome is claimed.
