# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis

- I read the Phase 2 task and guidance contracts, the assigned parent
  experience, all four sampled solver policies, scores, observations, metrics,
  embedded wake diagnostics, and the available inherited optimizer notes. I
  inspected the common held-fish prewarm sheet first, then the released sheets
  for the three replicated `tail_steering_gain=0.60` anchors and the isolated
  `0.65` result. I also inspected the assigned parent's high-speed damping
  regression as the most informative inherited negative comparison. No omitted
  Bookshelf material, neighboring configuration, repository history, clock,
  coordinate route, or external research was used.
- The shared prewarm sheet shows the fish held above and downstream of four
  staggered cylinders while their interacting streets develop, with the target
  in the merged second-row wake. It is common initial-condition evidence, not
  support for a memorized route or candidate-specific wake phase.
- The three executable `tail_steering_gain=0.60` anchors reproduce identical
  finite target capture in `73.859` release units with `2.4800L` mean distance,
  `0.06565` mean upstream-relative x speed, `51797` command energy, and RMS
  force/moment `24.94/410.68`. Their sheets show self-propelled diagonal
  movement into the developed wake, a pass below the target, and a bounded late
  correction into the `0.75L` capture circle without collision or domain exit.
  Both commands touch the `28 rad/time^2` candidate guard, but angles and joint
  speeds remain inside the task envelope.
- Raising only posterior mean-curvature sharing from `0.60` to `0.65` preserves
  that compact visual topology while starting the final lower-to-target closure
  slightly earlier. Metrics corroborate the route improvement: arrival falls
  to `72.160`, mean distance to `2.4638L`, mean upstream-relative x speed rises
  to `0.06732`, and total command energy falls to `51284`. The tradeoff is a
  small load and oscillation increase: RMS force/moment rise to
  `25.32/420.32`, RMS relative crossflow to `0.1360`, and posterior peak speed
  to `3.367`; both acceleration commands still touch `28`.
- No current sampled solver is a termination failure. The inspected inherited
  normalized high-speed damping schedule is therefore a failed optimization
  hypothesis rather than a safety failure: its visibly lower, kinked route
  regressed to `77.291` arrival and `2.6304L` mean distance while remaining
  finite. Together with inherited guard, damping, and energy-gain route
  branches, this makes an unevaluated continuation above `0.65` less defensible
  than promoting the exact observed improvement.

## Single-candidate hypothesis

Promote the exactly evaluated `tail_steering_gain=0.65` controller. Preserve
the parent's `0.75` period, `22 deg` oscillator, `2.1` energy-restoration gain,
bounded pure-bearing `0.75/10 deg` anterior steering, `0.55` lag, `0.65`
damping, and common `28/28 rad/time^2` command guard. At saturated anterior
steering, the isolated change adds at most `0.5 deg` of posterior mean-curvature
target; it does not alter oscillatory propulsion, observations, or authority.

This is an evidence-backed same-snapshot promotion, not a claim that posterior
steering response is monotone. Later CFD should reproduce finite compact
capture near the sampled `0.65` result. Retain it only while closure and
relative propulsion gains outweigh the modest load increase; falsify reuse if
a held-out wake phase, inflow, geometry, or target placement selects a deeper
route, loses capture, or raises load without quicker and more compact closure.
