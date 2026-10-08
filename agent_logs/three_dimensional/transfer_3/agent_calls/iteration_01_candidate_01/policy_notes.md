# Candidate wake-policy notes

## Inherited evidence diagnosis

- The only sampled solver, `solver_c61359212990`, is a direct-uniform
  still-water rollout (`U_infinity=0`, no cylinders or prewarm), so its motion
  is self-propelled rather than imposed advection. It ends `left_domain` at
  `27.4945T`, with distance changing from `12.3277L` to a useful minimum of
  `4.7800L` at about `17.85T`, then worsening to `9.7089L` at exit.
- The top-down sheet shows a coherent alternating wake and sustained forward
  translation through the useful segment. By `16-18T` the fish has crossed
  below the target, but the later frames show continued downward motion rather
  than a target-facing recovery. The oblique Lambda2 row confirms organized
  shed structures and a continuous body path, not a numerical breakup; its
  late path bends away from the target consistently with the top-down view.
- The useful finite segment is therefore broad approach plus propulsion, while
  the informative failure segment begins around closest approach: center
  `y/L` continues from about `7.91` to `0.80`, speed remains near `0.8U`, and
  heading grows from about `0.70` to `1.31 rad`. This is excess off-axis drive
  with inadequate persistent redirect, not coasting or loss of thrust.
- The raw inherited acceleration request exceeds the `1800 deg/T^2` envelope
  in about `70.5%` of joint-1 and `77.5%` of joint-2 samples; the two joint
  speeds reach the `260 deg/T` limit in about `8.2%` and `10.3%` of samples.
  The visually coherent wake is worth preserving, but the clipped carrier and
  large beat-scale heading swings make small additive steering corrections a
  poor source of mean turning authority.
- No inherited optimizer notes are present in this fresh workspace. The
  assigned guidance says to preserve useful measured transfer and replace a
  missing capability with bounded normalized body-frame feedback, which here
  means retaining a posterior-lagged carrier while changing the way target
  error becomes mean curvature.

## Candidate hypothesis

Use one small compatible mechanism: an alignment-gated C-start-like redirect
embedded in a state-feedback traveling-wave oscillator. Body-frame bearing and
normalized target-vector angle set a signed head-joint equilibrium; the
posterior target receives a same-sign, larger absolute-tangent bias so the two
joints form coordinated mean curvature rather than relying on a small
acceleration residual against a saturated carrier. Large observed
misalignment continuously reduces oscillation amplitude to reserve actuator
authority for redirect; as alignment returns, the bias and relief vanish and
the posterior-emphasized traveling wave resumes. An internal command guard is
below the evaluator's hard acceleration limit and is intended as a rare safety
boundary, not the gait generator.

Expected measurable change: after the first below-target crossing, bearing-led
curvature should make mean heading turn back toward the target before the fish
reaches the lower virtual boundary, while maintaining a coherent wake and
continued distance progress. The rollout should show substantially less raw
acceleration clipping than the inherited `70.5%/77.5%` rates.

Reject this translation if it destroys self-propulsion, produces persistent
guard-limited commands or joint-limit dwell, turns in the same wrong direction
after positive body-frame target bearing, or merely delays the same
`left_domain` trajectory without improving minimum distance or termination.

bookshelf_consulted: true
source_domain: biological fast-start turning plus robotic-fish target-modulated CPG control
source_mechanism: large observed heading error creates bounded whole-body mean curvature, then releases into a posterior-emphasized traveling beat as alignment returns
transferable_invariant: separate redirecting mean curvature from propulsive oscillation and continuously reserve actuation for the redirect when target misalignment is large
nontransferable_details: species-specific C-start shape and timing, published CPG gains, dimensional cadence, exact tail amplitudes, and any prescribed route or vortex phase
policy_translation: normalized body-frame target geometry shifts both joint equilibria into coordinated signed curvature, gates oscillator amplitude, and otherwise retains a state-derived posterior phase lag
falsification: reject if the post-crossing heading does not reverse toward the target, propulsion collapses, command limiting remains persistent, or joint/load histories become less stable
