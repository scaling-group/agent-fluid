# Multi-Wake Candidate Diagnosis

## Evidence read before editing

- The shared prewarm sheet shows the common held fish near the upper-right
  boundary while four developed cylinder wakes convect toward it; the target is
  diagonally upstream and lower, between the second-row wakes. This is common
  initial-condition evidence, not a candidate response.
- The prefilled target-blind `0.55`-period, `28 deg` gait is visibly carried
  into a nearly vertical lower-domain escape. Its diagnostics agree: head
  displacement is `(-3.55,-13.30)L`, mean local flow is
  `(-0.041,-0.241)`, both joint rates and accelerations reach their hard
  limits, command-energy mean is `1496`, minimum distance is only `8.61L`, and
  final progress is `0.024`.
- The strongest finite sample uses a `0.90`-period, `28 deg` oscillator and a
  positive, posterior-only `10 deg` bearing bias. Its keyframes show genuine
  diagonal motion toward the target before a broad upward curl and boundary
  exit. It improves survival from `50.13` to `73.39`, progress from `0.024` to
  `0.132`, and minimum distance from `8.61L` to `6.34L`; near-zero mean local
  flow with upstream head displacement `-2.73L` supports self-propulsion rather
  than favorable advection. The useful approach is not stable, however: the
  posterior joint reaches `45 deg`, both joint rates reach `260 deg/time`, both
  commands reach the candidate's `1650 deg/time^2` clamp, and RMS force/moment
  rise to `196/2014` before the loop.
- The lower-authority `1.10`-period, `14 deg`, positive posterior-bias sample
  avoids large loads but moves `+2.45L` downstream, never gets closer than the
  initial `12.42L`, and exits after `19.22`; propulsion cannot be reduced that
  far. The anterior-equilibrium steering sample is the opposite boundary: it
  curls at release and becomes unstable after `1.52`, with RMS force/moment
  `61379/660629`. The inherited `9d66` result also warns that a later attempted
  repair did not preserve the strong sample's upstream motion (`+0.08L` head x,
  progress `-0.062`, exit at `45.62`), so rate damping is not evidence-backed
  as a standalone cure and must remain modest.

## Candidate hypothesis

Use the strong sample's `0.90`-period posterior-only steering architecture and
positive bearing sign, but reduce oscillator amplitude from `28` to `22 deg`
and posterior lag from `0.80` to `0.70`. With the same period this retains much
more drive than the failed `14 deg`/`1.10` combination while reducing the
nominal posterior excursion that reached the joint stop. Form the steering
argument from clipped body-frame bearing plus a small positive multiple of the
short-window bearing rate. When a positive bearing is already falling, the
rate term reduces the positive bias before crossing zero; when bearing error is
growing, it adds bounded corrective lead. Keep this damping outside the
anterior propulsion oscillator, cap it before the nonlinear steering map, and
lower the command clamp to `1450 deg/time^2`.

The candidate is supported only if it retains diagonal upstream motion and a
minimum-distance improvement over the seed while surviving beyond `73.39`
without posterior angle/rate saturation or the broad upper loop. It is
falsified if desaturation removes upstream progress (as in the weak gait), if
the bearing-rate term increases switching/load or repeats the inherited
`9d66` regression, or if the positive posterior sign still drives an
upper/lower boundary curl. Later evaluation, not this worker, determines that
outcome.
