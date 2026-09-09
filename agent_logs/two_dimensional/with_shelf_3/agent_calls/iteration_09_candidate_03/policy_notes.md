# Multi-wake policy candidate notes

## Evidence diagnosis before edit

- All four sampled solver records terminate with `target_reached` at release
  time `32.472`, mean/final/minimum distance `1.64761/0.747485/0.747485 L`, and
  score `0.224538`. Their released and prewarm keyframe sheets are byte-identical;
  the policies differ only cosmetically. This is evidence of deterministic replay
  from the fixed snapshot, not robustness to wake phase.
- The released sheet shows self-propelled, target-directed motion: the fish
  preserves a traveling bend, turns down and left from the upper-right release,
  enters the interacting second-row wake, and reaches the target along a compact
  diagonal route. The corresponding `-10.912/-4.332 L` head displacement,
  `0.939835` progress, and `0.334/-0.140` mean world velocity agree with the
  visual diagnosis; the motion is not passive downstream advection.
- The route succeeds through substantial wake disturbance (`0.245` RMS relative
  crossflow, `68.70` RMS lateral force, `931.60` RMS moment), so there is no
  evidence for indiscriminate crossflow cancellation. No sampled failure
  keyframe is available; inherited guidance supplies only aggregate failure
  evidence and warns that unrestricted bearing-trend feedback destroyed the
  traveling bend.
- Both joints touch the `260 deg/time` velocity and `1800 deg/time^2`
  acceleration ceilings. The posterior half-cycle controller is faster than its
  allocation-only parent according to sampled optimizer guidance, but raises
  force/moment RMS by `21.4%/17.4%`. Peak-only diagnostics do not establish
  saturation residence or isolate the load source.

## Candidate hypothesis

Preserve the complete successful route scaffold: filtered body-frame bearing,
bounded `12 deg` total curvature, bearing-conditioned posterior allocation,
state-feedback oscillator, and lagged posterior wave. Add one mechanism only:
a smooth posterior phase-space headroom gate on the incremental `8%` helpful
half-cycle residual. The gate compares posterior angle and velocity relative to
the controller's own nominal gait scales, so it yields the extra residual when
the posterior state exceeds its gait envelope without attenuating the base wave
or moving either oscillator center. A later CFD rollout should retain target
capture and the compact diagonal route while reducing saturation residence or
force/moment load; reject the mechanism if capture/arrival worsens without a
measured load benefit.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and residual control over rhythmic locomotion
source_mechanism: preserve a stable low-dimensional rhythm while sensor feedback modulates only a bounded residual command
transferable_invariant: extra steering authority should be state-gated by remaining gait-envelope headroom so the base traveling wave survives constraint contact
nontransferable_details: published robot morphology, oscillator network, learned policy, dimensional gains, duty ratios, and source-task routes
policy_translation: multiply only the target-helping posterior half-cycle increment by a smooth gate built from normalized posterior angle and velocity in the two-joint body-frame contract
falsification: reject if target capture or the compact diagonal trajectory is lost, arrival slows without lower load or saturation residence, or the base traveling bend is visibly weakened

## Non-CFD validation

- The guidance provenance checker passes after removing a duplicated rendering
  of the same assigned-parent marker from the workspace `README.md`.
- The public policy-contract check passes with the available Julia runtime: the
  parameter object has no environment `L`, the policy accepts the full passive
  observation contract, and returns two finite accelerations.
- Representative joint-state checks confirm that target alignment exactly
  recovers the incumbent action and that, away from alignment, the new action
  lies between the ungated half-cycle command and a zero-residual command; the
  gate therefore cannot amplify or suppress the base gait by construction.
- The solver boundary check passes with only
  `candidate_target_policy.jl` changed inside `solver/`.
- Formal CFD is intentionally deferred to EvE after worker exit; no same-worker
  performance or load improvement is claimed.
