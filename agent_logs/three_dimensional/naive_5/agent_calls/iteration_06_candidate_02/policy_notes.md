# Course-angle unilateral-pump candidate

## Evidence diagnosis before the edit

- All four sampled rollouts are contract-valid direct-uniform still-water
  evaluations (`U_infinity=(0,0,0)`, no cylinders, no prewarm). In every
  combined keyframe sheet the top-down row shows self-propelled translation and
  an alternating vorticity trail, while the oblique row confirms a coherent
  three-dimensional caudal Lambda2 wake. The route difference is therefore a
  controller response, not advection or moving-window transport.
- `solver_12fc3441a636` is the best scalar but an informative route failure.
  Its raw-yaw course closure bends the top-down wake upward, raises the center
  from about `13.87L` at `8T` to the `15.20L` boundary, and terminates at only
  `20.790T` with `6.268L` remaining. The oblique row ends with the same short,
  coherent trail rather than a loss of propulsion.
- The assigned parent `solver_aaab22dcaa09` preserves a coherent, nearly
  horizontal wake to `38.671T`, but passes the target longitude near `24.6T`
  about `4.7L` high and exits left. Its parent-derived course-bias child
  `solver_74980306a278` repeats that topology and makes it worse: minimum
  distance changes from `4.676L` to `5.016L`, the late corridor rises from
  about `y=14.0L` to `y=14.4L`, and both terminate near `38.7T`. Thus adding a
  larger course setpoint inside the phase-rejected yaw loop is not evidenced
  steering authority.
- `solver_8b43d67d5abc` supplies the useful contrast. Direct course-based
  half-cycle selection lowers the exit to `y=13.778L` and improves closest
  approach to `4.516L` without collapsing either visual wake, but it still
  travels past the target and exits left. Its signed course angle grows from
  about `0.46 rad` at `8T` to `1.57 rad` at target-longitude crossing and
  `2.82 rad` at exit, whereas the sine-only cross-product signal falls from
  `1.0` to `0.32` after the target is behind. The existing selector therefore
  loses urgency precisely when a redirect is required.
- The three long carriers spend about `44--45%` of samples with at least one
  joint at the speed cap and `59--60%` at the acceleration clamp. Stronger
  additive half-cycle selection is consequently confounded with clipping:
  the parent's mean selector grows in magnitude from about `0.22` to `0.54`
  in `solver_74980306a278` without a beneficial route response.

## Policy hypothesis

Preserve the evidenced `0.90T/18 deg` traveling-bend carrier, anterior phase
pump, posterior lag, and angle headroom. Replace additive response-gated
half-cycle acceleration with one bounded actuation-allocation mechanism. Form
the full signed angle from body-frame velocity to the target using both the
cross and dot products; blend continuously to bearing while speed is small.
Use its calibrated half-stroke sign to attenuate the phase pump only on the
opposing half-cycle. This creates amplitude/duty asymmetry by withholding
energy rather than adding another command into the active clamps. As measured
course aligns, attenuation vanishes; if the fish passes the target, the dot
product keeps the redirect request strong instead of letting a sine-only
signal decay.

Expected result: the coherent carrier remains self-propelled, but its course
turns downward before or shortly after target-longitude crossing instead of
remaining in the `y=14L` corridor. Falsify the mechanism if it repeats an
upper exit, cannot improve on the `4.516L` direct-selector minimum, still exits
left without a meaningfully different turn, destroys the alternating 3D wake,
or fails to reduce speed/acceleration limit residence while reducing drive on
one half-cycle.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and asymmetric flapping or duty-ratio control
source_mechanism: measured direction error continuously redistributes energy between rhythmic half-cycles while the propulsive oscillator remains the carrier
transferable_invariant: preserve the traveling wave, infer gait side from joint state, and produce a bounded turn by weakening the half-cycle opposed to the measured body-frame course request; release the asymmetry as course aligns
nontransferable_details: published gains, clocked CPG phase, linkage geometry, dimensional cadence, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: compute a speed-gated signed course angle from body-frame target and velocity dot/cross products, map it to the response-calibrated stroke side, and attenuate only the opposing anterior phase pump without increasing carrier or steering acceleration
falsification: reject if cross-track progress does not beat the `4.516L` direct-selector result, the left-exit topology remains unchanged, wake coherence or propulsion collapses, or actuator-limit residence does not fall
