# Wake-policy diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts: `U_infinity=(0,0,0)`, no cylinders, no prewarm, and capture. Motion
  toward the target is therefore self-propelled rather than environmental
  advection.
- The best-score sheet (`solver_8ce1bc88a53c`) and the most informative
  relative mechanism failure (`solver_74436c6ae2ba`, the assigned parent) show
  the same useful visual topology in both rows. A compact alternating
  top-down vortex street appears by `4T`, remains coherent around the gradual
  target-directed arc, and reaches the capture circle. The oblique Lambda2 row
  confirms paired three-dimensional wake structures attached to the posterior
  body through approach. Neither sheet shows wake collapse, passive drift, a
  boundary encounter, or a reason to replace the traveling-wave carrier.
- The assigned parent's phase-fitted terminal counter-curvature is fastest
  (`23.7600T`) but fails its damping hypothesis. Its score/mean distance are
  `-0.536482/2.434407L`, peak yaw is `3.4715 rad/T`, anterior speed-limit
  exposure is `20.35%`, and peak lateral-force/yaw-moment coefficients are
  `0.02556/0.01482`. The target-course-plus-yaw-relief candidate
  (`solver_e08e4373a646`) is slightly later at `23.8810T` but improves these to
  `-0.535986/2.434313L`, `2.9748 rad/T`, `19.71%`, and
  `0.02400/0.01409`, respectively. Thus the parent's extra terminal speed is
  coupled to noisier yaw and load response, not a cleaner route.
- The best scalar result (`solver_8ce1bc88a53c`) combines phase-demodulated
  course gating with the parent's counter-bend and reaches `23.8315T` with
  mean distance `2.434073L`. It still raises peak yaw, lateral load, and heave
  load to `3.2076 rad/T`, `0.02497`, and `5.277`, versus
  `2.9748 rad/T`, `0.02400`, and `4.349` for the direct course residual. The
  approach allocator (`solver_8c3d920cc8a5`) lowers acceleration exposure but
  is latest (`23.9250T`) and has the worst sampled mean distance
  (`2.435081L`). These tradeoffs do not support composing another fitted-phase
  bend or an acceleration-reserve allocator.
- Inherited logs provide the missing mechanism isolation: adding the bounded
  line-of-sight transverse-velocity residual to the v22 raw-yaw-relief carrier
  improved score from `-0.537462` to `-0.535986` and mean distance from
  `2.435490L` to `2.434313L` at the same `23.8810T` arrival, without increasing
  the `0.02400/0.01409` planar load peaks. In contrast, raw-yaw relief alone
  was a weak negative against v21: one step later, essentially unchanged yaw
  and posterior speed exposure, and peak heave load increased from `4.349` to
  `5.448`. Instantaneous target-transverse speed remains beat-contaminated, so
  another coefficient fitted to one rollout is not justified.

## Single candidate hypothesis

Retain the response-released, smoothly projected same-sign C-bend and its
posteriorly lagged state-feedback carrier. Add only the sampled target-relative
terminal course residual: the signed body-frame cross product of the observed
head-to-target vector and swimmer velocity, continuously gated inside `3L` and
at nonzero translation speed, enters the existing steering request. Remove
both the parent's phase-fitted static counter-bend and v22's raw-yaw
whole-oscillator amplitude relief. This isolates one observation-driven route
mechanism while leaving propulsion, cadence, and the physical command envelope
unchanged.

Falsification: reject the residual if it loses capture or alternating-wake
coherence; if mean distance exceeds `2.434313L` or arrival is materially later
than `23.8810T` without a meaningful load/limit improvement; or if yaw,
joint-speed exposure, command effort, or force/moment histories regress. The
current worker does not claim the unevaluated ablation will match its source
composition.

bookshelf_consulted: true
source_domain: sensor-feedback direction tracking in robotic-fish CPG control
source_mechanism: a bounded sensory course residual modulates steering around a stable rhythmic propulsive carrier
transferable_invariant: separate traveling-wave propulsion from target-relative route correction and test the smallest residual that leaves the carrier intact
nontransferable_details: published gains, explicit oscillator phase, robot or species kinematics, dimensional cadence, exact vortex phases, and prescribed routes
policy_translation: use normalized body-frame target and velocity observations to add a bounded line-of-sight transverse-velocity correction to the existing two-joint steering request only in the terminal band
falsification: reject if capture, route directness, coherent alternating wake, yaw, actuator exposure, or load histories worsen relative to the sampled course-residual capture

## Worker-side verification boundary

- The guidance semantic-change check and editable-boundary check pass. A static
  audit finds `65` returned parameter fields covering all `63` distinct direct
  `params.FIELD` references, with exactly one `target_policy_params` and one
  `target_policy` entrypoint and no clock, random, file-I/O, or cylinder-route
  dependency.
- After removing comments and the version label, the executable candidate is
  identical to the inherited schema-checked isolated-course implementation.
  The prescribed independent checker was invoked, but its pinned model is not
  available for this account; the Julia load probe also cannot run because no
  Julia executable is installed in this workspace. A read-only fallback audit
  independently passed the guidance, schema, boundary, and nonempty-file checks.
- No CFD was run. Formal evaluation occurs after the worker exits, so the
  candidate hypothesis is not recorded as rollout evidence here.
