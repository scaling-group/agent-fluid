# Middle-approach posterior phase handoff

## Evidence read before the edit

- I inspected `wake_observation.md`, `wake_metrics.csv`,
  `wake_diagnostics.json`, the trajectories, and both rows of the combined
  `wake_keyframes.jpg` for all four sampled solvers. Every rollout reports
  direct uniform initialization at `U_infinity=(0,0,0)`, no cylinders, finite
  dynamics, `239` moving-window shifts, and capture at about `16.0544T`.
- In both score classes, the top-down sequence grows from quiescent release
  into a strong alternating red/blue street and the body translates under its
  own undulation. The oblique Lambda2 row shows bounded alternating 3D
  structures shed behind the caudal region, with no prewarm wake, advective
  shortcut, wake collapse, domain interaction, or instability. The fish turns
  onto the target-directed route and reaches the capture sphere while a large
  finite wake remains behind it.
- The two sampled policy hashes differ only by a carrier-demodulated
  line-of-sight mean-curvature branch. It changes `128/2919` commands and at
  most `8.55e-5L` of the path, while every `8/6/4/2/1.25/1.0L` milestone,
  `239` shifts, and the visible two-view wake remain unchanged. Its better
  result is only `0.7458456L` versus `0.7458538L` at the same capture time.
  The sampled optimizer logs repeat these two terminal outcomes; they do not
  supply evidence that another terminal gain or onset will create useful
  trajectory diversity.

## Diagnosis and candidate hypothesis

The carrier and target-directed mean steering are already successful, while
recent mean-curvature and wave-relief additions act mainly on the final
fraction of a beat. The unresolved test is actuator allocation earlier in the
closing approach. Preserve the proven mean route and coherent carrier, but
use a different feasible-action primitive between `1.75L` and the established
`0.90L` terminal handoff: subtract recent body turn from recent bearing motion
to expose target-line change caused by translation, and only when that
normalized residual is persistently reopening the bearing, reduce the
posterior velocity-phase lag by a bounded amount. This is a state-feedback
phase translation, not a new mean bend, an acceleration-clamp wrapper, or a
clocked maneuver. It is reflection equivariant, retains the anterior carrier,
never increases the lag coefficient, and fades away as terminal line-of-sight
damping takes over.

The candidate is useful only if it changes the middle approach without losing
the established route: advance the `1.25L` or `1.0L` milestone or reduce the
observed distance integral while retaining capture, wake coherence, and the
force/limit envelope. Reject the mechanism if it merely changes the last
crossing, delays a milestone, increases limiting or loads materially, breaks
the alternating wake, or makes capture less reliable.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and two-joint phase-lag steering
source_mechanism: sensor-conditioned posterior phase-lag modulation preserves the rhythmic carrier while reallocating tail-force timing
transferable_invariant: modulate posterior wave timing from bounded measured response while leaving the anterior oscillator and target-directed mean bend intact
nontransferable_details: published gains, clock phase, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: in the reliable closing middle approach, use normalized recent body-frame bearing motion minus recent body turn to reduce only the posterior velocity-phase lag when translational line-of-sight error is reopening; fade to the inherited terminal controller below 0.90L
falsification: reject if pre-approach motion changes, the 1.25L or 1.0L milestone and distance integral do not improve, capture or wake coherence is lost, or actuator/load growth outweighs route benefit
