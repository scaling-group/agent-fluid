# Response-selective terminal posture handoff

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. The
  inherited `v39_geometry_agreed_course_allocation` reaches capture at
  `19.783508 T`, score `-0.262179959`, mean distance `2.151933490 L`, and
  final distance `0.749067426 L`. Its two carrier-recovery children retain the
  same capture step and outer trajectory and improve only the fifth decimal of
  mean/final distance: `v40_intercept_deficit_carrier_rescue` scores
  `-0.262163153`, while the assigned `v40_intercept_unsupported_carrier_recovery`
  scores `-0.262141399`.
- The distinct `v40_intercept_supported_terminal_posture` child is the only
  semantic improvement in this sample. It is identical through the `4 L`
  crossing at `15.444014 T`, permits a small damped-posture allocation on an
  already closing center intercept, and captures at `19.684490 T`, about
  `0.099 T` earlier than all three alternatives. It improves score, mean
  distance, and final distance to `-0.261384287`, `2.151092787 L`, and
  `0.748302400 L`. Below `4 L`, its `|action|>30 rad/T^2` counts fall from
  `318/373` to `229/302` anterior/posterior samples, while joint-angle extrema
  also decrease. Local lateral-force and yaw-moment maxima rise only slightly,
  from about `0.02724/0.01564` to `0.02753/0.01567`; this bounds further
  posture allocation and does not justify a larger hold fraction.
- I inspected the combined keyframe sheets for the best terminal-posture
  rollout and the informative lower-quality `v39` control from release to
  capture, including both top-down mid-plane vorticity and oblique 3D
  body/Lambda2 rows. Both fish visibly self-propel along the same compact
  target-directed path, shed a coherent alternating posterior wake, and retain
  finite localized three-dimensional structures. Neither shows passive
  advection, a loop, collision, boundary-exit precursor, wake collapse, or
  instability. The useful difference is therefore a localized terminal
  allocation response, not a new wake family or a propulsion repair. All four
  samples capture, so `v39` is the informative weaker comparison rather than a
  failure-termination example.
- The inherited optimizer log supplies a concrete negative boundary:
  releasing outer course priority with short-window closure efficiency created
  a visible loop, a `30.58 L` path, capture only at `44.885483 T`, score
  `-0.936939307`, and mean distance `2.877117766 L`. The observation window is
  about `0.04 T`, much shorter than the `0.55 T` beat. A new achieved-response
  selector must therefore use instantaneous joint geometry, not another noisy
  reconstructed route or closure rate.
- Same-state reconstruction on the best trace shows the terminal-posture gate
  is independently dominant on `165` stored states from about `3.63 L` to
  `1.60 L`. The already normalized posterior traveling-target lag spans roughly
  `0.02` to `1.98` drive amplitudes in those states. Applying the existing
  smooth lag-support map would release unnecessary posture allocation on `52`
  stored states while retaining it when posterior response is poor. Offline
  replay across all four traces changes only `51-52` states, all below `4 L`,
  with a maximum same-state command difference of about `3.56 rad/T^2`; every
  output remains finite and bounded by the declared software limit. These are
  activity and noninterference checks, not CFD evidence.

## Policy hypothesis

Start from the evaluated `v40_intercept_supported_terminal_posture`, preserving
its state-feedback oscillator, signed geometry/course outer allocator, target
residual, center-intercept predictor, redirect equilibrium, cadence, mean
curvature, terminal ceiling, and acceleration limit. Add one response selector
to the terminal posture handoff: normalize the observed posterior error to its
current traveling-bend target by drive amplitude and use the already declared
smooth response thresholds. When lag is large, retain the evaluated posture
handoff; once posterior tracking is achieved, continuously release only that
extra handoff back toward the unchanged carrier. Active large-angle redirect
still wins through the existing maximum, and no outer command can change.

The expected benefit is to retain the earlier terminal capture and reduced
high-command incidence while avoiding posture allocation after the posterior
joint is already producing the requested traveling response, thereby bounding
the small load increase. Falsify the candidate if the selector is dormant,
acts at or beyond `4 L`, weakens the initial range advantage, delays or loses
capture, worsens the distance integral, restores high-command or joint-stop
dwell, raises loads, creates a loop or instability, or degrades either wake
view. The new CFD rollout occurs only after this worker exits and is not
claimed as evidence here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish coupled-oscillator control and biological response-gated redirect-to-cruise transitions
source_mechanism: use measured body response to hand off continuously between a bounded steering posture and the propulsive traveling wave
transferable_invariant: a posture intervention should persist while the posterior traveling response is unresolved and release when the requested inter-joint response is achieved
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: below the normalized terminal band, multiply only the intercept-supported posture handoff by a smooth drive-amplitude-normalized posterior-lag support; preserve the redirect maximum, two-joint targets, carrier, and all authority limits
falsification: reject on dormancy, any outer command change, loss of the early range advantage, slower or lost capture, worse distance integral, restored saturation or stop dwell, load growth, a loop, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- The actual candidate keeps the sampled winning policy intact except for the
  terminal posterior-response selector and its version/provenance comments.
  It retains the parent's `12%` posture ceiling and reuses the existing
  drive-amplitude normalization and smooth posterior-lag thresholds; no
  authority, cadence, curvature, or observation-history parameter was added.
- The prescribed `.codex/agents/check-runner.toml` was invoked after the
  edits, but its pinned `gpt-5.4-mini` model is unsupported on this ChatGPT
  account and failed before executing a check. Its three configured non-CFD
  commands were therefore run directly and separately. The guidance check
  first exposed a duplicated assigned-parent marker in the rendered root
  `README.md`; removing only the duplicate repaired parent resolution. The
  material-guidance check, lightweight two-output Julia contract, and solver
  boundary check all pass.
- The deterministic schema audit resolves all `88` direct `params.FIELD`
  references in the `89`-field object returned by `target_policy_params()`;
  only the version label is intentionally unused by the control algebra. No
  formal CFD was run in this workspace.
