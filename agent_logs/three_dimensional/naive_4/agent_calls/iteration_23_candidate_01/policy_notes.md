# Carrier-residual slip-response candidate

## Evidence diagnosis before the edit

- All four sampled evaluations satisfy the frozen experiment contract: direct
  uniform `U_infinity=[0,0,0]` initialization, no prewarm or cylinders, finite
  dynamics, capture at `16.054375T` after 2,919 steps, and 239 moving-window
  shifts. The motion is self-propelled rather than background advection.
- I inspected both rows of the combined keyframe sheets for the three-way
  replicated best result and the distinct, slightly weaker yaw-damper result.
  The top-down views show the same smooth target-directed arc and coherent
  alternating vorticity street from release through capture. The oblique views
  show compact alternating caudal Lambda2 structures without wake breakup,
  collision, domain exit, or out-of-plane instability. The carrier, base
  redirect, posterior traveling wave, and steering sign therefore remain
  evidence-backed and should not be replaced.
- The current sample closes the assigned-parent combination hypothesis. Three
  comment-distinct policy hashes have identical executable control and produce
  byte-identical wake sheets, `0.745943L` final/minimum distance,
  `1.929921L` distance integral, and score `-0.047001`. The combination is a
  replicated trace-scale improvement over the inherited yaw damper
  (`0.746051L`, `1.930012L`, `-0.047113`) and redirect handoff
  (`0.746070L`, `1.930028L`, `-0.047133`), but all arrive on the same step.
  This supports retaining the combination while rejecting another terminal
  threshold or scalar-gain edit as useful controller diversity.
- The remaining terminal error is translational as well as angular. In the
  best trace, body-frame bearing turns around near `0.864L` and reopens to
  `0.183 rad`; at capture the target-signed heading rate is `2.092 rad/T`, but
  lateral velocity is still `-0.390U`, opposite the positive target turn, and
  the predicted miss remains `0.368L`. A reflection-odd least-squares carrier
  model fitted outside the `1.75L` approach region,
  `v_lateral/U = -0.282(q1/A) - 0.667(qdot1/(omega A))`, explains `92.2%` of
  far-field lateral-velocity energy with `0.103U` RMS residual. At capture it
  predicts `+0.362U`, exposing a measured `-0.752U` residual. Thus raw slip is
  beat-contaminated, while carrier-residual slip supplies a meaningfully
  different response observable that the current yaw-only terminal brake does
  not use.

## One candidate mechanism

Preserve the evaluated carrier and all inherited terminal handoff/yaw-damping
roles. Add one bounded posterior mean-curvature response during the existing
closing approach: subtract the far-field joint-phase prediction from measured
body-frame lateral velocity, then add target-directed curvature only when this
residual translation opposes the current raw redirect direction. Smooth
approach, course-reliability, and opposition gates make the addition vanish in
the proven far-field route, under unreliable/reverse translation, when slip is
carrier-explained, or once the residual lateral response becomes target-aiding.
The correction is capped below the existing supplemental yaw curvature and
does not alter the oscillator, posterior wave, phase relief, acceleration
allocator, terminal handoff, or active yaw damper.

Expected evidence is retained capture and two-view wake coherence with an
earlier late-approach milestone, a smaller distance integral, or an earlier
capture step than the replicated `-0.047001` parent. Falsify the mechanism if
it changes the pre-approach route, delays or loses capture, increases posterior
excursion/limiting or loads materially, destroys the coherent wake, or merely
adds curvature without improving trajectory geometry.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal capture control
source_mechanism: preserve rhythmic propulsion while sensory feedback separates carrier-scale lateral motion from persistent slip and applies a bounded response correction
transferable_invariant: do not cancel periodic lateral motion wholesale; remove the joint-phase carrier prediction and correct only target-opposing residual slip until measured translation responds
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics and envelopes, exact vortex phases, morphology-specific loads, and source-task routes
policy_translation: use normalized anterior joint phase to predict body-frame lateral carrier velocity, subtract it from measured lateral velocity, and add bounded reflection-odd posterior mean curvature only under closing approach, reliable course, and target-opposing residual-slip gates in the two-joint contract
falsification: reject if the correction alters the proven far-field route or wake, fails to release with target-aiding slip, delays or loses capture, or worsens distance, actuator, or load evidence

## Non-CFD verification after the edit

- Candidate SHA-256:
  `1cff496ffba58125b5716fd56dfe03b8f4df778c41a2476ada60639048d108e2`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account. Its three prescribed commands were
  run directly and separately: the material guidance/notes check, lightweight
  Julia policy-contract check, and editable-boundary check all pass. The
  rendered `README.md` contained the assigned-parent marker twice; only the
  exact duplicate was removed so the prescribed guidance checker could resolve
  the parent.
- The deterministic schema guard finds all 51 direct `params.FIELD`
  references in the 51-field object returned by `target_policy_params()`.
  A deterministic 20,000-state sweep spanning joint phase, body-frame target
  geometry, course, bearing rate, and yaw response returns finite commands
  within `31.416 rad/T^2`, exact lateral-reflection equivariance, a finite
  non-finite-observation fallback, and no outward command at the exact
  posterior speed boundary.
- Counterfactual replay on the replicated parent states changes only the
  posterior command, over 87 samples from `1.675L` through capture; the maximum
  difference is `5.618 rad/T^2`. It leaves all earlier sampled actions exact,
  changes mean absolute posterior command only from `24.638` to
  `24.647 rad/T^2`, and reduces rather than increases exact acceleration-limit
  samples from 646 to 644. These checks establish mechanism support and
  boundedness only; formal CFD remains unevaluated for the next worker.
