# Wake-policy candidate notes

## Evidence diagnosis

- The assigned-parent guidance preserves only the common-seed lesson, while
  its inherited worker logs and the sampled completed rollouts now provide a
  sharper comparison. Every referenced evaluation used direct uniform still
  water at `U_infinity=(0,0,0)`, no cylinders, and no prewarm, so the visible
  trajectories and wakes are policy-generated rather than ambient advection.
- The strongest finite example is the sharp bearing/trend posterior-mean
  controller (`solver_7afa3aa3b5d0`). Its top-down row shows sustained
  leftward self-propulsion and an alternating mid-plane wake; its oblique row
  confirms a coherent three-dimensional Lambda2 trail through `12T`. It
  reduces distance from `12.328L` to `9.141L`, reaches `0.753U`, and lasts
  `13.129T`. This supports retaining its zero-centered anterior oscillator,
  posterior lag, `0.20 rad` bearing scale, and bounded cruise curvature.
- The useful path still ends in an upper-boundary exit. Bearing changes from
  about `+0.09 rad` at `6T` to `-0.08` at `8T`, `-0.31` at `10T`, and
  `-1.28` at termination while center y rises from `13.99L` to `15.20L`.
  Thus the static posterior offset helps forward progress but cannot arrest
  the large wrong-way yaw after alignment is crossed. Posterior acceleration
  is already at its envelope in about `62%` of samples, so another unbounded
  additive acceleration or carrier-gain increase is unsupported.
- Broader/weaker static posterior offsets repeat the same topology much
  earlier: `solver_7125e140ff9f` and `solver_f222e3379ba1` exit at `9.350T`
  and `9.191T` with minima `11.642L` and `11.824L`. Their two visual rows show
  short coherent wakes followed by the same upward hook, so their smaller or
  slower target response is not a useful starting point.
- Phase-aware half-cycle steering also fails this evidence test. Attenuating
  the turn-opposing half-cycle on top of the strong static offset
  (`solver_34a7dbcb0a78`) regresses closest approach to `9.855L`; replacing
  the offset with signed half-cycle scaling in the inherited
  `solver_2eee69704138` regresses to `11.655L` and exits at `9.086T`. Both
  combined sheets retain a wake but still curve into the upper boundary.
  Later candidates should not treat more half-cycle asymmetry as a supported
  repair for this failure class.

## Policy hypothesis

Retain the strongest sampled controller as a cruise mode and add one new,
continuous burst-redirect mechanism in the posterior target. When the
magnitude of bearing plus its bounded windowed trend is small, use the proven
`12 deg` mean-curvature cruise target and full lagged carrier. When that
predicted body-frame error grows beyond a moderate threshold, smoothly raise
the bounded posterior mean curvature while reducing both carrier half-cycles.
This creates a nonsteady redirect rather than a larger static gain: yaw
correction temporarily takes priority over thrust, and the same geometry and
trend signal releases the redirect and restores the carrier as alignment
recovers. The anterior oscillator remains unchanged and the complete posterior
target is bounded below the joint-angle envelope.

The next evaluation should preserve the parent's coherent cruise wake through
the first alignment crossing, then reduce upward drift, contain negative
bearing, and survive beyond the upper-exit topology or improve closest
approach past `9.141L`. Falsify the mechanism if the redirect activates during
the small-error cruise, collapses useful x progress without recovering
bearing, retains the same upper exit, or increases angle/rate saturation or
load spikes.

bookshelf_consulted: true
source_domain: biological C-start or burst turning combined with classical posterior traveling-wave propulsion
source_mechanism: large observed direction error gates a strong bounded bend, and observed recovery releases the bend back into a propulsive posterior beat
transferable_invariant: temporarily trade rhythmic thrust authority for curvature only while body-frame direction error is large or diverging, then continuously restore the traveling carrier as the response reduces that error
nontransferable_details: species-specific C-start shape, published bend magnitudes, dimensional timing, exact vortex phase, full-body kinematics, and task-specific routes
policy_translation: use bounded body-frame bearing plus its windowed trend to blend between the strongest sampled posterior cruise target and a bounded high-curvature, reduced-carrier redirect while leaving the anterior joint-state oscillator unchanged
falsification: reject if small-error propulsion is degraded, large negative bearing is not contained, the same upper-domain exit persists without better progress, or actuator/load histories worsen materially
