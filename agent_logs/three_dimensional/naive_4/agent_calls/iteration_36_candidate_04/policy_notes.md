# Translational-response persistence for moment-residual steering

## Evidence diagnosis before the policy edit

- All four allocated rollouts satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture. No failed-termination
  sheet is present, so the weaker captures and inherited logged regressions
  are the informative negative controls.
- I inspected the combined sheets for the best finite moment-only policy
  (`solver_2acfcfa19ef8`) and the weakest finite load-consensus policy
  (`solver_006ebd822d4e`) from release through capture. In both top-down rows,
  the release transient grows into a coherent alternating caudal wake behind
  a smooth target-directed arc; zero background flow makes the translation
  self-propulsion rather than advection. Both oblique body/Lambda2 rows retain
  compact alternating three-dimensional structures without wake collapse,
  collision, domain exit, or out-of-plane instability. Their topology is
  effectively indistinguishable at sheet resolution, so route and actuator
  evidence, not vortex prominence, must decide the controller mechanism.
- The moment-only policy and the sampled translational-terminal variant have
  different source hashes but identical traces and sheets: capture at
  `15.735508T`, final/minimum distance `0.744372L`, distance integral
  `1.919818L`, 2,861 steps, 231 moving-window shifts, and score `-0.037222`.
  Carrier-demodulated moment steering is therefore the supported route-scale
  mechanism, while another near-capture line-of-sight threshold is not useful
  trajectory diversity on this rollout.
- The assigned parent's odd-cubic carrier veto is a completed negative
  result. Relative to moment-only it delays capture to `15.741009T`, worsens
  distance integral to `1.920970L` and score to `-0.038337`, despite moving
  the crossing slightly inward to `0.744246L`. Its inherited replay changed
  249 posterior commands and introduced eight additional acceleration-ceiling
  outputs even though the refined gate could only suppress mean-curvature
  duty. Thus higher fitted carrier variance did not identify disposable
  steering response; restore the evaluated linear observer rather than tune
  another harmonic veto.
- The load-consensus extension is independently negative: it delays capture
  further to `15.746509T`, raises distance integral to `1.921600L`, moves the
  crossing outward to `0.744715L`, and scores `-0.039050`. This rejects another
  stacked load-conditioned curvature increment. The current candidate must
  retain the existing `2 deg` supplemental curvature ceiling and change its
  response allocation rather than add a second bend.
- Reconstruction of the winning trace exposes a distinct response signal. In
  the route regime above `2L`, the moment branch has nontrivial duty on 712
  samples; normalized target-line rotation caused by center translation
  opposes the requested redirect on 709 of them. Across all 1,932 reliable
  route samples with nontrivial raw redirect duty, this adverse translational
  response occurs on 1,929, with median magnitude `0.00258` and 90th
  percentile `0.00960` after carrier-frequency normalization. This is a
  retrospective association, not causal evidence, but it identifies a
  measured route-response backstop that is distinct from the failed nonlinear
  carrier classifier and lateral-load authority increment.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG wake-disturbance rejection
source_mechanism: preserve rhythmic propulsion while bounded steering authority persists only until measured target-relative response realigns
transferable_invariant: retain the traveling-bend carrier and slow body-frame target turn while an anticipatory hydrodynamic-moment residual and direct target-line slip share one bounded correction envelope, which releases continuously when neither reports adverse response
nontransferable_details: published gains, dimensional rates and moments, species-specific burst kinematics, exact tail or vortex phase, clock-defined maneuver stages, source wake geometry, world coordinates, and task-specific routes
policy_translation: restore the evaluated linear carrier-moment observer, compute carrier-frequency-normalized translational line-of-sight rate from body-frame target displacement and velocity, and smoothly union only its target-redirect-opposing component with the moment opposition gate under the existing reliable far/middle-route envelope and unchanged 2 degree curvature ceiling
falsification: reject if capture or any established route milestone regresses, distance integral worsens, the coherent two-view wake or force envelope degrades, posterior limiting grows without target-progress benefit, or the slip backstop changes no feasible posterior action

## One candidate hypothesis

Produce exactly one candidate by preserving the sampled moment-only policy's
anterior oscillator, posterior traveling wave, axial-force response allocator,
target/course steering, redirect, approach and terminal roles, mean-first
allocation, and exact actuator projection. Remove the assigned parent's
unevaluated-by-design nonlinear classifier now that its CFD result is negative.
Within the restored moment branch, add one kinematic response backstop: the
body-frame cross product of target displacement and center velocity gives the
line-of-sight rate caused by translation alone. When this rate opposes the
reliable requested redirect, smoothly union it with the moment-opposition gate;
when both moment and slip responses clear, the extra curvature releases.

The two response gates select duty inside the same `2 deg` correction ceiling,
so they cannot stack curvature or alter its sign. The base redirect, yaw
response, propulsion, approach, and terminal controls remain intact. The
falsifiable expectation is that response persistence advances a middle-route
milestone or lowers distance integral while retaining capture and wake
coherence. Lower load or command effort without route benefit is not success.
Formal CFD remains post-exit evidence, so no outcome for this candidate is
claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `02a9d0494978e9d45f016dd675f380b83b9f3505c081ca182cba2337a9e4d77c`.
  Static schema validation resolves exactly 57 direct `params.FIELD`
  references against the same 57 fields returned by
  `target_policy_params()`, with no missing or unused parameter. The added
  response scale is owned by that parameter object.
- The prescribed lightweight Julia contract returns two finite accelerations,
  and the solver editable-boundary check passes. A deterministic 5,000-pair
  sweep across mirrored body-frame target geometry, translation, loads, joint
  state, bearing, and yaw response returns finite actions within the declared
  acceleration bound with zero lateral-reflection error. Non-finite target,
  velocity, force, moment, bearing, and yaw observations also select finite
  fallbacks.
- Counterfactual evaluation on reconstructed states from the sampled
  moment-only trace changes 823 posterior commands and no anterior commands,
  over `0.2255-15.6915T`. Mean and maximum changed-command magnitudes are
  `0.3636` and `3.8337 rad/T^2`, and no new exact acceleration-limit hit
  appears. This establishes broad feasible, non-clamp-equivalent response
  support, but does not predict its unevaluated closed-loop effect.
- The guidance-materiality check initially found two identical assigned-parent
  markers in the rendered workspace `README.md`; removing only the duplicate
  repaired that inherited metadata defect, after which guidance materiality,
  the Julia contract, and solver boundary checks pass. The configured checker
  was invoked, but its pinned `gpt-5.4-mini` model is unsupported for this
  account, matching the inherited infrastructure limitation. Its prescribed
  checks were therefore run directly and separately. No CFD was run.
