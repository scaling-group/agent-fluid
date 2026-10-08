# Course-aligned outer steering-residual relief

## Evidence and visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window dynamics, and capture. Three sampled outcomes
  reproduce `v40_intercept_supported_terminal_posture` exactly, including
  capture at `19.684490 T`, score `-0.261384287`, mean/final distance
  `2.151092787 L`/`0.748302400 L`, and the `4 L` crossing at `15.444014 T`.
- The informative active regression is
  `v41_response_opposed_intercept_posture`. It preserves the `4/3/2 L`
  crossings but delays the `1 L` crossing by about `0.02750 T` and capture by
  `0.03850 T`; score, mean distance, and final distance regress to
  `-0.261856310`, `2.151574012 L`, and `0.748641372 L`. Its added posture
  allocation lowers below-`4 L` high-command counts only from `229/302` to
  `225/299` and rate-cap counts from `252/400` to `249/399`, while increasing
  peak lateral force from `0.027533` to `0.027721` and peak yaw moment from
  `0.015673` to `0.015701`. Lower clipping incidence did not compensate for
  suppressing useful rhythmic response.
- The other nominal `v41` sample is exactly behavior-identical to `v40`; its
  high-threshold course/yaw selector is dormant. Together with the inherited
  command-ratio regression, the current evidence rejects further terminal
  posture strengthening, clip-shape repair, and unevidenced threshold changes.
- The assigned parent's post-worker result closes the apparent inverse test.
  Its response-permissive handoff retained up to four percentage points more
  carrier on outward joint response, yet regressed to score `-0.261822240` and
  final distance `0.748728991 L`. The parent's pre-evaluation hypothesis was
  reasonable, but completed CFD now rejects using outward posture-error rate
  to move the same terminal allocation in either direction. An initial draft
  of that inverse was therefore discarded before selecting the final
  candidate mechanism.
- I inspected the complete combined keyframe sheets for reproduced `v40` and
  the active response-opposed regression, including both the top-down
  mid-plane-vorticity row and oblique body/Lambda2 row from release through
  capture. Both fish visibly self-propel from quiescent water along the same
  compact upper-side target approach, form a coherent alternating posterior
  wake, and retain finite localized three-dimensional structures. Neither is
  passively advected and neither shows a loop, collision, domain-exit
  precursor, wake collapse, numerical instability, or out-of-plane motion.
  The common outer path and wake localize the regression to the late
  rhythm-to-posture allocation.
- The surviving positive mechanism is the signed geometry/course allocator:
  inherited results improved from `v38` (`-0.271582682`) to `v39`
  (`-0.262179959`) by allowing instantaneous center-course information to
  prioritize the target residual only when it agreed with body-frame target
  geometry. In `v40`, the remaining outer command still always includes the
  full gait-scale half-cycle steering residual even when measured translation
  is already closing nearly along the target ray. Protecting that useful
  translation by relieving only the high-frequency residual is independent of
  the rejected terminal handoff edits; the lower-frequency mean bend remains.

## Policy hypothesis

Start from the three-times-reproduced `v40` controller and leave its complete
at-or-below-`4 L` handoff bit-identical. Outside that band, when center
translation is established, range is closing, the predicted course miss is
small, and body-frame target geometry still asks for steering, relieve at most
ten percent of only the existing half-cycle steering residual. Preserve the
state-feedback oscillator, posterior lag, mean-curvature target, signed
geometry/course priority allocator, cadence, terminal posture, and acceleration
limit. A smooth actual-distance gate makes the mechanism vanish at `4 L`.

This is one course-protective actuator-allocation mechanism, not scalar-only
gain tuning: it distinguishes useful target-directed translation from the
gait-scale body angle that drives the residual, while leaving the slower bend
request in the posterior target. Expect a small outer-path improvement without
changing terminal commands or the coherent traveling wake. Falsify it if the
branch is dormant or effectively constant, changes any state at or below
`4 L`, acts without established closing translation and a supported course,
weakens the mean bend or stronger redirect, delays or loses capture, worsens
mean/final distance, increases stop dwell or loads, becomes unstable, or
degrades either wake view. The new CFD evaluation occurs only after this
worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish path following and wake-exploitation studies
source_mechanism: preserve useful rhythmic propulsion and observed target-directed translation while applying route correction as a separately bounded residual
transferable_invariant: when a coordinated traveling bend already produces closing translation along the target ray, gait-scale steering need not overwrite that useful motion; retain the low-frequency bend while softly relieving only the shared high-frequency residual
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: outside the normalized terminal band only, combine positive closure, established body-frame center velocity, small predicted course miss, and nonzero target geometry to relieve a bounded share of the half-cycle steering residual while preserving oscillator drive, posterior mean curvature, and all terminal commands
falsification: reject on dormancy or constant activation, any change at or below the terminal band, action without supported closing translation, weaker mean-bend or redirect steering, slower or lost capture, worse distance integral, stop dwell, load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Replaying reconstructed normalized body-frame observations from both the
  reproduced `v40` and response-opposed traces changes `1982` stored states
  relative to `v40` on each trajectory. Every change is outside `4 L`, over a
  range of about `4.0009--12.3245 L`; every at-or-below-`4 L` command is
  exactly unchanged. The maximum equal-state command difference is about
  `0.4662 rad/T^2`.
- On the reproduced `v40` trace, the combined closing-, motion-, course-, and
  geometry-support signal varies smoothly from approximately zero to one
  (median `0.276`, interquartile range `0.038--0.698`) rather than behaving as
  a constant multiplier. This establishes an independently active mechanism,
  not a coupled-flow benefit.
- A deterministic `48600`-state grid spanning range, body-frame target and
  course angles, closing response, both joint positions, and both joint rates
  finds `4655` active differences. All outputs are finite and inside the
  declared acceleration limit; no state at or below `4 L`, without positive
  closure, or without established translation changes.
- The prescribed check-runner was invoked after all material edits, but its
  pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account and
  failed before executing a command. Its configured material-guidance,
  lightweight Julia two-output contract, and solver edit-boundary checks were
  run directly and pass. The supplemental deterministic parameter-schema
  audit also passes: all `89` direct `params.FIELD` references resolve in the
  `90`-field object returned by `target_policy_params()`; only the version
  label is intentionally unused. No formal CFD was run in this workspace.
