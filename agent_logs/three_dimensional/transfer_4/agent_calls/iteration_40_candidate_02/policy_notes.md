# Candidate diagnosis: retain the measured v31 exploitation policy

## Evidence read before candidate selection

- The four sampled solvers are byte-identical v31 repeats: each captures at
  `18.0125T` with score `-0.064000433`, observed distance integral
  `1.336755663L`, padded mean distance `1.950346350L`, center path
  `13.214861L`, and head cross-track `0.732689L`. All use direct uniform
  quiescent initialization and 251 lossless moving-window shifts. Their
  policies, trajectories, and combined keyframe sheets have matching hashes,
  so they establish deterministic reproduction rather than four mechanisms.
- In both rows of the sampled combined sheet, the fish self-propels toward the
  target behind a coherent alternating mid-plane wake and stable oblique 3D
  vortex train. There is no release artifact, passive advection, wake breakup,
  boundary interaction, or body instability. The final body is oblique and
  still beating energetically at the capture circle, consistent with the
  measured final alignment `0.1297`, speed `0.8806U`, and absolute yaw rate
  `0.8077 rad/T`; propulsion formation is not the missing capability.
- The assigned parent's completed v32 rollout supplies the informative
  negative comparison. Its top-down and oblique sheets remain visually in the
  same coherent class and it captures at the same `18.0125T`, but its score is
  `-0.064008829`. Relative to v31, observed distance integral changes by only
  `-5.4e-8L`, center path by `+1.36e-5L`, head cross-track by `-1.80e-5L`,
  final alignment by `+1.99e-5`, and final absolute yaw by `-8.99e-4 rad/T`;
  approach acceleration- and rate-limit residence is unchanged at the sampled
  precision. These are not semantic or useful-trajectory improvements.
- V32's inherited counterfactual predicted nonzero internal relief on `9.64%`
  of approach samples with a `0.1342` peak fraction, but completed CFD shows
  realized anterior output changed on only 39 samples and by at most
  `0.03633 rad/T^2`, just `0.116%` of the `31.416 rad/T^2` ceiling. The first
  difference occurs only at `0.950L`. Thus internal selector activation did
  not survive downstream command addition, clamping, and the saturated
  phase-plane dynamics as meaningful actuator authority.
- The observation polarity was not yet a control-error polarity. Projecting
  the fitted lateral residual into the instantaneous target-normal direction
  on the v31 trace shows that it opposes the signed course error on `92.1%` of
  approach samples; its mean course-error product is `-0.0521`. The residual
  is a calibrated body-y observation, but the parent's
  `-turn_command * lateral_slip_residual` gate does not establish that the
  observed component is harmful and should be suppressed.

## Candidate hypothesis written before policy materialization

Materialize exactly one candidate: the byte-identical evaluated v31
course-consensus posterior-duty policy already prefilled under `solver/`.
Do not continue v32 with a larger relief gain or lower selector threshold:
that would be scalar tuning of a channel whose realized authority and error
semantics both failed. Preserve v31's odd target-to-curvature map, nominal
cadence, posterior lag/emphasis, conserved approach mean bend, bounded
course-consensus duty surface, rate governor, and coherent two-view wake.

Expected signature: deterministic reproduction of the sampled capture and
metric class. This is an exploitation candidate, not a claim that the poor
terminal alignment is solved. Falsify it if formal evaluation does not retain
capture near `18.0125T`, the observed closure integral and route class, the
coherent alternating top-down/oblique wake, or the established actuator-load
class. A later departure should first establish target-normal error semantics
and realized post-arbitration command authority on replay, then require a
semantic CFD improvement rather than a larger internal gate.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and feedback-modulated robotic-fish rhythmic control
source_mechanism: preserve a posterior-emphasized traveling wave and use sensor feedback only through a bounded, physically effective modulation surface
transferable_invariant: a corrective residual must have target-relative error meaning and survive actuator arbitration while retaining the useful traveling wave
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phase, and source-task routes
policy_translation: no new shelf primitive is adopted; retain the evaluated v31 two-joint state-feedback law because the completed v32 residual translation had neither validated error polarity nor meaningful realized command authority
falsification: reject v31 if it fails to reproduce capture and the established wake, closure, route, and load class; reject a later residual transfer unless target-normal polarity, reflection behavior, realized commands, and a semantic CFD improvement agree

