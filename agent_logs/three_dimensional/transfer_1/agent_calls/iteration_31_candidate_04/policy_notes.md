# Contraction-released posterior turn-shape candidate

## Completed evidence and visual diagnosis before editing

- All four sampled episodes are finite `capture` rollouts initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. Three byte-identical samples reproduce the v46 phase-even posterior
  turn-shape controller at `17.64401 T`, score `-0.07419`, and total/observed
  distance integrals `1.95985/1.34371 L`. This is the only sampled mechanism
  that materially improves the assigned v43 parent's `17.75400 T`, `-0.07917`,
  and `1.96508/1.34990 L` result.
- The sampled axial-confident posterior approach-wave comparator captures at
  `17.74850 T`, score `-0.07899`, and integrals `1.96493/1.34985 L`. Relative
  to that comparator, v46 leads by `0.043-0.050 L` at every `2 T` checkpoint
  from `4-12 T`; the comparator briefly leads by `0.007/0.011 L` at `14/16 T`,
  but v46 restores the advantage before capture. Thus a route-wide approach-
  wave addition does not explain or improve the phase-even result.
- I inspected readable combined sheets for one reproduced v46 sample and the
  approach-wave comparator from release through capture. Their top-down rows
  show active self-propulsion along smooth target-signed arcs, with compact
  startup vorticity developing into coherent alternating posterior streets.
  Their oblique rows show compact paired Lambda2 structures following the
  caudal region without reversal, collision, boundary exit, or wake collapse.
  Another byte-identical v46 sample has a black oblique row; that is a render/
  evidence failure and is not used to claim 3D-wake superiority.
- Trace diagnostics support preserving the v46 carrier. Relative to v43, v46
  changes mean/max speed only from `0.7168/0.9603` to
  `0.7199/0.9662 L/T`, leaves peak normalized planar force/moment at
  `0.03225/0.01609`, and lowers any-joint acceleration-limit residence from
  about `44.15%` to `43.83%` while shifting some authority posteriorly.
- Reconstructed body-frame feedback localizes the remaining tradeoff. V46
  reduces the parent's negative bearing excursion over `6-10 T`, but its
  bearing is already contracting toward centerline while the always-available
  phase-even residual continues the same turn. The route then crosses early:
  mean de-gaited bearing is `0.359 rad` over `12-14 T` versus `0.232 rad` for
  v43, and mean closing is `0.833` versus `0.862 L/T`. From `12-16 T` the
  bearing instead diverges and the target-signed residual remains useful; by
  the terminal segment v46 contracts bearing and recovers the arrival lead.

## One-candidate policy hypothesis

Preserve the completed v46 target sensing, selective crossflow pose
confidence, state-feedback carrier, redirect, launch governor, cadence,
half-cycle steering, carrier-first allocation, and phase-even posterior
turn-shape residual. Add one response-release gate to that residual only:
inside the existing de-gaited centerline window, use the sign of bearing times
its windowed trend to recognize contraction, scale release continuously by
normalized contraction rate, and let the existing far-distance gate make this
release yield on terminal approach. Divergence, a stopped carrier, zero turn
request, or an active large-error redirect leaves the established behavior
available. The gate is reflection-even and contains no clock, global direction,
or memorized route.

The intended signature is to retain v46's early and terminal closure while
reducing its `12-16 T` off-axis excursion: capture no later than `17.644 T`,
total/observed integrals below `1.95985/1.34371 L`, and no material increase
over `0.9663 L/T`, `43.83%`, or `0.03225/0.01609` in maximum speed,
acceleration-limit residence, normalized force, or moment. The candidate's CFD
runs only after this worker exits; these thresholds are falsification criteria,
not same-worker claims.

```text
bookshelf_consulted: true
source_domain: biological C-start response release and sensor-modulated robotic-fish direction tracking
source_mechanism: release added curvature when observed target-angle response shows that a redirect is geometrically completing, and restore it when the error remains unresolved
transferable_invariant: an extra target-signed wave-shape turn should yield when normalized body-frame target angle is already contracting, rather than persisting until motion crosses the desired line
nontransferable_details: published gains, dimensional maneuver timing, species or robot kinematics, full-body curvature envelopes, exact vortex phases, open-loop oscillator phase, and task-specific routes
policy_translation: multiply only the existing phase-even posterior turn-shape residual by one minus a bounded release formed from de-gaited bearing contraction, its normalized windowed rate, the existing centerline window, and a far-distance gate; preserve both-joint carrier and final actuator projection
falsification: reject if the middle-route bearing excursion or distance checkpoints do not improve, the v46 arrival or integral advantage is lost, the residual fails mirrored-sign and release tests, posterior saturation or normalized loads grow materially, or readable two-view evidence loses the coherent alternating wake
```

## Evidence boundary

All completed outcomes and visual claims above come from the assigned parent,
sampled solver results, inherited optimizer logs, and inherited durable
guidance. The new candidate has no same-worker CFD evidence.

## No-CFD implementation audit

- The single materialized candidate is
  `dogfish_target_control_v47_contraction_released_posterior_turn_shape`, with
  SHA-256
  `934293ef540c2550dee0eae68c1aedd42da1386f1042f7960e2b5f7c7d2cc0f2`.
  It adds only the contraction/completion release around v46's existing
  posterior turn-shape residual; the anterior action path is unchanged.
- Frozen-state reconstruction over the completed v46 trace changes anterior
  acceleration by exactly zero, changes posterior acceleration by a mean
  `0.1514 rad/T^2` and maximum `1.0684 rad/T^2`, and keeps every output inside
  the componentwise limit. Mean release is `0.1643`; it falls to
  `0.0098/0.0015/0.0000` over `12-14/14-16/16 T` to capture, so the divergent
  middle correction and terminal residual are structurally preserved. These
  are localization checks on completed states, not a closed-loop result.
- A controlled state test gives zero release for bearing divergence. Direct
  drive tests give zero turn-shape residual for a stopped anterior carrier or
  a fully active redirect, exact equal-and-opposite residuals for mirrored
  target-turn commands, and an exactly reflection-even contraction gate.
  All `67` distinct direct `params.FIELD` references resolve against the `69`
  fields returned by `target_policy_params()`.
- The guidance semantic check, full lightweight Julia policy contract, and
  solver editable-boundary check pass. The required check-runner was invoked,
  but its pinned `gpt-5.4-mini` model is unavailable for this account; its
  three exact non-CFD checks were therefore run locally and separately. No
  formal CFD was run.
