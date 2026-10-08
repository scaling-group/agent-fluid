# Wake-policy candidate notes

## Inherited and sampled evidence

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders, and no prewarm.
  The observed translation, yaw, and wakes are therefore self-generated.
- The body-frame lateral-slip controller (`solver_fc78cfbb9251`) remains the
  strongest useful trajectory. Its top-down row shows an alternating signed
  vorticity street through the approach, and its oblique row shows coherent
  three-dimensional Lambda2 structures. It survives `26.637T`, improves mean
  distance to `7.684L`, and approaches to `2.960L`, but passes about `2.87L`
  above the target and exits the upper boundary.
- The inherited distance/alignment relief, full envelope relief, and
  approach-hold descendants do not improve that trajectory class: closest
  distances are `3.162L`, `3.032L`, and `3.592L`, and all still exit high.
  Their combined sheets preserve the early propulsive wake, while the most
  strongly damped approach-hold sheet loses the alternating wake by about
  `17T` and then visibly coasts into the same upward arc. Thus drive relief
  alone is not terminal acquisition.
- The approach-hold trace provides an actuator-polarity experiment that the
  inherited reasoning missed. From `17T` to `20T`, the anterior carrier is
  effectively absent (`mean(abs(q1))=0.005 rad`,
  `mean(abs(qdot1))=0.06 rad/T`) while target bearing averages `-1.222 rad`,
  posterior joint angle averages `-0.209 rad`, and yaw rate averages
  `-0.222 rad/T`. The held posterior bend and the resulting yaw have the same
  sign, whereas every sampled policy maps negative bearing/slip demand to a
  negative bend under the assumption that it will create positive corrective
  yaw. The active map therefore reinforces the large bearing error.
- The same sign relation survives the active carrier rather than being a
  single coasting artifact. Over `17--20T`, all four samples have mean bearing
  between about `-1.22` and `-1.31 rad`, mean posterior bend between
  `-0.181` and `-0.209 rad`, and mean yaw rate between `-0.198` and
  `-0.231 rad/T`. This explains why three distinct drive schedules changed
  speed and effort but not the upper-exit topology.

## Policy hypothesis

Return to the evidenced lateral-slip carrier and make one structural change:
reverse the polarity from bounded bearing-minus-lateral-velocity demand to
posterior mean curvature. The joint-state Van der Pol oscillator, posterior
lag, amplitudes, limits, and slip residual remain unchanged. The correction is
body-frame and reflection-equivariant; it does not add a world direction,
route, clock, approach stage, or larger gain.

The corrected sign should initially turn with, rather than against, the target
geometry and should reverse mean yaw when the bearing becomes negative instead
of holding the sampled negative-bend/negative-yaw feedback loop. Retain the
mechanism if bearing remains contained, the coherent alternating wake and
leftward propulsion survive, and closest approach beats `2.960L` or the
termination class improves. Falsify it if the mean yaw response under a
one-signed steering interval does not reverse, if initial target progress is
lost, or if the trajectory mirrors the old miss into the opposite boundary.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking with a propulsive CPG and tail-beat bias
source_mechanism: map observed target geometry to a bounded mean bend superposed on a separately sustained rhythmic carrier
transferable_invariant: target-relative steering requires an empirically correct polarity between normalized body-frame lateral error and the swimmer's mean yaw response while preserving the propulsive rhythm
nontransferable_details: published gains, actuator sign conventions, species-specific kinematics, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: preserve the sampled joint-state oscillator, posterior lag, and bearing-minus-slip signal, but negate the posterior mean-curvature map because the carrier-suppressed rollout shows bend and mean yaw have the same sign
falsification: reject if coherent propulsion or initial progress collapses, corrected mean yaw does not reduce bearing, closest approach does not beat 2.960L, or the old upper miss is merely reflected into an opposite-boundary exit
