# Rear-sector response-following reacquisition candidate

## Visual and metric diagnosis before the edit

- All four assigned examples and the inherited completed rollouts use direct
  uniform still-water initialization with `U_infinity=[0,0,0]`, no cylinders,
  and no prewarm. In the compared assigned sheets (`4482...`, the best scalar
  score, and `9295...`, the closest assigned approach), the top-down rows form
  coherent alternating vortex streets and the oblique rows retain
  tail-connected three-dimensional Lambda2 structures. The fish are
  self-propelled. Every assigned policy nevertheless follows the same high-side
  route and leaves through the upper boundary after approaching only
  `4.530--5.126L`; the failure is directional response, not advection, wake
  collapse, or numerical instability.
- The empirically calibrated yaw-response carrier in the inherited logs is the
  useful route mechanism. Mapping posterior curvature request to opposite-sign
  physical yaw reached `2.299L` at `18.41T`; response-deficit posterior
  half-cycle attenuation improved that to `2.169L` at `18.45T`, reduced
  reconstructed acceleration near-limit residence from `55.0%` to `52.4%`,
  and retained comparable force/moment peaks (`0.0335/0.0170`). The latter is
  the strongest inherited first approach, but it still receded to `7.727L`
  and left through the upper boundary at `28.04T`.
- At that `2.169L` minimum the target is still forward in body coordinates
  (`[-0.738,-2.039]L`), so its later failure is not evidence for perturbing the
  first approach. The target crosses the head's transverse plane about
  `0.75T` later at `2.306L`; after the crossing the route request remains near
  saturation while the short-window physical yaw repeatedly has the opposite
  sign. The controller therefore spends its remaining posterior authority
  fighting an already-established yaw rather than choosing a feasible
  rear-sector turn and reacquiring the target.
- Two completed curvature additions falsify applying more of the same route
  sign before or at the miss. The assigned parent's closure-loss posterior
  burst worsened the calibrated carrier's `2.299L` minimum to `3.254L`, reached
  the `45` degree joint limit, raised near-limit acceleration residence to
  `60.9%`, and raised peak planar force/moment to `0.0450/0.0206`. The sibling
  response-released anterior shift worsened its `2.169L` parent to `2.931L`
  and exited high at `24.79T`. Both visual sheets keep a finite alternating
  wake, so their regression is actuator competition rather than instability.

## Single policy hypothesis

Start from the strongest completed response-deficit controller: preserve its
full anterior state-feedback oscillator, posterior lag, calibrated
posterior-curvature-to-yaw convention, bounded mean curvature, crossflow
residual, approach-aware anterior course redistribution, and response-gated
posterior half-cycle attenuation. Add one terminal branch-selection mechanism
which is exactly silent while the target remains forward. Only when the target
is rearward in normalized body coordinates, radial closure is lost, forward
speed is established, and measured yaw is opposite the original requested
response, blend the route command toward the actuator-coordinate command that
continues the already-established physical yaw. Simultaneously release the
small anterior course center back toward the full zero-mean carrier. When the
target becomes forward again or the original response recovers, the gate
vanishes continuously and ordinary pursuit resumes.

This does not add curvature to a saturated actuator and does not shed the
traveling wave. It chooses the dynamically available U-turn branch only after
the inherited first miss, allowing a second approach instead of continuing to
fight yaw until the same upper exit. Replaying the gate algebra on the
completed `2.169L` history makes it identically zero through the first minimum
and until the target becomes rearward; afterward its mean is about `0.175` and
its maximum is about `0.729` near `20.08T` at `2.653L`. This establishes
localization and boundedness, not a counterfactual CFD result.

Expected result: preserve the inherited deep first approach and connected
alternating wake, then complete a response-aligned turn that makes the target
forward again and creates a second approach or capture instead of monotonic
recession. Falsify the mechanism if the first minimum degrades, the gate chatters
into loss of the carrier, joint/load residence rises materially, or the target
never returns to the forward sector before another upper-boundary exit.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: choose a bounded redirect from observed directional response and release it into the propulsive rhythm when geometry is recovered
transferable_invariant: preserve the rhythmic carrier while normalized target sector and measured response select a feasible turn branch, with continuous release when the target becomes forward again
nontransferable_details: species-specific C-start shape, published gains and frequencies, robot geometry, prescribed maneuver duration, exact vortex phase, and task-specific routes
policy_translation: retain the two-joint calibrated pursuit carrier; only for a rearward receding target and wrong-sign measured yaw, blend posterior route request toward the command consistent with that yaw while releasing anterior course bias
falsification: reject if the inherited first approach or coherent wake is lost, if loads or joint-limit residence worsen, or if rear-sector selection fails to make the target forward again and produce capture, re-approach, or a better termination class

## Evaluation boundary

No CFD outcome is claimed for this candidate. The later evaluation should
compare capture and termination first, then preservation of the first minimum,
rear-to-forward target-sector crossings, re-approach count and depth,
post-minimum recession, acceleration and joint-limit residence, force/moment
peaks, and both visual rows.
