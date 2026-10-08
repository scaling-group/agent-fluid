# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The assigned parent is the prefilled `solver_c33f31eb9226` target-error
  allocation. It captures at `23.122009T`, has mean distance `2.127679L`,
  score `-0.231273`, mean action about `58.990`, peak normalized
  force/moment `0.030527/0.015817`, and anterior/posterior rate-cap occupancy
  about `11.68/6.21%`. Its direct-uniform background is exactly zero. The
  combined sheet has a valid top-down row but a black labeled oblique row, so
  it cannot independently establish preservation of the three-dimensional
  wake.
- The executable phase-lag controls `solver_bd37a8d7a3f9` and
  `solver_4e1a15b275ab` reproduce capture at `23.122009T`, mean distance
  `2.133413L`, and score `-0.237071`. The latter has a complete oblique row:
  the top-down alternating street corresponds to discrete three-dimensional
  Lambda2 structures at `4T`, `12T`, `20T`, and capture. Together with still
  water, sustained forward motion, and finite alternating joint motion, this
  is evidence of self-propulsion rather than passive advection.
- Relative to that phase-lag control, the assigned parent is ahead through
  `10T` (`8.646L` versus `8.822L` at `8T`, and `7.311L` versus `7.390L` at
  `10T`) but behind late (`2.101L` versus `2.026L` at `20T`). Its bounded
  target-error allocation therefore improves the integrated route and action
  envelope without improving the crossing time.
- `solver_ed8cdbcee113` keeps the phase-lag carrier but uses a bounded
  line-of-sight-rate lead only in posterior-rudder recruitment. Its valid two-
  view sheet retains the same S-route, alternating mid-plane street, and
  discrete Lambda2 wake. It is identical to the phase-lag control through the
  early route, then is ahead at `18T` (`2.999L` versus `3.028L`) and `20T`
  (`1.972L` versus `2.026L`), capturing at `22.572023T`. The trade is mean
  distance `2.127978L`, score `-0.232481`, mean action about `60.545`, and
  posterior rate-cap occupancy about `7.21%`. This is a useful later steering
  mechanism but not by itself a scalar win over the assigned parent.
- Inherited optimizer logs reinforce the mechanism boundary: a through-water-
  speed crossfade regressed to `-0.249630`, and target-side phase-recovery
  redistribution regressed to `-0.244905`. Those tests argue against another
  speed selector or beat-side modification of the posterior recovery. The two
  current positive effects instead occupy separable roles: slow target-error
  allocation of a fixed recovery share and bounded translational line-of-sight
  lead in the independently scheduled rudder gate.

## Visual diagnosis

All four top-down rows show the established target-directed S trajectory and a
coherent alternating wake up to first crossing; none shows coasting, upper/lower
domain escape, or a wake collapse. The valid oblique rows in the line-of-sight
sample and one phase-lag repeat show discrete alternating structures rather
than an unstructured load burst. The assigned parent's early progress is
visibly stronger, while the line-of-sight sample bends onto the target sooner
late in the approach. Black oblique rows in the parent and one phase-lag repeat
are render failures and are not counted as wake observations.

## Policy hypothesis

Retain the assigned parent's convex, full-target-error allocation between
whole-carrier and velocity-quadrature posterior recovery. Add the sampled
bounded residual `bearing_window_rate - turn_rate_recent`, project it one
carrier period, and use the led full target error only in the existing
posterior-rudder error gate. Keep geometric rudder sign, peak rudder authority,
carrier phase, recovery budget, terminal relief, and every other control path
unchanged. This should combine the parent's early distance-integral advantage
with the line-of-sight sample's later approach advantage without stacking a
new actuator command.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological/robotic approach scheduling
source_mechanism: modulate a preserved propulsive rhythm with bounded sensor-feedback anticipation in the steering channel
transferable_invariant: preserve the traveling carrier while slow body-frame target geometry and bounded measured line-of-sight motion schedule an existing steering load
nontransferable_details: published CPG gains, species kinematics, dimensional lead times, exact wake phase, and task-specific routes
policy_translation: subtract recent body turn from the short-window bearing rate, clamp the normalized residual, project it one observed carrier period, and apply it only to the posterior-rudder recruitment gate
falsification: reject if capture is lost or later than 23.122009T, mean distance is not below 2.127679L, score does not exceed -0.231273, or the established route, carrier wake, action, rate-cap, force, or moment envelopes worsen; a clean composition should also approach the sampled 22.572023T arrival

The source shelf supplied only the carrier-preserving sensor-modulation
invariant. The actual observation, sign, scale, and one-period bound come from
the sampled L64 rollouts, not from published settings.
