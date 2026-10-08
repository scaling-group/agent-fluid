# Response-gated phase-even posterior turn-shape candidate

## Completed evidence and visual diagnosis before editing

- All four sampled episodes are finite `capture` rollouts initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  Three byte-identical evaluations of the assigned v46
  phase-even posterior turn-shape policy reproduce capture at `17.64401 T`,
  score `-0.07419`, and total/observed distance integrals
  `1.95985/1.34371 L`.  The axial-confident posterior approach-wave comparator
  captures later at `17.74850 T`, scores `-0.07899`, and worsens the integrals
  to `1.96493/1.34985 L`.
- The phase-even policy leads the approach-wave comparator by
  `0.0075/0.0503/0.0472/0.0429/0.0510/0.0472 L` at the `2/4/6/8/10/12 T`
  checkpoints, then trails by only `0.0071/0.0106 L` at `14/16 T` before its
  earlier capture.  This is evidence that posterior authority is useful as
  route steering, not that the already coherent gait needs another approach
  propulsion residual.
- I inspected both combined release-to-capture sheets, including the top-down
  mid-plane vorticity rows and the oblique body/Lambda2 rows.  Both controllers
  actively self-propel on the same smooth target-signed arc.  Compact release
  vorticity develops into an organized alternating posterior street, with
  compact paired caudal structures visible obliquely through capture.  There
  is no passive advection, reversal, collision, domain exit, or wake collapse,
  and the slower approach-wave policy introduces no beneficial wake topology.
- The metric cross-check agrees with the visual diagnosis.  The phase-even and
  approach-wave policies have maximum speeds `0.96625/0.96031 L/T`, any-joint
  acceleration-limit residence `43.83/44.19%`, and the same peak normalized
  planar force/moment scale `0.03225/0.01609`.  The stronger route therefore
  does not justify more carrier amplitude, cadence, or terminal thrust.
- Frozen-trace reconstruction of the completed v46 controller locates a
  response opportunity without treating it as closed-loop evidence.  A smooth
  sign-coherence test between the bounded ordinary turn request and de-gaited
  observed yaw would release only about `1-2%` of the posterior residual on
  average through `8 T`, when the yaw response usually opposes the requested
  turn, but about `20-23%` after `12 T`, where correct-sign yaw episodes become
  common and the small checkpoint regression begins.  On the completed trace,
  the proposed gate changes the projected posterior action in only
  `3.6/2.6/3.6%` of samples over `0-4/4-8/8-12 T`, versus
  `10.4/7.1/14.4%` over `12-14/14-16/16-18 T`; these are localization checks,
  not predicted CFD gains.

## One-candidate policy hypothesis

Preserve the completed v46 state-feedback carrier, target sensing, selective
crossflow pose confidence, geometric redirect, launch governor, cadence,
half-cycle steering, carrier-first spillover, and componentwise actuator
projection.  Change only the phase-even posterior turn-shape residual: infer a
smooth requested-turn direction from the normalized body-frame turn request,
compare it with the already de-gaited observed yaw rate, and attenuate the
extra posterior residual as that response acquires the requested sign.  The
base route steering remains active, so the gate removes only redundant extra
wave-shape curvature rather than coasting or suppressing recovery.

The next CFD evaluation should retain v46's early and middle closure, coherent
alternating two-view wake, and capture while reducing the `14-16 T` regression
or posterior limit residence.  Falsify the candidate if capture or either
distance integral regresses, the `2-12 T` checkpoint lead is lost, correct-sign
yaw is released before useful curvature forms, target-signed motion or wake
coherence degrades, or speed, saturation, force, or moment materially exceeds
the completed v46 envelope.  Formal CFD runs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biologically inspired burst redirects and sensor-modulated robotic-fish CPG steering
source_mechanism: preserve the propulsive rhythm while releasing extra curvature when an observed heading response appears
transferable_invariant: supplementary wave-shape steering should remain active while de-gaited yaw opposes the body-frame request and yield smoothly once yaw responds with the requested sign
nontransferable_details: published gains, dimensional cadence or amplitude, species and robot kinematics, clocked oscillator phase, exact vortex phase, and task-specific routes
policy_translation: multiply only the phase-even posterior target-angle residual by one minus a bounded sign-coherence product of normalized body-frame turn request and de-gaited yaw rate; preserve the carrier, base two-joint steering, redirect, and actuator projections
falsification: reject if early or middle closure, capture, distance integrals, target-signed curvature, or the organized two-view wake regresses, or if posterior saturation and normalized speed/load envelopes do not improve or remain bounded
```

## Evidence boundary

Outcome and visual claims above come from the assigned parent guidance,
sampled completed solver results, and inherited optimizer notes.  The response
gate is a single unevaluated state-feedback hypothesis; no same-worker CFD
result is claimed.

## No-CFD implementation audit

- The sole candidate is
  `dogfish_target_control_v47_response_gated_posterior_turn_shape`.  Its only
  behavioral difference from the completed v46 policy is the observed-yaw
  response gate on the supplementary posterior turn-shape acceleration.
- All `67` distinct direct `params.FIELD` references resolve among the `69`
  fields returned by `target_policy_params()`.  A targeted Julia comparison
  confirms that opposing-yaw behavior is byte-identical to v46, while a
  correct-sign yaw state changes only the posterior action; the response gate
  is reflection-even and tested outputs remain finite within the componentwise
  acceleration bound.
- The material-guidance check, lightweight Julia policy contract, and solver
  editable-boundary check pass locally.  The configured check-runner was
  invoked, but its pinned `gpt-5.4-mini` model is unavailable for this ChatGPT
  account, so it could not start.  No formal CFD was run.
