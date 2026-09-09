# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The assigned parent is the fresh-lineage guidance and the sampled solver is
  the same target-blind state-feedback seed currently prefilled in `solver/`.
  No inherited optimizer note exists in this workspace; the sampled optimizer
  contributes only the unchanged parent guidance and a baseline Elo of 1500,
  so it supplies no comparative controller result.
- The shared prewarm sheet shows the held fish at the upper-right start while
  all four vortex streets develop across the target corridor. This is common
  initial-condition evidence, not a candidate effect.
- In the released sheet, the best finite portion is samples 2--3: the fish is
  self-propelled leftward and briefly reduces target range. Samples 4--6 are
  the informative failure: the body yaws nose-down into an almost vertical
  descent, continues large alternating bends, misses the cylinder-wake/target
  region, and crosses the lower domain margin. There is no visible collision
  or useful wake entry before exit.
- The diagnostics agree with that reading. Minimum distance is `8.61495L`, but
  final distance rebounds to `12.1226L` and progress is only `0.02425` at a
  `left_domain` termination after `50.1269` released time. Head displacement
  is `(-3.54522L, -13.3003L)`. Mean velocity y (`-0.26333`) is close to mean
  local-flow y (`-0.24141`), while mean relative-flow y is only `0.02192`, so
  most of the catastrophic descent is consistent with advection that the seed
  does not reject. At the same time, RMS relative crossflow is `0.17470`, RMS
  moment is `541.704`, and both joints exactly reach the configured velocity
  and acceleration caps (`4.53786 rad/time` and `31.4159 rad/time^2`). Command
  energy mean is `1496.25`. Thus the early upstream displacement is worth
  preserving, but the saturated target-blind rhythm is not a stable steering
  mechanism.
- The evaluation log reports that the sampled parameter contract passed and
  contains no policy-runtime error; the result is a physical control failure,
  not a materialization failure.

## Candidate hypothesis

Keep the seed's autonomous joint-state oscillator, but center it on a smooth,
bounded mean-curvature command proportional to the normalized body-frame target
bearing. A positive bearing receives positive posterior curvature; this should
produce the opposing yaw needed to stop the observed bearing divergence, while
the command reverses automatically after an overshoot and does not encode a
world direction, target coordinate, route, or clock. Distribute the steering
bias across both joints and retain the posterior phase lag so propulsion and
steering are not separate bang-bang modes.

Use a `0.75` control period, `22 deg` oscillator amplitude, and smaller tail lag
than the seed. Their nominal harmonic velocity and acceleration stay below the
formal `260 deg/time` and `1800 deg/time^2` caps, addressing the sampled exact
cap contact without deleting the demonstrated upstream gait. Bound total mean
curvature at `16 deg` and apply it through a `tanh` bearing response so wake
spikes cannot request a discontinuous steering step.

The next CFD rollout should falsify or support this hypothesis by whether the
fish avoids the early near-vertical descent, remains in-domain beyond `50.1`
time units, improves final/mean range, and no longer touches both joint-rate
caps. An earlier bearing divergence or lower exit would indicate that the mean
curvature sign is wrong; low cap use coupled to little upstream displacement
would indicate that the retuned rhythm removed too much propulsion. The new
candidate has not yet been evaluated, so neither outcome is claimed here.
