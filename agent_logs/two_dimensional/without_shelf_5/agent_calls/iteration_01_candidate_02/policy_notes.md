# Multi-Wake Policy Candidate Notes

## Evidence diagnosis

- The assigned parent is the fresh target-blind oscillator; no inherited
  optimizer rollout logs are materialized in this workspace beyond the one
  sampled solver evaluation.
- The shared prewarm sheet shows a developed four-cylinder staggered wake and
  the held fish at the common upper-right release pose. In the released sheet,
  the fish never enters the useful wake or target region: it first moves a
  short distance upstream-left, then yaws into a steep nose-down trajectory
  and exits through the lower boundary.
- The sampled metrics corroborate the visual failure. Termination occurs after
  only `50.1269` of the `300` release horizon, with head displacement
  `(-3.5452, -13.3003)L`, only `0.0243` progress, and minimum/final target
  distances `8.6150L` / `12.1226L`. Thus the brief upstream displacement is a
  useful propulsive mechanism, but it is overwhelmed by uncontrolled lateral
  turning rather than guided into the wake corridor.
- The gait also reaches both engineering caps: maximum joint rate is
  `4.5379 rad/time` (260 degrees/time) and maximum acceleration is
  `31.4159 rad/time^2` (1800 degrees/time^2), with mean command energy
  `1496.25`. The `0.55`-period, 28-degree seed should therefore not be made
  more vigorous before adding steering.
- There is only one sampled candidate, and it is the informative failure, so
  no positive cross-candidate ranking is possible in this generation. The
  hypothesis below is not claimed as evaluated evidence.

## Candidate hypothesis

Keep the state-feedback oscillator and lagged posterior target that produced
upstream motion, but reduce the nominal oscillation to a 24-degree amplitude
and 0.60 period to leave some joint-angle and rate headroom. Add a clamped mean
bend derived only from `state.bearing`, whose body-frame convention and bounded
scale are supplied by the task contract. A positive bearing receives a
negative mean bend on both joints; this should oppose the visually observed
downward yaw while remaining translation- and target-location-independent.
The posterior joint continues to follow the oscillatory component with a
velocity lag, so steering does not replace propulsion.

The next CFD evaluation should falsify this mechanism if the fish still exits
vertically without reducing bearing error, if the steering sign drives an
earlier lower-boundary exit, or if the modest gait reduction removes useful
upstream progress. Later workers should then change steering sign/gain or
restore propulsion separately rather than increasing all oscillator commands.
