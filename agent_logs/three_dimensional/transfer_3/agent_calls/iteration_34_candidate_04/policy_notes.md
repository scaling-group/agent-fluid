# Converging posterior-response outer allocation candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled solver examples satisfy the frozen Phase-2 contract:
  direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  dynamics, and capture. Three are byte-identical `v40` policies; the fourth
  adds a signed course/yaw conjunction but produces the same trajectory and
  score. Thus the sample reproduces capture at `19.684490 T`, score
  `-0.261384287`, mean/final distance `2.151092787 L`/`0.748302400 L`, and
  shows that the different branch is dormant rather than beneficial.
- I inspected the complete combined keyframe sheet for the reproduced `v40`
  parent, including the top-down mid-plane-vorticity row and the oblique
  body/Lambda2 row from release through capture. The fish self-propels from
  quiescent water along a compact lower-left approach and sheds a coherent
  alternating posterior wake; the oblique view retains finite localized 3D
  structures. There is no passive advection, collision, boundary-exit
  precursor, wake collapse, or numerical instability.
- I also inspected the complete sheets for the assigned parent's completed
  converging-posture candidate and the inherited outer phase-lag governor.
  The converging-posture sheet is visually almost indistinguishable from
  `v40`, but its active 93-command terminal change worsens score and mean/final
  distance to `-0.261772172`, `2.151409218 L`, and `0.748659670 L` at the same
  capture step; its late force/moment maxima also rise. The phase-lag governor
  remains self-propelled and initially sheds a coherent wake, but its small
  response-conditioned shortening of the derivative-defined posterior lag
  turns the compact `12.9511 L` route into a visible `31.0127 L` orbit. It
  delays capture to `46.145020 T`, worsens score/mean distance to
  `-0.915605503`/`2.857986094 L`, and accumulates 607 moving-window shifts
  instead of 243 while remaining finite. Posterior lag is therefore a
  protected course-forming relation, not a feasibility knob.
- Metrics localize the remaining overload to the established outer gait. On
  reproduced `v40` states above `4 L`, the anterior/posterior commands exceed
  `30 rad/T^2` on `1139/1671` samples and contact the `260 deg/T` rate envelope
  on `207/342`; the coherent wake and monotone progress after startup show that
  the traveling bend is productive despite these contacts. The current
  allocator chooses extra common scaling from posterior position error alone,
  even when measured posterior velocity is already reducing that error. That
  response direction is an untested selector between the two already validated
  outer priorities: traveling-bend recovery and bounded target residual.
- The assigned-parent result closes the proposed terminal posture-energy locus,
  and inherited results also reject outward-response posture/carrier changes,
  terminal clipping blends, direct posterior-lag reshaping, and extra startup
  mean-curvature redirect. The new test therefore remains outside `4 L`, does
  not add another terminal response branch, and does not change a curvature
  target, cadence, beat side, or total acceleration authority.

## Policy hypothesis

Start from reproduced `v40` and preserve its state-feedback oscillator,
derivative-defined posterior lag target, target guidance, course/geometric
route allocation, center-intercept corridor, terminal posture handoff, and
command cap. In the existing outer saturation allocator, form the normalized
positive product of posterior lag-target error and posterior joint velocity.
This is positive only when measured posterior motion is reducing the
instantaneous lag error. Use that response to transfer at most a small declared
fraction of the existing lag-recovery priority toward the already bounded
target residual. Opposed or stationary response retains `v40` exactly, and the
existing course-agreement branch may still complete the same transfer.

This is a response-conditioned actuator-allocation mechanism, not scalar-only
gain tuning. It alters neither the posterior lag target nor either joint's
authority, and the existing outer gate makes it exactly absent at and below
`4 L`. Expected result: avoid continuing to reserve common-scale headroom for
an error already correcting itself, improve outer target progress, and retain
the directed traveling bend, compact route, coherent two-view wake, and quiet
terminal capture. Falsify the mechanism if the response gate is dormant or
nearly constant, changes a terminal same-state command, delays or loses
capture, worsens distance integral, produces a loop or exit, increases rate
contact or loads, destabilizes the rollout, or degrades either wake view.
The candidate's CFD result occurs only after this worker exits and is not
claimed here.

bookshelf_consulted: true
source_domain: traveling-wave swimming models and closed-loop coupled-oscillator robotic-fish control
source_mechanism: retain a directed anterior-to-posterior bend while using measured oscillator response to allocate bounded route correction
transferable_invariant: preserve the lagged wave target, but reduce recovery allocation when normalized joint motion already closes its tracking error so complementary low-frequency steering can use the available command direction
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, and task-specific routes
policy_translation: above 4 L only, use positive posterior lag-error times posterior velocity to transfer a small bounded share from the existing response-conditioned common limiter to the existing geometry-owned target residual without changing lag, mean curvature, or acceleration limits
falsification: reject on dormancy, terminal activation, slower or lost capture, worse distance integral, a changed looping or exit topology, more stop dwell or loads, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Replaying evaluated `v40` and the candidate on all `3579` reconstructed
  stored `v40` states changes `1768` commands, confined to
  `0.2915--15.4385 T` and `12.3272--4.0009 L`. All `772` recorded states at
  or below `4 L` remain exactly identical. The maximum component difference is
  `0.23344 rad/T^2`, about `0.76%` of the software acceleration cap.
- On changed states the smooth posterior-convergence support has
  `0/10/50/90/100%` quantiles of approximately
  `0.0000004/0.0283/0.4569/0.9330/0.9913`. The mechanism is therefore active,
  response-varying, and bounded rather than dormant or effectively constant.
  Same-state selectivity does not establish a beneficial coupled-flow result.
- A deterministic `65,610`-state grid spanning range, body-frame target angle,
  center-course angle and speed, closure, both joint positions, and both joint
  rates returns two finite accelerations within the declared cap for every
  state. Every grid state at or below `4 L` exactly reproduces evaluated `v40`.
  The deterministic parameter-schema audit resolves all `90` direct
  `params.FIELD` references against the `91` returned fields; only the version
  label is intentionally unused. No formal CFD was run in this workspace.
- The prescribed check-runner was invoked after the material edits, but its
  pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account and failed
  before executing a command. Running its three specified non-CFD commands
  directly gives PASS for the material guidance update, finite two-output Julia
  contract, and solver edit boundary. The guidance check first exposed two
  identical assigned-parent markers in the rendered root `README.md`; removing
  only the duplicate restored unambiguous parent resolution.
