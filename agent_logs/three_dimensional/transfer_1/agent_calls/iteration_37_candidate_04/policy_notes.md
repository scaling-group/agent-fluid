# Response-arbitrated terminal course candidate

## Completed evidence and visual diagnosis before editing

- All four sampled rollouts are finite `capture` episodes initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm.  Two byte-identical v50 evaluations reproduce the strongest result:
  capture at `17.412992 T`, score `-0.0595203`, total/observed distance
  integrals `1.945327/1.329976 L`, and final distance `0.745094 L`.
- The v49 approach-retained partition captures later at `17.484489 T` and
  worsens total/observed integrals to `1.947439/1.331949 L`.  It is closer than
  v50 by `0.02493/0.02249 L` at `6/8 T`, but v50 leads by
  `0.01279/0.03641/0.03554/0.03727 L` at `10/12/14/16 T`; v50's advantage is
  therefore a middle/late response-arbitration improvement rather than a new
  carrier or wake topology.
- The sampled v52 terminal course-slip feedback exactly matches v50 through
  the far route and reaches capture on the same `17.412992 T` step, but it
  crosses more shallowly at `0.746705 L`, raises the total integral to
  `1.946671 L`, and worsens score to `-0.0611859`.  Its observed integral is
  effectively unchanged (`1.329989 L` versus `1.329976 L`), while any-joint
  acceleration-limit residence rises from `40.11%` to `40.75%`.  At capture,
  it moves the head slightly closer to the target line in `y` but about
  `0.00168 L` farther from the target in `x`; the direct extra route curvature
  trades axial closure for lateral alignment without an arrival benefit.
- Inherited v51 and optimizer comparisons reinforce the boundary.  Making the
  posterior-response qualifier more decisive improves the observed integral
  and the `6-12 T` route but captures later at `17.45149 T`; axial-response and
  centerline-deadband variants also fail to improve v50.  Another posterior
  release-law reshape or scalar carrier/steering gain change is not supported.
- I inspected the combined release-to-capture sheets for v50, v49, and v52,
  including the top-down vorticity and oblique body/Lambda2 rows.  Every
  top-down row shows self-propelled motion on a smooth target-signed arc, with
  compact startup vorticity growing into an organized alternating posterior
  street and no reversal, collision, domain exit, or visible lateral-wake
  waste.  The v52 oblique row is readable and shows compact paired caudal
  structures through capture; the v50 row is readable at release, `4 T`,
  `16 T`, and capture but has a black `12 T` panel, while v49's oblique panels
  are black after their labels.  Those black panels are rendering failures,
  not evidence of a wake change.  The readable v52 view supports preserving
  the 3D carrier; its scalar/trajectory regression supplies no beneficial new
  wake mechanism.
- V50 and v52 share maximum speed `0.98310 L/T` and peak normalized
  force/moment `0.032252/0.016092`.  V50 already ends with strong correct-sign
  yaw, so v52's independent course term can remain redundant with the
  established rate loop.  The evidence supports changing where the course
  observation enters feedback, not increasing its gain or changing the gait.

## One-candidate policy hypothesis

Preserve completed v50's normalized body-frame target sensing, state-feedback
traveling-wave carrier, posterior lag, selective crossflow pose confidence,
base route and redirect steering, launch response, carrier-first spillover,
half-cycle steering, geometrically qualified posterior response, approach
priority, and componentwise actuator projection.  Add exactly one terminal
course mechanism: compute the same reflection-odd, dimensionless signed sine
between the body-frame head-to-target vector and body velocity used by v52,
but inject its near-approach, positive-closing correction only into the
existing bounded target-yaw-rate request.  Multiply it first by a continuous
direction-aligned de-gaited-yaw response deficit, so a correct-sign response
makes the course request yield before it reaches the rate loop.  The ordinary
geometric curvature request remains unchanged.  The existing yaw-rate error
then supplies only the remaining response rather than stacking course slip as
independent direct curvature after that loop.

The next CFD rollout should remain identical to v50 outside the established
`2.1 L` approach region, preserve its middle/late lead and coherent alternating
two-view wake, and either improve the terminal crossing/integral or behave more
like v50 than the direct v52 residual.  Falsify the mechanism if capture is
later or shallower than v50, observed or total integral worsens, the signal
changes the far route, terminal yaw or slip grows, target-signed curvature or
wake coherence is lost, or speed, saturation, force, or moment materially
exceeds the completed v50 envelope.  Formal CFD occurs only after this worker
exits.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal capture control
source_mechanism: modulate an existing rhythmic controller through sensor-defined direction error and measured response while preserving the propulsive carrier
transferable_invariant: a terminal course error should alter a bounded desired turning response and yield as observed yaw supplies that response, rather than stack an independent curvature command on an already-correcting gait
nontransferable_details: published gains, dimensional maneuver timing, species-specific kinematics, full-body CPG state, exact vortex phase, and task-specific routes
policy_translation: form a normalized reflection-odd body-frame target/velocity course error, gate it by normalized approach, positive closing, and a continuous direction-aligned de-gaited-yaw response deficit, and add it only inside the existing bounded target-yaw-rate calculation for the two-joint state-feedback controller
falsification: reject if the completed v50 route changes outside approach, capture or either distance integral regresses, terminal course error or switching grows, or speed, saturation, normalized force, moment, or the readable two-view wake exceeds the completed envelope
```

## Evidence boundary

All numerical outcomes and visual claims above come from completed sampled
solver evidence, the assigned-parent guidance, and inherited optimizer logs.
The response-arbitrated course mechanism is one unevaluated policy hypothesis;
no same-worker CFD result is claimed.

## No-CFD implementation audit

- The sole materialized solver candidate is
  `dogfish_target_control_v53_response_arbitrated_terminal_course`, SHA-256
  `d65a9dc5c2138692411cd3159b326548794a2c965f023431f23ccd41b36eae70`.
  Its only behavioral difference from completed v50 is the bounded course
  observation, response-deficit gate, and target-yaw-rate modulation above;
  carrier, direct geometry request, posterior release, and projections are
  unchanged.
- Frozen reconstruction over all `3,166` completed v50 trace rows changes
  actions only on the final `301` approach/closing rows, beginning after the
  distance crosses `2.1 L`.  It is exactly unchanged on every far-route and
  non-closing row.  Maximum reconstructed action difference is
  `0.09555 rad/T^2`, versus `0.97877 rad/T^2` for the completed direct v52
  design audit.  At v50 capture, direction-aligned yaw response is `0.99517`,
  reducing the course request to `-0.00094` request units and the reconstructed
  action change to about `0.00023 rad/T^2`; this is locality evidence, not a
  predicted CFD improvement.
- A deterministic `24,576`-state grid confirms finite componentwise-bounded
  actions, exact equality with v50 for every far-approach or non-closing case,
  reflection-odd course error/request, and reflection-even yaw-response
  confidence.  All `69` distinct direct `params.FIELD` references resolve
  among the `71` fields returned by `target_policy_params()`.
- The material-guidance, lightweight Julia contract, and solver editable-
  boundary checks pass.  The configured `.codex/agents/check-runner.toml` was
  invoked, but its pinned `gpt-5.4-mini` model is unsupported on this ChatGPT
  account; its three exact no-CFD checks were therefore run locally and
  separately on the finalized files.  No formal CFD was run.
