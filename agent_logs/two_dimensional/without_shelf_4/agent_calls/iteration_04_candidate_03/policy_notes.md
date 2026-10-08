# Wake-policy candidate diagnosis

## Evidence read before policy changes

- The shared prewarm sheet fixes the relevant initial condition: the fish is
  held in the developed, overlapping four-cylinder streets downstream and
  above the target, so the released controller must both propel upstream and
  remove the initial lateral offset.
- The assigned parent records the weak-gait failure first: its cap-feasible
  but inactive controller was advected `+2.17L` downstream and exited after
  `16.75`. The sampled `19 deg`, `0.67`-period controller repairs that failure.
  Its released sheet shows a broad initial turn followed by upstream motion
  toward the target row; the run survives the full horizon, finishes at its
  `5.81L` minimum, and moves the head `(-5.85,-4.28)L`. Diagnostics confirm
  finite active propulsion without envelope contact: maximum joint angles are
  about `19/24 deg`, rates `178/134 deg/time`, and accelerations `1670/1260
  deg/time^2`.
- The strongest sampled finite controller changes only that anterior shell
  from `19` to `20 deg` while retaining the `0.67` period, `0.65` posterior
  lag, `0.80` damping, and bounded negative bearing/rate bias. Its sheet shows
  the same large release turn, then sustained upstream travel into the useful
  central wake and capture rather than a late rebound. It reaches `0.749L` at
  `266.26`, moves `(-11.03,-4.70)L`, and improves mean distance to `7.22L`.
  The result is not explained by harsher lateral loading: RMS crossflow,
  force, and moment are `0.132`, `18.26`, and `353.21`, all below the sampled
  `21 deg` near-miss, while maximum acceleration remains finite at `30.67`.
- The failure comparisons bound the hypothesis. Raising posterior lag from
  `0.65` to `0.78` and reducing damping to `0.72` leaves the anterior shell
  unchanged but produces tight, wasteful turning in the released sheet and
  essentially zero upstream displacement (`+0.06L`). The `21 deg`,
  `0.69`-period, `0.38` bearing-scale sample progresses `-8.12L` upstream but
  visibly turns back above the target late; its final `3.61L` distance is
  worse than its `3.25L` minimum and its RMS force/moment rise to
  `19.15/363.27`. Those coupled changes do not justify extrapolating beyond
  the demonstrated `20 deg` mechanism.

## Candidate hypothesis

Promote the demonstrated successful `20 deg`, `0.67`-period controller as the
single candidate, including its local `30.8` acceleration guard. This is a
one-axis repair of the assigned `19 deg` prefill: it preserves the steering
sign and scale that remove the target-row offset and preserves the posterior
phasing whose stronger sampled alternative failed. The falsifiable expectation
is target capture near the sampled `266.26` release time with negative head-x
travel and no actuator-envelope contact. Reject the mechanism on later wake
phases if it loses monotone late distance progress, contacts the guard or hard
caps persistently, rebounds laterally, or fails to enter the central wake.
