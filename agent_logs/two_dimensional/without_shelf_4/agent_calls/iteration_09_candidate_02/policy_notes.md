# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four sampled solver results are runtime duplicates of the demonstrated
  `20.25 deg`, `0.67`-period controller: their released keyframe sheets are
  byte-identical and their metrics match except for wall time and negligible
  power-proxy serialization. The common prewarm sheet shows the fish held high
  and downstream/right while the staggered cylinder streets develop through
  the target. Because this sheet is also byte-identical to the inherited
  step-8 prewarm, it is initial-condition evidence rather than policy evidence.
- In the sampled released sheet, the controller self-propels into a useful
  wake-assisted corridor rather than drifting passively. It first makes a broad
  down/up correction on the right, enters the interacting central wake, then
  approaches the target nearly horizontally. It reaches `0.7498L` at `244.547`
  with mean distance `6.452L`, head travel `(-10.916,-4.187)L`, and no
  collision, exit, instability, or rebound. Mean upstream velocity `-0.04443`
  exceeds the magnitude of mean local-flow x `-0.03649`, while the small
  residual difference is consistent with active swimming assisted by the wake.
- More drive is unsupported. Maximum anterior acceleration is already
  `31.055 rad/time^2` against the `31.2` policy guard and `31.416` hard cap;
  the sampled RMS relative crossflow, lateral force, and moment are `0.13437`,
  `18.263`, and `362.214`. The visible inefficiency is lateral route selection,
  not lack of propulsion.
- No sampled sheet is a hard failure, so the assigned-parent evidence supplies
  that boundary: the weak `14 deg`, `0.80`-period gait was advected `+2.172L`
  downstream and exited at `16.747`, while the `19 deg`, `0.67`-period gait
  self-propelled upstream but ended the horizon at its `5.812L` minimum. The
  coupled `21 deg`, `0.69`-period variant rebounded from `3.246L` to a `3.610L`
  miss. These failures bracket corridor acquisition and warn against changing
  the demonstrated shell or phasing.
- The inherited step-8 rollout completes the parent's isolated lower-lookahead
  test. Its policy changes only bearing-rate lookahead `0.25 -> 0.20`. The
  released sheet retains eventual central-wake entry and a horizontal final
  approach, but frames 2--5 show a wider, more jagged down/up route and delayed
  steering unwind. Capture moves from `244.547` to `258.621`, mean distance
  worsens from `6.452L` to `8.041L`, command energy rises from `170142` to
  `179926`, and RMS lateral force rises from `18.263` to `18.629`. Its tiny RMS
  relative-crossflow reduction `0.13437 -> 0.13419` and moment reduction
  `362.214 -> 360.028` do not compensate for the longer, later, more loaded
  route. Together with the parent's `0.30` lookahead result (capture `270.446`,
  mean distance `8.499L`, RMS lateral force `18.958`), both directions around
  `0.25` regress; bearing lookahead should no longer be tuned at this wake phase.

## Candidate hypothesis

Restore and preserve the demonstrated `0.25` bearing-rate lookahead together
with the `20.25 deg` shell, `0.67` period, `0.65/0.80` posterior lag/damping,
`10 deg` steering limit, `0.30` bearing scale, `0.30 rad/time` rate clamp, and
`31.2 rad/time^2` acceleration guard. Add one distinct observation mechanism:
a small smooth rejection term from the normalized body-frame relative-flow
crossflow `state.relative_flow_velocity_body_U[2]` inside the existing bounded
bearing steering signal.

The evidence gives a crossflow scale of about `0.134`; use `0.15` as the smooth
normalization scale and cap the dimensionless rejection contribution at
`0.15`. At the observed RMS scale this is equivalent to only about a
`0.032 rad` bearing offset and roughly a `1 deg` posterior steering correction
near the center of the `10 deg` saturator. Positive relative crossflow produces
a positive counter-bend at zero bearing, opposing lateral water-relative drift;
the sign reverses symmetrically. This preserves target authority, uses no
coordinates, route, target identity, remote probe, prescribed inflow, external
phase, or elapsed time, and cannot expand the existing steering limit.

This is an unverified local hypothesis, not a claimed improvement. Under the
certified prewarm it should retain capture and central-wake acquisition while
reducing the visible correction width, mean distance below `6.452L`, arrival
time below `244.547`, or RMS lateral force below `18.263` without extra guard
contact. Falsify it on lost/later capture, a wider or more rapidly switching
route, increased mean distance/load, or if instantaneous crossflow makes the
posterior command chase vortices. On falsification, restore the pure `0.25`
anchor and distrust instantaneous crossflow rejection; a later worker should
test a temporally filtered normalized drift/force signal rather than another
bearing gain or lookahead change.
