# Multi-wake policy diagnosis and hypothesis

## Evidence read before editing

- The assigned parent guidance identifies the prefilled controller as a
  target-blind joint-state oscillator and asks for bounded, normalized
  body-frame feedback. No inherited optimizer log is present in this
  workspace, and the only sampled solver result is the naive seed
  (`solver_899193877bf6`), so there is no positive finite comparator to claim.
- The shared prewarm sheet shows the common held fish above and downstream of
  four developed, interacting staggered vortex streets. At release the fish is
  still outside the useful merged-wake/target region; this is common initial
  condition evidence, not a controller outcome.
- In the released sheet, the seed begins approximately toward the target but
  its visually rapid, small-scale tailbeat does not hold that direction. The
  body turns steeply downward, its path bends away from the target/wake region,
  and it exits the lower domain without a cylinder collision.
- The numerical evidence supports that reading: termination is `left_domain`
  after only `50.1269` of the `300` release horizon; head displacement is
  `(-3.545, -13.300)L`; minimum distance improves only to `8.615L` before final
  distance returns to `12.123L`; mean local vertical flow (`-0.241`) nearly
  matches mean fish vertical velocity (`-0.263`), while mean relative vertical
  flow is only `0.0219`. Thus the large visible lateral excursion is primarily
  advection/yaw failure rather than useful cross-wake self-propulsion.
- Both joint velocity and acceleration reach their configured hard limits
  (`4.5379 rad/time` and `31.4159 rad/time^2`), command-energy mean is
  `1496.25`, and the estimated tailbeat/shedding ratio is `32.83`. The current
  `0.55` cadence therefore produces saturated effort without route retention;
  the evidence does not justify wake-frequency matching or a phase-specific
  open-loop command.

## Candidate hypothesis

Retain the seed's state-encoded traveling-bend oscillator, but slow and reduce
it enough to avoid routine rate/acceleration clipping. Shift the oscillator's
mean curvature with a bounded target-bearing term, oppose body-frame lateral
drift, and add a smaller normalized-moment damping term. Keep the posterior
joint following only the oscillatory component so the steering offset remains
as smooth net tail curvature instead of being canceled by the lagged joint.

This uses only normalized/body-frame passive observations already exposed by
the task and owns every gain and bound in `target_policy_params()`. It does not
encode coordinates, time, wake phase, or a route. The later CFD rollout can
falsify the hypothesis if the fish still exits near 50 time units, if joint
saturation/load remains persistent, or if bearing correction turns with the
wrong sign. Supporting outcomes would be a finite release substantially beyond
the seed's exit, reduced joint-limit contact/effort, retained upstream-leftward
progress, and a lower final/mean target distance before any claim of capture.
