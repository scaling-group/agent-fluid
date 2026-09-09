# Wake-policy candidate diagnosis

## Evidence read before editing

- Every sampled and inherited rollout used direct uniform still-water
  initialization with `U_infinity=[0,0,0]`, no cylinders, and no prewarm.
  Motion in both visual rows is therefore self-propulsion rather than ambient
  advection or reused-flow momentum.
- I inspected both rows of the combined sheets for the highest-score sampled
  capture (`solver_6b0e320e2f55`), all other exact speed-reserve captures, the
  first projected-miss capture, and both inherited exact-policy projected-miss
  failures. The speed-reserve captures sustain a long alternating top-down
  vortex street and compact oblique Lambda2 pairs through capture at
  `18.2050--18.6010T`. The two failures retain the same active wake through
  their closest passes and subsequent turns; there is no carrier collapse,
  collision, or numerical instability immediately before the lower exits.
- Three sampled policies are byte-identical to the prefilled
  `dogfish3d_intercept_guarded_speed_reserve_v1` (`567de354...`) and all three
  capture at `0.7466--0.7494L`. They cross at `0.8268--0.9083L/T` despite
  substantially different projected miss at about `1L` (`0.143--0.905L`).
  This is repeat evidence for preserving its state-feedback traveling bend,
  achieved-course route servo, projected-intercept release guard, and sparse
  outward-carrier reserve.
- The assigned-parent lineage replaced terminal course error inside `2L` with
  normalized signed projected miss. Its first run captured at `0.7477L`, but
  exact-byte repeats missed at `1.6366L` and `1.7680L` and exited below. Both
  repeat failures were already on wider projected passes as they crossed
  `2L`, and by closest approach their target/velocity alignment was negative
  (about `-0.24/-0.21`) while speed remained about `0.82L/T` and the existing
  route request was saturated in the corrective direction. Thus tuning the
  projected-miss blend is unsupported: the reusable defect is failure to
  redirect a coherent, still-propelled fish after a threshold miss.
- Saturation-only allocation changes are also contradicted. The inherited
  total-command governor lowered exact speed-limit residence but missed at
  `1.3877L`, while the repeat-supported baseline still touches `260 deg/T` and
  clamps returned acceleration on roughly `68.5--68.7%/70.6--71.0%` of rows.
  Clamp fraction does not separate capture from the lower-pass failures.

## Candidate mechanism and falsification

Preserve the prefilled speed-reserve controller everywhere on an approaching
trajectory. Add one recovery mechanism: a bounded target-signed posterior
mean-curvature acceleration only when four continuous body-frame gates agree
that the fish is near the target, its short-window range is increasing, its
instantaneous target/velocity alignment is receding, and its route error is
large. This is a state-triggered burst redirect after a miss, not a hidden
stage or clock. The term is added outside carrier-reserve attenuation so the
traveling bend remains active around the shifted posterior mean.

The curvature amplitude is `6 deg`; at the nominal oscillator rate its raw
tracking contribution is about `13.7 rad/T^2`, below half the `1800 deg/T^2`
action envelope before final clamping. All active thresholds and amplitudes
are owned by `target_policy_params`. The recovery gate is identically zero
for the three sampled successful trace endpoints because target/velocity
alignment and range closure remain positive through capture.

Expected test: retain the three-repeat approach/capture topology, wake, speed,
and loads when capture occurs on the first pass. If numerical trajectory
variation instead produces a near lower pass, the receding gate should engage
posterior curvature soon after closest approach, reverse the lower-exit arc,
and permit a later capture without coasting or suppressing the alternating
wake.

Falsification: reject this recovery primitive if it activates before the
closest pass on a successful approach, loses first-pass capture, weakens the
top-down or oblique traveling wake, materially raises saturation or force/yaw
moment peaks, or retains the same lower-domain exit after a miss. A later
capture with a tight high-load orbit is not sufficient; future workers should
then seek an earlier authority observation rather than increase recovery
curvature.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish mean-curvature turning over a rhythmic propulsive carrier
source_mechanism: gate a bounded target-signed curvature burst by observed miss and response state while preserving posterior traveling-wave propulsion
transferable_invariant: after a coherent swimmer passes a nearby target while receding and strongly misaligned, a transient posterior mean-curvature bias can redirect it without replacing the carrier or prescribing a route
nontransferable_details: species-specific C-start shape, robot duty ratios, published gains, dimensional cadence, exact beat or vortex phase, and task-specific paths
policy_translation: multiply a six-degree posterior curvature target by smooth normalized distance, window-closing, target/velocity alignment, and route-error gates; add its tracking acceleration to the existing two-joint body-frame controller only after a pass
falsification: reject if any first-pass capture changes, recovery does not prevent the lower exit, the carrier collapses, actuator or load peaks rise materially, or a later capture requires a tight high-load orbit

## Non-CFD verification

- Recorded-trace projection is inactive on every row of the three exact
  speed-reserve captures and the first projected-miss capture. On the two
  inherited repeat failures it activates on `329/297` rows and reaches
  `0.861/0.703`, respectively. This confirms the intended observational
  separation without claiming a counterfactual CFD outcome.
- The prescribed Julia policy contract returns finite accelerations
  `(-15.0784,-1.6932)`. A separate synthetic check gives recovery gate `0`
  for approach and `0.7979` for a near receding miss; simultaneous lateral
  reflection preserves the gate and negates both returned joint actions
  exactly within `1e-12`.
- The reusable-guidance delta and solver editable-boundary checks pass. Static
  schema validation confirms every direct `params.FIELD` reference is present
  in `target_policy_params`. No CFD was run.
