# Dual-response release candidate

## Completed evidence and visual diagnosis before editing

- All four sampled rollouts are finite `capture` episodes initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm.  The assigned v46 phase-even posterior turn-shape parent captures
  reproducibly at `17.64401 T`, score `-0.07419`, and total/observed distance
  integrals `1.95985/1.34371 L`.
- Releasing only the supplementary posterior curvature when de-gaited bearing
  contracts improves capture to `17.53399 T`, score to `-0.06405`, and the
  integrals to `1.94972/1.33372 L`.  It is closer than v46 at every `2 T`
  checkpoint through `16 T`, lowers any-joint acceleration-limit residence
  from `43.83%` to `42.75%`, and keeps peak normalized force/moment at
  `0.03225/0.01609`.
- A separately sampled release driven by correct-sign de-gaited yaw also
  improves v46, capturing at `17.50649 T`, score `-0.06667`, and integrals
  `1.95193/1.33422 L`.  Contraction release is closer by
  `0.00095/0.00631/0.00259/0.01720/0.03326/0.02565 L` at the `2-12 T`
  checkpoints, whereas yaw-response release is closer by `0.01801/0.02787 L`
  at `14/16 T` and captures `0.02750 T` earlier.  Thus neither completion cue
  dominates across the whole route.
- I inspected the combined release-to-capture sheets for v46 and both v47
  variants, including the top-down vorticity and oblique body/Lambda2 rows.
  All three visibly self-propel on smooth target-signed arcs; compact startup
  vorticity becomes an organized alternating posterior street and paired
  caudal 3D structures persist through capture.  There is no passive
  advection, route reversal, collision, domain exit, or wake collapse.  The
  response-gated variant's peak force/moment remains close at
  `0.03225/0.01625`, so its later-route lead is not evidence for more carrier
  amplitude or cadence.

## One-candidate policy hypothesis

Materialize the completed contraction-release controller and add the separately
validated yaw-response release as a second completion cue around the same
small posterior turn-shape residual.  Combine the two releases as a bounded
soft union: contraction can remove redundant curvature while target angle is
geometrically resolving, and correct-sign yaw can do so when bearing is not
contracting.  The second cue was nearly inactive early on its parent's frozen
trace but useful later, matching the complementary checkpoint results.  Only
the supplementary posterior residual yields; the state-feedback carrier,
target geometry, base two-joint steering, large-error redirect, launch
governor, and componentwise acceleration projection remain unchanged.  Both
release cues are reflection-even and use normalized body-frame state without a
clock, global direction, or memorized route.

The intended signature is to retain the contraction variant's `2-12 T`
checkpoint lead and lower integral while approaching the response variant's
`14-16 T` lead and earlier capture.  Falsify the soft union if it loses capture,
worsens either `1.94972/1.33372 L` integral, releases needed curvature while
bearing diverges and yaw is wrong-signed, raises posterior saturation or the
`0.9732/0.03225/0.01625` speed/force/moment envelope materially, or degrades
the organized two-view wake.  This candidate's CFD runs only after this worker
exits.

```text
bookshelf_consulted: true
source_domain: biological C-start response release and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a propulsive rhythm while supplementary curvature yields when observed geometric or yaw response shows that the requested turn is taking effect
transferable_invariant: extra wave-shape steering should remain available during unresolved target error but release continuously when normalized body-frame observations provide independent completion evidence
nontransferable_details: published gains, maneuver timing, species or robot kinematics, full-body curvature envelopes, exact vortex phases, open-loop oscillator phase, and task-specific routes
policy_translation: retain the completed posterior traveling-wave residual and multiply it by the complement of a bounded soft union of de-gaited bearing-contraction and correct-sign de-gaited-yaw releases; preserve the carrier, base two-joint steering, redirect, and final actuator projections
falsification: reject if checkpoint-wide closure or either distance integral regresses, capture is lost, mirrored-state tests fail, needed curvature is removed under unresolved response, saturation or normalized loads grow materially, or readable two-view evidence loses the coherent alternating wake
```

## Evidence boundary

All outcome and visual claims above come from completed sampled CFD, the
assigned parent guidance, and inherited optimizer notes.  The soft-union
candidate has no same-worker CFD evidence.

## No-CFD implementation audit

- The single materialized candidate is
  `dogfish_target_control_v48_dual_response_released_posterior_turn_shape`,
  with SHA-256
  `c71ce6cd80be8c1a5a4deb7cfcaa911d996da77cafa87a77b1d3dea705ad8d8a`.
  Relative to the completed contraction-release controller, its only control
  change is the correct-sign yaw cue and bounded soft union around the same
  supplementary posterior residual.
- All `68` distinct direct `params.FIELD` references resolve among the `70`
  fields returned by `target_policy_params()`.  The lightweight Julia contract
  returns two finite actions, and controlled states keep every action inside
  the componentwise acceleration limit.
- Cue-isolation tests give zero release when bearing diverges and yaw has the
  wrong sign, positive release from contraction alone, and positive release
  from correct-sign yaw alone.  Direct drive tests preserve an exactly
  equal-and-opposite posterior residual under mirrored joint motion and turn
  commands, and the algebraic soft union remains bounded between its strongest
  input and their clipped sum.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this ChatGPT account.  Its three exact checks were therefore
  run locally and separately: the material guidance check, lightweight Julia
  contract, and solver editable-boundary check all pass.  No formal CFD was
  run.
