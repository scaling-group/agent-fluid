# Line-of-sight drift candidate

## Visual and quantitative diagnosis before the policy edit

- All sampled and inherited evaluations used direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm snapshot, and no cylinders. The three
  sampled copies of the assigned rate-governed parent are exact deterministic
  repeats: capture at `23.3640T`, mean score-distance `2.409486L`, and score
  `-0.51274776`. The lower-scoring sampled clamp comparison also captures and
  is visually very similar, so the inherited step-6 policies are the more
  informative failures.
- I inspected both rows of the combined sheets for the strong parent, the
  weaker clamp capture, the shared carrier-damping rollout, and both step-6
  failures. Their top-down rows all show self-propulsion from quiescent water,
  a coherent alternating wake, and a broad target-directed turn. Their oblique
  Lambda2 rows retain compact, alternating posterior structures through the
  final approach; there is no passive advection, prewarm artifact, collision,
  wake collapse, or out-of-plane instability. The useful differences are in
  course geometry and progress, not wake existence.
- The joint-load cadence gate preserves that wake but lowers mean speed from
  `0.5701` to `0.5413 U`, delays capture from `23.3640T` to `24.8380T`, and
  worsens mean score-distance from `2.409486L` to `2.521632L`. This confirms the
  assigned parent's boundary against further carrier-energy attenuation.
- The gait-yaw projection is a stronger route failure. It increases center
  path from `13.3177L` to `14.8232L`, maximum straight-line cross-track
  excursion from `2.014L` to `3.058L`, RMS yaw rate from `1.554` to
  `1.687 rad/T`, RMS force coefficient from `0.01234` to `0.01342`, and tail
  residence above 96% joint rate from `3.58%` to `13.86%`. Capture slips to
  `24.4090T` and score to `-0.62377`. Thus the high joint-rate correlation did
  not identify yaw recoil that could safely be subtracted from the route loop.
- A different invariant is available without predicting gait phase. In the
  strong parent's far/middle transit, co-windowed `turn_rate_recent` and
  `bearing_window_rate` each contain about `1.55 rad/T` RMS beat motion, while
  their difference is the inertial target line-of-sight rate: only
  `0.0263 rad/T` RMS, bounded by `0.0515 rad/T`, with a persistent
  `+0.0214 rad/T` mean. The body heading cancels kinematically because target
  bearing and yaw are measured across the same history window. This agrees
  with the visible broad excursion: the parent head path is `12.615L` for an
  `11.58L` initial target separation and reaches about `2.01L` off the direct
  line before correcting late.

## One policy hypothesis

Preserve the captured traveling-wave carrier, odd target-to-curvature map,
half-cycle steering, approach behavior, and direction-selective rate governor.
Add one route-observer mechanism to guidance: subtract the co-windowed target
bearing rate from recent yaw rate to recover inertial line-of-sight drift, map
that residual through one bounded odd correction, and release it continuously
inside the already successful terminal corridor. This does not subtract an
estimated gait signal or alter carrier energy; it feeds a body-frame,
target-relative course invariant into the existing two-joint steering path.

Expected result: reduce the broad midcourse cross-track excursion and distance
integral while retaining capture, arrival scale, actuator statistics, and the
coherent two-view posterior wake. Falsify the mechanism if capture is lost,
the route bends farther from the direct line, arrival or mean distance worsens,
joint saturation or force/moment scale increases materially, or the final
approach and wake topology change adversely. Also reject it if the evaluated
co-windowed difference does not track inertial line-of-sight rotation.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and adaptive wake-interaction control
source_mechanism: separate slow target-route motion from fast gait-synchronous body recoil before applying a bounded steering residual
transferable_invariant: use a target-relative kinematic residual whose body-yaw component cancels across the same observation window, then preserve the propulsive carrier
nontransferable_details: published CPG gains, dimensional cadence, species kinematics, prescribed vortex phase, evidence-specific rate scales, and task routes
policy_translation: form turn_rate_recent minus bearing_window_rate from normalized body-frame target observations, apply a bounded odd correction only outside the terminal corridor, and pass it through the existing two-joint steering law
falsification: reject if cross-track path, distance integral, arrival, capture, loads, saturation, reflection symmetry, or top-down and oblique wake coherence worsen, or if the residual fails to represent inertial line-of-sight drift
