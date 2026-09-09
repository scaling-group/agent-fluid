# Multi-wake target-policy candidate notes

## Evidence diagnosis

- The four sampled solver candidates, their policy files, and their released
  keyframe sheets are byte-identical. They therefore provide one deterministic
  finite reference, not four wake-robustness trials. All reach the target at
  `44.121`, with `1.70618L` mean distance, `0.748931L` final/minimum distance,
  and `-10.910/-4.263L` head displacement.
- The shared prewarm sheet shows the fish held above and downstream of a fully
  developed, interacting four-cylinder wake. After release, the fish produces
  a coherent traveling wake and moves diagonally upstream through the merged
  wake rather than merely following the local flow: mean body velocity in x is
  `-0.2470` while mean local-flow x is `-0.1848`, giving positive upstream
  motion relative to the water. The final two released frames show a downward
  approach followed by a corrective hook into the target; there is no sampled
  failure sheet to compare, so inherited failed/refined rollouts are the only
  negative contrast.
- The successful route is not low-authority. RMS lateral force/moment are
  `388.95/3908.93`, mean command energy is `1036.49`, maximum joint rates are
  `4.53786` rad/time (the configured `260 deg/time` cap), and maximum commanded
  accelerations are `28.79/28.39` rad/time^2 beside the candidate's `29.0`
  soft limit. Optional posterior emphasis can therefore ask for more tail
  motion precisely when the actuator has no rate headroom.
- Inherited step-17--19 evidence argues against modifying terminal route
  prediction again: suppressing an opposing heading forecast reached at
  `45.331` with `1.72584L` mean distance; an unsigned crossflow-times-yaw gate
  reached at `45.150/1.71930L` and raised force/moment RMS to `460/4421`; other
  shared-cap or closure-conditioned refinements reached at `45.69--46.07`.
  These all retain capture but are inferior to the current independently
  bounded body-course residual.

## Policy hypothesis

Preserve the oscillator, lagged posterior target, half-cycle steering,
yaw-magnitude steering gate, terminal time-to-go cap, and independent
body-course damper. Add one smooth actuator-resource allocator: compute joint
rate use relative to the oscillator's own `omega * amplitude` rate scale, and
apply the existing headroom signal to the *optional* aligned/progress posterior
emphasis with a nonzero floor. The base lagged traveling wave remains at scale
one, negative course feedback remains fully active, and target steering is not
rate-gated. This should reduce futile extra tail demand during rate-cap contact
without changing the evidenced diagonal route. It is not a scalar-only gait
tune; it changes when the optional propulsion residual is admitted.

bookshelf_consulted: true
source_domain: reactive fish propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve the posteriorly lagged propulsive wave while modulating only an extra gait envelope from measured state
transferable_invariant: protect the traveling-wave backbone and withdraw optional posterior drive when normalized actuator-state feedback shows no useful headroom
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot actuator dynamics, exact vortex phase, and task-specific routes
policy_translation: gate only aligned/progress posterior emphasis by a smooth function of max joint-rate use divided by the candidate-owned oscillator rate reference, with a nonzero residual floor; leave base lag, steering, and all body-frame route observations unchanged
falsification: reject if capture or the diagonal wake-entry topology is lost, or if arrival/mean distance worsens without a compensating reduction in command effort or force/moment load; also reject if rate-cap contact and effort remain materially unchanged

