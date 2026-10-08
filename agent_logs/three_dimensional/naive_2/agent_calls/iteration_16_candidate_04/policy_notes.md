# Low-forward-speed carrier-convergence candidate

## Visual and metric diagnosis before the edit

- All four sampled solver entries report direct-uniform still-water
  initialization with `U_infinity=[0,0,0]`, no cylinders, and no prewarm.
  They materialize the same policy and deterministic trajectory, so they are
  duplicate evidence of one completed behavior rather than four independent
  robustness trials.
- I inspected both rows of the sampled capture's combined sheet. The top-down
  row shows sustained leftward self-propulsion, a compact alternating vortex
  street, and the target entering the moving view before the head crosses it.
  The oblique row shows tail-connected three-dimensional Lambda2 structures
  through approach. The trace agrees: distance falls from `12.328L` to
  `0.748L` at `16.637T`, 98.1% of logged steps reduce distance, head-path
  tortuosity is about `1.10`, and cross-track displacement stays within about
  `-0.15--0.53L`. Route topology is no longer the principal deficiency.
- I also inspected both rows of the inherited closure-loss burst-redirect
  failure. Its top-down wake remains alternating and its oblique structures
  remain tail-connected, but the fish curves above the target, reaches only
  `3.254L` at `18.018T`, and exits through the upper boundary at `25.053T`.
  Its maximum cross-track displacement is about `6.74L`, and 30.3% of logged
  steps increase distance. This confirms that coherent wake appearance alone
  did not repair raw route-response semantics.
- The captured controller's joint-phase-demodulated yaw response is therefore
  protected. It produces a finite capture with maximum joint magnitude about
  `0.560 rad` and peak planar force/moment about `0.0369/0.0186`. Its remaining
  score opportunity is early propulsion: over `0--1T` and `1--2T`, mean
  body-forward speed is only about `0.003U` and `0.033U`, distance changes by
  only about `0.04L`, and anterior excursion grows only from about `9.2 deg`
  to `10.9 deg`. The established carrier reaches roughly `31 deg`, the
  `260 deg/T` joint-speed envelope, and materially useful forward response
  around `4--5T`. Later motion is already strongly closing and should not be
  re-routed.

## Single policy hypothesis

Preserve the completed capturing controller's amplitude, period, posterior
lag, normalized body-frame route geometry, phase-demodulated yaw response,
and phase-selective steering. Add only a low-forward-speed convergence channel
to the anterior state-feedback oscillator: when measured body-forward speed
is small, increase the Van der Pol amplitude-restoration coefficient; as
forward response develops, continuously return to the completed base
coefficient. The gate is a bounded function of normalized body-frame velocity,
not elapsed time or a launch-stage counter, so it can also re-engage after a
genuine loss of propulsion.

This changes the carrier's convergence rate without increasing its target
amplitude, changing its frequency, adding route curvature, or weakening the
full traveling wave. The expected result is earlier useful propulsion and a
smaller distance integral while retaining the demonstrated target crossing.
Falsify it if early distance progress is not improved, capture is delayed or
lost, the post-transient route differs materially, or joint-speed contact,
near-limit acceleration residence, force, or moment worsens beyond the sampled
capture's finite envelope.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and fish speed versus tail-beat kinematics
source_mechanism: use sensed locomotor response to modulate convergence of a low-dimensional rhythmic carrier while retaining its bounded steady gait
transferable_invariant: low normalized forward response can recruit faster convergence to the same propulsive rhythm, and the recruitment should release continuously once the response appears
nontransferable_details: published CPG gains, species-specific amplitudes and frequencies, dimensional swimming speeds, exact vortex phases, maneuver duration, and task-specific routes
policy_translation: use finite body-frame forward velocity to gate an added anterior oscillator restoration coefficient while leaving the established amplitude, period, posterior wave, and steering feedback unchanged
falsification: reject if the completed capture is not retained, early progress or arrival does not improve, or saturation, joint contact, wake organization, force, or moment materially worsens

## Evaluation boundary

The gate and its scales are a policy hypothesis only. No CFD result is claimed
for this candidate. Its later evaluation should compare capture, arrival time,
distance integral, progress over the first `2T` and `4T`, time to established
joint excursion and forward speed, route tortuosity, acceleration and
joint-speed residence, peak force/moment, and both wake views against the
completed `16.637T` capture.
