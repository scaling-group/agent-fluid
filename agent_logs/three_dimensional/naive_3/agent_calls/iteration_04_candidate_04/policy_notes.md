# Wake-policy candidate notes

## Evidence diagnosis before editing

- The assigned parent guidance, all four sampled solver evaluations, and the
  inherited optimizer logs were read before proposing the policy. Every
  sampled rollout is a finite direct-uniform still-water release with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot, so none of the
  apparent progress is passive advection or a prescribed wake interaction.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows for
  all four samples, with the `2.4431L` near-miss as the strongest finite example
  and the `3.5871L` half-cycle result as the informative weaker trajectory. Both
  visibly self-propel and retain alternating three-dimensional wakes, but both
  cross below the target and exit the lower boundary. The near-miss survives to
  `31.097T`; its local-flow magnitude is about `0.02U` near mid-rollout while
  body speed is roughly `0.7U`, confirming a powered overshoot rather than wake
  advection or moving-window transport.
- The parent bearing-gated policy is still the best completed rollout: it moves
  from `12.3277L` to `2.4431L` at `17.869T`. Distance then increases to
  `9.1933L` at the lower-boundary exit. From `15T` to `18T`, reconstructed full
  body-frame target direction grows from about `0.80` to `1.61 rad` while
  forward body speed remains about `0.66--0.77U`; the coherent wake continues,
  so the missing behavior is an earlier course redirect rather than propulsion
  recovery.
- Three completed variants leave that topology unchanged. Distance-conditioned
  carrier relief reaches only `2.8455L`; replacing acute bearing with full
  target direction reaches `2.4939L`; and the inherited away-half-cycle brake
  reaches `2.5009L`. Each still exits below. Full direction is the correct
  target-ahead/behind representation, but changing it only after a pass is too
  late, while carrier attenuation or anterior return braking alone does not
  create enough pre-pass course correction.
- The instantaneous heading-rate term is not a slow response signal in this
  gait. Before `18T`, `|heading_rate|` exceeds `2 rad/T` for about `42%` of the
  strongest rollout, and `direction - 0.18*heading_rate` reverses sign relative
  to target direction for about `23%` of those samples. The anterior command is
  already clamped about `75%` of the rollout. Increasing curvature, command
  ceiling, or half-cycle acceleration would therefore repeat contradicted
  saturation-heavy mechanisms rather than separate navigation from tailbeat
  yaw.

## Policy hypothesis

Preserve the evidenced `0.55T`, 28-degree joint-state carrier, restrained
7-degree full-anterior curvature limit, posterior lag, full-direction posterior
gate, and `28 rad/T^2` acceleration reserve. Replace the instantaneous yaw-rate
release with one course-tracking mechanism: compute the fish's bounded travel
angle from normalized body-frame velocity and subtract it from the bounded full
target direction. The mean bend then responds to target-versus-course error,
not the fast rigid-body yaw oscillation created by the tailbeat. This remains
state feedback and uses no clock, world coordinate, route, or case identity.

The expected signature is unchanged early wake coherence and forward progress,
but a sustained pre-pass bend when the velocity course falls to the wrong side
of the target direction, followed by a smaller miss than `2.4431L` or a better
termination class. Falsify the mechanism if it weakens early propulsion,
creates a tight-turn topology, preserves the same lower-boundary overshoot,
increases command/rate residence, or fails to reduce target-versus-course error.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and fish target-to-curvature steering
source_mechanism: superpose a bounded navigation bend on a propulsive rhythm using target direction and measured translational slip
transferable_invariant: slow body-frame target-versus-course error should command mean curvature while fast joint-state oscillation continues to supply a traveling bend
nontransferable_details: published CPG gains, clocked phase, robot geometry, species-specific kinematics, exact vortex phases, dimensional lookahead, and task-specific routes
policy_translation: compute full direction from normalized target_body_L, compute course angle from normalized velocity_body_U, and map their bounded difference to the existing two-joint mean-curvature carrier while retaining direction-gated posterior propulsion
falsification: reject if early target progress or wake continuity degrades, the same powered lower-boundary overshoot remains, a tight turn replaces it, or actuator-limit residence worsens
```
