# Moment-conditioned opposing-lobe wave relief

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase 2 contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and capture. I inspected the best/prefilled
  moment-residual sheet and the weakest load-consensus sheet from release to
  capture. In both top-down vorticity rows, the release transient grows into a
  coherent alternating caudal wake behind a smooth target-directed arc; with
  zero background flow, the motion is self-propulsion rather than advection.
  Both oblique body/Lambda2 rows retain compact alternating three-dimensional
  wake structures without collapse, collision, virtual-boundary exit, or
  out-of-plane instability. The sheets are visually indistinguishable at this
  resolution, so trajectory and actuator histories—not vortex prominence—are
  the discriminating evidence. No failed termination is allocated; the weaker
  finite captures and inherited regressions are the informative controls.
- The prefilled policy and independently sourced moment-only policy are
  byte-identical in trajectory and combined wake evidence despite different
  source hashes. Both capture at `15.735508T`, final/minimum distance
  `0.744372L`, distance integral `1.919818L`, all the same
  `8/6/4/2/1.25L` milestones, and score `-0.037222`. The prefill's exact
  translational terminal damper is therefore inactive at trajectory scale and
  another terminal threshold or line-of-sight rewrite is not useful diversity.
- The two distinct sampled changes both regress the winning route. Requiring a
  nonlinear odd-harmonic carrier observer to veto moment steering delays every
  milestone, moves capture to `15.741009T`, raises distance integral to
  `1.920970L`, increases mean posterior demand from `25.012` to
  `25.254 rad/T^2`, and raises peak lateral force from `0.03380` to
  `0.03465`, even though final distance improves slightly to `0.744246L`.
  Adding a corroborating lateral-load mean-curvature increment likewise delays
  every milestone, capturing at `15.746509T` with integral `1.921600L` and
  score `-0.039050`. Better carrier-fit variance and independent load
  agreement therefore do not justify suppressing the proven response or
  stacking another mean bend.
- The inherited moment-to-yaw response handoff supplies a third negative
  control: attenuating the moment branch when demodulated yaw became
  target-aiding erased its route gain, delaying capture to `15.768509T` and
  worsening the integral to `1.924377L`. Pointwise target-aiding yaw does not
  prove that the anticipatory moment correction is redundant. Conversely, the
  established one-sided steering relief is positive evidence that attenuating
  only the posterior wave lobe opposing a requested turn can retain a coherent
  traveling wake while freeing feasible response. The current moment gate has
  substantial non-clamp-equivalent route support (603 samples in the inherited
  trace analysis), making it a distinct response signal for one wave-allocation
  test without adding curvature authority.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish half-cycle turning and sensor-modulated CPG wake-disturbance rejection
source_mechanism: preserve a traveling bend while measured adverse yaw load selectively weakens the posterior half-cycle that opposes the requested turn
transferable_invariant: retain the anterior rhythm, posterior lag, target-directed mean curvature, and proven moment correction; use normalized body-frame response only to attenuate an opposing posterior wave lobe, never to amplify a lobe or add mean bend
nontransferable_details: published gains, dimensional frequencies and loads, species-specific envelopes, exact Strouhal values, exact tail or vortex phase, source wake geometry, clock-defined maneuver stages, and task-specific routes
policy_translation: preserve the prefilled policy and map its existing bounded moment-residual curvature into an equivalent dimensionless addition to the established steering-turn input used only by one-sided posterior wave relief; direction remains the raw body-frame target redirect and the total relief input remains bounded
falsification: reject if capture or any established milestone regresses, distance integral worsens, the coherent alternating two-view wake degrades, posterior limiting or force/moment loads rise without route benefit, or replay shows no feasible posterior action support beyond clamp-equivalent commands
```

## One candidate hypothesis

Produce exactly one candidate by keeping the prefilled anterior oscillator,
posterior lag, axial-response propulsion allocation, target/course redirect,
carrier-demodulated yaw and moment mean corrections, approach/terminal roles,
mean-first posterior allocation, and exact speed-limit projection unchanged.
Change only the phase-conditioned wave-relief input. Express the already
bounded moment-residual curvature as a fraction of the established cruise
curvature scale, add that signed fraction to the existing steering-turn signal,
and clamp the result to the original normalized turn envelope before evaluating
posterior wave relief. Use the same construction for the raw guard path.

This is a small compatible combination of an evaluated hydrodynamic response
and an evaluated one-sided wave-shaping mechanism, not scalar-only gain tuning:
mean steering authority is unchanged, the anterior joint is unchanged, and no
posterior lobe can be amplified. The falsifiable expectation is that relieving
the wave specifically while adverse non-carrier moment requests the proven
mean correction will advance a route milestone or lower distance integral
without losing capture, wake coherence, or the force/limit envelope. Formal
CFD occurs only after this worker exits, so no outcome for this candidate is
claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `950058bc853315521c397cdfcecdeb1067cf1cdc376297e5796d32398851dc3b`.
  Its source diff from the prefill changes only the normalized wave-relief
  input after the already evaluated mean target and moment corrections; no
  parameter value, terminal role, propulsion endpoint, or anterior action law
  changes. Static schema validation resolves all 56 direct `params.FIELD`
  references against exactly the same 56 fields returned by
  `target_policy_params()`, with no missing or unused field.
- The prescribed lightweight Julia contract returns two finite bounded
  accelerations. A deterministic 20,000-pair sweep spanning mirrored target
  geometry, body-frame velocity and load, bearing/yaw response, and joint
  phase returns finite actions inside the declared acceleration limit with
  zero lateral-reflection error.
- Counterfactual replay on all 2,861 sampled-best states changes 412 posterior
  commands and no anterior commands relative to the prefill. Changed support
  spans `0.0220-15.6310T` and `12.3275-0.8855L`; mean and maximum posterior
  command differences are `0.0558` and `1.5312 rad/T^2`. Candidate and
  baseline each have 675 replayed posterior acceleration-limit samples. This
  establishes feasible, non-clamp-equivalent response support without
  predicting the unevaluated closed-loop hydrodynamic outcome.
- Guidance materiality, the finite policy contract, deterministic parameter
  ownership, and solver editable-boundary checks pass. The first materiality
  run exposed two identical assigned-parent markers in the rendered workspace
  `README.md`; removing only the duplicate repaired that inherited metadata
  defect without changing the parent. The configured check-runner was invoked,
  but its pinned `gpt-5.4-mini` model is unavailable for this account; its three
  prescribed commands were therefore rerun directly and separately, and all
  pass. No CFD was run.
