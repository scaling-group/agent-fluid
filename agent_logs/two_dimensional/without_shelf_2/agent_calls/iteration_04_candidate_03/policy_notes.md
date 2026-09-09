# Candidate wake-policy diagnosis

## Evidence read before editing

- The shared prewarm sheet establishes the same held fish, staggered four-
  cylinder layout, target, and developed interacting vortex streets for every
  sample. Differences after release are therefore candidate-specific under
  this common snapshot.
- The static-bearing `5a92cf19c4c6` policy (`gain=0.55`, `limit=8 deg`)
  visibly self-propels leftward, turns through a broad loop below the target,
  enters the downstream wake corridor, and reaches the `0.75L` target radius
  in `130.23` release-time units. Its `0.9397` progress, mean velocity/local-
  flow x values of `-0.0835/-0.0455`, and finite RMS force/moment
  `26.34/427.54` agree with the visual diagnosis.
- The otherwise identical assigned-parent sample `1d009cf43d90` adds a
  bounded `0.10`-horizon bearing-window-rate lead. Its keyframes show initial
  target approach followed by a tight reversal and a large loop back to the
  right boundary; it never enters the useful cylinder-wake region. The
  trajectory has minimum distance `9.749L` but finishes at `13.964L`, overall
  progress `-0.1240`, and mean velocity/local-flow x `+0.0139/+0.0362`, so its
  long motion is not sustained upstream propulsion. It exits the domain after
  `158.42` units despite modest RMS force/moment `19.44/310.48`.
- The best finite sample `0b64bef95ee2` removes derivative steering and raises
  static bearing authority to `gain=0.70`, `limit=10 deg`. Its keyframes show
  an earlier, shallower turn and a shorter route into the wake/target than the
  `0.55/8 deg` anchor. It reaches in `91.61` units with mean distance `2.834L`
  versus `3.516L`, while mean upstream velocity relative to local flow grows
  from `0.0380` to `0.0515`. RMS force/moment rise to `38.81/550.75`, but the
  reported maxima (`|phi|=0.550/0.441 rad`, `|phi_dot|=3.203/3.224`, and
  candidate-clamped `|phi_ddot|=28`) remain finite and inside the configured
  joint envelope.
- Inherited parent logs reinforce the boundary: a weak early controller was
  advected out after `16.73` units with no distance improvement, while a
  higher-amplitude sign-reversal attempt became unstable in `4.45` units with
  RMS relative crossflow `3.139` and force/moment `5.50e4/5.68e5`. The
  successful energy-regulated gait and positive static steering sign should be
  retained; neither raw rate lead nor sign/amplitude reversal is justified.

## Single candidate hypothesis

Remove `bearing_window_rate` entirely and retain the evaluated successful
`0.75`-period, `22 deg` energy-regulated traveling-bend gait. Cautiously extend
the successful static-bearing trend to `gain=0.80`, `limit=11 deg`: this should
reduce the remaining early S-shaped detour visible in the `0.70/10 deg` run
without introducing a derivative-dependent turn reversal. The extra one-degree
center bound leaves nominal anterior oscillation plus steering well below the
`45 deg` joint envelope. The hypothesis is falsified if evaluation loses target
reach, increases the low/right loop or mean distance, or produces materially
higher load/saturation without earlier capture.
