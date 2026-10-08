# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, the assigned-parent
experience, all four sampled solver scores, observations, compact metrics,
embedded wake diagnostics, and policies, plus the inherited optimizer notes
and evaluated descendants available inside this workspace. Following the
wake-visual inspection procedure, I viewed the common held-fish prewarm sheet
first, then the released sheets for the duplicated best finite
`oscillator_energy_gain=2.1` policy and the informative `2.2` regression. I
also inspected the inherited evaluated `2.05` sheet because it brackets the
same isolated controller dimension. The current sampled set has no collision,
domain exit, instability, or horizon miss; "regression" below means a finite
route, effort, and load regression rather than failed termination. I used no
omitted Bookshelf material, neighboring configuration, repository history,
global-coordinate route, clock, or external research.

The shared prewarm sheet shows the fish held above and downstream of four
developed, interacting vortex streets, with the target inside the merged
second-row wake. It is identical initial-condition evidence for every
candidate and does not support coordinate memorization or a
candidate-specific phase schedule.

Three sampled `2.1` policies reproduce the same successful outcome. Their
released sheet shows a bounded down-left turn, productive lateral beating,
self-propelled upstream motion through the developed wake, and a shallow,
compact target entry without a loop or boundary excursion. Mean world x speed
`-0.14784` against local-flow x `-0.08219` gives `0.06565` upstream-relative x
speed. Capture occurs at `73.86` with `2.480L` mean distance, `51797` command
energy, `0.13097` RMS relative crossflow, and `24.94/410.68` RMS force/moment.
Both acceleration channels touch the candidate's `28 rad/time^2` guard, while
joint angles and speeds remain inside the task envelope.

Increasing only the common energy gain to `2.2` keeps the rollout finite but
visibly selects a deeper lower correction before capture. The metrics
corroborate that route regression: arrival slows to `77.73`, mean distance
rises to `2.541L`, upstream-relative x speed falls to `0.06006`, command
energy rises to `55790`, relative crossflow rises to `0.13282`, and RMS
force/moment rise to `26.42/423.30`. Slightly lower peak joint angles and
speeds do not make this a gentler interaction. The inherited `2.05` rollout
supplies the other side of the bracket: its sheet remains compact, arrival is
fastest at `72.70`, upstream-relative x speed remains `0.06562`, and command
energy, crossflow, and force/moment improve to `50630`, `0.12774`, and
`21.05/379.50`, but its `2.511L` mean distance and `-0.6125` score are worse
than `2.1`. Thus one common gain is not monotone across closure, effort, and
load, and the evaluated evidence rejects continuing above `2.1`.

## Single candidate hypothesis

Restore the evaluated `2.1` navigation anchor and retain its positive-bearing
gain `0.75`, `10 deg` steering cap, `0.75` period, `22 deg` orbit, posterior
target and lag, `0.65` damping, and common `28 rad/time^2` guard. Split the
energy feedback at the nominal unit-energy orbit: use the exact evaluated
`2.1` gain when oscillator energy is below one and the exact evaluated `2.05`
gain when it is above one. The feedback remains continuous at unit energy
because the gain multiplies `(1 - energy)`, uses only normalized joint state,
and adds no route, time, coordinate, or wake-phase signal.

This is a mechanism-separation test, not a claim that the prior summaries show
which branch caused each outcome. If stronger below-orbit recovery produced
the `2.1` compact closure while the lower common gain produced the `2.05` load
benefit through gentler above-orbit dissipation, the split should retain
capture near `73.86` and mean distance near `2.480L` while moving effort and
loads below `51797` and `24.94/410.68`. Reject the hypothesis if it takes the
`2.2` lower route, reduces upstream-relative x speed materially below
`0.0656`, raises effort/load, or loses capture. If it exactly reproduces
`2.1`, infer only that the changed above-orbit branch was dynamically inactive
or immaterial on this rollout; held-out wake phase, inflow, geometry, and
target placement remain required falsification axes.
