# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The four sampled shared-prewarm sheets are byte-identical. They show the
  fish held at the upper-right release pose while the four staggered cylinder
  streets develop and merge through the target region. This is the certified
  common initial condition, not a candidate effect.
- The two `1700 deg/time^2` policies and released sheets are mutually
  byte-identical, as are the two `1650 deg/time^2` policies and sheets. Both
  variants visibly make an initial target-facing turn, actively swim left and
  down under a dense periodic trail, enter the merged wake late in the
  traverse, and capture without collision, domain exit, or instability. The
  `1650` route has advanced farther by corresponding intermediate frames and
  reaches the ring sooner. Its mean body velocity `(-0.3289,-0.1367)` differs
  materially from mean local flow `(-0.1840,-0.1909)`, especially in useful
  leftward motion, so this is self-propulsion rather than passive advection.
- The CSV and embedded wake diagnostics agree with the pictures. Relative to
  exact `1700`, exact `1650` improves score from `0.159531` to `0.189303`,
  arrival from `34.331` to `33.027`, mean distance from `1.7137L` to
  `1.6831L`, command energy from `45153` to `42310`, and power from `3390` to
  `3183`. The active posterior maximum moves from `29.671` to
  `28.798 rad/time^2`, and posterior excursion falls from `0.509` to `0.495`
  rad. The tradeoff is adverse wake loading: relative-crossflow RMS rises from
  `0.2312` to `0.2358`, force RMS from `54.48` to `63.93`, and moment RMS from
  `766.14` to `859.31`; the anterior acceleration and both joint-rate
  envelopes remain touched.
- No sampled rollout is a semantic failure, so `1700` is the informative
  adverse finite comparator. Inherited optimizer notes provide the failed
  mechanism boundary: a `27`-degree amplitude probe visibly fell behind and
  regressed to `38.214/1.812L` and `53078/3978` energy/power despite lower
  loads. Earlier gain, allocation, lag, and damping continuations were
  non-monotonic, and mixed auxiliary feedback became unstable at `2.807`.
  Those axes and the observation set therefore remain fixed.

## Single-candidate hypothesis

Continue only the replicated posterior acceleration-bound sequence by one
equal `50 deg/time^2` step, from `1650` to `1600 deg/time^2`. Preserve the
`0.55`-period, 28-degree oscillator, lag `0.75`, damping `0.65`, bounded
body-frame bearing gain `1.7`, 12-degree steering limit, fraction-`0.35`
allocation, and existing observations. The two exact `1650` evaluations show
that the previous continuation reproducibly improved navigation and effort;
this candidate tests the next boundary and does not claim that tighter bounds
are generally better or that they unload the fish.

The later CFD evaluation supports `1600` only if it preserves the visible safe,
self-propelled turn-then-diagonal capture and materially improves on the
`1650` navigation/effort anchor (`0.189303` score, `33.027` arrival,
`1.6831L` mean distance, `42310/3183` energy/power) without a disproportionate
load increase. Loss of capture or route, collision, exit, instability, failure
to improve navigation/effort, relative crossflow above `0.25`, force RMS above
`75`, or moment RMS above `1000` rejects further tightening. Even a positive
result applies only to the certified wake phase and start pose until held-out
wake or geometry evidence exists. No current-worker CFD outcome is assumed.
