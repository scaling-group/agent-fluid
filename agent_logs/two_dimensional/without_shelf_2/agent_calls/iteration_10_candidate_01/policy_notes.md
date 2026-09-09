# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace and guidance contracts, the assigned parent experience,
all four sampled scores, observations, compact metrics, nested wake diagnostics,
and policies, plus the available inherited optimizer notes and their evaluated
descendants before selecting this candidate. I inspected the common held-fish
prewarm sheet first, then the released sheets for the triplicated `28/28`
anchor, the sampled `28/27` split guard, and the assigned parent's evaluated
`28/27.5` midpoint. No omitted Bookshelf material, neighboring configuration,
repository history, coordinate route, clock, or external research was used.

The shared prewarm sheet shows the fish held above and downstream of four
developed, interacting vortex streets, with the target in the merged second-row
wake. This is the common initial condition for every candidate, not support for
a memorized route or candidate-specific wake phase.

The three identical `28/28 rad/time^2` anchor rollouts remain the strongest
physical reference. Their keyframes show a bounded down-left turn, productive
lateral beating, and a compact diagonal entry into the useful developed wake,
followed by target crossing without a loop, collision, or boundary excursion.
Capture takes `74.23` release units and mean distance is `2.561L`. Mean world x
velocity is `-0.14682` against mean local-flow x `-0.08249`, so its `0.06433`
upstream-relative speed demonstrates self-propulsion rather than passive
advection. RMS force/moment are `22.39/393.08`, command energy is `50940`, and
joint angles and speeds stay below the hard envelope although both acceleration
commands touch the candidate's `28` guard.

Lowering only the posterior guard to `27` changes the late route and is not a
clean physical improvement. It has the best sampled scalar score and slightly
lower mean distance (`-0.6544`, `2.555L`), but its keyframes show a lower final
correction; arrival slows to `76.44`, upstream-relative x speed falls to
`0.06199`, command energy rises to `53200`, and RMS force/moment rise to
`24.69/417.71`. Posterior peak speed also rises from `3.225` to `3.233`, so
lower authority did not directly regulate tail speed or load.

The assigned parent's evaluated midpoint falsifies the proposed interpolation
between those routes. With only the posterior guard changed to `27.5`, the
fish still turns toward the target and eventually enters the useful wake, but
the keyframes show a visibly deeper lower excursion and longer correction
before capture. Arrival regresses to `95.96`, mean distance to `2.806L`, and
upstream-relative x speed to `0.05344`; command energy grows to `64918`, RMS
force/moment to `51.98/665.46`, and peak joint speeds to `3.220/3.242`. The
nearly unchanged RMS relative crossflow (`0.13274` versus `0.12919` at the
anchor) does not rescue the visibly wasteful route or the much larger load.
All current sheets terminate by target capture, so this is a failed
optimization hypothesis rather than a collision, domain-exit, or numerical
failure. The inherited reversed-sign instability remains only a logged safety
boundary and is not presented as newly inspected visual evidence.

## Single candidate hypothesis

Restore the reproducible anchor's common `28 rad/time^2` action guard and retain
its evaluated positive-bearing gain `0.75`, `10 deg` steering cap, `0.75`
period, `22 deg` state-energy oscillator, energy gain, posterior target, and
lag. Change only posterior damping from `0.65` to `0.675`. In the existing
policy equation this modestly strengthens the bounded negative feedback on
`qdot2`; unlike guard interpolation it does not withhold tracking authority or
change the anterior propulsion loop. This is an isolated tail-response probe,
not a claim that more damping is generally beneficial.

Later CFD should preserve finite capture, the anchor's compact diagonal route,
and material upstream-relative propulsion while reducing posterior peak speed,
command effort, or force/moment load. Treat it as an improvement only if those
changes do not cost arrival or mean distance materially relative to `74.23`
and `2.561L`. Reject the probe if the altered phase response produces a lower
excursion, reduces upstream-relative x speed below the anchor, raises load, or
loses capture. A same-snapshot improvement would still require falsification
under held-out wake phase, inflow, geometry, and target placement; no outcome
for this unevaluated candidate is claimed here.
