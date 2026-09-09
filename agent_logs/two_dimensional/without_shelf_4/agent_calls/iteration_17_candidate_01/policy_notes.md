# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared-prewarm sheet shows the fish held at the common upper-right
  release pose while the four staggered-cylinder streets develop and overlap
  through the target corridor. This is the certified common initial condition;
  it supplies the wake layout but cannot rank candidate policies.
- The assigned parent proposed narrowing the pure rolling-progress selector's
  transition scale from `0.020` to `0.015 L/time`. Two current samples reproduce
  that one-parameter candidate and its CFD outcome exactly, while two other
  current samples reproduce the `0.020` parent. Both sheets show active body
  oscillation, a broad release turn, repeated wake-band crossings, and an
  almost horizontal target entry without collision, domain exit, or numerical
  instability. The `0.015` sheet takes a different late wake band and reaches
  the circle after `210.370` instead of `213.659`; score improves from
  `-3.863` to `-3.528` and mean distance from `5.856L` to `5.519L`.
- Diagnostics support self-propelled, wake-assisted progress rather than
  passive advection. With `0.015`, mean upstream head speed is `0.05223` while
  mean local-flow magnitude in x is `0.03551`, so controller-relative upstream
  transport rises to `0.01672` from the parent's `0.01261`. Upstream head
  displacement increases from `10.915L` to `11.040L`, and total command energy
  falls from `148695` to `147846` despite the earlier arrival.
- The improvement is a steering-timing effect, not more drive or a relaxed
  envelope: maximum lateral target offset remains `4.293L`, maximum anterior
  acceleration remains `31.055 rad/time^2` below the `31.2` policy guard, and
  anterior joint angle/velocity extrema are unchanged. RMS relative crossflow
  is slightly lower (`0.13289` versus `0.13353`), but RMS lateral force and
  moment rise from `17.761/354.838` to `18.426/363.057`. The route benefit thus
  carries a modest load tradeoff and is not evidence that still narrower
  progress transitions improve monotonically.
- The inherited `75%` progress / `25%` away-drift schedule blend remains the
  informative failure. Its sheet shows continued propulsion followed by wide
  reversals and a deep lower-corridor excursion; it misses at the `300` horizon
  with final/minimum/mean distance `3.689/3.381/7.507L`. Its unchanged
  `31.055` anterior-acceleration maximum and lower `17.475` RMS force rule out
  gait loss or excessive load as the cause. Blending separately successful
  selectors disrupted corridor retention, so the current evidence supports
  pure progress timing rather than signal composition.

## Single candidate hypothesis

Adopt the independently reproduced `0.015 L/time` pure rolling-progress
transition as the one candidate. Preserve the evaluated `20.25 deg`,
`0.67`-period propulsion, posterior lag/damping, `10 deg` steering bound,
`0.30` bearing scale, `0.25` bearing-rate lead, sign-gated target-away lateral
correction, `0.07--0.08` lookahead envelope, `0.10` lateral-velocity clamp, and
`31.2` acceleration guard. This changes only how decisively rolling closing
speed selects between the already evaluated lookahead endpoints; it adds no
coordinate, route, clock, prescribed inflow, remote wake probe, or mixed
selector.

The direct fixed-prewarm expectation is the reproduced finite capture near
`210.370`, mean distance near `5.519L`, positive upstream margin near `0.01672`,
and unchanged propulsion/excursion maxima. Treat `0.015` as a local anchor, not
an optimum: reject transfer if a later or held-out wake phase loses capture,
worsens route integral, drops upstream margin below the `0.020` parent's
`0.01261`, contacts the acceleration guard, expands lateral excursion, develops
visible switching, or raises force/moment enough to outweigh the route gain.
The current worker claims no same-worker CFD result.
