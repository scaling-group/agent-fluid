# Course-agreeing target-ray residual candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled solvers are exact copies of the strongest finite policy and
  trajectory. They satisfy the frozen direct-uniform still-water contract with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, and capture at `16.93205T`.
  The replicated reference scores `-0.20004481`, has mean distance
  `2.08513L`, and crosses at `0.74389L`.
- I inspected the combined keyframe sheet and both view-specific sheets for
  that replicated reference, then compared both views with the assigned
  parent's completed target-ray-rate continuation. From release through
  capture, the top-down sheets show continuous target-directed translation and
  a coherent alternating red/blue street. The oblique sheets show compact
  caudal Lambda2 structures through the capture sphere. Neither trajectory is
  passively advected or exhibits a held-joint coast, wake collapse, collision,
  boundary exit, or numerical instability. The reference trace supports the
  visual diagnosis: peak fish speed is `1.391U` while peak sampled local flow
  is only `0.03270U`.
- The assigned parent added a symmetric terminal feedforward residual from the
  point-consistent matched-window target-ray rate
  `turn_rate_recent - bearing_window_rate`. It still captured slightly sooner
  at `16.92622T`, but regressed to score `-0.20442999`, mean distance
  `2.08866L`, and crossing distance `0.74814L`. Its whole-trace joint-angle,
  joint-speed, force, moment, yaw-rate, fish-speed, and local-flow maxima are
  unchanged from the replicated reference. The visually identical wakes and
  unchanged mechanical extrema make this an allocation failure, not a loss of
  propulsion or safety.
- The parent's non-CFD overlap audit shows why a narrower test is available:
  the symmetric rate residual strengthened the established course request in
  only 86 of its 222 terminal samples and relaxed it in the other 136. This
  lineage has separately shown that collision-corridor steering relief and
  same-sign instantaneous-yaw amplification both regress. The new candidate
  therefore must neither infer that steering is redundant nor use beat-scale
  yaw as target motion.

## Single-candidate policy hypothesis

Preserve the four-times-sampled reference's zero-centered anterior oscillator,
lagged posterior carrier, full body-frame velocity-course loop, posterior
acceleration reserve, C1 acceleration envelope, high-onset positive-power
speed guards, one-sided target-signed measured-yaw work allocation, receiver
speed taper, and posterior stopping-risk projection. Add one bounded terminal
sensor-residual mechanism: estimate inertial target-ray rotation with the
matched-window identity already calibrated by the inherited traces, but
project its correction onto the sign and magnitude of the assembled
velocity-course request. An opposing correction becomes zero rather than
withdrawing demonstrated steering; an agreeing correction is capped by both
its own bound and the base request. The distance, swimming-speed, and
forward-target gates keep the broad route and folded-bearing region unchanged.

This tests whether target-ray motion is useful only as a one-sided confirmation
of the established course loop. Expect the same broad route and coherent wake,
capture, no new joint contact, and better mean/crossing distance than the
symmetric parent's `2.08866L/0.74814L`; seek an improvement over the replicated
reference's `-0.20004481/2.08513L` without exceeding `0.5993 rad` posterior
excursion or `0.0370/0.0184` force/moment. Falsify the mechanism if it loses
capture, changes states outside `2.25L`, relaxes or reverses the base course
request, degrades the alternating three-dimensional wake, or fails to improve
distance quality without a compensating semantic or mechanical benefit.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and biological terminal approach
source_mechanism: preserve the propulsive rhythm while bounded target-relative feedback updates only compatible directional work
transferable_invariant: a slower target-motion observation may confirm an established rhythmic steering request, but should not cancel useful course feedback unless cancellation is separately evidenced
nontransferable_details: published gains, dimensional rates, species-specific kinematics, full-body CPG networks, prescribed stages, exact vortex phases, capture radius, and task-specific routes
policy_translation: form matched-window target-ray rate from normalized body-frame observations; apply a bounded near-target residual only after projecting it onto the sign and magnitude of the existing velocity-course signal, leaving both joint carrier dynamics and every allocation and viability layer unchanged
falsification: reject if broad-route equivalence, capture, or alternating three-dimensional shedding is lost; if the residual ever weakens the base course request; or if score, distance integral, crossing depth, joint viability, posterior angle, or force/moment loads regress without a new semantic benefit
```

No formal CFD is run in this worker. The candidate's rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Replaying the new observation and agreement projection over the replicated
reference's 3,079 recorded states changes 86 samples, from `15.718T` and
`2.243L` through capture. It changes zero samples at or beyond `2.25L` and
zero samples in a direction opposing the base velocity-course request. The
applied steering-signal increment peaks at `0.02430 rad`, below its
parameter-owned `0.03 rad` bound; 61 changed samples are positive and 25 are
negative. This confirms a non-inert, one-sided terminal sensor-residual test,
not a scalar carrier edit or a replay of the symmetric 222-sample parent. The
projection does not evolve the fish or fluid and is not evidence for the
unevaluated candidate's CFD outcome.
