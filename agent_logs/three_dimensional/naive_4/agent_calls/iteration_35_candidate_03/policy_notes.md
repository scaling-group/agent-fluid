# Moment-responsive posterior duty relief candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture. No failed-termination
  sheet is allocated, so the lower-value captures and mechanism regressions
  are the informative failures rather than claimed collisions or instability.
- I inspected the combined sheets for the assigned-parent/best moment policy
  (`solver_2acfcfa19ef8`), the load-consensus regression
  (`solver_006ebd822d4e`), and the weaker no-moment control
  (`solver_0d0db1d9cf71`) from release through termination. The top-down
  rows show a release transient growing into a coherent alternating caudal
  wake behind a smooth target-directed arc. With zero background flow, the
  translation is self-propulsion rather than advection. The oblique
  body/Lambda2 rows show compact three-dimensional caudal structures without
  visible wake collapse or out-of-plane instability. Their wake topology is
  effectively indistinguishable at sheet resolution, so trajectory and load
  diagnostics—not vortex prominence—must decide between these mechanisms.
- The no-moment control captures at `15.768509T`, distance integral
  `1.924067L`, final distance `0.745720L`, 232 shifts, and score
  `-0.041674`. Carrier-demodulated, opposition-only moment curvature
  advances every inherited route milestone and captures at `15.735508T`,
  `1.919818L`, `0.744372L`, 231 shifts, and `-0.037222`. It keeps mean
  posterior demand slightly lower and limiting essentially unchanged, but
  raises maximum posterior excursion, lateral force, and yaw moment modestly
  to about `35.15 deg`, `0.03380`, and `0.01920`.
- Two distinct source policies—moment-only net-line damping
  (`solver_2acfcfa19ef8`) and moment plus exact translational terminal
  damping (`solver_883a064fe477`) produce identical trajectories, scores,
  and two-view sheets. The terminal rewrite is therefore inactive at physical
  trajectory scale. Adding a separate lateral-force consensus curvature
  retains the coherent wake but regresses the moment winner to
  `15.746509T`, `1.921600L`, `0.744715L`, and `-0.039050`.
  Corroborated load is not evidence for stacking another mean bend.
- The inherited moment branch changes feasible posterior action on hundreds
  of route samples and its trace-fitted carrier subtraction explains about
  96% of route-regime moment variance. The remaining opportunity is therefore
  not another direction, onset, terminal damper, or curvature gain. Its small
  excursion/load cost motivates testing whether the same evidenced moment
  request should also redistribute posterior wave duty, so supplemental mean
  curvature does not fight an unchanged counter-turning half-cycle.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control, asymmetric-flapping turning, and Lighthill-style posterior reactive loading
source_mechanism: preserve a directional traveling bend while a measured adverse yaw-load response attenuates only the posterior half-cycle that opposes the requested turn
transferable_invariant: keep the anterior rhythm, posterior lag, and slow target-directed mean turn intact; translate supplemental response-based curvature into bounded attenuation-only duty redistribution rather than stacking another mean bend
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact Strouhal values, exact tail or vortex phase, full-body waveforms, source moment scales, and task-specific routes
policy_translation: retain the assigned-parent moment-residual curvature, normalize only its already bounded signed curvature by the proven cruise-curvature scale, add that quantity to the phase-relief turn signal, and clamp it before applying the existing one-sided posterior-wave attenuation; leave the raw guard, propulsion allocation, redirect direction, and terminal laws unchanged
falsification: reject if capture or any route milestone regresses, distance integral worsens, the coherent alternating two-view wake degrades, posterior limiting or loads grow, or the new signal changes no feasible posterior action and merely duplicates the existing relief
```

## One candidate hypothesis

Produce exactly one candidate from the assigned parent. Preserve its anterior
state-feedback oscillator, posterior lag, target/course steering,
carrier-residual redirect selector, yaw and moment response branches, approach
and terminal shaping, axial-force propulsion allocation, mean-first action
projection, and exact actuator-limit projection. Change only how the posterior
wave relief interprets the already computed moment correction: add the signed
moment curvature divided by the existing cruise-curvature limit to the
bounded steering-duty signal. Because the moment branch is already
opposition-only and approach-faded, this term is zero without an evidenced
adverse moment and cannot reverse the requested turn. It affects only the
counter-turning half-cycle through the existing attenuation law; it does not
add mean curvature or amplify either half-cycle.

The falsifiable expectation is to retain the moment policy's route-scale
capture gain while lowering posterior excursion or lateral/yaw load, and
ideally improve a route milestone or distance integral by preventing the
supplemental bend from competing with an unchanged wave lobe. Reduced command
or load without target-progress neutrality is not success under the inherited
pre-limit-guard regressions. Formal CFD occurs only after this worker exits,
so no outcome for this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `9ce7e9e22974161d62a0e5656d56a3f953b39ffc66f225fa018b7921ba3a408e`.
  The deterministic schema audit finds exactly 56 returned parameter fields
  and 56 direct `params.FIELD` names, with no missing or unused field. The
  prescribed lightweight Julia contract returns two finite accelerations.
- A deterministic 20,000-pair state sweep across target side and distance,
  joint phase, body velocity, body force, moment, heading response, and
  line-of-sight response returns finite actions inside the declared
  acceleration limit with zero lateral-reflection error. Non-finite force,
  moment, heading-rate, and bearing-rate probes select finite fallbacks.
- Counterfactual reconstruction on the assigned-parent trace changes 194
  posterior commands and no anterior commands, from the soft opening at
  `0.253000T` through `15.631006T`, over distances
  `12.325690-0.885491L`. Mean and maximum absolute command changes are
  `0.049891` and `0.715567 rad/T^2`, with no new acceleration-limit hit.
  The wave-target attenuation is not pointwise command-magnitude monotone
  because target tracking and mean-wave cancellation interact; closed-loop
  route and load evidence, not lower reconstructed demand, remains the
  falsification criterion.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account. Its three prescribed commands were
  therefore run directly and separately: guidance materiality, the Julia
  policy contract, and solver editable-boundary checks pass. The first
  materiality run exposed two identical assigned-parent markers in the
  rendered workspace `README.md`; removing only the duplicate repaired that
  inherited metadata defect without changing the assigned parent. No CFD was
  run.
