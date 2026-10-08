# Candidate wake-policy notes

## Evidence diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, and capture termination. The samples form
  two replicated behaviors rather than four independent trajectories: v33 is
  present twice and the behavior shared by v34/v37 is present twice.
- Both combined keyframe sheets were inspected from release through capture.
  Their top-down rows show self-propelled motion with a coherent, alternating
  reverse-street-like wake rather than ambient advection. Their oblique
  Lambda2 rows show the corresponding three-dimensional alternating structures
  staying attached to the translating fish trajectory. The fish turns toward
  the target and reaches it without wake collapse, boundary contact, or an
  instability precursor. No failed visual artifact is sampled in this
  workspace, so v33 is the least-favorable finite comparator rather than a
  fabricated failure case.
- The v33 replicas capture at `23.84252T`, mean distance `2.433543L`, and final
  distance `0.746165L`. The v34/v37 behavior captures at `23.83702T`, mean
  distance `2.433468L`, and final distance `0.746096L`. Thus the distributed
  two-joint rate observer supplies a small reproducible progress improvement,
  but the nearly indistinguishable sheets and unchanged termination class do
  not establish a semantic trajectory improvement.
- Within `3L`, v34/v37 slightly reduce mean absolute yaw/cross-track speed from
  v33's `1.67999 rad/T`/`0.23924U` to `1.67939 rad/T`/`0.23868U` and peak
  moment from `0.013730` to `0.013581`; peak yaw instead rises from `3.18484`
  to `3.19386 rad/T`. The rate observer is therefore retained but not treated
  as a complete terminal-load remedy.
- A separate, actionable limitation survives every sample. V34/v37 spends
  `11.58%` of the full rollout at the anterior `260 deg/T` velocity cap and
  `4.59%` at the posterior cap; the corresponding inside-`3L` exposures are
  `10.32%` and `8.15%`. Its anterior normalized joint-speed percentiles are
  `0.895` at p75 and `1.0` from p90 onward, while projected acceleration peaks
  reach `31.26` and `31.39 rad/T^2`. The visually productive wake therefore
  coexists with repeated kinematic clipping and little acceleration headroom.

## Policy hypothesis

Preserve v34's target geometry, response-released C-bend, posterior traveling
lag, command projection, terminal course brake, and distributed yaw observer.
Add one reflection-symmetric state-feedback mechanism: use the maximum absolute
two-joint speed normalized by the owned physical velocity limit to smoothly
reduce oscillator cadence only in the near-cap envelope. Start the governor
above the measured p75 anterior speed so ordinary carrier motion is unchanged;
apply modest full-load relief so the controller backs away from futile hard
clipping without coasting or changing steering polarity. This is a dynamic
envelope governor, not a scalar-only retune.

Expected evidence: retain capture and the coherent alternating wake while
reducing joint-velocity-cap exposure and projected command effort. Reject the
mechanism if capture/progress falls outside the v33-v34 range, either visual row
loses wake coherence, terminal yaw/cross-track/moment worsens, or velocity-cap
exposure does not materially fall.

## Structured bookshelf transfer

```text
bookshelf_consulted: true
source_domain: sensor-feedback modulation of robotic-fish CPG locomotion under actuator constraints
source_mechanism: measured locomotor state continuously modulates a rhythmic command while leaving the coupled gait structure intact
transferable_invariant: use normalized proprioceptive envelope pressure to soften rhythmic drive before hard saturation, preserving the traveling-wave coordination that produces thrust
nontransferable_details: published oscillator equations, gains, dimensional cadence, robot morphology, species kinematics, exact vortex phase, and task route
policy_translation: compute a bounded load from the maximum normalized two-joint speed and smoothly droop the existing state-feedback oscillator frequency only near the measured velocity cap
falsification: reject if capture or coherent alternating wake regresses, if yaw/load histories worsen, or if joint velocity-limit exposure and command effort fail to decrease
```

