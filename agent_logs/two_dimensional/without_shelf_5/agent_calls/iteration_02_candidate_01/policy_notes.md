# Multi-wake target-policy diagnosis

## Evidence read before the policy edit

- The assigned parent is the slower `0.95`-period, `15`-degree oscillator with
  a negative posterior-only bearing bias plus heading-rate and lateral-velocity
  terms. Its released sheet shows the fish bending progressively nose-down and
  leaving the lower domain without entering the target corridor. The metrics
  agree: it survives `76.692/300` time units but displaces `(2.371,-11.073)L`,
  never improves on the initial `12.424L` distance, and finishes `15.582L`
  away. Reduced effort (`340.6` mean command energy) therefore did not preserve
  useful upstream self-propulsion or supply correctly signed steering.
- The shared prewarm sheet is common initial-condition evidence: at release the
  fish is held at the upper-right pose while four developed vortex streets
  merge across the target corridor. It does not distinguish the candidates.
- The strongest finite sampled result uses the original `0.55`-period,
  `28`-degree traveling-bend gait and one smooth positive body-frame bearing
  command distributed between the anterior oscillator center and total
  posterior tangent center. Its keyframes show active self-propulsion: the fish
  turns from the release diagonal onto a smooth upstream-left route, crosses
  the developed wake, and enters the green capture ring rather than being
  advected out. It reaches the target at `41.316`, with displacement
  `(-10.910,-4.251)L`, `0.940` progress, mean/final distance
  `1.919/0.750L`, and finite RMS force/moment `41.98/660.23`.
- The target-blind policy with the same propulsive gait is an informative
  route-control failure: it initially closes to `8.615L`, then rotates nearly
  vertical and exits the lower boundary at `50.127`. Its displacement
  `(-3.545,-13.300)L` and mean velocity/flow y values `-0.263/-0.241` show that
  the large lateral escape is substantially advection-dominated despite some
  upstream propulsion. Thus the successful run's target capture cannot be
  credited to gait vigor alone.
- Two inherited negative results resolve the bearing convention. A moderated
  `0.60`-period policy put a *negative* bearing bias into both joint centers;
  the sheet shows an immediate U-turn toward the downstream/right boundary and
  it exits after `11.335` with `-0.194` progress, `2.938L` positive x motion,
  and RMS moment `7297`. A slower multichannel policy used the same negative
  bearing sign and became unstable after `2.807`, with RMS relative crossflow
  `3.672`, RMS force `53306`, and RMS moment `687730`. More signals or lower
  cadence are therefore not evidence-backed substitutes for the successful
  positive, distributed bearing curvature.
- The successful run still touched both velocity and acceleration caps and
  spent `1404.9` mean command energy. Those are engineering cautions, but this
  score configuration gives effort zero weight and the sampled set does not
  isolate a cap-respecting propulsion change that retains capture. Mixing in
  the failed amplitude/cadence changes would sacrifice the only demonstrated
  target-reaching mechanism without controlled evidence.

## Candidate policy hypothesis

Replace the failing prefill with the evaluated target-reaching controller
without recombining it with failed siblings. Preserve the successful
state-encoded oscillator, positive bounded `tanh` bearing command, `0.4`
anterior share, and full posterior tangent center. This is a single
translation-independent feedback policy: it reads no coordinate, target
identity, cylinder identity, elapsed time, or remote wake signal.

Under the certified shared prewarm, the candidate should reproduce a smooth
upstream-left approach and first crossing near `41.3` time units rather than
the parent's lower-domain exit. The hypothesis is falsified if the identical
policy does not reproduce finite capture under the same snapshot, if bearing
grows before the initial turn completes, or if a later varied-phase/geometry
test loses route retention. A later worker may test cadence or amplitude in a
one-factor comparison, but should not simultaneously change the proven
bearing sign/distribution or add unscaled moment and lateral-flow feedback.
