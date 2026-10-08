# Stride-qualified terminal anterior energy envelope

## Visual and quantitative diagnosis before editing

- I read the workspace and assigned-parent guidance, all four sampled solver
  policies, scores, observations, metrics, diagnostics, and trajectories, plus
  the inherited v20, v22, and v23 optimizer notes and completed evaluations.
  Every compared rollout uses direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination.
- I inspected both rows of the combined keyframe sheets for sampled v16 and
  v20 and inherited v23. The top-down rows show self-propulsion from rest and
  the same coherent alternating vorticity street through capture. The oblique
  rows show compact three-dimensional posterior Lambda2 structures without
  passive advection, boundary interaction, wake breakup, or out-of-plane
  instability. The useful difference is therefore terminal energy allocation,
  not creation or repair of the wake.
- Sampled v20 remains the scalar leader at `18.0070T`, score `-0.064028`, and
  mean distance `1.950358L`, but finishes with course alignment `0.1092`, speed
  `0.8820U`, absolute yaw `0.9840 rad/T`, and both acceleration commands at the
  ceiling. Its instantaneous yaw-power selector preserves closure but does not
  deliver the claimed terminal damping.
- The inherited v22 gait-demodulated yaw-feedback test also misses its semantic
  target: score regresses to `-0.065191`, final alignment is `0.1287`, and
  absolute yaw is `1.0486 rad/T`. A high open-loop phase-regression fit is not
  enough to make the residual a useful closed-loop course observable.
- The inherited v23 terminal carrier-energy envelope is a qualified positive
  mechanism. Relative to v20 it raises final alignment to `0.2216`, lowers
  absolute yaw to `0.1940 rad/T`, shortens head cross-track from `0.7317L` to
  `0.7183L`, and lowers near-target rate residence above 96% from
  `16.03/14.50%` to `14.47/9.39%`; near acceleration-ceiling residence also
  falls from `69.21/75.83%` to `69.80/71.57%`. Its boundary is objective cost:
  arrival slips to `18.0125T`, mean distance rises to `1.951453L`, and score
  regresses to `-0.065385`. Because v23's gate acts throughout the `2.10L`
  approach using nearly saturated total-speed authority, the evidence supports
  retaining anterior energy relief but qualifying when it earns its transit
  cost.

## Single policy hypothesis

Start from evaluated v20, preserving its odd target-to-curvature map,
state-feedback anterior oscillator, posterior lag/emphasis and phase-consistent
work reserve, far/middle route controller, yaw-power-selective posterior wave,
conserved forward mean-bend allocation, half-cycle steering, and
reversal-preserving rate governor.

Add one terminal energy-allocation mechanism. Compute a dimensionless
stride-to-go ratio from body speed times the policy-owned control period divided
by normalized target distance. Smoothly combine it with the existing moving,
misaligned approach authority, and bleed anterior carrier energy only above the
scheduled phase-plane envelope. This is exactly inactive outside the existing
`2.10L` approach, acts weakly when many strokes remain, and strengthens when a
single stroke would traverse a material fraction of the remaining range. It
does not change mean curvature, cadence, the posterior target, or any
world-frame route. Distance, speed, energy, and the gate are reflection
invariant; the velocity-opposing bleed changes sign with anterior joint rate.

Expected evidence is v20-identical far/middle closure and both coherent wake
views, retained capture and approximately its distance integral, with a
v23-directed improvement in final yaw/alignment and joint-limit residence.
Falsify the mechanism if pre-approach actions change, capture or mean distance
regresses materially, terminal yaw and alignment do not improve together,
limit residence migrates posteriorly, or either wake view loses coherence.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated robotic-fish oscillator control
source_mechanism: preserve posterior traveling-wave work for thrust while reducing excess anterior carrier energy only in a task-qualified terminal regime
transferable_invariant: allocate rhythmic work posteriorly and schedule anterior oscillator energy from normalized remaining range and body motion rather than suppressing the complete two-joint gait
nontransferable_details: published gains, species-specific envelopes, dimensional cadence, exact vortex phase, full-body kinematics, capture radius, world coordinates, and task-specific routes
policy_translation: multiply the existing body-frame moving/misaligned approach authority by a bounded speed-times-control-period over distance gate, then apply velocity-opposing bleed only to anterior phase-plane energy above its scheduled envelope while leaving the posterior traveling-wave target intact
falsification: reject if transit changes, capture or distance integral worsens materially, yaw and alignment do not improve jointly, actuator load migrates posteriorly, reflection fails, or either coherent wake view deteriorates

## Lightweight validation after editing

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported by this account. Running its immutable
  commands directly gives PASS for the guidance-materiality check and PASS for
  the solver-boundary check; `candidate_target_policy.jl` is the only solver
  difference.
- Julia is not installed or discoverable, so the executable include/action
  probe cannot run. The deterministic static fallback passes: all `67` unique
  direct `params.FIELD` references resolve among the `68` fields returned by
  `target_policy_params`; both public entrypoints occur exactly once, the file
  is nonempty, delimiters balance, and no clock, randomness, file I/O,
  cylinder input, or world-route input is referenced.
- Replaying the new authority on the completed v20 trajectory makes it exactly
  zero for all `2881` samples at or beyond `2.10L`. Inside approach its
  mean/maximum/final authority is `0.1325/0.5067/0.5067`, compared with the
  inherited v23 envelope's reported mean/maximum authority
  `0.2690/0.7069`. Algebraic reflection leaves distance, speed, course
  alignment, stride-to-go, and energy authority unchanged while reversing the
  sign of joint velocity and the velocity-opposing bleed. These are contract
  and activation checks, not CFD evidence; EvE must test the resulting capture,
  score, loads, and both wake views after this worker exits.
