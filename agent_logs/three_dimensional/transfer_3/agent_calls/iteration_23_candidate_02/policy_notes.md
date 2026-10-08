# Reproduction of direction-conditioned outer limiter coupling

## Evidence and visual diagnosis before the policy edit

- The assigned parent is the prefilled `v34` distortion-gated limiter. It
  captures from `12.327720 L` at `23.369514 T`, with score `-0.4035179823`,
  mean distance `2.300524064 L`, and final distance `0.748664737 L`. Its
  clip-angle gate multiplies the whole `12%` common-scale contribution, so it
  removes the reproduced coupling floor whenever component clipping causes
  little direction rotation. Its result is correspondingly close to the `v33`
  partial-coupling baseline: capture at `23.435516 T`, score
  `-0.4079736071`, and mean distance `2.305032573 L`.
- The other sampled outer-actuator mechanisms provide a controlled comparison
  because all retain the same target guidance and below-`4 L` terminal law.
  The rate-headroom guard improves capture to `22.891006 T`, score to
  `-0.3709551729`, and mean distance to `2.267155038 L`. The
  direction-conditioned limiter instead retains the `12%` common-scale floor
  and adds at most six percentage points only under clip-angle distortion; it
  is the strongest finite sample, capturing at `21.912008 T`, score
  `-0.3246592933`, mean distance `2.218947189 L`, and final distance
  `0.747680604 L`. This is a semantic arrival and distance-integral
  improvement, not only a smaller terminal endpoint.
- I inspected every combined keyframe sheet from release through capture,
  including the top-down mid-plane vorticity row and the oblique body/Lambda2
  row. All four rollouts verify direct uniform still-water initialization and
  show self-propelled motion along a compact target-directed arc, a coherent
  alternating posterior wake, finite localized three-dimensional structures,
  and a quiet held-bend final glide. The direction-conditioned sample is
  visibly farther along the same useful topology by `12 T` and `20 T`; its
  metrics give distances `6.95664 L` and `1.87431 L`, versus `7.16965 L` and
  `2.78077 L` for the assigned parent. No sampled episode has a failed
  termination, so the assigned slower capture is the informative regression;
  no collision, loop, boundary exit, wake collapse, passive advection, or
  out-of-plane instability is claimed from these sheets.
- Telemetry bounds the tradeoff. The direction-conditioned sample has no
  acceleration-cap command inside `4 L` and lowers below-`4 L` peak
  force/moment norms to about `0.01271/0.00713`, from the `v33` baseline's
  `0.01623/0.00833`. Its global force/moment maxima rise modestly to
  `0.02988/0.01558`, from `0.02858/0.01520`, and posterior acceleration/rate
  cap incidence increases. Thus lower cap incidence is not a sufficient goal;
  retained coordinated direction and faster progress matter, while further
  authority or limiter stacking is not yet justified.

## Policy hypothesis

Promote the sampled `v34` direction-conditioned policy unchanged as this
workspace's single candidate. Preserve the state-feedback oscillator,
posterior lag, target-angle redirect, closure preview, shared terminal mean
bend, crossflow/settled-response support, center-intercept corridor, and paired
terminal release. Outside `4 L`, preserve the reproduced `12%` blend toward a
common scale and add its bounded six-percentage-point increment only when
component clipping rotates the normalized two-joint command. Inside `4 L`,
the limiter remains exactly dormant.

This is independent reproduction of one actuator-coordination mechanism, not
scalar-only gain tuning and not a new same-regime stack. Its evaluated sample
supports the mechanism, but the new candidate's own CFD result occurs only
after this worker exits. Falsify the promotion if it does not reproduce the
earlier capture and distance-integral improvement, if terminal commands differ,
or if the compact path, coherent two-view wake, joint-stop behavior, loads, or
stability regress. Do not add the sampled rate-headroom guard until the
direction-conditioned result is independently reproduced.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body swimming together with sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve coordinated anterior-to-posterior traveling-bend structure while enforcing a bounded actuator envelope
transferable_invariant: common bounded scaling preserves an overloaded coordinated two-joint command direction, and added preservation is most useful when independent component clipping measurably rotates that direction
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, full-body waveforms, exact phase lags, vortex phases, capture geometry, and task-specific routes
policy_translation: retain normalized body-frame targeting and the reproduced base outer coupling, then use the sine of the joint-space clipping angle to gate only one bounded extra common-scale contribution outside the normalized terminal band
falsification: reject on failed reproduction, terminal-command interference, delayed or lost capture, worse distance integral, changed trajectory, joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- The candidate is byte-identical to the evaluated direction-conditioned
  sample, with SHA-256
  `2c717baeab46ef4e3b148517b6fca1d8adf4b3ac3c681d11bde166550c082d45`.
  This establishes exact promotion, not a new CFD result.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account and failed before executing a command.
  Its three declared checks were then run directly and separately. The
  material guidance/notes check, finite two-acceleration Julia contract, and
  solver edit-boundary check all pass. The guidance check initially exposed
  an inherited duplicate copied-parent marker in the rendered `README.md`;
  removing only that duplicate made the check resolve the assigned parent and
  pass.
- A deterministic schema audit resolves all 81 direct `params.FIELD`
  references in the candidate to the 82 fields returned by
  `target_policy_params()`; only the version label is intentionally unused by
  the controller algebra. No formal CFD was run in this workspace.
