# Geometrically qualified posterior-response release

## Completed evidence and visual diagnosis before editing

- All four sampled evaluations are finite `capture` episodes initialized
  directly from uniform still water with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm snapshot.  Three byte-identical v47 contraction-release
  evaluations reproduce capture at `17.53399 T`, score `-0.0640479`, and
  total/observed distance integrals `1.949721/1.333721 L`.
- The completed v49 approach-retained partition is the best sampled policy:
  capture at `17.48449 T`, score `-0.0616520`, and total/observed integrals
  `1.947439/1.331949 L`.  Relative to v47 it is closer by
  `0.02493/0.02289/0.03254 L` at `6/8/16 T`, but it is farther by
  `0.01002/0.02534/0.00116 L` at `10/12/14 T`.  Its final sample is deeper
  (`0.745909` versus `0.746974 L`) and any-joint acceleration-limit residence
  falls from `42.75%` to `40.17%`; peak normalized planar force and moment
  remain `0.032252/0.016092`.  Thus the approach-priority mechanism survives
  closed-loop CFD, but correct-sign yaw release still has a middle-route
  crossover rather than uniform value.
- I inspected the combined and view-specific sheets for v49 and a readable
  v47 reproduction from release through capture.  Both top-down rows show
  active self-propulsion on smooth target-signed arcs: compact startup
  vorticity develops into an organized alternating posterior street without
  reversal, collision, or wake collapse.  The readable v47 oblique row shows
  compact paired caudal Lambda2 structures through capture.  The v49 oblique
  row is black after frame 000, so it is an evidence/rendering failure and
  cannot establish comparative 3D-wake improvement.  Nothing visible or
  metric-backed supports changing the coherent carrier.
- The assigned-parent notes and earlier inherited logs rule out reopening
  carrier cadence, approach thrust, or base route authority: four such
  approach-local changes worsened total integral while barely changing the
  observed integral, and the failed v48 distance handoff was identical to v47
  through `14 T`.  By contrast, v49 validates the geometry-partitioned route
  and restores decisive approach curvature without increasing the sampled
  force/moment envelope.
- A frozen-trace reconstruction of completed v49 is diagnostic rather than
  closed-loop evidence.  Its out-of-band yaw-release confidence is concentrated
  after `12 T`, averaging about `0.080/0.095` over `12-14/14-16 T`, exactly
  where the completed trace has moderate-to-large de-gaited bearing and the
  `10-14 T` regression.  Correct-sign yaw is therefore not sufficient evidence
  that a large remaining target-angle error has completed.  The reconstruction
  is used only to localize the proposed gate, not to predict a CFD gain.

## One-candidate policy hypothesis

Start from completed v49 and preserve its normalized body-frame sensing,
state-feedback carrier, posterior lag, selective crossflow pose confidence,
base route and redirect steering, launch response, carrier-first spillover,
half-cycle steering, componentwise actuator projection, and approach return of
target-signed posterior curvature.  Change only the out-of-band yaw-response
release of the existing phase-even posterior turn-shape residual.  Multiply
that branch by the already computed centerline-completion confidence.  The
result is a continuous geometric annulus: contraction remains the release
signal inside the centerline window; correct-sign de-gaited yaw may release the
supplementary residual just outside that window; at large remaining error the
response is not mistaken for completion and the extra target-signed curvature
returns.  The added absolute-bearing multiplier is reflection-even, uses no
route clock or world-frame cue, and introduces no scalar gain.

The next CFD evaluation should preserve v49's `6-8 T` and terminal leads while
reducing its `10-14 T` regression, retain capture and the coherent top-down
wake, and remain within the sampled speed, saturation, force, and moment
envelope.  Falsify the mechanism if the early lead disappears, capture is
later or shallower, the middle-route deficit grows, switching becomes
beat-sensitive, the target-signed arc or readable two-view wake degrades, or
loads/limit residence materially exceed v47/v49.  Formal CFD occurs only after
this worker exits.

```text
bookshelf_consulted: true
source_domain: biological burst-turn response release and closed-loop robotic-fish direction tracking
source_mechanism: preserve the propulsive rhythm while releasing supplementary curvature only after observed yaw response and geometric turn completion agree
transferable_invariant: a correct-sign response can release extra steering, but response alone must not announce completion while normalized body-frame target error remains large
nontransferable_details: published gains, dimensional maneuver timing, species-specific curvature envelopes, full-body CPG state, exact vortex phase, and task-specific routes
policy_translation: multiply only the existing out-of-band correct-yaw release of the posterior turn-shape residual by bounded de-gaited centerline-completion confidence; retain the carrier, base steering, contraction branch, and approach priority
falsification: reject if v49's early or terminal lead, capture, target-signed arc, or coherent two-view wake is lost, the 10-14 T deficit grows, or saturation, normalized force, or moment materially exceeds the sampled envelope
```

## Evidence boundary

All outcome and visual claims above come from the assigned parent guidance,
sampled completed solver results, and inherited optimizer notes.  The
geometrically qualified release below is one unevaluated policy hypothesis; no
same-worker CFD result is claimed.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v50_geometrically_qualified_posterior_response`.
  All `68` distinct direct `params.FIELD` references resolve among the `70`
  fields returned by `target_policy_params()`.
- A deterministic `18,432`-state comparison with completed v49 confirms the
  new yaw-release branch equals the v49 branch times the bounded geometric
  qualifier, the anterior action is unchanged, the posterior action changes
  on `1,328` sampled states, and every output is finite and within the
  componentwise acceleration envelope.  The largest sampled posterior action
  change is `0.97447 rad/T^2`.
- The required configured checker was invoked but its pinned `gpt-5.4-mini`
  model is unavailable for this account.  Its three exact checks were then run
  locally and separately: material guidance/notes, the lightweight Julia
  policy contract, and the solver editable boundary all pass.  The guidance
  check first exposed the inherited duplicate assigned-parent marker in the
  rendered workspace `README.md`; removing only that duplicate marker repaired
  provenance.  No formal CFD was run.
