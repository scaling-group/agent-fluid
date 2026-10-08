# Intercept-corridor terminal response-release candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled solvers satisfy the frozen Phase-2 contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no prewarm snapshot or
  cylinders, finite moving-window dynamics, and capture from `12.32772 L`.
  Three byte-identical v28 evaluations reproduce score `-0.5281032175`, mean
  distance `2.4291077322 L`, final distance `0.7461626530 L`, and capture at
  `25.1185226 T`; the v26 sample captures at the same step with slightly worse
  score `-0.5281078349`, mean distance `2.4291113720 L`, and final distance
  `0.7461675406 L`. The repeated v28 result supports deterministic promotion
  but its advantage is only `4.62e-6`, so it does not support more release
  amplitude.
- I inspected the complete combined sheet for the strongest finite v28 sample
  and the inherited informative v27 mean-bend-unloading regression. In both
  top-down rows the fish self-propels along the same compact target-directed
  arc and sheds a coherent alternating wake; the wake and body sweep subside
  into a quiet held-bend glide near capture. Both oblique rows show finite
  three-dimensional Lambda2 packets through the outer approach, without
  out-of-plane instability, collision, or domain-exit precursors. The v27
  regression is therefore a subtle terminal allocation failure, not a wake
  collapse visible at keyframe resolution.
- The v28 trajectory enters the existing `1.6 L` response band with velocity-
  to-target angle `0.4431 rad` and constant-velocity cross-track miss
  `0.6850 L`; both decrease monotonically to `0.3103 rad` and `0.2278 L` at
  capture while speed remains near `0.654 L/T`. The current angle gate is
  already nonzero at band entry even though the projected line does not yet
  pass through a compact target corridor. Conversely, by `0.9 L` the
  projected miss is below `0.30 L` despite a residual `0.3365 rad` course
  angle. This is direct evidence for measuring the achieved intercept rather
  than treating a fixed angular error as the release criterion.
- Completed negative boundaries remain decisive: moving the helpful crossflow
  cue onto shared mean-curvature unloading regressed to score `-0.5295582789`
  and final distance `0.7476926446 L`; phase-selective carrier scaling
  regressed to `-0.5281232687` and `0.7461837530 L`. The new candidate must not
  change mean bend, select a beat side, split joint roles, or enlarge the
  inherited `3.5%` course-conditioned release budget.

## Policy hypothesis

Preserve v28's state-feedback traveling carrier, posterior lag, target-angle
redirect, closure preview, two-joint mean-curvature equilibrium, helpful-
crossflow response gate, coupled carrier release, and command limits. Replace
only its fixed velocity-to-target angle support with a constant-velocity
intercept-corridor support: in normalized body coordinates, compute the
absolute cross-track miss `distance_L * |sin(course_error)|`, and continuously
earn the same small paired release as that miss enters a declared compact
corridor. Positive closure, late proximity, helpful relative crossflow, and
settled response remain mandatory independent gates.

This is one new approach-hold feedback mechanism, not scalar-only gain tuning:
the semantic variable changes from angular alignment to predicted closest
approach. It should be exactly command-invariant outside the inherited late
response gate, withhold the extra release near `1.6 L`, then restore it once
the observed translation predicts a small miss, without changing static
curvature or carrier phase. Reject it if its stored-state gate is inactive or
unbounded, it changes commands outside `1.6 L`, delays or loses capture,
worsens mean/final distance or intercept miss, creates a late loop, or restores
oscillation, saturation, joint stops, force/moment growth, instability, or
wake degradation.

bookshelf_consulted: true
source_domain: biological burst-response release and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: release strong corrective allocation only after observed target-relative translation demonstrates an intercept, while preserving the rhythmic propulsive scaffold
transferable_invariant: a redirect can be relaxed continuously when normalized target geometry and measured body-frame velocity predict a small cross-track miss under positive closure
nontransferable_details: published gains, dimensional cadence, species-specific bend envelopes, duty ratios, clock phase, exact vortex phase, capture radius, and task-specific routes
policy_translation: body-frame target and velocity vectors form a bounded predicted-miss corridor gate for the inherited small coupled carrier release; proximity, closure, helpful crossflow, and settled two-joint response remain required
falsification: reject if the gate is inactive, affects the outer path, increases release authority, changes mean bend or beat phase, delays or loses capture, worsens distance or miss, or restores wake loss, saturation, joint stops, load spikes, or instability

## Non-CFD implementation audit

- The returned parameter object owns every directly referenced field, and a
  lightweight contract state produces two finite commands.
- Replaying v29 and the evaluated v28 parent algebra on all `4,567` stored v28
  trajectory states gives exactly zero command difference at and beyond
  `1.6 L`. The intercept support is active on `160` of `226` states inside the
  band and spans `[0,1]`; the parent angle support spans approximately
  `[0.0247,0.9245]`. The candidate therefore withholds the added release at
  band entry and reaches full support only after the predicted miss contracts.
- On those stored states, the mean absolute candidate-parent command change is
  about `0.00034/0.00080 rad/T^2`, with maxima
  `0.00112/0.00268 rad/T^2`; final replay changes are only
  `0.00052/0.00119 rad/T^2`. This establishes finite output, bounded active
  feedback, and exact outer noninterference only. The coupled-flow capture,
  score, trajectory, loads, and wake remain future evaluation evidence.
