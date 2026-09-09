# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- All four sampled rollouts are valid direct-uniform still-water evaluations
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. In both
  rows of the combined sheets, each fish visibly self-propels and sheds a
  body-connected alternating wake; none of the motion is passive advection or
  a numerical-instability failure.
- The response-gated shared half-cycle controller `solver_a4eae6d626b3` is the
  strongest finite example. Its top-down row shows the longest coherent
  leftward track and the oblique row retains a staggered three-dimensional
  Lambda2 wake through `10.32T`. Metrics agree: it reaches `9.759L`, versus
  `11.359L` for fixed shared asymmetry, `11.977L` for posterior-only phase
  scaling, and `11.683L` for the inherited course-residual/rate-barrier
  controller. It is therefore the mechanism to preserve, not merely the
  highest scalar score.
- The improvement is still not semantic. Every sample exits at center
  `y=15.20L`; the best fish accelerates left but also rises from `14.0L` to the
  upper boundary while target bearing changes from `+0.118` to sustained
  negative excursions as large as about `-0.5 rad`. Its mean/max speed is
  `0.453/0.948 L/T`, and both joint rates occupy the hard-limit neighborhood
  about `5.4%` of samples. The inherited rate barrier removes hard-rate
  occupancy but lowers mean speed to `0.279 L/T`, regresses closest distance
  to `11.643L`, and repeats the identical boundary exit. Rate suppression is
  thus a concrete negative result: reserve obtained by braking the carrier is
  not useful control reserve here.
- The body yaw response is dominated by the propulsive phase, so feeding raw
  yaw rate back as if it were a slow course measurement is poorly conditioned.
  Across all four sampled trajectories, yaw rate has `0.899--0.956` absolute
  correlation with anterior joint rate. A common least-squares carrier model
  using both joint rates reduces yaw-rate RMS from `1.23--1.86` to
  `0.12--0.28 rad/T`; the residual mean remains negative, matching the visible
  upper-exit drift. This supports phase compensation rather than stronger raw
  rate damping or another carrier-gain edit.

## Single candidate hypothesis

Restore the strongest sampled response-gated shared half-cycle controller and
add one carrier-phase-compensated yaw-response mechanism. Estimate the
beat-scale yaw from the two observed joint rates, subtract it from observed
heading rate, and feed only the bounded residual into the body-frame bearing
and lateral-response turn request. Correct-sign residual yaw releases the
half-cycle bias; wrong-sign residual yaw strengthens it, while the evidenced
traveling carrier and wrong-side-slip redirect remain unchanged. This should
retain the best rollout's coherent wake and leftward propulsion while arresting
the slow negative-yaw drift after bearing crosses zero.

Falsify the candidate if closest distance does not beat `9.759L`, if it repeats
the upper-boundary exit without a materially longer target-directed trajectory,
if phase compensation reduces speed toward the `0.279 L/T` rate-barrier
failure, or if joint-rate/load behavior or wake coherence worsens. The current
worker cannot claim the new CFD result; later workers must test these bounds.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and asymmetric flapping
source_mechanism: sensor feedback modulates beat-side amplitude while rhythmic state separates locomotor phase from slower directional response
transferable_invariant: retain a posteriorly lagged propulsive bend, steer through bounded half-cycle asymmetry, and release or reinforce it using body response after removing the joint-phase-correlated yaw component
nontransferable_details: published gains, clock phase, robot linkage geometry, species kinematics, dimensional frequencies, exact vortex phases, and task-specific paths or maneuver timing
policy_translation: use normalized body-frame bearing and lateral velocity for the evidenced redirect, estimate carrier yaw from the two joint rates, and add only a bounded phase-compensated heading-rate residual to the two-joint half-cycle request
falsification: reject if coherent leftward propulsion falls, closest distance fails to beat 9.759L, hard-rate occupancy worsens, or the upper-boundary termination repeats without meaningful delay
