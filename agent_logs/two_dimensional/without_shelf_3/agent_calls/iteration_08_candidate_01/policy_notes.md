# Wake-policy candidate diagnosis

## Evidence read before the edit

- The common prewarm sheet shows the held fish at the upper edge of four developed,
  interacting vortex streets; this is the same initial condition for every sampled
  policy and is not candidate-specific evidence.
- The strongest finite sample is the guarded `12 deg`, gain-`0.60`, recent-turn
  damping-`0.04` angle-only oscillator. Its released sheet shows genuine leftward
  self-propulsion through frames 2--4, followed by a tight pitch upward and a broad
  upper return before domain exit. This agrees with `-4.08L` head-x displacement,
  a transient `6.71L` minimum range, finite RMS force/moment `66.5/958`, and final
  range `9.73L`; the transient approach did not become target capture.
- The unguarded gain-`0.75`, `16 deg` sample initially travels left but visibly
  folds at termination. Its `33.06` released time, both `1800 deg/time^2` cap
  contacts, `260 deg/time` anterior speed, and RMS force/moment `20024/314391`
  confirm that this dramatic turn is numerical instability, not useful wake
  rejection.
- Two controlled descendants preserve the guarded gait but make the finite upper
  loop earlier: adding up to `0.02` recent-turn damping below about `8L` gives only
  `-2.48L` head-x and `8.59L` minimum range, while raising only the steering ceiling
  to `14 deg` gives `-2.46L` and `8.85L`. Their nearly unchanged joint-speed and
  action extrema show that the course loss is not explained by guard activation.
  Inherited logs also show that lowering the ceiling to `10 deg` cuts head-x travel
  to `-1.43L`, whereas uniform damping `0.05` survives longer but completes a lower
  return and finishes `15.00L` away. Thus neither globally weakening steering nor
  increasing ceiling/damping is supported.

## Candidate hypothesis

Keep the strongest finite sample's oscillator, joint guards, `12 deg` ceiling,
gain `0.60`, and damping `0.04` exactly fixed. Apply one smooth static rolloff to
the bearing-proportional term only when the body-frame target bearing becomes
large. The initial geometry has a small bearing, so the demonstrated upstream gait
and moderate-error authority should remain unchanged; during the visible late
cross-axis pursuit, the rolloff should prevent a saturated steering bias from
closing the upper U-turn. Recent-turn damping remains outside the rolloff so rapid
rotation is still opposed. The rolloff uses only normalized body-frame bearing and
contains no coordinates, route, time, wake probe, or prescribed inflow.

This candidate is supported only as an isolated test of the large-bearing-loop
interpretation. It is falsified if it reduces upstream head displacement before
the prior `6.71L` closest approach, repeats either upper/lower full return, increases
joint/load extrema materially, or still fails to enter a closer target/wake
corridor. Because the current candidate's CFD runs after this worker exits, no
improvement is claimed here.
