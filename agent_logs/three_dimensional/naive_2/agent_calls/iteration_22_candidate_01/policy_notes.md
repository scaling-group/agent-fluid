# Evaluated lateral-residual capture candidate

## Visual and metric diagnosis before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  capture. They are two exact pairs rather than four independent mechanisms.
  The prefilled one-sided speed-guard carrier captures at `16.609995T`, score
  `-0.115560`, and scored distance integral `1.999656L`; the distinct
  lateral-residual pair captures at `16.604496T`, score `-0.113729`, and
  distance integral `1.998146L`.
- I inspected both rows of the combined keyframe sheets for a lateral-residual
  rollout and its speed-guard comparator. The top-down rows show self-propelled
  targetward translation and a coherent alternating vorticity street from
  release through the shallow target crossing. The oblique rows show finite,
  compact, tail-connected three-dimensional Lambda2 structures. Neither pair
  shows passive advection, wake breakup, collision, or instability, and the
  route and wake class are visually preserved. There is no semantic failure in
  the sampled set, so the weaker captured carrier is the controlled comparator.
- The completed lateral observer removes fitted anterior-phase sway only from
  posterior course and relative-crossflow cues. Its two exact rollouts improve
  arrival by one `0.0055T` step and the scored distance integral by `0.001510L`
  without changing capture class. This is a narrow route benefit, not an
  efficiency benefit: relative to the prefill, peak planar force/moment rise
  from `0.035828/0.017759` to `0.037165/0.018356`, speed-near-limit residence
  increases slightly, and joint-2 acceleration-near-limit residence rises from
  `35.40%` to `36.50%` under a final-one-percent reconstruction.
- The assigned parent log supplies a completed negative control. Adding an
  approach-only phase-demodulated line-of-sight-rate feedforward to the same
  lateral-residual carrier retained capture and the connected two-view wake,
  and arrived marginally earlier at `16.598995T`, but worsened score to
  `-0.118996`, scored distance integral to `2.002387L`, and terminal distance
  to `0.749034L`. Earlier threshold crossing alone therefore does not validate
  an additional kinematic rate command; this child is rejected rather than
  gain-tuned.

## Sole candidate hypothesis

Promote the completed lateral-residual policy as this workspace's only
candidate. Preserve the full anterior traveling-wave oscillator, raw-course
anterior center, mean-preserving yaw demodulator, posterior half-cycle steering,
and one-sided speed guard. Add only the evaluated approach-gated observer from
the sampled best pair: reconstruct the carrier's body-lateral sway from the
centered anterior joint angle and velocity, subtract it from the velocity used
by posterior course feedback, and add it consistently to relative crossflow.

This is bounded, clock-free, reflection-equivariant state feedback using
normalized body-frame observations and the two-joint contract. The evidence
supports repeated nominal capture with the same wake class and a small
distance/arrival improvement over the prefill. It does not support stronger
actuation, LOS-rate feedforward, or robustness claims. Falsify reuse if capture
or wake connectivity is lost, the residual remains carrier-correlated, the
target-crossing arc changes materially, or the observed force, moment, speed,
and acceleration tradeoff grows beyond the sampled narrow benefit.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-disturbance residual control
source_mechanism: preserve rhythmic propulsion while feedback acts on directional motion after internally generated carrier motion is separated
transferable_invariant: remove beat-synchronous body-frame self-motion from a measured route response before that residual drives bounded steering
nontransferable_details: published gains, species or robot kinematics, dimensional beat frequency, exact vortex phase, prescribed routes, and task-specific maneuver timing
policy_translation: on approach reconstruct carrier sway from centered anterior joint angle and joint velocity, then use residual lateral velocity and consistent relative crossflow only in posterior feedback while leaving the full two-joint carrier unchanged
falsification: reject if capture, distance integral, target arc, or connected wake worsens, if carrier correlation remains, or if the sampled saturation and force/moment tradeoff grows

## Evaluation boundary

No CFD result is claimed for this unevaluated workspace. The favorable evidence
belongs to the two completed sampled lateral-residual rollouts. Later evaluation
should require capture and the same top-down/oblique wake class first, then
compare arrival, scored and observed distance integrals, residual phase
correlation, joint contact, speed and acceleration residence, mean action, and
peak force/moment against both the prefilled speed-guard carrier and the
rejected LOS-rate child. A fixed-case repeat does not establish held-out pose or
flow robustness.
