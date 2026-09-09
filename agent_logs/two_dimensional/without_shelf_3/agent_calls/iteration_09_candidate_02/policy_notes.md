# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the held fish above and to the right of four
  developed, interacting cylinder streets. It is the shared initial condition,
  not evidence for any candidate-specific control effect. All released sheets
  considered here terminate before the fish enters the target-centered wake
  corridor, so the live problem remains far-field course retention.
- The strongest finite sampled policy is the guarded angle-only oscillator with
  bearing gain `0.60`, steering ceiling `12 deg`, and fixed opposing recent-turn
  gain `0.04`. Its sheet shows a self-propelled leftward leg through the middle
  frames, then a sharp upward pitch and broad upper return. The metrics agree:
  head displacement `(-4.08,+1.80)L`, minimum range `6.71L`, progress `0.217`,
  and finite RMS force/moment `66.5/958`. Mean x velocity `-0.0673` exceeds the
  local upstream flow magnitude `-0.0457`, while mean y flow is nearly zero;
  the useful upstream leg and later upward drift are therefore not passive
  advection.
- The sampled `16 deg`, gain-`0.75` guarded policy pitches upward sooner and
  reaches only `10.35L` minimum range. Its RMS force/moment `350/5007` are much
  larger than the finite anchor's, so extra static bearing demand does not turn
  the visible upper course into productive wake rejection.
- The assigned parent's now-evaluated large-bearing rolloff is a concrete
  negative result. With the anchor's gait, guards, `12 deg` ceiling, and `0.04`
  turn damping held fixed, reducing bearing authority above a `45 deg` scale
  made the upper pitch occur before a useful upstream leg. Head travel collapsed
  to `(-0.50,+1.79)L`, minimum range worsened to `10.20L`, progress became
  `-0.023`, and release lifetime fell to `46.62`; finite loads `81.4/1261` show
  that this was course loss rather than numerical instability. The inherited
  `0.0425` turn-damping midpoint likewise retained the upper-exit topology and
  reached only `8.42L` with `-1.93L` head-x travel. Together with the sampled
  `10/14 deg` ceiling and range-gated damping failures, this rules out another
  steering-magnitude, absolute-bearing, or derivative-gain interpolation as the
  present candidate.

## Candidate hypothesis

Restore the strongest finite controller exactly and add only a small, smoothly
bounded damping term from normalized body-frame lateral velocity. The task
contract exposes `velocity_body_U`, and the anchor's `+1.80L` head-y motion with
near-zero mean local y flow makes controller-generated lateral motion a more
direct signal than absolute bearing for the observed exit. Subtracting positive
lateral velocity from the steering request should oppose the developing upper
drift while leaving the anchor's static bearing gain, saturation ceiling,
turn-rate gain, gait, steering distribution, and joint guards unchanged. A
`0.35` velocity gain is smoothly capped at `2 deg`, so the new correction cannot
replace the demonstrated `12 deg` target-bearing authority or command an
unbounded wake response.

This is supported only as an isolated test of bounded lateral-motion feedback
before wake entry. It is falsified if the early upstream leg falls materially
short of `-4.08L`, minimum range worsens from `6.71L`, the same upper return
persists, a lower return appears, or joint/load extrema rise materially. The
candidate uses no coordinates, clock, route, prescribed inflow, remote probes,
target-station flow, or omitted research shelf. Its CFD evaluation occurs after
this worker exits, so no improvement is claimed here.
