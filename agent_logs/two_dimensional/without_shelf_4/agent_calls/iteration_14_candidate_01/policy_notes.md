# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four sampled shared-prewarm sheets are byte-identical. They show the
  fish held at the upper-right release pose while the four staggered-cylinder
  vortex streets develop and overlap across the target corridor. This is the
  certified common initial condition, not candidate-ranking evidence.
- The four current rollouts reduce to two exactly reproduced policies. The
  stronger finite reference uses a constant `0.08` sign-gated body-frame
  lateral-velocity lookahead. Its sheet shows a broad self-propelled
  acquisition loop, several useful wake-band crossings, and an almost
  horizontal central-wake entry by rendered frame `25`, with no collision,
  domain exit, or instability. It captures at `224.488` with mean distance
  `6.311L`; mean upstream velocity is `-0.04895` against mean local-flow x
  `-0.03293`, leaving `0.01602` controller-relative upstream transport. RMS
  relative crossflow, lateral force, and moment are
  `0.13427/17.943/361.014`.
- The current `0.07` lower bracket is the most informative policy failure in
  the sampled set; no sampled sheet is a hard task failure. Its sheet still
  enters the useful wake and captures, but only at rendered frame `28` after a
  longer sequence of corridor reversals. Capture is delayed to `245.449`,
  controller-relative upstream transport falls to `0.01284`, mean relative
  lateral flow becomes more biased at `-0.01250` versus `-0.00494`, and RMS
  lateral force/moment rise to `18.399/363.454`. Its `6.305L` mean distance and
  `-4.291` score narrowly improve the `0.08` values by `0.006L` and `0.020`,
  but that scalar gain does not compensate for the `20.961` later capture and
  larger loads. Total command energy also rises from `157453.9` to `169649.0`.
- Both current policies retain the same `4.293L` maximum lateral offset and
  `31.055 rad/time^2` maximum anterior acceleration below the `31.2` policy
  guard. The changed behavior is therefore steering timing, not a propulsion,
  saturation, or clearance effect. The fish is not passively advected in
  either case because its upstream velocity exceeds local upstream flow.
- Inherited optimizer logs provide the upper-side boundary: changing only the
  same lookahead to `0.10` delayed capture to `263.346`, worsened mean distance
  to `6.974L`, reduced upstream margin to `0.00931`, and increased force and
  total effort without changing the propulsion guard or excursion envelope.
  They also record an alignment-gated heading-rate continuation at `265.298`
  with `7.822L` mean distance and negative upstream margin, plus a
  sign-asymmetric bearing-rate horizon miss at `3.632L`. Another constant
  bracket, drive increase, or rotational-rate term is not supported.

## Single candidate hypothesis

Preserve the demonstrated `20.25 deg`, `0.67`-period oscillator, posterior
lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25` bearing-rate
lookahead, `0.10` lateral-velocity clamp, and `31.2` acceleration guard.
Replace the current constant `0.07` lateral lookahead with one bounded
magnitude schedule using the already evidenced target-away drift weight:

```text
lookahead = 0.07 + (0.08 - 0.07) * away_drift_weight
```

The existing counter-drift term then uses this scheduled lookahead. It tends
to the successful `0.08` setting only as target-away translation becomes
strong, tends to `0.07` for weak drift, is exactly zero for stationary or
targetward lateral motion, and remains bounded to `0.008 rad` before the
steering nonlinearity. The candidate adds no observation, coordinate, route,
clock, prescribed-inflow value, or remote wake probe; all active constants are
owned by `target_policy_params()`.

The falsifiable expectation is that strong away-drift events recover the
`0.08` policy's earlier corridor acquisition and positive upstream margin,
while weaker correction near zero drift avoids unnecessary counter-steering
and preserves the `0.07` policy's small distance-integral advantage. Require
target capture no later than `224.488`, mean distance no higher than `6.305L`,
positive controller-relative upstream transport, and no increase over the
`0.08` force/moment or guard envelope to call the mechanism an improvement.
Reject it on lost/later capture, a larger late corridor rebound, worse score or
mean distance than `0.07`, upstream margin below `0.01602`, material
crossflow/load/effort growth, guard contact, or visible switching. This scope
is only the certified fixed-prewarm phase; the current worker claims no CFD
result, and a held-out wake phase remains necessary for transfer.
