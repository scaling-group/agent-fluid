# Phase 2 course-gated half-cycle candidate

## Visual and metric diagnosis before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, and no cylinders. Their translation and
  wakes are self-generated rather than imposed advection.
- `solver_19f251537923` is the strongest finite approach. Both visual rows
  show a coherent alternating top-down vortex street and compact oblique
  Lambda2 structures. It moves from `12.328L` to `6.138L` at `16.505T`, but
  then keeps swimming below the target and exits the lower boundary at
  `26.147T`, after distance reopens to `10.460L`. Its raw commands exceed the
  `1800 deg/T^2` envelope in 3346/4754 anterior and 3655/4754 posterior
  samples, so the useful wake does not validate its clipped steering stack.
- The assigned prefill `solver_97bc3c03d55b` also sheds a strong, visibly
  three-dimensional alternating wake. Range decreases monotonically to
  `9.175L`, but heading falls from `0.506` to `-0.791 rad` and the route exits
  the upper boundary at `11.132T`. At `4T` its line-of-sight error has already
  crossed from positive to approximately `-0.02 rad`, while its body-frame
  velocity is about `(-0.25,+0.33)U`: the fish is sliding on the wrong course
  even though the geometry-only yaw loop has nominally reversed. Raw action
  still exceeds the acceleration envelope in 830/2024 and 628/2024 samples.
- `solver_a8731015fd6e` removes instantaneous yaw-rate feedback and limits
  posterior mean curvature to `4 deg`, yet repeats the same upper-exit
  topology: only `11.878L` closest approach, heading `-0.928 rad`, and center
  `y=15.20L` at `9.108T`. Thus another tail-only static-curvature magnitude is
  not isolated as a useful next test.
- `solver_1b4176f9edeb` is envelope-compliant and uses posterior half-cycle
  asymmetry, but it simultaneously weakens the carrier to `12 deg/0.70T` and
  gates steering with a roughly seven-step recent yaw estimate. The visual
  sheets show a much weaker wake; force peaks at only about `0.0128` versus
  `0.0260--0.0355` in the fast carriers, minimum range is `12.165L`, and the
  fish again exits high at `8.591T`. This negative result does not isolate the
  phase-local actuator because carrier authority and feedback semantics both
  changed.
- The inherited logs sharpen the semantic problem: `turn_rate_recent` and
  `bearing_window_rate` span only about seven `0.0055T` integration steps in
  this evaluator, so they remain beat-scale signals rather than slow yaw
  response. Prior candidates using them saturated or selected a boundary-exit
  turn. By contrast, `velocity_body_U` supplies a directly normalized course
  vector from which a target-relative course error can be formed without a
  hidden clock, route, or mutable filter.

## Policy hypothesis

Preserve the evidenced fast joint-state traveling-bend carrier, but remove
static posterior mean curvature and raw recent-yaw tracking. Target line of
sight supplies the low-speed turn request. Once translation develops, blend in
the signed angle from the observed body-frame velocity vector to the
body-frame target vector. This course error should countersteer as soon as the
fish's motion crosses the target course, rather than waiting for a noisy
instantaneous yaw loop or for range to reopen.

Apply that bounded request only as posterior half-cycle amplitude asymmetry.
The observed posterior wave side supplies phase, so the controller remains
state-feedback and reflection-equivariant. Use an intermediate carrier between
the sampled weak envelope-compliant gait and the strong saturation-dominated
gaits, and keep an explicit command guard below the immutable acceleration
limit. This is one small compatible combination: a directed carrier plus a
course-released phase-local steering actuator.

Expected evidence is a coherent wake stronger than `solver_1b4176f9edeb`, an
initial correct-side turn, and course-error reversal before either vertical
boundary exit. Falsify the mechanism if range does not beat `9.175L`, the wake
remains as weak as the `12 deg/0.70T` child, raw commands live on the guard, or
the trajectory repeats an upper/lower boundary exit with monotonically growing
absolute course error.

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop direction tracking, with classical traveling-wave propulsion
source_mechanism: sensor-modulated half-cycle amplitude asymmetry superposed on a posterior-lagged propulsive wave
transferable_invariant: preserve a directed traveling bend while a bounded target-relative course error strengthens only the turn-consistent half-cycle and releases or reverses after course crossing
nontransferable_details: published gains, dimensional frequencies, linkage geometry, species-specific envelopes, clock-driven CPG phase, exact vortex phase, and task-specific routes
policy_translation: derive line-of-sight and velocity-to-target course angles from normalized body-frame target_body_L, distance_L, velocity_body_U, and observed joint phase; use their bounded blend only to scale the posterior half-cycle in the two-joint state-feedback carrier
falsification: reject if the wake stays weak, commands routinely meet the guard, range fails to improve beyond 9.175L, or course error grows through another vertical-boundary exit
```

## Pre-CFD joint-state sanity

A `100T` joint-only probe with the episode's `0.0055T` integration step and
angle/rate/acceleration clamps rejected the draft `20 deg/0.65T` carrier: both
joint rates reached `260 deg/T`, and the posterior command spent thousands of
steps above 95% of its internal guard. With the retained `15 deg/0.80T`
carrier, the same aligned and persistent `+/-1` turn-request probes reached at
most `36.5/41.1 deg`, `256.1/247.9 deg/T`, and
`1484.9/1509.9 deg/T^2`; no episode or internal guard was hit. A mirrored-state
probe produced exactly negated actions. These checks establish bounded wiring
and reflection equivariance only; they do not establish wake strength, course
correction, or target capture.
