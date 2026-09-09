# Multi-Wake Candidate Diagnosis

## Evidence scope

The assigned parent guidance is still the fresh-lineage guidance, and no
inherited optimizer log is present in this workspace. The only sampled solver
is the finite naive-seed rollout `solver_82b05fa0d389` (score `-14.294201`,
`left_domain`). It is therefore both the best available finite example and the
informative failure; there is no successful or near-miss sample from which to
claim a positive mechanism.

The shared prewarm sheet shows the common held fish at `(21,14)L`, well to the
right of four developed, interacting vortex streets and of the target behind
the second cylinder row. The released sheet shows brief leftward advance
followed by large heading excursions and a tight downward path that never
enters the target/wake corridor, ending through the lower boundary without a
collision.

This visual reading agrees with the compact and heavy diagnostics:

- release lasts only `50.1269` of `300` time units;
- head displacement is `(-3.545,-13.300)L`, while closest approach is only
  `8.615L` and final distance rebounds to `12.123L`;
- the fish is closest near `t=31.94`, then turns away and descends;
- both joint accelerations reach the `1800 deg/time^2` limit and occupy at
  least 99% of that limit for about 62% and 65% of trajectory samples;
- RMS lateral force and yaw moment are high (`21.94` and `541.70`), consistent
  with wasteful lateral/rotational loading rather than controlled approach;
- the `0.55` control period is about 33 times faster than the estimated
  shedding frequency, so the seed cannot be described as wake-synchronized.

The evidence supports a concrete negative result: preserving this
target-blind, acceleration-clipped rhythm is not a viable navigation policy in
the current release. It does not isolate lack of target feedback from excessive
frequency as the sole cause, so both changes below remain a coupled hypothesis.

## Candidate hypothesis

Replace the seed with one bounded, target-aware state oscillator:

- increase the control period to reduce acceleration clipping and command
  effort while retaining a self-propelled traveling bend;
- center the first-joint oscillator on a saturated body-frame bearing command,
  with bounded heading-rate damping to resist the observed yaw excursions;
- have the second joint follow the oscillatory part of the first joint with a
  velocity lag and a smaller share of the steering center, so steering does not
  destroy the posterior traveling wave;
- use only `bearing`, `heading_rate`, `phi`, and `phi_dot`; do not use global
  coordinates, elapsed time, target identity, prescribed inflow, or remote flow
  probes.

Every propulsion and steering gain, scale, limit, and damping coefficient will
be returned by `target_policy_params()`. The expected signature is materially
less acceleration saturation, bounded heading response that reduces bearing,
survival beyond `50.1` release units, and continued leftward progress into the
second-row target corridor. A renewed lower-domain exit with growing bearing
falsifies the steering sign or gain; survival with weak distance progress and
low effort instead falsifies the slower/low-amplitude propulsion setting.
