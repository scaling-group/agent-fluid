# Target-closing, axial-response posterior cruise burst

## Evidence diagnosis before the policy edit

- The assigned solver prefill is `solver_502dfb1f0223`. It satisfies the
  direct-uniform still-water contract, retains capture, and reaches the target
  at `15.708008T` with distance integral `1.918172L`, final distance
  `0.743744L`, `231` moving-window shifts, and score `-0.035505`.
- I inspected the combined keyframe sheets for the strongest finite sample
  (`solver_1a8c73736b49`) and the weakest-score sampled comparison
  (`solver_502dfb1f0223`) from release through capture. In both top-down rows,
  the initially quiescent field develops a compact release transient and then
  a coherent alternating caudal vortex street while the fish follows a smooth
  target-directed arc. The oblique rows show bounded alternating Lambda2
  structures without passive advection, wake collapse, collision, domain
  exit, or out-of-plane instability. The sheets differ only subtly at their
  sampling resolution; trajectory, load, and action histories are the useful
  discriminants. Both summaries and diagnostics confirm
  `U_infinity=(0,0,0)`, uniform direct initialization, finite dynamics, and
  capture.
- `solver_1a8c73736b49` and the independently sourced
  `solver_e4b4c0604a5d` are byte-identical in both policy and combined wake
  sheet. They retain adverse translational response inside the existing
  error-opened posterior-curvature envelope and improve every
  `8/6/4/2/1.25L` milestone over the prefill, capture at `15.686007T`, reduce
  the distance integral to `1.916135L`, use `226` shifts, and score
  `-0.033442`. Their wake is therefore the candidate base, but a third rewrite
  of that policy would not be trajectory diversity.
- The weaker sampled controls show what to preserve. Handing redirect wave
  relief back to propulsion on target-aiding demodulated yaw
  (`solver_502dfb1f0223`) delays every milestone and raises mean posterior
  demand and acceleration-ceiling residence. Releasing the response correction
  on realized yaw (`solver_a3ebfdcbb7c5`) captures still later at
  `15.713508T` and has distance integral `1.917987L`. Target-line translation
  must therefore remain inside the reliable raw-error envelope, and aiding yaw
  is not a supported release signal for either mean curvature or the
  target-opposing posterior lobe.
- The inherited step-32 log is an additional negative control omitted from the
  assigned parent's current durable summary: reducing base posterior action on
  adverse axial-force lobes delayed capture from `15.768509T` to `15.785009T`,
  worsened distance integral from `1.924071L` to `1.925588L`, and moved the
  crossing from `0.745725L` to `0.747963L`. The inherited step-39 redirect-
  phase allocation likewise regressed the current sampled-best family to
  score `-0.039816` and final distance `0.745761L`. Another adverse-load relief,
  half-cycle recovery selector, terminal threshold, or yaw handoff is closed
  by completed evidence.
- The remaining force observation has positive support rather than only a
  proposed interpretation. The established positive-axial-force allocator
  advanced the later `6/4/2/1.25L` milestones versus speed-only recovery while
  lowering mean posterior demand. On the current sampled-best trace, normalized
  body-forward force is positive on `71.1%` of samples. Outside the `1.75L`
  approach, measured target-closing efficiency exceeds `0.75` on `79.3%` of
  samples, including 1,401 high-speed samples with simultaneously positive
  axial response. Thus the response signal has broad feasible cruise support
  after the existing low-speed recovery closes; the current policy simply does
  not allocate any supplemental posterior wave there.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion and sensor-modulated robotic-fish CPG direction control
source_mechanism: preserve a directional traveling bend while measured task progress and propulsive load jointly allocate a bounded posterior burst
transferable_invariant: retain the anterior carrier and zero-response base wave, and add posterior wave authority only when normalized body-frame target closing and positive axial response agree
nontransferable_details: published gains, species-specific amplitudes, dimensional frequencies, exact Strouhal values, exact vortex phase, source force scales, clock-defined gait stages, and task-specific routes
policy_translation: start from the sampled-best state-feedback carrier; preserve its low-speed force allocator, then make a smaller posterior-wave endpoint available after recovery only under reliable target-aligned translation, with the existing positive-force gate selecting the feasible increment and proximity returning continuously to the evaluated approach law
falsification: reject if capture or an established milestone regresses, distance integral or final crossing worsens, the coherent two-view wake changes adversely, posterior excursion or limiting grows without route benefit, or replay shows only clamp-equivalent action

## One candidate hypothesis

Produce exactly one candidate from `solver_1a8c73736b49`. Preserve its
anterior oscillator, posterior lag, target/course steering, carrier-demodulated
route and load residuals, translational-response correction, approach and
terminal laws, low-speed positive-force allocation, mean-first construction,
and exact actuator projection.

Add one small compatible mechanism rather than another scalar retune: after
the low-speed recovery gate closes, normalized target-closing efficiency opens
a bounded cruise-wave endpoint only when course reliability is established.
The already evidenced positive body-forward-force gate interpolates to that
endpoint. Zero or adverse force, poor target closing, unreliable course, and
near-target approach recover the sampled-best action continuously. The cruise
increment is smaller than the established recovery increment and sized within
the observed posterior target headroom; it does not alter frequency, steering
curvature, turn sign, or the acceleration envelope.

The falsifiable expectation is an earlier middle/late route or lower distance
integral with capture and the coherent 3D wake preserved. A lower command or
load statistic without route benefit is not success. Formal CFD occurs only
after exit, so no outcome for this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `c34c59e62b871d63f92ab967d7abfb6bfb59e15a630000709a0193ac790d178d`.
  Static schema validation resolves all 61 direct `params.FIELD` references
  against exactly 61 fields returned by `target_policy_params()`, with no
  missing or unused field. The prescribed lightweight Julia contract returns
  two finite bounded accelerations.
- Counterfactual evaluation on all 2,852 reconstructed sampled-best trace
  states changes 366 posterior commands and no anterior commands over
  `3.575001-15.647507T`. Mean and maximum changed-command magnitudes are
  `1.9366` and `4.7305 rad/T^2`. There are zero changes at or below the
  established `0.35U` low-speed recovery boundary, zero changes under adverse
  axial force, and no new posterior acceleration-ceiling output; reconstructed
  ceiling count falls from 640 to 634 because the shifted wave endpoint can
  sometimes unload mean/wave cancellation. This establishes broad feasible,
  non-clamp-equivalent cruise support without predicting closed-loop CFD.
- Mirroring target geometry, translation, lateral force, moment, yaw/line-of-
  sight response, and both joint states across every reconstructed trace state
  gives exactly zero action-reflection error. The guidance materiality,
  lightweight contract, parameter schema, and single editable solver boundary
  checks pass. Exactly one candidate file exists and no formal CFD was run.
- The configured `.codex/agents/check-runner.toml` was invoked as required, but
  its pinned `gpt-5.4-mini` model is unsupported for this account, matching the
  inherited worker limitation. Its three prescribed non-CFD commands were run
  separately against the final files and pass: material reusable guidance,
  finite two-joint Julia contract, and the single editable solver boundary.
