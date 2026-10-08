# One-sided phase-authority candidate notes

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the experiment contract: direct uniform
  initialization at `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot,
  and finite dynamics. Every candidate nevertheless terminates at the upper
  virtual boundary (`center_y=15.200L`) by `8.800--9.740T`, so the repeated
  failure is uncontrolled trajectory curvature rather than advection,
  collision, or numerical instability.
- In both visual rows the fish is self-propelled. The top-down sheets grow an
  alternating red/blue caudal wake from still water, and the oblique Lambda2
  sheets show three-dimensional shed structures and a long inertial path by
  termination. The wake remains coherent across the strongest and weaker
  finite examples; the discriminating defect is that the path bends upward
  after about `5T` instead of settling onto the target line.
- The posterior-only bearing-plus-trend mean-curvature policy is the strongest
  sampled comparator. It reaches `11.413/11.421L` minimum/final distance and
  survives to `9.740T`, versus `12.091/12.312L` and `8.899T` for the prefilled
  yaw-rate-damped bias. Its target bearing has already crossed from positive to
  negative near `5T`, yet yaw and upward displacement persist to the boundary.
  Steering reversal is therefore delayed by the body/wake response even when
  the geometric request changes sign.
- That strongest policy asks the posterior joint for more than the fixed
  acceleration envelope in about `54.9%` of samples and peaks near
  `101 rad/T^2`. The sampled turn-rate-residual policy is worse
  (`11.858/11.985L`) and raises posterior over-envelope requests to about
  `69.8%`; its nominally recent bearing/yaw rates alternate at roughly the
  tail-beat scale because the available history spans only about `0.033T`.
  These data do not support treating those rate fields as a slow yaw-response
  estimate without additional cycle-scale structure.
- The inherited two-sided half-cycle amplitude candidate preserved the visible
  alternating wake but regressed to `11.778/11.860L` and exited at `8.800T`.
  Its explicit hard clamp placed the posterior request exactly on the
  `31.416 rad/T^2` limit for about `43%` of samples. Thus strengthening the
  requested-side lobe while weakening the other is not, by itself, an
  effective saturation remedy.

## Policy hypothesis

Preserve the strongest sampled controller's anterior Van der Pol carrier,
posterior lag, and bounded body-frame bearing-plus-trend request. Replace its
continuous posterior mean tangent with one-sided phase authority. Derive the
unsteered posterior acceleration from current joint state; apply a smooth
target-signed bias only while that carrier acceleration points against the
requested steering direction. This weakens the counter-turn half-cycle without
also enlarging the already clipped turn-side lobe. When the target bearing
reverses after overshoot, the selected half-cycle reverses automatically.

The downstream evaluation should retain the coherent 3D wake, reduce posterior
over-envelope residence below the sampled `54.9%`, and beat the `11.413L`
closest approach or improve the upper-exit termination class. Falsify the
translation if the posterior oscillation or forward progress collapses, if
hard-limit residence remains comparable, or if it repeats the upper exit with
no distance improvement over the strongest comparator.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and biological turning superposed on an undulatory carrier
source_mechanism: state-phased half-cycle asymmetry for directional turning
transferable_invariant: a bounded turn request can bias cycle-average curvature by modifying only the useful phase of an otherwise preserved traveling bend
nontransferable_details: published gains and duty ratios, clocked CPG phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: map bounded body-frame bearing and its observed trend to a turn request, derive posterior carrier acceleration from the two-joint state, and smoothly weaken only the carrier lobe opposed to that request
falsification: reject if the coherent wake or forward progress degrades, posterior limit residence does not fall below the continuous-bias comparator, or the `11.413L` closest approach and upper-exit topology do not improve

The candidate has no same-worker CFD result; these are hypotheses for the
downstream evaluator.

## Non-CFD verification

- A Julia mock-state check returns two finite accelerations and verifies exact
  sign reversal under simultaneous reflection of bearing, bearing trend, joint
  angles, and joint rates.
- As a counterfactual command audit only, evaluating this law on the recorded
  strongest trajectory's states lowers posterior over-envelope requests from
  `54.9%` to `42.4%`; this does not predict the closed-loop rollout because the
  candidate will generate different states.
- The required guidance-provenance, lightweight policy-contract, and solver
  boundary checks pass. No CFD was run in this workspace.
