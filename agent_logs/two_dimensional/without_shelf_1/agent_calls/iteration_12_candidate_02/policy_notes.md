# Multi-wake target-policy candidate notes

## Visual and metric diagnosis

The shared prewarm sheet is common initial-condition evidence: the held fish
starts above and downstream of the four developed, interacting cylinder
streets. The released sheets show active upstream swimming rather than passive
advection. The strongest finite sample moves its head at about
`-0.141 L/time` while mean local flow is `-0.099 L/time`, travels `-7.89L`
upstream, reaches `4.87L`, and makes `0.424` progress. It nevertheless stays
above the target/wake corridor, makes a broad upward hook after its closest
approach, and exits with `+1.79L` head-y drift. Its posterior angle reaches
`0.781 rad`, both joint rates and candidate accelerations hit their caps, and
RMS force/moment are `406/4113`.

The sampled `10 deg` anchor, `11 deg` anchor, distance relief, and fore-aft
bearing gate all retain that route topology. Raising the static posterior bias
from `10` to `11 deg` improves upstream travel from `-6.93L` to `-7.89L` and
closest approach from `5.33L` to `4.87L`, but does not change lateral drift and
raises load. Reducing the `11 deg` bias inside `6L` loses travel and progress
without changing the exit. The fore-aft gate is more informative: it preserves
nearly the `11 deg` closest approach (`4.89L`) but weakens the bearing drive to
a positive `0.15` floor as the target approaches the beam or moves behind; it
still exits with `+1.80L` drift. Thus merely reducing the folded bearing term
does not unwind the established loop.

Two inherited lateral-velocity corrections now provide a concrete negative
result. Direct body-lateral damping at gain/scale `0.20/0.10` cuts upstream
travel to `-4.41L`, worsens closest approach to `5.82L` and progress to
`0.239`, raises RMS force/moment to `428/4648`, and retains `+1.79L` upper
drift. A separately normalized slip correction at gain/scale `0.30/0.35`
also regresses travel to `-6.79L`, closest approach to `5.47L`, and progress
to `0.375`, while preserving the same exit. Lateral translation is therefore
not a useful damping proxy for the missing turn in this controller family.

## Single candidate hypothesis

Restore the complete strongest `11 deg`, `0.70/0.35` anchor and keep its
oscillator, posterior lag, damping, fade, and command ceiling unchanged while
the target is ahead in the body frame. Add one smooth behind-target recovery
gate using the normalized forward projection `-target_body_L[1]`: the bearing
multiplier remains exactly `+1` for every forward target, then transitions over
the first `1L` behind the fish to a bounded `-0.50`. Direct heading-rate
damping is unchanged.
This addresses a structural boundary of the observation: `state.bearing`
folds fore-aft geometry through `abs(forward_distance)`, so its sign alone
cannot distinguish an ahead target from a behind target. Unlike the sampled
positive-floor gate, the recovery command can actually unwind a turn after
the target passes behind; unlike distance relief, it cannot damage the useful
approach leg before that event.

The candidate is supported if it matches the `11 deg` anchor through the
`4.87L` approach and then reduces the final upper hook, `+1.79L` lateral drift,
or limit/load pattern. It is falsified if the target never enters the recovery
gate, if the same upper exit survives, or if reversal causes switching, loses
upstream progress before closest approach, or increases saturation/load. This
worker does not claim a CFD outcome before the downstream evaluation exists.
