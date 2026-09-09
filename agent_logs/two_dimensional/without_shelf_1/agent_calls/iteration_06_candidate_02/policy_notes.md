# Candidate wake-policy notes

## Evidence diagnosis

The shared prewarm sheet shows the common difficult initial condition: the fish
is held near the upper-right boundary while the target sits behind the second
cylinder row, and four developed vortex streets occupy the long approach. The
released sheets do not show passive downstream advection or entry into that
useful wake region. All four sampled policies generate a traveling bend and
self-propel upstream, but trace a broad upper loop and leave the domain before
turning down toward the target.

The clean posterior-only sequence isolates normalized heading-rate feedback
while preserving the `0.90`-period gait. With no rate damping, gain `0.35`, and
gain `0.70`, respectively, upstream head displacement improves from `-2.73L`
to `-4.69L` to `-6.93L`, progress improves from `0.132` to `0.255` to `0.380`,
and mean distance improves from `10.65L` to `9.48L` to `8.03L`. The `0.70`
case is also the best sampled finite result by score (`-9.53`) and closest
approach (`5.33L`). Its mean velocity x (`-0.130`) exceeds the local-flow
contribution (`-0.091`), supporting self-propulsion rather than wake advection.

That improvement has a clear boundary. All three keyframe sheets still end at
the upper boundary after essentially the same `+1.20L` center displacement;
gain `0.70` exits after `55.38` release units versus `73.39` with no damping,
and raises RMS force/moment from `196/2014` to `325/3331`. Both joint-rate and
acceleration commands still reach their caps. Adding bounded body-lateral-
velocity damping to gain `0.35` is a negative comparison: it reduces progress
from `0.255` to `0.174`, worsens closest approach from `7.30L` to `7.73L`, and
reduces upstream head travel from `-4.69L` to `-3.40L`. This does not support a
second feedback signal or a simultaneous propulsion retune.

## Policy hypothesis

Keep the complete gain-`0.70` propulsion, posterior servo, bearing sign, fade,
and command ceiling, and change only `turn_rate_damping` to `1.05`. For a large
bearing request and a turn rate above the `0.35` scale, gain `0.70` can only
reduce the normalized request from about `1` to `0.30`; gain `1.05` can briefly
cross zero and provide bounded counter-steering after rotation develops, while
leaving the initial zero-rate turn request unchanged. The falsifiable
expectation is retention of strong upstream motion with a tighter trajectory
that bends away from the upper boundary before the prior exit. The hypothesis
fails if it loses the gain-`0.70` progress topology, causes rapid downstream
exit, or repeats the upper loop without improving clearance; in that case later
workers should bracket the threshold between `0.70` and `1.05` or vary only the
turn-rate scale, not add lateral or bearing-rate feedback.
