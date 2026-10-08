# Predictive terminal-coast candidate

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and finite moving-window
  dynamics.  Their motion is therefore self-propelled rather than imposed
  advection.
- I inspected both rows of every combined keyframe sheet.  The top-down views
  develop the same coherent alternating red/blue caudal street from release to
  capture, while the oblique views show persistent compact three-dimensional
  Lambda2 structures behind the tail.  All four bodies take the same broad
  left/down route and capture in `16.258--16.291T`; no variant gains its result
  by suppressing the working carrier or by a visibly different route.
- The shared response-gated posterior redirect is the sampled semantic gain to
  preserve.  Its unmodified rollout captures at `0.746L` in `16.291T`, whereas
  inherited one-sided relief without the strong response gate passed a
  `5.144L` closest point and exited through the upper boundary at `18.975T`.
  The redirect solves the earlier course topology but leaves posterior action
  on the hard acceleration limit for `60.4%` of the captured rollout and
  `82.9%` of samples below `1.2L`.
- The three sampled follow-ups separate terminal mechanisms more clearly than
  their small score spread.  Redirect-priority acceleration allocation lowers
  total posterior hard-limit residence to `22.5%`, but below `1.2L` both joints
  still saturate for `65.5/41.7%` of samples and mean force is `0.0201`.
  Mild proximity/closing modulation reaches the best scalar score
  (`-0.066121`) but retains `32.1/47.4%` near-field limit residence and mean
  force `0.0160`.  The assigned closing-gated straight-joint hold instead
  captures at `0.746L` in `16.269T`, eliminates both near-field acceleration
  residencies, and lowers mean force below `1.2L` to `0.00746`; its modestly
  worse scalar score is not evidence against this large control-quality gain.
- The assigned hold has one avoidable fixed-task assumption: its drive release
  depends on a static `1.2L` proximity transition.  Inherited logs show the
  successful parent already closes at about `1.2--1.3L/T` over the last second,
  so whether coasting can still cross the `0.75L` capture boundary depends on
  distance *and* observed closing momentum.  A slow near approach should not
  receive the same release as a fast one, especially on held-out initial poses.

## Policy hypothesis

Preserve the sampled cruise carrier, course-error steering, response-gated
redirect, and opposing-wave relief exactly.  Preserve the assigned candidate's
closing-gated damped straight-joint hold, but replace its fixed-distance gate
with one predictive terminal-coast mechanism.  Compare remaining normalized
distance to the capture boundary with the distance that the observed positive
closing speed would cover during a bounded fraction of one carrier period.
Only positive predicted reach opens the hold; weak or negative closing response
continuously restores the captured transit controller.

This changes the gate's semantics rather than tuning its distance gain.  It
should retain the coherent wake and approximately `16.27T` capture while
keeping near-field acceleration and force near the assigned hold's low levels;
it should also avoid premature coasting when a held-out approach is nearby but
slow.  Falsify it if capture is lost or materially delayed, if the broad route
or wake changes before terminal approach, if either joint again spends a
substantial fraction of the sub-`1.2L` interval at the acceleration limit, or
if near-field mean force rises materially above `0.00746`.

bookshelf_consulted: true
source_domain: biological terminal capture and sensor-feedback modulation of robotic-fish rhythmic locomotion
source_mechanism: reduce rhythmic drive only when observed approach response says passive continuation can finish the interception
transferable_invariant: terminal propulsion relief should depend jointly on remaining target distance and reliable target-aligned closing momentum, and should release when that response disappears
nontransferable_details: species maneuvers, published CPG gains, dimensional distances, prescribed phases, morphology-specific stopping data, and task-specific routes
policy_translation: compare normalized distance outside the capture boundary with positive closing speed times a bounded fraction of the state-feedback carrier period, then use the smooth reach margin to blend the two-joint transit command into the existing damped straight hold
falsification: reject if capture or the coherent approach wake is lost, arrival regresses materially, near-field saturation returns, or low/negative closing speed fails to restore full transit authority

The new candidate has no same-worker CFD result; only downstream evaluation can
establish these expectations.

## Non-CFD verification

- A counterfactual gate audit on the assigned captured trace—not a closed-loop
  prediction—places the new and old first `0.1` gate crossings at
  `15.653/15.681T` and their first half-authority crossings at
  `15.912/15.840T`.  The predictive gate remains below `0.0004` while distance
  exceeds `1.75L`, supporting separation from the evidenced transit regime.
- A deterministic `91,125`-state sweep returned two finite commands within the
  acceleration envelope and exact sign reversal under joint/bearing/lateral
  reflection.  The parameter-schema, public-contract, guidance-provenance, and
  solver-boundary checks also pass without running CFD.
