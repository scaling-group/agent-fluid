# Course-supported paired terminal-release candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled solvers satisfy the frozen Phase-2 contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window dynamics, and capture from `12.32772 L`.
  Three are byte-identical evaluations of the assigned v26 parent and
  reproduce score `-0.5281078349`, mean distance `2.4291113720 L`, final
  distance `0.7461675406 L`, and capture at `25.1185226 T`.
- The distinct sampled v28 course-supported paired release retains that
  capture step while improving score to `-0.5281032175`, mean distance to
  `2.4291077322 L`, and final distance to `0.7461626530 L`. This is a small
  completed-rollout improvement, not evidence that a larger release would be
  better.
- I inspected the combined keyframe sheets for the v28 result and the
  inherited v27 shared-mean-unloading regression (`-0.5295582789`). In both
  top-down rows the fish self-propels along the same compact target-directed
  arc and sheds a coherent alternating wake; it is not advected. The oblique
  rows show finite three-dimensional Lambda2 structures through the outer
  approach and a quiet held-bend handoff before capture. Neither rollout shows
  collision, domain-exit precursors, wasteful terminal oscillation, or
  numerical instability, so the coarse images cannot rank their subtle late
  differences without trajectory and load evidence.
- The inherited phase-selective common-carrier candidate is the second useful
  negative. It preserves capture and the outer wake but regresses to score
  `-0.5281232687`, mean distance `2.4291235633 L`, and final distance
  `0.7461837530 L`. Together with the shared-mean regression, this indicates
  that the terminal course signal is useful as a smooth release condition,
  not yet as authority to phase-scale the carrier or unload static curvature.

## Policy hypothesis

Promote the evaluated v28 policy as the single candidate. It preserves v26's
state-feedback oscillator, posterior lag, target-angle redirect, closure
preview, shared mean-curvature equilibrium, and crossflow-supported coupled
release. Its only added mechanism computes the unsigned angle between
normalized body-frame target direction and body velocity; convergence below a
declared band, together with the existing late proximity, helpful crossflow,
positive closure, and settled-joint gates, earns at most `0.035` additional
paired release toward the same mean-centered carrier.

The candidate does not change mean bend, split joint roles, select a beat side,
add a route, or use time. The next CFD evaluation should reproduce the sampled
capture and small distance-integral improvement. Reject the mechanism if it
changes the outer trajectory, delays or loses capture, weakens closure/course
alignment, restores carrier oscillation, saturation, joint-stop dwell, load
growth, instability, or wake degradation. Because the measured advantage is
only about `4.6e-6` in score, a non-reproduction also falsifies the promotion.

bookshelf_consulted: true
source_domain: biological response release and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: release strong corrective curvature continuously after observed motion becomes target-directed while preserving the propulsive rhythm
transferable_invariant: reduce corrective allocation only when normalized target-relative kinematics and settled actuator response demonstrate useful continued closure
nontransferable_details: species escape kinematics, published gains, dimensional cadence, clock phase, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: body-frame target and velocity directions form a bounded course-alignment gate that adds a small paired release to the inherited proximity, helpful-crossflow, closure, and two-joint settled-response support
falsification: reject if the gate is inactive, affects the outer path, unloads the shared mean, delays or loses capture, worsens course or closure, or restores oscillation, saturation, joint stops, load spikes, instability, or wake loss

