# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The assigned parent guidance is the fresh-lineage guidance copied from
  `optimizer_8e0d898b9ac1`. No inherited `logs/optimize/` directory exists, so
  there is no prior candidate note to treat as rollout evidence.
- The sole sampled solver, `solver_5434ff87b2ba`, is the common naive seed. It
  used direct uniform still-water initialization (`U_infinity=(0,0,0)`), was
  numerically stable, and terminated `left_domain` at `8.5965T`. Distance began
  at `12.3277L`, improved only to `12.0694L`, and ended at `12.3647L`; the best
  progress was therefore just `0.2583L` before reversal.
- In the combined keyframe sheet, the top-down row shows the tail generating a
  coherent alternating wake and translating the body, while the path bends
  increasingly toward the upper boundary. The oblique Lambda2 row confirms a
  genuinely three-dimensional, connected posterior vortex trail rather than
  passive advection or a prewarm artifact. Thus the useful behavior to preserve
  is the state-feedback traveling bend and its self-propulsion.
- The target-relative failure is visible in the trajectory: reconstructed
  body-frame bearing changes from `+8.9 deg` at release to `-1.7 deg` near
  `3.97T`, then diverges to `-72.4 deg` at exit while the controller continues
  applying zero steering. The body-frame lateral speed reaches about `0.24U`
  and yaw rate repeatedly reaches order `1/T`. The dominant missing capability
  is bounded target-relative yaw regulation, not more oscillator gain.

## Policy hypothesis

Preserve the seed oscillator, amplitude, frequency, and posterior lag, but run
the oscillator about a bounded mean-curvature equilibrium computed from the
normalized body-frame bearing. Add measured heading rate inside the same
bounded feedback signal so curvature relaxes when the turn response is already
correct and strengthens when yaw is worsening the bearing. Apply the same mean
bias to both joints, matching the repository's calibrated fact that positive
joint bias produces negative yaw. This should keep the coherent propulsive
wave while reversing the late over-turn before the upper-domain exit.

This is one mechanism-level architecture change, not a scalar-only retune. Its
evaluation should be rejected if it destroys the posterior wake, produces
persistent action/joint saturation, leaves the same upper-boundary topology,
or fails to improve the `12.0694L` closest approach and `8.5965T` survival.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and fish mean-curvature turning
source_mechanism: sensor-driven bounded mean tail-beat bias superposed on a propulsive rhythm
transferable_invariant: persistent target error should shift mean body curvature while the posteriorly lagged traveling bend remains the propulsion carrier
nontransferable_details: published gains, actuator geometry, species kinematics, dimensional beat frequency, exact wake phase, and task-specific routes
policy_translation: map normalized body-frame bearing plus normalized measured heading rate through a bounded nonlinearity to equal two-joint mean curvature, with phase encoded only by joint angle and velocity
falsification: reject if target bearing does not recover after its first sign crossing, if propulsion collapses or saturation becomes persistent, or if the fish repeats the upper-boundary exit without better distance progress
