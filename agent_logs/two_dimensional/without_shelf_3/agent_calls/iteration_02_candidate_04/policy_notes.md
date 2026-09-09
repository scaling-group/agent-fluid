# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis

- The assigned parent is the fresh-lineage guidance augmented only with the
  target-blind seed's negative result. The inherited optimizer notes proposed
  several first-generation steering laws but did not claim their then-pending
  CFD outcomes; the sampled evaluations now supply those outcomes.
- The shared prewarm sheet shows the fish held at the upper-right release pose
  while all four cylinder streets develop through the target corridor. It is
  identical initial-condition evidence, not a controller effect.
- The strongest finite sampled rollout is the `0.75`-period, `22 deg` gait with
  positive body-frame bearing curvature. Its released sheet shows genuine
  leftward self-propulsion, but also repeated large reorientation and a folded
  terminal shape before `unstable_dynamics` at `33.06` released time. It moves
  `-3.59L` upstream with only `+0.15L` lateral displacement and improves range
  from about `12.42L` to `9.21L`, yet never reaches the useful target/wake
  region. The compact diagnostics agree: mean velocity x is `-0.149` versus
  local-flow x `-0.077`, so the upstream component is active; however both
  acceleration caps are reached, joint 1 reaches the rate cap, and RMS force-y
  and moment-z rise to `20023.6` and `314391`.
- The target-blind seed is the most informative longer physical failure. Its
  sheet shows a steep descent out the lower boundary after `50.13` time, with
  `(-3.55,-13.30)L` head displacement. Its `8.61L` transient minimum rebounds
  to `12.12L`; mean lateral velocity `-0.263` nearly follows local flow
  `-0.241`, and all joint rate/acceleration caps are touched. Thus visible
  bending and transient approach are not wake rejection.
- Two sampled negative-curvature steering variants turn away from the target
  corridor: the radially regulated variant stays low-load and below the action
  caps but moves `( +2.74,-2.32 )L` at the head and exits after `15.86` time;
  the bearing-rate variant becomes unstable after `1.66` time with essentially
  no progress. An inherited negative-curvature plus heading-rate variant also
  exits downward with `( +0.98,-13.25 )L` displacement. These architectures
  are not controlled sign-isolation tests, but together they make reversing
  the only progress-producing positive curvature direction a poor next step.
- Cross-checks use each example's `wake_metrics.csv` and the
  `wake_diagnostics` object exported in `wake_observation.json`; no standalone
  diagnostics file is present in this rendered workspace. Evaluation stdout
  and inherited notes report materialized policy contracts, so these are
  physical control failures rather than missing-field or policy-load errors.

## One candidate hypothesis

Retain positive bounded bearing curvature, but reduce its gain and limit so the
fish keeps some of its initially useful downward-left attitude instead of
overcorrecting into the strong reorientations visible in the best rollout. Add
a small opposing body turn-rate term to arrest continued yaw without encoding
a world direction, target coordinate, route, or clock.

Use the stable sibling's phase-radius oscillator regulation and split steering
shape, while slowing the gait to a `0.90` period and reducing amplitude to
`18 deg`. The nominal first-joint harmonic speed and acceleration are about
`2.19 rad/time` and `15.3 rad/time^2`, comfortably below the configured
`4.54` and `31.42` caps before feedback transients. Keep the posterior
velocity lag for active upstream propulsion, but use critical posterior
damping and a `12 deg` steering limit to reduce the fold/load route to
instability.

The next CFD evaluation supports this hypothesis only if the fish preserves
negative relative-flow x, remains finite and in-domain beyond `50.13` time,
adds useful negative-y travel without a near-vertical escape, and improves
distance while avoiding persistent cap contact and large load spikes. It is
falsified by renewed folding/instability, downstream motion like the
negative-curvature siblings, lower-boundary escape, or a conservative but
non-propulsive horizon miss. No outcome for this new candidate is claimed in
this worker.
