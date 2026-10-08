# Wake-policy candidate notes

## Visual and metric diagnosis

- All four sampled rollouts use direct uniform `U_infinity=(0,0,0)`
  initialization without cylinders or prewarm. Their translation is
  self-propulsion, not advection. In every top-down row the traveling carrier
  sheds a coherent alternating signed-vorticity street, and the oblique rows
  confirm persistent three-dimensional Lambda2 structures through the broad
  approach.
- The closest sampled result reaches `2.999L`; the continuously beating
  half-cycle redirect reaches `3.013L`; the two distance-conditioned carrier
  reductions reach `3.162L` and `3.592L`. All four miss high, hook toward the
  upper boundary, and terminate `left_domain`, so neither freed actuator
  reserve nor preserved cycling has supplied capture authority.
- The distributed-bend case makes the failure especially visible: after its
  large-error gate engages, both joints settle near `(-0.175,-0.209) rad`, the
  oblique wake stops receiving strong alternating structures, and the body
  coasts from a `2.999L` pass to the upper boundary. The distance hold likewise
  becomes nearly static. These are active-redirection failures caused by lost
  hydrodynamic cycling.
- The half-cycle candidate is the stronger diagnostic because it keeps the
  anterior rhythm and alternating wake. At `16T`, its full-quadrant target
  bearing is about `-0.815 rad` and body angle is `+0.096 rad`; at `20T`, they
  are about `-2.115` and `-0.297 rad`. Its negative turn request creates a
  negative posterior mean bend while the body angle decreases, which makes
  the target-angle error more negative. The same reinforcing polarity appears
  in the other sampled trajectories. Thus the repeated upper hook is not just
  inadequate gain: the demonstrated posterior bend-to-yaw sign is opposite
  the sign assumed by the target-to-curvature map.

## Policy hypothesis

Keep the zero-centered anterior oscillator and full posterior traveling
carrier unchanged. Recover signed full-quadrant target angle from normalized
`target_body_L`, retain the evidenced body-frame lateral-slip residual, and
reverse the residual-to-posterior-mean-curvature polarity. This makes measured
target angle and cross-target slip negative feedback instead of the observed
reinforcing loop. Do not add a distance gate, damping schedule, anterior
equilibrium shift, carrier attenuation, or clocked mode.

The next rollout should retain the coherent far-field wake while body angle
moves opposite the signed target error and prevents the post-crossing bearing
runaway. Falsify the candidate if bearing magnitude grows under the corrected
command, broad progress or alternating shedding collapses, closest distance
does not beat `2.960L`, actuator-limit occupancy worsens materially, or the
same upper-boundary exit occurs without a meaningfully different trajectory.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and target-vector mean-curvature control
source_mechanism: observed direction error continuously modulates a bounded bend around an intact rhythmic carrier
transferable_invariant: close the steering loop with the empirically calibrated bend-to-yaw polarity, keep target error in normalized body coordinates, and preserve the traveling propulsive wave
nontransferable_details: published gains, species-specific joint envelopes, dimensional frequencies, exact vortex phases, clock phase, and task-specific routes
policy_translation: form a bounded full-quadrant target-angle-minus-body-slip residual and apply its negative, as required by the sampled posterior-bend/yaw response, only to the posterior mean-curvature channel around the unchanged joint-state carrier
falsification: reject if the commanded curvature does not reduce signed target error, wake coherence or broad progress degrades, the `2.960L` closest approach is not improved, or the upper-exit topology persists
