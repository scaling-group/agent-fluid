# Posterior-headroom-arbitrated turn-shape candidate

## Completed evidence and visual diagnosis before editing

- All four sampled rollouts are finite `capture` episodes initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm.  The strongest completed result is v46 phase-even posterior turn
  shape: it captures at `17.64401 T`, score `-0.07419`, and total/observed
  distance integrals `1.95985/1.34371 L`.  This is a semantic improvement over
  the assigned v43 parent at `17.75400 T`, `-0.07917`, and
  `1.96508/1.34990 L`, rather than a deeper final sample alone.
- I inspected every combined sheet from release through capture, including both
  the top-down vorticity row and the oblique body/Lambda2 row.  The readable v43
  and best-v46 sheets show active self-propulsion along a smooth target-signed
  arc.  Their compact startup structures become coherent alternating posterior
  wakes in both views, without reversal, collision, boundary exit, or visible
  instability.  The posterior-approach comparator has the same organized
  top-down route but black oblique frames; that rendering failure cannot support
  a comparative 3D-wake claim.
- The approach-thrust and axial-confident approach-wave comparators are
  byte-identical to v43 through `16 T`, capture at `17.74850 T`, and worsen the
  total integral to `1.96520/1.96493 L`.  They therefore confirm the inherited
  negative lesson that another proximity/closure gate is not the missing route
  mechanism.
- The successful phase-even posterior residual changes the route well before
  capture: relative to v43 it is closer by `0.0075/0.0497/0.0472/0.0429/0.0508/
  0.0472 L` at `2/4/6/8/10/12 T`.  It then trails by `0.0068/0.0110 L` at
  `14/16 T` before its earlier capture.  Mean/max speed rises modestly from
  `0.7168/0.9603` to `0.7199/0.9662 L/T`, while peak normalized force and
  moment remain `0.03225/0.01609`.
- The actuator split identifies a bounded follow-up test.  V46 lowers anterior
  acceleration-limit residence from `37.98%` to `35.97%` but raises posterior
  residence from `6.16%` to `8.10%`; posterior contact is absent through
  `12 T` and rises to `23.8%` over `12-16 T` and `29.1%` thereafter.  Thus the
  new posterior mechanism is useful, but its late authority competes with the
  established tail carrier/steering allocation exactly where its checkpoint
  lead reverses.  The inherited author note predicted this as its falsification
  boundary; completed CFD now makes it the next mechanism-level arbitration
  test rather than a reason to increase its gain.

## One-candidate policy hypothesis

Materialize completed v46 as the base and preserve its target sensing,
traveling-wave carrier, launch governor, selective crossflow pose confidence,
geometric redirect, half-cycle steering, rejected-anterior spillover, and
componentwise actuator bounds.  Keep the evidenced phase-even posterior
turn-shape residual, but allocate it only after the posterior carrier and the
proven steering/spillover residual.  Scale it by posterior headroom divided by
the sum of that headroom and the candidate residual magnitude.  This keeps most
of the new mechanism when the posterior actuator is available, continuously
yields as priority demand approaches the envelope, cannot consume all
same-sign remaining headroom, and vanishes when priority demand is already on
the limit.  It uses only observed joint state, body-frame target feedback, and
the existing physical action bound; it adds no clock, route identity, terminal
schedule, flow-sign steering, or scalar gain retuning.

The intended signature is to preserve v46's early/middle checkpoint lead and
capture while reducing its `12 T`-to-capture posterior limit residence and
eliminating the `14/16 T` closure reversal.  Require total/observed integrals no
worse than `1.95985/1.34371 L`, capture no later than `17.64401 T`, a readable
coherent two-view wake, and no material growth beyond the v46 speed/load
envelope.  Reject the arbitration if it collapses to the slower v43 route,
removes useful target-signed curvature despite available headroom, or merely
changes the terminal sample.  Formal CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and posterior wave-shape steering
source_mechanism: add bounded target-signed posterior gait modulation to an established rhythmic carrier, with feedback arbitration that yields rather than overwrites the carrier
transferable_invariant: a useful posterior steering residual should preserve the traveling carrier and priority target authority, and its added command should contract continuously when the posterior actuator has no normalized headroom
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact vortex phases, open-loop oscillator phase, actuator models from another platform, and task-specific routes
policy_translation: retain the bounded body-frame turn command times reflection-even anterior joint-motion envelope from completed v46, but apply its posterior acceleration residual only after carrier, half-cycle steering, and rejected-anterior spillover, scaled by the ratio of remaining posterior action headroom to headroom plus residual magnitude under the existing componentwise limit
falsification: reject if the early and middle checkpoint lead, capture, or either distance integral regresses; if late posterior limit residence is not reduced; if the posterior residual loses equal-and-opposite turn-command symmetry; or if speed, normalized loads, or the readable organized two-view wake materially worsen
```

## Evidence boundary

Outcome and visual claims above come from the assigned parent guidance, the
four completed sampled solver evaluations, and inherited optimizer notes.  No
same-worker CFD result is claimed for the candidate below.

## No-CFD implementation audit

- The single candidate is
  `dogfish_target_control_v47_headroom_arbitrated_posterior_turn_shape`, with
  SHA-256
  `00ae3977617e2e90be4249267dd33542b8d607537c91d39d2a0c26e1c3f37268`.
  Its only control change from completed v46 is priority/headroom arbitration
  of the already evidenced posterior turn-shape residual.
- All `66` distinct direct `params.FIELD` references resolve against the `68`
  fields returned by `target_policy_params()`.  The exact lightweight Julia
  contract returns two finite actions within the componentwise limit.
- A targeted comparison confirms exact v46 equivalence when the anterior
  carrier is stopped and exact preservation of the anterior action in an
  active-turn state.  The latter changes only the posterior action from
  `-21.2823` to `-21.2312 rad/T^2`; explicit opposite turn commands give
  equal-and-opposite raw turn-shape residuals, and all tested outputs remain
  finite and bounded.
- Frozen-state reconstruction on the completed v46 trajectory changes `2950`
  posterior samples, keeps every action between the priority-only and full-v46
  allocations, and retains `73.14%` of the full residual on average.  Maximum
  and mean absolute changes from v46 are `1.6296/0.3561 rad/T^2`; reconstructed
  posterior limit residence changes from `8.1047%` to `8.0424%`.  These values
  bound the new arbitration on prior states and are not a closed-loop outcome.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its three exact non-CFD commands were run
  locally and separately: the material-guidance check, lightweight Julia
  contract, and solver editable-boundary check all pass.  The guidance check
  first exposed and then passed after removal of a duplicated assigned-parent
  marker in the rendered workspace README.  No formal CFD was run.
