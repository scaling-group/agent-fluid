# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no prewarm) and terminate in `capture` at
  `18.865--19.052T`. The top-down rows show self-propelled, target-directed
  motion with a coherent alternating wake through capture; the oblique rows
  show persistent compact caudal Lambda2 structures rather than advection or
  wake collapse.
- The strongest finite score is the approach-amplitude-relief composition
  (`-0.21057`, `19.052T`, mean distance `2.09874L`), while the weakest is one
  terminal-lateral-velocity composition (`-0.21654`, `18.865T`, mean distance
  `2.10468L`). Their visible route and both wake views are materially alike.
  Two byte-identical terminal-lateral-velocity policies span
  `18.865--19.008T` and scores `-0.21654` to `-0.21164`, so differences of this size do
  not identify a better scalar setting or terminal residual.
- The three sampled compositions all retain the same response-release gate
  and half-cycle steering. Their public acceleration is already projected,
  but it remains at the envelope on about `60.7--61.1%` of anterior and
  `73.1--73.4%` of posterior rows, with joint-rate contact around
  `10.7--11.0%` and `14.7--15.2%`. Terminal amplitude relief does not establish
  load relief: it still contacts the rate limit and is slightly slower than
  the sampled clean half-cycle/response-gate rollout (`18.881T`).
- Assigned-parent guidance and inherited logs already reject direct
  instantaneous velocity residuals and show that adding a yaw-response
  qualifier to the captured carrier preserved capture but worsened arrival,
  mean distance, and rate contact. The new evidence does not rescue either
  qualifier. It instead supports isolating the evidenced actuator-side
  half-cycle mechanism from those route-side additions.

## Policy hypothesis

Use normalized body-frame lateral target fraction as the sole persistent turn
request. Preserve the sampled opposite-sign anterior/posterior mean curvature,
the joint-state oscillator and posterior lag, and the exact final acceleration
projection. Redistribute that curvature by the observed anterior displacement
half-cycle, but remove terminal lateral-velocity lead, distance scheduling, and
yaw-response release. This should preserve the coherent captured route while
removing two instantaneous route modifiers that inherited evidence found
neutral or harmful. Reject the hypothesis if evaluation loses capture, leaves
the `18.865--19.052T` / `2.0987--2.1047L` sampled band without a compensating
load improvement, increases saturation, or disrupts either wake view. Because
the present samples do not include the resulting clean composition, no CFD
improvement is claimed in advance.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and mean-curvature turning
source_mechanism: target-directed half-cycle amplitude asymmetry superposed on a propulsive rhythm
transferable_invariant: infer beat side from joint state and bias bounded turn authority toward the useful half-cycle while preserving the traveling wave
nontransferable_details: published gains, clock-driven CPG phase, species kinematics, dimensional frequency and amplitude, exact wake phase, and task routes
policy_translation: map normalized body-frame lateral target fraction to bounded opposite-sign joint curvature and scale both shares by bounded anterior-joint displacement phase
falsification: reject if capture is lost, route or load metrics fall outside the sampled capture band without benefit, saturation rises, or the top-down street or oblique caudal structures lose coherence
