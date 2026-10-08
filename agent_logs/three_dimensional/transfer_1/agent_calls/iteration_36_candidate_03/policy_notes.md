# Closing-response arbitration for posterior-turn release

## Completed evidence and visual diagnosis before editing

- All four sampled rollouts are finite `capture` episodes initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  The two byte-identical v49 samples reproduce capture at
  `17.48449 T`, score `-0.0616520`, and total/observed distance integrals
  `1.947439/1.331949 L`.  V50 remains the strongest completed policy, capturing
  at `17.41299 T`, score `-0.0595203`, and integrals
  `1.945327/1.329976 L`.
- V51 is the informative completed regression rather than a termination
  failure.  Its decisive smooth geometry map captures later and more shallowly
  than v50 at `17.45149 T` and `0.748203 L`; total integral and score regress to
  `1.946554 L` and `-0.0612916`.  The mechanism nevertheless creates a useful
  different trajectory: observed integral improves to `1.328924 L`, and v51
  leads v50 by `0.03010/0.03356/0.01702/0.00878 L` at
  `6/8/10/12 T`.  That lead is gone by `14 T`, and v51 trails by `0.01760 L`
  at `16 T`.  Its maximum speed falls from `0.98310` to `0.96666 L/T`, but
  any-joint acceleration-limit residence rises from `40.11%` to `42.99%`;
  peak normalized planar force/moment is unchanged at
  `0.032252/0.016092`.
- I inspected the combined release-to-capture sheets for the strongest finite
  v50 rollout and the v51 regression, as well as both v49 reproductions.  The
  readable top-down rows show active self-propulsion on nearly the same smooth
  target-signed arc: compact startup vorticity develops into an organized
  alternating posterior street through capture, without reversal, collision,
  domain exit, or wake collapse.  All current sampled oblique rows are black
  after their frame labels (one v49 combined sheet is entirely black), so this
  is an evaluation/rendering failure.  The current sample verifies top-down
  carrier coherence only; it cannot support a comparative three-dimensional
  wake claim.
- Frozen reconstruction explains why another scalar completion threshold is
  not the next test.  Relative to v50's linear geometry qualifier, v51 changes
  its strongest correct-yaw release events during startup and the `6-12 T`
  useful regime, but closed-loop state drift later changes the release class
  and erases the lead.  On the completed traces, correct-yaw samples average
  only about `0.02-0.03 L/T` normalized closing response during `0-2 T`, then
  about `0.86-0.98 L/T` from `6-16 T`.  This separates lack of established
  propulsion from the late geometry class without using elapsed time or a
  memorized route.
- Assigned-parent guidance and inherited optimizer notes rule out reopening
  carrier cadence, amplitude, approach thrust, base route gain, or an
  independently scheduled distance handoff.  V50's middle/late gain and v51's
  early lead both arise from arbitration of the existing small phase-even
  posterior steering residual while the top-down carrier remains coherent.

## One-candidate policy hypothesis

Start from completed v50 and preserve its normalized body-frame target
sensing, state-feedback traveling-wave carrier, posterior lag, selective
crossflow pose confidence, base route and redirect steering, launch response,
carrier-first spillover, half-cycle steering, contraction-release branch,
approach priority, and componentwise acceleration projection.  Change only
the geometry confidence that qualifies correct-yaw release of the existing
small posterior turn-shape residual.

Retain v51's bounded decisive completion map as a launch-only candidate, but
blend it continuously back to v50's completed linear geometry confidence using
the already computed absence of productive normalized closing response.  When
closure has not formed, strong geometric/yaw agreement may decisively release
supplementary curvature instead of stacking steering on the launch wave.  As
measured closure forms, the blend returns to v50, preventing v51's nonlinear
map from reopening the completed `14-16 T` and terminal regression.  This is a
response-state handoff: it adds no explicit time, step, world-frame cue,
distance-stage route schedule, carrier change, or new steering sign.

The next CFD evaluation should retain v51's `6-12 T` route lead while matching
v50 by `14-16 T`, capture no later than v50, preserve v50's integrals and
top-down coherent wake, and remain inside the sampled speed, saturation,
force, and moment envelope.  Falsify the mechanism if the early lead fails to
survive, the v51 terminal regression remains, capture or target-signed motion
is lost, switching becomes beat-sensitive, acceleration-limit residence
approaches v51 without a closure benefit, or a readable oblique rollout shows
degraded caudal wake structure.  Formal CFD occurs only after this worker
exits.

```text
bookshelf_consulted: true
source_domain: biological burst-turn response release, sensor-modulated robotic-fish direction tracking, and terminal capture control
source_mechanism: keep the propulsive rhythm active while supplementary curvature yields only when observed geometric response is useful, then return authority according to measured approach response
transferable_invariant: arbitrate supplementary wave-shape steering by bounded body-frame geometry and observed closing response while preserving the carrier and base target steering
nontransferable_details: published gains, dimensional maneuver timing, species-specific curvature envelopes, full-body kinematics, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: blend the existing decisive geometry-yaw completion map toward the completed linear map as normalized productive closing response forms; apply it only to release of the small posterior turn-shape residual
falsification: reject if v51's 6-12 T lead is not retained, v50's 14-16 T and terminal behavior regresses, capture or coherent wake is lost, the new response scalar develops signed dependence, or speed, saturation, normalized force, or moment exceeds the sampled envelope
```

## Evidence boundary

All outcome and visual claims above come from the assigned parent guidance,
sampled completed solver results, and inherited optimizer logs.  The proposed
closing-response arbitration is one unevaluated policy hypothesis; no
same-worker CFD result is claimed.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v52_closing_arbitrated_posterior_response`.  Relative
  to completed v50, only one owned completion scale, the bounded
  closing-response interpolation, and diagnostic return fields are added; the
  carrier, base steering, contraction release, approach gate, and final
  actuator allocation are unchanged.  All `69` distinct direct
  `params.FIELD` references resolve among the `71` fields returned by
  `target_policy_params()`.
- Frozen replay on the completed v50 trace gives zero anterior-action change,
  a maximum posterior-action delta of `0.021423 rad/T^2`, and exact agreement
  with the stated interpolation law.  Thirteen posterior samples change above
  `1e-9 rad/T^2` during `0-2 T`; later deltas are at most
  `2.64e-6 rad/T^2`, confirming that established closure returns the policy
  numerically to v50.  Every replayed output is finite and within the
  componentwise acceleration envelope.  These are localization checks, not a
  prediction of closed-loop gain.
- A deterministic `3,600`-state audit gives finite bounded actions, zero
  interpolation error, and zero mirror error for the newly used
  closing-response arbitration scalar.  No whole-policy reflection claim is
  made: the inherited controller deliberately retains unequal signed route
  authority through `negative_turn_request_gain`.
- The material-guidance check, lightweight Julia contract, parameter-schema
  guard, and solver editable-boundary check pass.  The required configured
  check-runner was invoked, but its pinned `gpt-5.4-mini` model is unavailable
  for this ChatGPT account; its three exact no-CFD checks were run locally and
  separately.  No formal CFD was run.
