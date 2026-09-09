# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The assigned parent guidance separates useful propulsion from navigation:
  the target-blind seed briefly moved upstream but was then carried down the
  lower wake branch, while the unguarded positive-bearing angle-only gait was
  the first controller to sustain active upstream travel before its body folded
  and the dynamics became unstable. The inherited notes also show that two
  full-orbit radial regulators stayed low-load but moved downstream with the
  local flow, so replacing the demonstrated angle-only oscillator is not
  supported.
- The shared prewarm sheet shows the same held fish above and to the right of
  the target while four developed, overlapping vortex streets fill the route
  from release to the second-row target. It is common initial-condition
  evidence. No sampled released sheet reaches the useful cylinder corridor, so
  the present decision remains a far-field course/stability test rather than a
  wake-capture law.
- The unguarded `0.75`-period positive-bearing policy visibly straightens into
  a sustained upstream leg, moving its head `(-3.59,+0.15)L` with mean x
  velocity `-0.149` versus local flow `-0.077`. Its `9.01L` minimum and `0.259`
  progress are genuine active approach, but the final sheet shows a severe
  fold. Diagnostics agree: joint-one speed and both acceleration commands hit
  the hard caps, and RMS force/moment rise to `20024/314391` before instability
  at `33.06` released time.
- Restoring that gait with terminal joint guards kept active upstream motion
  and remained finite, but the current prefill still turned upward outside the
  wake and exited after `47.35` time. Its head moved `(-2.45,+1.73)L`; maximum
  speed/acceleration reached `4.25 rad/time` and `29.65 rad/time^2`, and RMS
  force/moment remained `350/5007`. Protection prevented the catastrophic fold
  but did not supply a convergent diagonal course.
- The sampled `0.04` opposing recent-turn-rate candidate is the strongest
  finite result. Its sheet preserves an active upstream body wave, reaches the
  closest sampled range of `6.71L`, moves its head `(-4.08,+1.80)L`, and stays
  finite for `65.47` time. Joint angles remain `0.568/0.453 rad`, accelerations
  `27.78/25.54 rad/time^2`, and RMS force/moment `66.5/958`, all far below the
  folded failure. However, the last two frames show the fish reverse through a
  broad upward turn and leave the domain without entering the target/wake
  corridor; its joint-one speed still reaches `4.36 rad/time`. Thus the small
  yaw-damping term is finite and compatible with propulsion, but its sampled
  magnitude does not arrest the visible late course excursion.

## One candidate hypothesis

Start from the strongest finite sample and change only its recent-turn-rate
damping gain from `0.04` to `0.08`. Keep its `0.75`-period, `22 deg` angle-only
oscillator, posterior traveling lag, `12 deg` bounded positive-bearing law,
joint guards, and smooth `1600 deg/time^2` action shoulder exactly unchanged.
Doubling the opposing yaw term should matter primarily during the rapid broad
turn visible late in the rollout; it vanishes when turn rate is small and the
outer `tanh` continues to bound steering, so the evidenced upstream gait is not
globally weakened.

The policy uses only body-frame bearing, current heading rate exposed as
`turn_rate_recent`, and joint state. It adds no coordinates, route, target
identity, clock, prescribed inflow, or unavailable wake probe. The next CFD
evaluation supports the hypothesis only if negative head-x displacement and
the finite low-load gait survive while upward displacement and late heading
reversal shrink, minimum/final distance improve, or the fish stays in-domain
long enough to enter the wake corridor. It is falsified if stronger damping
again produces an upper exit, erases active upstream motion, drives persistent
steering saturation, or recreates growing joint/load excursions. No outcome
for this unevaluated candidate is claimed here.
