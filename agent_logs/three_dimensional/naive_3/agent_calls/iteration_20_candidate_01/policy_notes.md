# Continuous posterior stopping-risk candidate

## Completed evidence and visual diagnosis

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. All capture at
  about `18.27T`. Their top-down sheets show the same coherent alternating
  vorticity street through the target approach, while the oblique sheets show
  compact three-dimensional Lambda2 structures behind an actively undulating
  body at `12T`, `16T`, and capture. Peak body speed is about `1.329U`, versus
  only `0.0315U` peak measured local flow, so the route is self-propelled and
  is not moving-window transport or passive still-water advection.
- The inherited `0.857L` left-exit near miss is the informative visual
  trajectory failure. Its two views retain a strong wake, but the fish passes
  nearly tangent to the capture circle and continues left while course error
  remains large. The later acceleration-reserve controller converts that
  topology into capture without adding drive: it reduces sampled posterior
  raw acceleration exceedance from about `67.5%` to `46.4%` by preventing the
  carrier from erasing the saturated course-steering request.
- The unguarded captured prefill reaches exactly `-45 deg` at the posterior
  joint and produces coincident terminal force and yaw-moment peaks of
  `0.20756` and `0.09276`. The fixed `8 deg` geometric brake preserves capture
  and lowers those peaks to `0.17183/0.07699`, but still reaches `-45 deg`
  because it ramps after the remaining margin is already smaller than the
  observed stopping distance.
- Both sampled velocity-aware guards preserve capture and the visually
  indistinguishable broad wake while avoiding posterior contact. The hard
  viability guard limits posterior excursion to about `42.78 deg`; the
  continuous stopping-risk barrier limits it to about `43.00 deg`. In both,
  peak force and yaw moment revert to the nonterminal values
  `0.03716/0.01907`. The continuous case has the slightly better sampled score
  (`-0.248270` versus `-0.248277`) and avoids introducing a discontinuous
  maximum-braking switch, so it is the evidence-backed candidate base.
- This does not establish low-effort locomotion: all sampled captures still
  touch the `260 deg/T` velocity limit in `147/85` anterior/posterior samples,
  and the continuous guard retains about `51.3/46.4%` raw acceleration
  exceedance. Those are later optimization targets, not reasons to disturb a
  newly demonstrated safe-capture mechanism in this candidate.

## Policy hypothesis written before the solver edit

Replace the prefilled unguarded terminal controller with the sampled
continuous posterior stopping-risk barrier while preserving its full-quadrant
normalized target ray, measured body-frame velocity course, zero-centered
anterior oscillator, posterior traveling wave, distance-conditioned
acceleration reserve, and physical limits. Compare posterior kinetic stopping
distance with remaining angle margin in the current direction of motion. Only
inside the already active terminal-allocation regime, smoothly cap outward
acceleration as normalized risk rises and demand bounded inward braking once
the state reaches the predicted stopping boundary.

This is a promotion of a completed mechanism, not a claim about this worker's
unevaluated rollout. The expected signature is repeat capture near `18.28T`,
the same alternating three-dimensional wake, posterior excursion below
`44 deg`, and no terminal load spike. Falsify the promotion if capture is
lost, the broad trajectory changes before the terminal risk gate activates,
posterior contact returns, peak terminal force or yaw moment exceeds the
sampled `0.03716/0.01907` envelope, or the constraint suppresses the carrier
instead of releasing when joint motion turns inward.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal capture control
source_mechanism: preserve a productive rhythmic carrier while observed mechanical risk gates a bounded terminal correction
transferable_invariant: retain target-directed traveling-wave propulsion and constrain only joint motion whose normalized stopping distance predicts contact, releasing the correction when the risk clears
nontransferable_details: published gains, robot linkage geometry, species-specific envelopes, dimensional cadence, clock phase, exact vortex phase, task-specific routes, and source actuator ratings
policy_translation: keep normalized target_body_L versus velocity_body_U course feedback and the two-joint acceleration-reserve carrier; use posterior angle, angle velocity, and the owned acceleration envelope to form a smooth terminal stopping-risk barrier
falsification: reject if capture or coherent alternating 3D shedding is lost, intervention changes the broad route, posterior contact returns, or terminal force and yaw-moment peaks exceed the sampled safe-barrier result
```
