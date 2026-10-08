# Evidence-selected carrier-residual yaw opposition feedback

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and capture
  after `2,919` steps. I inspected the combined top-down mid-plane-vorticity
  and oblique body/Lambda2 sheets for the distinct yaw-residual rollout
  `solver_d9f2302868e3` and the prefilled parent `solver_d97cee67d951`; the
  other two sampled sheets are byte-identical to the parent. Both distinct
  sheets show self-propulsion, a traveling posterior bend, an alternating
  red/blue wake established by about `4T`, and compact three-dimensional shed
  structures retained through capture. Neither shows passive advection,
  collision, boundary exit, wake collapse, or instability. The informative
  contrast is therefore a useful trajectory change within the capture class,
  not a different wake or termination topology.
- The prefilled parent is exactly replicated by `solver_5187bb13ebc0`,
  `solver_d97cee67d951`, and `solver_ed6d64fbfa4b`: their policy and keyframe
  hashes match, as do `16.054512T` capture, `0.744345L` crossing,
  `1.938857L` held distance integral, and `229` window shifts. This confirms
  the inherited intercept-conditioned anterior release is a stable carrier,
  while three repeated evaluations contribute no new physical diversity.
- On that carrier, `solver_d9f2302868e3` subtracts a normalized anterior-phase
  prediction from measured yaw rate and adds bounded posterior mean curvature
  only when the remaining yaw opposes a speed-reliable target redirect. It
  preserves the coherent two-view wake and identical `16.0545T` arrival while
  advancing the `8/6/4/2L` milestones from
  `9.2015/11.1540/13.0130/14.9050T` to
  `9.0750/11.0440/12.9195/14.8005T`. Observed distance integral improves from
  `1.314014L` to `1.303739L`, score from `-0.055617` to `-0.048654`, mean
  posterior acceleration falls from `24.888` to `24.616 rad/T^2`, and exact
  posterior acceleration-limit residence falls from `22.47%` to `21.86%`.
  This is evidence for response-gated feasible action, rather than a scalar
  gain edit or another clamp-equivalent wrapper.
- The benefit has a boundary: maximum posterior angle rises from `0.553` to
  `0.636 rad`, peak lateral force rises from `0.03193` to `0.03321` in the
  logged normalization, moving-window shifts rise from `229` to `239`, and the
  final crossing is shallower (`0.747530L` versus `0.744345L`). Peak yaw moment
  is slightly lower (`0.01903` versus `0.01945`). The added mechanism should
  therefore be retained as a far/middle redirect response, not extrapolated
  into stronger terminal centering or justified by score alone.

## Policy hypothesis

Use the evaluated `solver_d9f2302868e3` policy as the single candidate. Keep
the prefilled state-feedback oscillator, carrier-phase-residual redirect
selector, raw target-versus-course turn direction, one-sided opposing-wave
relief, mean-first posterior allocation, response-subordinate approach
settling, intercept-conditioned anterior damping release, and exact
speed-boundary projection. Add only the evaluated yaw-response mechanism:
predict the reflection-odd beat-scale yaw component from normalized anterior
joint position and velocity, subtract it from normalized measured heading
rate, and add bounded posterior mean curvature only when the residual opposes
a target-directed redirect after forward speed is reliable. Aiding residual
yaw receives no extra action, and raw target/course error still owns redirect
direction.

Prior closed-loop evidence predicts earlier far/middle distance milestones and
lower distance integral without changing the coherent wake or capture time.
Falsify the mechanism if the downstream rollout loses capture or wake
coherence, delays an `8/6/4/2L` milestone, increases posterior limiting/load
enough to erase the route benefit, or turns the larger posterior excursion
into a limit or stability problem. The candidate's new CFD evaluation occurs
after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation, path following, and adaptive wake-response control
source_mechanism: separate phase-predictable locomotor motion from sensor-measured residual response before adding bounded target-directed turning authority
transferable_invariant: preserve the rhythmic carrier and aiding yaw, but oppose a measured non-carrier yaw response only when it conflicts with a persistent target-directed redirect
nontransferable_details: published CPG gains, dimensional yaw thresholds, species-specific body waves, exact vortex phases, source-task routes, and source-task capture timing
policy_translation: predict normalized carrier yaw from anterior joint position and velocity, subtract it from heading rate normalized by carrier frequency, and gate a bounded reflection-odd posterior mean-curvature increment by body-frame target/course redirect, forward-speed reliability, and residual-yaw opposition
falsification: reject if the residual gate acts without reliable target redirect, breaks lateral reflection equivariance, suppresses aiding yaw, weakens the coherent traveling wake, loses capture or milestone progress, or increases posterior excursion, limiting, and loads enough to outweigh distance-integral benefit

## Non-CFD verification after the policy edit

- The final candidate SHA-256 is
  `ec7aaed22fc3e0b6fee4c441b76dea5a54c9dc8f39f2003be085ebcf0dd0920e`,
  byte-identical to the evaluated `solver_d9f2302868e3` source. This
  establishes exact evidence-selected reuse, not a same-worker CFD claim.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. Its three
  prescribed checks were then run directly and separately. The guidance check
  initially exposed a duplicated assigned-parent marker in the rendered
  `README.md`; removing only that duplicate restored unique provenance. The
  rerun passes, the lightweight Julia policy contract passes, and the solver
  editable-boundary check passes. No CFD was run.
- Static consistency finds one non-empty `candidate_target_policy.jl`, with
  all `41` direct `params.FIELD` references matched by the `41` fields returned
  from `target_policy_params()`.
