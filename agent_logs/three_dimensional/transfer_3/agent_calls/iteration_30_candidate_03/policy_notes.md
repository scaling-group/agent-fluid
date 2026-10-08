# Response-permissive intercept-posture handoff

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. The
  assigned prefill is `v41_response_opposed_intercept_posture`, which captures
  at `19.722988 T`, scores `-0.261856310`, and has mean/final distance
  `2.151574012 L`/`0.748641372 L`.
- The reproduced `v40_intercept_supported_terminal_posture` is the best
  current result: two independent samples capture at `19.684490 T`, score
  `-0.261384287`, and have mean/final distance `2.151092787 L`/`0.748302400 L`.
  It retains the common `4 L` crossing at `15.444014 T`. Its small
  closure- and center-intercept-supported handoff toward the existing damped
  two-joint bend therefore remains the terminal baseline.
- The assigned parent's added response-opposed posture share is active but
  negative. Relative to `v40`, it delays the `1 L` crossing from `19.162004 T`
  to `19.189503 T` and capture by `0.038498 T`; it worsens score by about
  `4.72e-4`, mean distance by `4.81e-4 L`, and final distance by
  `3.39e-4 L`. Although below-`4 L` high-command counts fall from `229/302`
  to `225/299` and anterior rate-cap contact falls by one sample, the terminal
  lateral-force maximum rises from about `0.02753` to `0.02772`. More posture
  authority during outward joint motion therefore trades away useful carrier
  response rather than improving capture.
- The other completed terminal allocations do not supply a positive
  replacement. Clipping-direction coordination captures at `19.728489 T`
  with score `-0.261932556` and mean/final distance
  `2.151649804 L`/`0.748698652 L`; the signed course-worsening selector is
  exactly identical to `v40`, including all crossings, saturation counts,
  loads, and score, so its proposed branch is dormant on the realized path.
- I inspected the complete combined sheets for the reproduced best `v40`
  rollout and the informative lower-quality command-coordination rollout,
  including every top-down mid-plane-vorticity and oblique body/Lambda2
  keyframe from release through capture. Both fish visibly self-propel from
  quiescent water along the same compact target-directed arc. Both form a
  coherent alternating posterior wake in the top-down row and finite,
  localized three-dimensional structures in the oblique row. Neither shows
  passive advection, a loop, collision, boundary-exit precursor, wake collapse,
  out-of-plane motion, or numerical instability. There is no failed
  termination in this sample; the one-step-slower coordination result is the
  most informative lower-quality control contrast. The visual similarity and
  common `4 L` crossing localize the useful distinction to terminal allocation,
  not outer propulsion or wake family.
- Inherited optimizer notes show why this locus was tested: `v40` improved its
  `v39` parent by `0.099018 T` and reduced terminal high-command incidence
  without changing the outer crossing, whereas two unsupported-intercept
  carrier rescues changed too few same-state commands to alter capture. The
  new completed evidence now rejects strengthening the supported posture from
  measured outward error rate, not the supported handoff itself.

## Policy hypothesis

Start from the twice reproduced `v40_intercept_supported_terminal_posture`,
preserving its state-feedback oscillator, target guidance, signed
geometry/course outer allocator, center-intercept corridor, mean-bend target,
closure preview, carrier floor, and command limit. Reuse the assigned parent's
normalized outward posture-error rate, but reverse its actuator-allocation
meaning: while a closing center intercept supports the handoff and either
joint is moving away from the damped bend, retain at most four percentage
points more of the established carrier by reducing the `12%` intercept posture
share toward `8%`. Motion already converging toward the posture retains the
full evaluated `v40` share. Large-angle redirect still combines by `max`, so
the mechanism cannot weaken stronger geometry-owned steering.

This is a response-conditioned rhythm-to-posture handoff, not scalar-only gain
tuning. It tests the causal inverse of the completed regression: a rhythmic
actuator should not receive extra posture allocation precisely while its
observed motion makes that controller fight the carrier. The mechanism is
zero outside the actual terminal band, without positive closure and supported
center intercept, at zero outward error rate, and wherever large-angle redirect
already owns more allocation. Expect the outer path and two-view wake to remain
unchanged while capture recovers or advances relative to `v40`. Falsify the
candidate if it is dormant or effectively constant, changes any state at or
beyond `4 L`, acts without closure/intercept support, weakens an active
large-angle redirect, delays or loses capture, worsens distance integral or
final distance, materially restores terminal saturation/load peaks, creates
joint-stop dwell or instability, or degrades either wake view. The new CFD
evaluation occurs only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop CPG robotic-fish direction control and continuous biological redirect-to-cruise or approach-hold transitions
source_mechanism: use measured oscillator response to allocate continuously between rhythmic propulsion and a bounded low-frequency posture
transferable_invariant: when rhythm and posture share actuators, observed joint response should govern the handoff; preserve bounded rhythmic allocation where the posture controller would oppose outward carrier motion, while allowing the established posture share when response already converges
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: within the existing normalized proximity-, closure-, and body-frame center-intercept-supported branch, project joint velocity against error to the unchanged two-joint bend, then smoothly retain a small carrier share only for outward motion without changing mean curvature, total authority, or the outer law
falsification: reject on dormancy or constant activation, action outside the supported terminal regime, weakening of stronger geometry redirect, slower or lost capture, worse distance integral, renewed saturation or load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Loading evaluated `v40`, the evaluated response-opposed parent, and the
  candidate in separate Julia modules and replaying reconstructed body-frame
  states from all four current trajectories changes `144--153` states relative
  to `v40`. Every changed state lies between about `1.60 L` and `3.63 L`, has
  positive closure and nonzero center-intercept support, and the maximum
  equal-state two-joint command difference is about `1.305 rad/T^2`. On the
  reproduced `v40` trace the outward-response support spans approximately
  `0.00006--0.99998` with mean `0.622`, so the retained carrier fraction varies
  smoothly from essentially zero to the declared four-point cap rather than
  acting like a constant gain.
- A deterministic `212625`-state grid spanning distance, target angle, center
  course, speed, closure, both joint positions, and both joint rates finds
  `2227` active differences from evaluated `v40`, with maximum difference
  about `1.443 rad/T^2`. All outputs are finite and within the declared command
  limit. No state at or beyond `4 L`, without positive closure, with an
  unsupported center intercept, or with both joint rates zero changes. These
  checks establish boundedness, activity, and gate selectivity only; they do
  not establish coupled-flow improvement or preservation of the realized wake.
- The lightweight two-output Julia contract passes. The deterministic schema
  audit resolves all `90` direct `params.FIELD` references in the `91`-field
  object returned by `target_policy_params()`; only the version label is
  intentionally unused. The prescribed `check-runner` was invoked after the
  material edits, but its pinned `gpt-5.4-mini` model is unsupported on this
  ChatGPT account and failed before executing a command. Its three configured
  non-CFD checks were therefore run directly and separately; the inherited
  duplicate assigned-parent marker in the rendered root `README.md` was
  repaired by removing only the duplicate marker, and the material-guidance,
  exact Julia policy-contract, and solver-boundary checks pass. No formal CFD
  was run in this workspace.
