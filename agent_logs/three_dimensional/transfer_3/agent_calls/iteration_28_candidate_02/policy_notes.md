# Intercept-supported terminal posture handoff

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. The two
  `v37_response_exclusive_allocation` samples are exact reproductions at
  `19.612991 T`, score `-0.282941223`, mean distance `2.172435105 L`, and
  final distance `0.748660505 L`.
- The unsigned `v38` course allocator improves score and mean distance to
  `-0.271582682` and `2.162124221 L`, but captures later at `19.998001 T`.
  It reduces below-`4 L` high-command incidence to `322/390` anterior/tail
  samples and terminal force/moment maxima to about `0.02630/0.01384`, while
  raising global maxima to about `0.03154/0.01678`. An instantaneous course
  magnitude alone therefore produces a useful early path but an overbroad
  authority transfer and a changed terminal approach.
- The best sampled `v39_geometry_agreed_course_allocation` retains only the
  signed course corrections that agree with target geometry. It improves
  score to `-0.262179959` and mean distance to `2.151933490 L`, crosses `4 L`
  at about `15.444014 T` instead of `15.614507 T` for `v38`, and partly
  recovers capture time to `19.783508 T`. Its terminal high-command incidence
  is `318/373`, global and terminal force maxima are about `0.03017`, and the
  global and terminal moment maxima are about `0.01564`. It has no joint-angle
  stop dwell and finishes with modest commands `0.166/0.951 rad/T^2`, but its
  rate limits are still contacted on `250/397` stored anterior/tail states.
- I inspected every sampled combined keyframe sheet from release through
  capture, including the top-down mid-plane-vorticity and oblique body/Lambda2
  rows. Each fish visibly self-propels from quiescent water along a compact
  target-directed arc, forms a coherent alternating posterior wake, and
  retains finite localized three-dimensional structures. None is passively
  advected and none shows a loop, collision, boundary-exit precursor, wake
  collapse, numerical instability, or out-of-plane motion. `v39` reaches the
  target with the same productive wake family as `v37/v38`; the useful visual
  distinction is its more direct early translation and its partial transition
  toward a held bend before capture. There is no failed termination in this
  sample, so reproduced `v37` is the informative lower-quality control
  contrast rather than a failure-class example.
- Reconstructing normalized body-frame geometry on the sampled `v39` trace
  shows its new outer course allocation is confined to the initial approach:
  it is active on about `416` states, almost all beyond `9.86 L`, and on about
  `403/416` of those states the geometry magnitude is worsening over the
  available observation window. Widening that course authority is therefore
  unsupported. Between `4 L` and `1 L`, however, the existing predicted
  center-intercept support identifies `185` closure-supported states where
  the current large-angle redirect gate is smaller than a capped `12%`
  posture-handoff request. This is an independently active terminal locus.

## Policy hypothesis

Start from evaluated `v39`, preserving its state-feedback oscillator,
target-guidance law, response-exclusive saturation allocator, signed
geometry/course agreement, closure preview, crossflow-supported relief, and
intercept corridor. Add one terminal approach-hold mechanism: inside the
existing normalized terminal band, when range is closing and the observed
center course already intersects the target corridor, permit at most `12%`
support for the existing damped two-joint mean-curvature equilibrium even when
the large-angle redirect gate is quiet. Combine it with redirect support by a
maximum, not a sum, so it cannot increase an already active redirect. It
changes neither the equilibrium, cadence, turn gains, course authority,
actuator limit, nor any outer command.

The expected benefit is to suppress intermittent carrier saturation and loads
during a geometrically valid terminal crossing without discarding `v39`'s
early range advantage or removing propulsion before the intercept is
supported. Falsify the candidate if the branch is dormant, acts outside `4 L`
or without positive closure/intercept support, changes the outer path, delays
or loses capture, worsens mean/final distance, increases joint-stop dwell or
loads, causes instability, or degrades either wake view. The new CFD rollout
occurs only after this worker exits and is not claimed as evidence here.

bookshelf_consulted: true
source_domain: closed-loop CPG robotic-fish path following and response-gated biological redirect-to-cruise transitions
source_mechanism: use observed task geometry and response to hand off continuously between rhythmic propulsion and a bounded posture equilibrium
transferable_invariant: near a target, an already closing intercept may receive a small state-gated posture allocation without changing the far-field rhythm or requiring a timed maneuver
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: inside the normalized terminal band only, take the maximum of the existing redirect gate and a capped body-frame center-intercept support, with both multiplied by the existing proximity and positive-closure gates, then blend toward the unchanged two-joint damped equilibrium
falsification: reject on dormancy, activation outside the terminal band or without closure/intercept support, loss of the early range advantage, slower or lost capture, worse distance integral, stop dwell, load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- The evaluated `v39` policy and the candidate were loaded in separate Julia
  modules and replayed on all three distinct sampled state traces. The new
  branch changes `157/219/319` stored states from the `v39/v38/v37`
  trajectories, with a maximum same-state command difference of about
  `4.3291 rad/T^2`. No state at or beyond `4 L` changes, and every changed
  state has positive closure plus nonzero center-intercept support.
- Every replayed candidate output is finite and within the declared
  `1750 deg/T^2` software limit. These checks establish activity,
  boundedness, support-gate selectivity, and outer same-state noninterference;
  they do not establish coupled-flow improvement or preservation of the
  realized trajectory.
- The lightweight two-output Julia contract and solver boundary check pass.
  The deterministic schema audit resolves all `88` direct `params.FIELD`
  references in the `89`-field object returned by `target_policy_params()`;
  only the version label is intentionally unused by the control algebra.
- The prescribed check-runner was invoked after the edits, but its pinned
  `gpt-5.4-mini` model is unsupported on this ChatGPT account and failed before
  executing a command. Its three configured non-CFD commands were therefore
  run directly and separately. The guidance check initially found the
  inherited duplicate assigned-parent marker in the rendered root `README.md`;
  removing only that duplicate repaired parent resolution, and all three
  checks pass. No formal CFD was run in this workspace.
