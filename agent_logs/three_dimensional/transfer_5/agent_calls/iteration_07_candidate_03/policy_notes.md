# Phase-demodulated course-steering candidate

## Evidence diagnosis before editing

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm), and all terminate
  in capture. The comparison therefore treats `solver_8ce1bc88a53c` as the
  strongest finite result and the assigned/prefilled approach allocator
  `solver_8c3d920cc8a5` as the informative weak result; the phase-yaw brake
  `solver_74436c6ae2ba` supplies the most informative load tradeoff.
- Both rows of every combined sheet show self-propelled target progress rather
  than advection: a coherent alternating mid-plane vortex street develops by
  about `4T`, the oblique Lambda2 row retains paired three-dimensional shed
  structures, and the fish follows the same broad gradual-turn route through
  capture. There is no visible wake collapse, boundary encounter, collision,
  or numerical instability to repair.
- The assigned allocator is the slowest sampled capture (`23.9250T`) and has
  the weakest sampled score (`-0.536784`, mean distance `2.435081L`). Reserving
  component-wise approach acceleration therefore did not create useful
  steering authority, even though the carrier and wake remained coherent.
- Phase-demodulating target-relative transverse speed and using it to sign an
  excess-yaw counter-bend gives the strongest sample: `solver_8ce1bc88a53c`
  captures at `23.8315T`, scores `-0.535794`, and lowers mean distance to
  `2.434073L`. This establishes the route signal as useful, but not the added
  mean-curvature actuator. Against the raw course-residual sample
  (`solver_e08e4373a646`), the best-score counter-bend raises terminal mean/peak
  absolute yaw from `1.556/2.975` to `1.684/3.208 rad/T`, peak lateral load
  from `0.02400` to `0.02497`, and terminal anterior/posterior `>=95%`
  acceleration exposure from `57.5/51.6%` to `56.8/59.0%`. The phase-yaw
  brake is still more aggressive (`3.472 rad/T`, `0.02556` peak lateral load),
  while the allocator is cleaner but slower. The evidence therefore supports
  retaining the demodulated course observation while changing how it enters
  the two-joint carrier.

## Policy hypothesis

Start from the evaluated response-released, smoothly projected C-bend carrier.
Compute the normalized body-frame line-of-sight cross-track speed and subtract
the anterior joint-state carrier proxy already tested by the best sampled
policy. Feed this bounded, proximity- and translation-gated residual into the
existing target steering request before its validated centerline, recovery,
half-cycle, and C-bend allocation. Do not add a separate terminal oscillator
center or whole-carrier amplitude brake. This preserves the useful traveling
wave and makes one course-level correction share the established steering
path, rather than superposing a second mean bend that can increase terminal
yaw and posterior acceleration saturation.

Falsification: reject this candidate if it loses capture or coherent
alternating wake structure; if it does not beat the allocator's `23.9250T`
arrival and `2.435081L` mean distance; or if it cannot approach the best
sample's directness while moving terminal yaw, lateral load, and posterior
acceleration exposure toward the raw-course sample. The fitted carrier proxy
is specific to this gait and must be re-estimated or removed if the residual
remains beat-periodic under a changed carrier or held-out condition.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal capture
source_mechanism: sensory course error modulates a low-dimensional propulsive rhythm through bounded steering asymmetry
transferable_invariant: preserve the traveling-wave carrier and route slow target-course correction through the established rhythmic steering channel rather than superposing an independent static bend
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phase, and source-task routes
policy_translation: use normalized body-frame target and velocity to form line-of-sight cross-track speed, reject the observed anterior joint-phase component, and add the bounded near-target residual to the existing two-joint half-cycle and C-bend request
falsification: loss of capture or wake coherence, worse directness than the allocator, or failure to reduce the sampled counter-bend's yaw/load/saturation tradeoff invalidates the transfer

## Worker-side verification boundary

- The new CFD result is not available to this worker and will not be claimed as
  evidence. Static and synthetic checks below establish only schema, symmetry,
  boundedness, and material activation of the proposed feedback path.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Running its prescribed checks directly
  gives PASS for the reusable-guidance semantic check and PASS for the solver
  editable-boundary check. The rendered README contained the same assigned
  parent marker twice; removing only that duplicate was required for the
  guidance checker to identify the parent.
- Julia is not installed in this workspace, so the exact include/contract probe
  cannot execute. The deterministic fallback audit finds `66` returned
  parameter fields, `64` distinct direct `params.FIELD` references, no missing
  fields, one `target_policy_params` definition, and one `target_policy`
  definition. Delimiters balance, and the candidate remains non-empty.
- Mirroring body-frame lateral target/velocity and anterior phase velocity
  reverses the new correction exactly in a synthetic probe (`-0.145790` versus
  `+0.145790`), while its gates bound its magnitude by the owned `0.45`
  steering gain and the inherited final projection bounds both accelerations.
- Static replay of the sampled trajectories shows the new path is zero outside
  `3L`, is above `0.01` in magnitude for `86.5–88.0%` of samples inside `3L`,
  and reaches only `0.355–0.397` before the existing approach and steering
  gates. On the strongest sampled route, the carrier subtraction reduces
  cross-track-speed RMS from `0.2741` to `0.1435 U`. These are algebra and
  signal-scale checks, not a fluid-dynamic counterfactual.
