# Replicated course-supported response-release candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled solvers satisfy the frozen Phase-2 contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window dynamics, and capture at `25.1185226 T` from
  `12.3277197 L`.
- Three independent samples (`solver_44ab37a6c1df`,
  `solver_5b4d6d3993a2`, and `solver_65ec0c80e778`) are byte-identical v28
  policies and reproduce byte-identical combined keyframe sheets, score
  `-0.5281032175`, mean distance `2.4291077322 L`, and final distance
  `0.7461626530 L`. The prefilled v26 sample (`solver_44f6e53e7268`)
  captures on the same solver step but is slightly worse at score
  `-0.5281078349`, mean distance `2.4291113720 L`, and final distance
  `0.7461675406 L`.
- I inspected both visual rows for the strongest replicated v28 rollout, the
  v26 baseline, and the inherited v27 mean-bend-unloading regression. In the
  top-down row each fish self-propels along the same compact target-directed
  arc and sheds a coherent alternating mid-plane wake; none is passively
  advected, loops, or approaches a boundary. In the oblique row, compact
  finite Lambda2 packets follow the outer arc without out-of-plane instability,
  and the last frames show the oscillatory wake subsiding into a quiet terminal
  glide. The coarse sheets cannot rank their small late differences, so the
  replicated distance and load histories decide the comparison.
- The inherited negative controls bound the interpretation. Moving the same
  helpful-crossflow cue onto shared mean-bend unloading retained the capture
  step but regressed to score `-0.5295582789`, mean distance
  `2.4302567953 L`, final distance `0.7476926446 L`, and a larger final
  lateral-force coefficient (`0.001428` versus v28's `0.000385`). Applying
  course error as half-cycle carrier scaling also retained capture but
  regressed to score `-0.5281232687`. Course response therefore supports a
  smooth paired allocation release, not phase selection or static-curvature
  unloading.

## Policy hypothesis

Promote the replicated v28 mechanism as this workspace's single candidate.
Preserve the v26 state-feedback oscillator, posterior lag, target-angle
redirect, closure preview, shared two-joint equilibrium, and validated
crossflow-supported coupled release. Add only the evaluated v28 response gate:
the unsigned angle between normalized body-frame target direction and
body-frame velocity course permits at most `3.5%` more *paired* release toward
the same mean-centered carrier when late proximity, helpful crossflow,
positive closure, settled joints, and course convergence all agree.

This is exploitation of a replicated completed result, not a same-worker CFD
claim and not evidence for increasing the release. The falsifiable expectation
is exact outer noninterference, the same coherent two-view wake and capture
step, and reproduction of the small distance-integral improvement. Reject the
mechanism if a later rollout changes the outer trajectory, delays or loses
capture, weakens closure/course alignment, restores terminal oscillation,
joint stops, saturation, material load growth, instability, or wake loss.

bookshelf_consulted: true
source_domain: biological response release and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: release strong corrective curvature continuously after observed motion becomes target-directed while preserving the propulsive rhythm
transferable_invariant: reduce corrective allocation only when normalized target-relative kinematics and settled actuator response demonstrate useful continued closure
nontransferable_details: species escape kinematics, published gains, dimensional cadence, duty ratios, clock phase, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: body-frame target and velocity directions form a bounded course-alignment gate that adds a small paired release to inherited proximity, helpful-crossflow, closure, and two-joint settled-response support
falsification: reject if the gate is inactive, affects the outer path, unloads shared mean curvature, selects a beat phase, delays or loses capture, worsens course or closure, or restores oscillation, saturation, joint stops, load spikes, instability, or wake loss
