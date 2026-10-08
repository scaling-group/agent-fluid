# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent is the line-of-sight-response carrier with symmetric
  angle stopping guards. Its three sampled copies are byte-identical and each
  captures at `0.749992L` and `27.7695T` after direct-uniform still-water
  initialization. Across `10098` joint samples the parent has no `45 deg`
  contact, but `1124` samples remain at the `260 deg/T` speed cap and `1700`
  actions reach the policy acceleration clamp. Mean absolute action is
  `17.3478 rad/T^2`; peak planar force and yaw moment are `0.02212` and
  `0.01041`.
- The parent's combined sheet shows genuine self-propulsion: an alternating
  top-down vortex street trails the translating body, compact three-dimensional
  Lambda2 structures remain organized in the oblique row, and a late
  correct-sign bend enters the capture circle. The moving window follows this
  world trajectory rather than advecting the fish.
- The sampled smooth speed-viability residual preserves the same productive
  visual topology and captures at `0.749366L` and `27.5770T`. It removes all
  exact speed-cap samples and retains zero angle contacts, while reducing mean
  absolute action to `16.0906 rad/T^2`; peak planar force/yaw moment remain
  essentially unchanged at `0.02218/0.01034`. Its better score (`-0.707508`
  versus `-0.709920`) is secondary to the actuator-envelope improvement.
- Inherited optimizer logs provide the informative failure missing from the
  current four solver samples. A short-horizon feasibility projection that
  maps same-direction acceleration to zero at the speed boundary misses at
  `0.752627L`, continues to `43.3455T`, and exits left at `9.94499L`; it still
  records `1568/15762` speed-cap samples and `3054/15762` acceleration-clamp
  samples. Its top-down and oblique sheets retain a coherent wake while the
  fish passes the capture circle and curls away, so the failure is a changed
  control trajectory rather than loss of propulsion or numerical instability.
  A narrower smooth inward barrier does capture (`0.749963L`) but leaves `34`
  exact speed-cap samples and increases peak force/moment to
  `0.02418/0.01124`, making the sampled broader smooth residual the strongest
  finite mechanism comparison.

## Policy hypothesis

Promote the evaluated speed-viability residual without changing the carrier,
posterior allocation, body-frame target/course selector, redirect, terminal
miss veto, line-of-sight response, or angle stopping guard. For either joint,
when observed angular speed enters a soft band below the hard envelope and the
combined command would accelerate farther in the same direction, smoothly
blend only that worsening component toward bounded inward braking. Preserve
all sub-band and speed-reducing commands exactly and apply the same signed
construction to both joints.

The formal expectation is repeat capture with the coherent multi-wake route,
zero angle contact, and strongly reduced speed-cap residence without higher
load or acceleration-clamp exposure. Reject the mechanism if capture is lost,
the ordinary traveling bend changes, near-limit chatter appears, speed
saturation returns, or the safety gain is traded for angle contact or larger
force/moment. The current candidate's CFD evaluation occurs after this worker
exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and finite-envelope traveling-wave propulsion
source_mechanism: preserve a productive rhythmic carrier while bounded measured-state feedback intervenes only when actuator motion approaches a physical envelope
transferable_invariant: envelope feedback should be reflection-equivariant, inactive during viable gait phases, and oppose only the command component worsening observed loss of rate headroom
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain normalized body-frame target-line control and add the same smooth joint-state speed band and inward-only acceleration residual independently to both joints
falsification: reject if repeat capture or coherent propulsion is lost, sub-band or speed-reducing commands change, speed-cap residence remains, or angle contact, clamp residence, force, or yaw moment increases

## Non-CFD implementation audit

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were then run
  directly and separately: the material guidance/schema validator, finite
  two-joint Julia contract, and solver editable-boundary check all pass.
- The candidate is byte-identical to the evaluated sampled smooth-speed-guard
  policy (SHA-256 `630283dcc05309a84219b6a9d1f28aac4aa6a8b5cb201e13cabd6ac7c95009a2`).
  Every direct `params.FIELD` reference is owned by `target_policy_params()`,
  exactly one candidate entrypoint exists under `solver/`, and all three
  required output files are non-empty. No CFD was run.
