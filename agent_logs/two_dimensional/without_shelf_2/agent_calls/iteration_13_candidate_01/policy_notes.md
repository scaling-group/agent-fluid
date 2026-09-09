# Multi-wake candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while four developed, asymmetric vortex streets fill the route
  to the target. It is common initial-condition evidence, not a policy result.
- All four current sampled rollouts reach the target; no current failure sheet
  is available. The informative comparison is therefore the three identical
  `oscillator_energy_gain=2.1` rollouts against the assigned-parent/prefill
  `2.2` rollout. The released sheets show both controllers turning down and
  left from the release, entering the developed wake corridor, and making a
  compact final approach from the right without collision, domain exit,
  coiling, or visibly wasteful lateral wandering.
- The motion is materially self-propelled rather than pure advection. At gain
  `2.1`, mean velocity x is `-0.14784` while mean local-flow x is `-0.08219`,
  giving `0.06565` upstream-relative x speed. At gain `2.2` this separation
  falls to `0.06006`. Both trajectories use bounded joint motion and converge,
  but both acceleration commands contact the `28` guard, so extra restoration
  authority is not a free increase in useful thrust.
- The isolated increase from `2.1` to `2.2` produces no visible route benefit
  and regresses every aggregate measure relevant to this comparison: arrival
  `73.86 -> 77.73`, mean distance `2.480L -> 2.541L`, command energy
  `51797 -> 55790`, RMS force `24.94 -> 26.42`, RMS moment
  `410.68 -> 423.30`, and upstream-relative x speed
  `0.06565 -> 0.06006`. The score likewise falls from `-0.5806` to `-0.6390`.
- The assigned optimizer log contains a separate target-reaching result with
  faster `72.70` arrival and lower energy/load but worse `2.511L` mean distance
  and `-0.6125` score. Because the inherited log does not include that
  candidate's policy or parameter attribution in this workspace, it is a
  Pareto reference only and does not justify reconstructing or mixing an
  unidentified mechanism.

## Policy hypothesis

Change only `oscillator_energy_gain` from the dominated prefill value `2.2`
to the exactly evaluated `2.1` value. Preserve period, requested orbit,
bearing feedback, posterior response, damping, and both `28` acceleration
guards so the candidate does not confound the demonstrated energy-gain effect
with route-sensitive guard, steering, or damping changes. On the common wake
snapshot this should recover the compact target-reaching route near the
replicated `73.86` arrival and `2.480L` mean distance while lowering effort and
load relative to `2.2`. This is falsified if reevaluation fails to reproduce
finite compact capture or if a held-out wake condition removes the `2.1`
advantage; no such held-out evidence is available here.
