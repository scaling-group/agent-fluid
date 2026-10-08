# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace and guidance contracts, assigned-parent experience, all
four sampled solver scores, observations, compact metrics, nested diagnostics,
and policies, plus the available inherited optimizer notes and their evaluated
descendants. I inspected the common held-fish prewarm sheet first, then the
released sheets for the duplicated `28/28` anchor, the score-leading `28/27`
split guard, and the assigned parent's evaluated constant-damping probe. No
omitted Bookshelf material, neighboring configuration, repository history,
coordinate route, clock, or external research was used.

The common prewarm sheet shows the fish held above and downstream of four
developed, interacting vortex streets, with the target in the merged
second-row wake. This is shared initial-condition evidence, not support for a
memorized route or candidate-specific wake phase.

The duplicated `28/28 rad/time^2`, `tail_damping=0.65` anchor remains the
strongest physical baseline. Its released sheet shows a bounded down-left turn,
productive lateral beating, compact diagonal entry into the developed wake,
and target crossing without a loop, collision, or boundary excursion. Capture
takes `74.23` release units and mean distance is `2.561L`. Mean world x velocity
is `-0.14682` against mean local-flow x `-0.08249`, so the `0.06433`
upstream-relative speed demonstrates self-propulsion rather than passive
advection. Command energy is `50940`, RMS force/moment are `22.39/393.08`, and
posterior peak speed is `3.225 rad/time`; both acceleration commands touch the
candidate guard while joint angles and speeds remain below the task envelope.

The sampled `28/27` split guard has the best scalar score and a slightly lower
mean distance (`-0.6544`, `2.555L`), but its sheet approaches from farther
below. It slows capture to `76.44`, reduces upstream-relative x speed to
`0.06199`, raises command energy to `53200`, raises RMS force/moment to
`24.69/417.71`, and slightly increases posterior peak speed to `3.233`.
Lowering posterior authority therefore did not regulate tail speed or load;
its scalar gain is not a clean physical improvement over the anchor.

The assigned parent's constant `tail_damping=0.675` result is the most
informative failed optimization hypothesis. Its sheet remains finite and turns
toward the target, but after the initial turn it takes a visibly deeper,
kinked lower correction and returns from underneath rather than preserving the
anchor's compact diagonal topology. Capture regresses to `91.50`, mean distance
to `2.788L`, score to `-0.8768`, and upstream-relative x speed to `0.05262`.
Total command energy rises to `60660` and RMS force/moment nearly double to
`42.13/581.11`. The extra damping does reduce posterior peak speed from
`3.225` to `3.145`, but anterior peak angle/speed rise from `0.516/3.121` to
`0.555/3.214`; the lower tail-speed peak therefore does not establish load
regulation. No current or inherited sheet used for this comparison collides,
exits the domain, or becomes nonfinite, so the failure is a wake-route and load
regression rather than a safety termination.

## Single candidate hypothesis

Restore the anchor's evaluated `0.65` posterior damping, common `28` action
guard, `0.75` positive-bearing gain, `10 deg` steering cap, `0.75` period,
`22 deg` state-energy oscillator, tail steering share, and lag. Add only a
bounded high-speed damping schedule: compute posterior speed relative to the
existing nominal gait scale `omega * amplitude`, keep damping exactly `0.65`
through ratio `0.95`, and ramp quadratically to `0.675` only from ratios `0.95`
to `1.0`. This retains the anchor's phase response for most of each tailbeat
while using the one demonstrated benefit of the failed constant-damping probe
only near the posterior-speed peak. The schedule is symmetric, normalized,
body-frame, and uses no new observation, time signal, global coordinate, wake
probe, or case-specific route.

Later CFD should preserve finite capture, the compact diagonal approach, and
material upstream-relative propulsion while reducing posterior peak speed,
effort, or load relative to the anchor. Treat it as an improvement only if any
tail-speed reduction is corroborated by arrival, mean distance, command effort,
and RMS force/moment without a deeper lower correction. Reject the schedule if
it reproduces the constant-damping route, drops upstream-relative x speed
materially below `0.06433`, or merely redistributes motion/load to the anterior
joint. A same-snapshot improvement would still require falsification under
held-out wake phase, inflow, geometry, and target placement; no CFD outcome for
this unevaluated candidate is claimed here.
