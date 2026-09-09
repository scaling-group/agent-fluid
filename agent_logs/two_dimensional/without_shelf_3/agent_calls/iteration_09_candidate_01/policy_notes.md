# Multi-Wake Candidate Diagnosis and Hypothesis

## Visual and quantitative diagnosis

- The shared prewarm sheet shows the held fish at the common upper-right
  release pose while the four developed cylinder streets overlap around the
  target. This is common initial-condition evidence, not a controller effect.
  Every released sheet keeps the fish to the right of the useful cylinder-wake
  corridor, so this candidate addresses far-field propulsion and course
  retention rather than claiming wake exploitation or capture behavior.
- The strongest finite sample is the guarded angle-only oscillator with a
  `0.75` period, positive-bearing gain `0.60`, fixed recent-turn damping
  `0.04`, and a `12 deg` steering ceiling. Its keyframes show a sustained,
  nearly horizontal upstream leg before a broad upper U-turn and top exit.
  The metrics confirm genuine self-propulsion rather than pure advection: mean
  x velocity/local flow are `-0.0673/-0.0457`, head displacement is
  `(-4.08,+1.80)L`, minimum range is `6.71L`, and RMS force/moment remain
  `66.5/958`. The fish never reaches the target or developed wake corridor.
- The assigned parent's range-gated damping increase preserves the visible
  upper-turn topology but shortens the upstream leg. Relative to the anchor,
  head-x travel falls to `-2.48L`, minimum range worsens to `8.59L`, and the
  episode exits after `53.97` rather than `65.47` released time. Its joint
  extrema are effectively unchanged (`0.568/0.453 rad` angles and
  `4.36/3.34 rad/time` speeds), so guard activation does not explain the lost
  approach.
- Current and inherited evaluations close off adjacent scalar steering edits.
  Raising only the ceiling to `14 deg` yields `-2.46L` head-x and `8.85L`
  minimum range with RMS force/moment `111/1560`; uniform damping `0.0425`
  yields `-1.93L` and `8.42L`; and a smooth large-bearing proportional rolloff
  yields only `-0.50L`, `10.20L` minimum range, and negative progress. Their
  released sheets all repeat the upper U-turn, and all finish with about
  `+1.77` to `+1.81L` head-y displacement. The course failure is therefore not
  supported as a monotone ceiling, derivative-gain, range-gating, or
  large-bearing-amplitude problem.
- The higher-authority `16 deg` sample also exits upward with head displacement
  `(-2.45,+1.73)L`, but its larger joint excursions and RMS force/moment
  `350/5007` make it an informative load failure, not support for increasing
  bend authority. Across the finite anchor and its close descendants, the
  nearly invariant terminal y displacement and joint extrema instead motivate
  changing the leverage of the same bounded steering bend.

## One candidate hypothesis

Restore the strongest finite controller's oscillator, posterior lag, guards,
`0.60` bearing gain, fixed `0.04` turn damping, and `12 deg` ceiling. Change
only `anterior_steering_fraction` from `0.35` to `0.25`, transferring one tenth
of the unchanged total steering equilibrium from the anterior joint to the
posterior joint. Because `anterior_bias + posterior_bias` still equals the
same saturated steering command, this isolates bend distribution rather than
globally weakening target-relative authority. The lower anterior share should
reduce the whole-body turning leverage that appears as the repeatable upper
U-turn while retaining posterior traveling-bend actuation and the anchor's
upstream rhythm.

The candidate uses only body-frame bearing, recent turn rate, and joint state;
it adds no coordinate, route, clock, target identity, prescribed inflow,
remote wake probe, or omitted-shelf dependency. The next CFD rollout supports
the hypothesis only if it remains finite, preserves meaningful negative head-x
travel, and reduces the repeatable `+1.8L` upper-exit drift or improves on the
`6.71L` minimum range. It is falsified if the redistributed bend collapses the
early upstream leg, repeats either full return, approaches hard joint/action
caps, or materially raises force and moment loads. No outcome for this
unevaluated candidate is claimed here.
