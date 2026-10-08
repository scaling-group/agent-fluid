# Evidence-selected anterior-only intercept release

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled solver rollouts satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, and finite capture.
  I inspected the top-down mid-plane vorticity and oblique body/Lambda2 rows of
  the combined sheets for the strongest finite sample `solver_5187bb13ebc0`
  and the assigned prefill parent `solver_736250db9a8b`, then checked the
  inherited signed-centering failure `solver_46da8b01de60`. Each sheet shows
  self-propulsion, a traveling posterior bend, an alternating red/blue wake
  established by about `4T`, and compact three-dimensional wake structures
  retained through capture. None shows passive advection, boundary contact,
  wake collapse, or instability. The informative failures are therefore
  terminal control-role regressions within the capture class, not visibly
  distinct wake topologies.
- The assigned prefill parent releases both anterior damping and posterior
  approach-wave settling inside its normalized body-frame intercept corridor.
  Relative to `solver_5187bb13ebc0`, it has the same `16.0545T` capture and
  `229` moving-window shifts but raises approach posterior acceleration-limit
  residence from `24.0%` to `29.2%`, worsens distance integral from
  `1.938857L` to `1.939710L`, and crosses at `0.745354L` rather than
  `0.744345L`. The two wake sheets are visually indistinguishable, so the
  posterior release is a terminal trajectory regression rather than useful
  hydrodynamic diversity.
- The sampled signed-intercept posterior half-cycle relief
  `solver_da1119fe4fc6` retains the parent's `24.0%` posterior limit residence,
  capture time, and coherent wake, but still regresses to `1.939122L` distance
  integral, `0.744660L` final distance, and score `-0.055945`, versus
  `-0.055617` for the anterior-only policy. The inherited signed mean-curvature
  correction is a stronger negative: `solver_46da8b01de60` lowers approach
  posterior limit residence to `22.9%` and captures one step earlier at
  `16.0490T`, yet worsens distance integral to `1.943328L`, crosses at the
  radius edge (`0.749671L`), and scores `-0.061164`. Lower posterior demand or
  a more center-directed instantaneous command does not establish a better
  closed-loop approach.
- The anterior-only policy has now reproduced byte-identically as
  `solver_5187bb13ebc0` and `solver_d97cee67d951`, both scoring `-0.055617` at
  final distance `0.744345L`. It preserves posterior settling and mean
  steering while the safe closing corridor releases only residual anterior
  braking. This is the strongest replicated candidate in the assigned parent,
  sampled solver results, and inherited optimizer logs.

## Policy hypothesis

Replace the prefill parent's broad carrier release with the replicated
anterior-only intercept release. Preserve the state-feedback oscillator,
carrier-phase residual redirect selector, raw target-versus-course turn
direction, one-sided opposing-wave relief, mean-first posterior allocation,
posterior approach settling, and exact speed-clamp projection. Compute the
reflection-even straight-course miss from normalized body-frame target and
velocity; only when proximity, target closing, course reliability, and a safe
intercept agree, release residual anterior velocity damping. Do not translate
the signed miss into posterior mean curvature, posterior half-cycle relief, or
posterior settling release.

The expected result is the already replicated coherent wake, route, and
capture of `solver_5187bb13ebc0`/`solver_d97cee67d951`, improving on the
assigned prefill parent without scalar-only tuning. Falsify reuse if the
downstream evaluation does not reproduce capture, the two-view wake loses
coherence, a distance milestone regresses, or the terminal release increases
loads or limiting without retaining the sampled distance-integral advantage.
This worker does not claim a new CFD result; evaluation occurs after exit.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal biological capture
source_mechanism: preserve rhythmic propulsion and target-directed posterior control while sensor feedback releases only a measured terminal braking role
transferable_invariant: on a reliable closing intercept, remove residual locomotor braking before removing steering or posterior wave-shaping authority, and restore braking continuously if projected miss degrades
nontransferable_details: published gains, dimensional burst timing, species-specific capture kinematics, prescribed oscillator or vortex phase, exact source-task capture radii, and task-specific routes
policy_translation: use normalized body-frame target and velocity to form a bounded reflection-even closest-miss gate; apply it only to anterior velocity damping while raw bearing and course feedback retain redirect direction and every posterior control role
falsification: reject if the gate acts outside a closing reliable approach, breaks lateral reflection equivariance, changes posterior semantics, or loses coherent propulsion, milestones, capture, distance-integral benefit, or acceptable loads

## Non-CFD verification after the policy edit

- The final candidate SHA-256 is
  `a01d9c5c1d5943bd930a4141f47681a1c361fbfcbab59326a51225fc8816bfc2`,
  byte-identical to both evaluated reproductions. This establishes exact policy
  selection, not a same-worker CFD claim.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. Its three
  prescribed checks were run directly and separately. The guidance check
  initially exposed a duplicated assigned-parent marker in the rendered
  `README.md`; removing only that duplicate restored unique provenance. The
  rerun, lightweight Julia policy contract, and solver editable-boundary check
  all pass.
- Static schema inspection finds `35` direct `params.FIELD` references and all
  `35` fields are returned by `target_policy_params()`. A deterministic
  `6,561`-state sweep over joint state, exact speed boundaries, target side,
  bearing, and body-frame velocity returns finite bounded commands, zero
  outward acceleration at either exact joint-speed boundary, and exactly zero
  lateral-reflection error. No CFD was run.
