# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet is common initial-condition evidence: the held fish
  starts above and downstream of the target while four developed, overlapping
  cylinder streets occupy the second-row target corridor. In every released
  sheet the fish remains above and to the right of that corridor. It makes a
  diagonal leftward leg, bends sharply nose-up after its closest approach, and
  exits the upper boundary without wake entry. The unresolved regime is thus
  far-field course recovery, not wake exploitation or `0.75L` capture.
- The duplicated `behind_bearing_fraction=-0.25` anchor is modestly
  self-propelled: its mean head x velocity is about `-0.0596L/time` versus
  mean local flow `-0.0454`, and it moves `(-4.44,+1.78)L`. It remains finite
  for `74.48` released time and reaches `6.63L`, but then opens to `9.43L`
  final range and exits. Its progress is `0.241`, RMS force/moment are
  `76.8/1030`, and inherited diagnostics put the anterior joint near
  `254 deg/time` while the posterior stays near `191 deg/time`.
- The sampled `-0.125` midpoint is the strongest navigation result in the
  current set, though not a recovery. Relative to `-0.25`, it improves score
  from `-11.286` to `-11.241`, head-x travel from `-4.44` to `-4.55L`,
  minimum/mean/final range from `6.63/9.45/9.43` to
  `6.61/9.42/9.36L`, progress from `0.241` to `0.247`, and RMS force/moment
  from `76.8/1030` to `75.9/1004`. Its lifetime falls to `69.85`, and its
  sheet still makes the same nose-up upper exit. This supports `-0.125` as a
  better approach baseline, not further rearward-bearing interpolation.
- Delaying an extra `-0.25` bearing reversal until the target is at least one
  body length rearward also fails to change the visible topology. It extends
  lifetime slightly to `75.88`, but versus the `-0.25` anchor it reduces
  upstream travel to `-4.32L`, worsens score to `-11.379`, mean/final range
  to `9.52/9.54L`, and progress to `0.232`, while raising RMS force/moment to
  `78.1/1072`. Together with inherited negative full/zero/`-0.50` rearward
  bearing, added turn damping, conditional overspeed damping, full-circle
  target-vector bearing, and short-window opening attenuation, this rules out
  another bearing, damping, or simple range-sign continuation.

## Candidate hypothesis

Use the evaluated `-0.125` policy unchanged during its demonstrated closing
leg. Add one bounded terminal structure: when the normalized target projection
is more than `1L` rearward and both the current and eight-observation range
rates show opening faster than `0.02L/time`, smoothly unload only the anterior
steering bias from `0.35` to `0.10` of the steering command. Keep the posterior
bias at its evaluated `0.65`, and leave the oscillator, bearing gain, `12 deg`
ceiling, fixed `0.04` turn damping, joint guards, and acceleration limiter
unchanged.

The trigger is more specific than abeam crossing or the sign of a short range
window, so it should be inactive throughout the useful approach. The control
mechanism is distinct from the failed global steering attenuation and
rearward speed-damping tests: it targets the anterior joint that alone nears
the hard speed cap, while the posterior joint retains measured speed headroom
and the established traveling bend. The hypothesis is supported only if the
candidate retains roughly `-4.5L` upstream travel and a `6.7L` or better
approach, then delays or removes the upper return without exceeding the
sampled `76/1005` RMS load scale. It is falsified if the gate erodes the
closing leg, repeats either boundary return, fails to reduce the anterior
excursion, worsens final/mean range, or raises loads. The policy uses only
normalized body-frame target geometry, normalized range rates, joint state,
and measured recent turn; it contains no coordinate, clock, route, prescribed
inflow, remote wake probe, target-station signal, or omitted-shelf dependency.
Its CFD result is deferred to EvE and is not claimed as current evidence.
