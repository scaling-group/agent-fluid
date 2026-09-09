# Multi-wake candidate diagnosis

## Evidence boundary and visual diagnosis

- The assigned parent promoted the `20 deg`, `0.67`-period phase-shell policy
  after its otherwise matched `19 deg` predecessor remained a longitudinal
  horizon miss. All four currently sampled solver entries report the same
  successful rollout (`266.255` release time, `0.749L` final/minimum distance,
  `-11.031L` head-x travel). Their released keyframe sheets are byte-identical,
  and every physical and scoring metric is identical; only wall-clock runtime
  differs. They are duplicate renderings of one fixed-prewarm outcome, so they
  confirm the parent's deterministic result but are not four independent
  wake-phase trials.
- The common prewarm sheet shows the held fish above and downstream/right of
  the target while the four mature cylinder streets overlap through and beyond
  the target corridor. It is shared initial-condition evidence, not evidence
  for the current controller.
- In the successful released sheet, the fish follows a broad initial turning
  route on the right, then aligns leftward, enters the interacting wake, and
  reaches the target from the right without collision, exit, or visible
  breakup. The diagnostics show that this is corridor selection rather than
  large sustained speed relative to the water: mean head velocity
  `(-0.04144,-0.01765)` is close to mean local flow
  `(-0.03889,-0.02029)`, while mean relative flow is only
  `(0.00254,-0.00264)`. Joint maxima remain finite at about `20.0/25.0 deg`,
  `187.7/141.3 deg/time`, and `1757.3/1325.9 deg/time^2`; the
  `30.8 rad/time^2` software guard is inactive.
- The inherited `19 deg` failure is the most informative local control. Its
  sheet shows productive self-propelled upstream motion and lateral correction,
  but it stays well to the right of the target at the horizon. Metrics agree:
  it survives all `300` release units, ends at its `5.812L` minimum, travels
  `(-5.846,-4.282)L`, and has mean velocity x `-0.01942` against local-flow x
  `-0.00682`. By contrast, the earlier weak cap-feasible controller is almost
  straight and is advected out of the downstream/right boundary at `16.747`,
  with `+2.172L` head-x motion, `-0.148` progress, and only `0.692` mean
  command energy. Thus large reductions in drive are not supported.
- The inherited optimizer log also rules out two obvious extrapolations: a
  stronger `0.78/0.72` posterior lag/damping pair looped near release and
  produced only `+0.058L` head-x travel, while a coupled `21 deg`, `0.69`
  period, `0.38` bearing-scale variant approached to `3.246L` and then
  rebounded to `3.610L`. That coupled miss does not identify amplitude alone,
  but it does not support weakening the successful policy's bearing response
  or increasing raw drive.

## Candidate hypothesis

Preserve the complete sampled successful propulsion bundle: `20 deg` anterior
shell, `0.67` period, `0.65/0.80` posterior lag/damping, `10 deg` bounded
posterior steering, `0.25` bearing-rate lead, and the inactive `30.8`
acceleration guard. Change only the bearing scale from `0.30` to `0.28`, so the
same bounded steering limit responds slightly more strongly to a given
body-frame bearing while leaving nominal gait acceleration unchanged. The
released sheet's broad early route and the inherited `0.38`-scale rebound make
earlier bounded alignment a narrower evidence-backed test than more amplitude
or posterior lag.

The next CFD evaluation should retain capture and negative head-x transport
while reaching sooner than `266.255` or lowering mean distance below `7.218L`,
without increasing the successful baseline's lateral force/moment materially.
Falsify this hypothesis if the fish exits the useful wake corridor, misses or
rebounds, fails to improve arrival/mean distance, or shows sharper wasteful
turning or load growth. Because the current evidence does not isolate bearing
scale, any such failure should return to the repeated `0.30` baseline rather
than trigger further gain sharpening.
