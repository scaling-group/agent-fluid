# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the assigned parent guidance, the four current sampled solver scores,
observations, metrics, nested diagnostics, and policies, and the available
inherited optimizer notes and evaluated descendants before writing this note.
Following the wake-visual-signals procedure, I inspected the common prewarm
sheet first and then the released sheets for the `0.75`, `0.77`, `0.745`,
`22.25 deg`, and `29 rad/time^2` variants. The current sampled set contains no
collision, exit, or unstable sheet; the older reversed-sign instability is
therefore retained only as an inherited safety boundary rather than presented
as newly inspected visual evidence. No omitted Bookshelf material, neighboring
configuration, repository history, coordinate route, clock, or external
research was used.

The common prewarm frames show the held fish above and downstream of four
developed, interacting vortex streets, with the target in the second-row wake
overlap. This is identical initial-condition evidence for every candidate, not
support for a memorized route.

The duplicated `steering_gain=0.75`, `22 deg`, `28 rad/time^2` sheets show the
strongest finite behavior. The fish makes a bounded down-left turn, maintains
a compact diagonal upstream approach, enters the developed target wake from
the right, and first crosses the `0.75L` target circle without a loop,
collision, or boundary excursion. Capture takes `74.23` release units and mean
distance is `2.561L`. Its mean world x velocity is `-0.14682` against local
flow x `-0.08249`, so the `0.06433` upstream-relative component confirms
self-propulsion rather than passive advection. RMS force/moment remain
`22.39/393.08`; joint angles and speeds stay below their hard limits, although
both accelerations touch the candidate's `28 rad/time^2` guard.

Four nearby isolated changes all preserve capture but regress from that route:

- The current `0.77`-gain prefill visibly makes a deeper correction before
  wake entry. Arrival rises to `78.58`, mean distance to `2.661L`, total command
  energy to `52761`, and RMS force to `23.77`, while upstream-relative x speed
  falls to `0.06261`.
- The inherited fitted `0.745` gain takes the clearest inferior topology,
  passing below the direct corridor and returning from underneath. Arrival is
  `86.99`, mean distance `2.694L`, upstream-relative x speed `0.05865`, and RMS
  force/moment `39.84/540.72`. This falsifies smooth interpolation around the
  narrow gain optimum on the common snapshot.
- Raising only amplitude from `22` to `22.25 deg` slows capture to `76.95`,
  lowers upstream-relative x speed to `0.05926`, raises total command energy to
  `54203`, and raises RMS force/moment to `24.75/420.04`. Its extra visible bend
  does not translate into faster upstream closure.
- Raising only the soft acceleration guard from `28` to `29 rad/time^2`
  produces a longer final correction and reaches at `80.00`; upstream-relative
  x speed falls to `0.05804` and RMS force/moment rise to `33.84/488.89`.
  Guard contact in the anchor therefore is not, by itself, evidence that more
  acceleration authority improves tracking or propulsion.

## One candidate hypothesis

Replace the `0.77` prefill with the directly evaluated anchor: positive-bearing
gain `0.75`, steering bound `10 deg`, `0.75`-period and `22 deg` state-energy
oscillator, the complete posterior traveling-bend response, and the
`28 rad/time^2` candidate guard. This is an evidence-backed rollback of the
prefill's one unsupported gain increment, not another interpolation. It keeps
all feedback normalized and body-relative and introduces no clock, coordinate,
route, force, flow, or unavailable probe dependence.

The falsifiable expectation is deterministic finite capture near `74.23`
release units with mean distance near `2.561L`, upstream-relative x speed near
`0.0643`, no joint-angle or speed hard-limit contact, and loads near
`22.39/393.08`. Reject the anchor as reusable if a held-out wake phase, inflow,
or cylinder layout loses capture or reverses the neighboring-variant ordering.
No new CFD result for this workspace candidate is claimed.
