# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet shows the held fish above the fully developed four-
  cylinder vortex streets, while the target lies inside the merged second-row
  wake. Every candidate therefore starts from the same wake phase and must
  generate upstream-relative propulsion while descending toward the wake; the
  prewarm is not candidate-specific evidence.
- The two `steering_gain=0.75` samples are exact behavioral duplicates. Their
  released sheets show a bounded initial turn followed by a compact diagonal
  upstream approach. The fish enters the developed wake only late in the
  approach and crosses the target circle without a visible loop, collision, or
  boundary excursion. The diagnostics confirm self-propulsion rather than
  passive advection: mean body velocity x is `-0.14682` while mean local-flow x
  is `-0.08249`, giving `0.06433` mean upstream-relative x speed. Capture takes
  `74.23` release units, mean distance is `2.561L`, and RMS force/moment is
  `22.39/393.08`; both candidate acceleration guards are touched, but joint
  speed (`3.225 rad/time`) and angle (`0.516 rad`) remain finite and below the
  task hard limits.
- The two `steering_gain=0.77` samples are also exact duplicates. Their sheets
  show the same useful mechanism, but a slightly deeper lateral approach and a
  later, more horizontal final entry. Metrics agree with the visible route
  regression: capture slows to `78.58`, mean distance rises to `2.661L`, and
  upstream-relative x speed falls to `0.06261`. Lower RMS relative crossflow
  (`0.1201` versus `0.1292`) and mean power proxy (`43.71` versus `45.38`) do
  not compensate for the worse targeting score; RMS moment is essentially
  unchanged (`393.44`).
- No failed rollout keyframe sheet is present in the sampled solver examples;
  all four reach the target. The inherited logs/guidance nevertheless bound the
  mechanism: gain `0.70` is slower (`91.61`), gain `0.82` is slower and more
  highly loaded (`83.83`, RMS force/moment `36.11/515.17`), and adding a
  bearing-rate lead previously caused a downstream exit. The inherited
  negative-sign/high-amplitude policy became numerically unstable, so this
  candidate keeps the demonstrated positive sign and regulated gait.
- The assigned-parent optimizer log selected `0.75` as the finite interior
  anchor. The inherited `0.77` worker made its next-step boundary explicit:
  regression should retain `0.75` and favor a lower-side probe rather than
  another upward extrapolation. The current duplicated `0.77` outcome meets
  that rejection condition, directly motivating the direction of this probe.

## Single candidate

Keep the successful `0.75`-period, `22 deg` energy-regulated oscillator,
posterior lag, `10 deg` steering bound, and `28 rad/time^2` candidate guard.
Change only the dimensionless bearing gain from `0.75` to `0.745`. The local
same-limit samples bracket the best response between `0.70` and `0.77`, with
the nearest stronger sample visibly overshooting the compact `0.75` route; a
small reduction tests whether the local optimum lies just below the incumbent
without discarding its propulsion or steering mechanism.

Falsifiable expectation: on the common prewarm, `0.745` should still reach the
target, preserve approximately `0.064` mean upstream-relative x speed and
finite `~393` RMS moment, and improve either the `74.23` capture time or
`2.561L` mean distance without increasing lateral excursion. Reject the change
if capture slows, the final approach becomes less direct, or force/moment and
joint saturation rise. This is a local common-snapshot interpolation, not a
claim that `0.745` generalizes across wake phase, geometry, or inflow.
