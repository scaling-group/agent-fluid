# Course-consensus half-cycle candidate

## Evidence diagnosis before editing

- All four sampled evaluations are valid direct-uniform still-water rollouts
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm), and all terminate in
  capture. The strongest finite score is the direction-consensus terminal brake
  (`solver_3b3fa6c1a86f`, `-0.535779`, `23.8590T`); the assigned/prefilled
  approach allocator is the weakest relative result (`solver_8c3d920cc8a5`,
  `-0.536784`, `23.9250T`).
- Both rows of their combined wake sheets, as well as the faster
  phase-demodulated brake and the course-plus-relief candidate, show self-propelled
  motion, a coherent alternating mid-plane reverse-vortex street, paired 3D
  Lambda2 structures, and the same broad gradual-turn capture route. No sample
  shows advection, wake collapse, boundary contact, collision, or instability;
  the unresolved difference is terminal regulation.
- The phase-demodulated course brake is fastest (`23.8315T`, mean scoring
  distance `2.434073L`) but superposes a terminal mean-curvature bend and has
  terminal mean/peak absolute yaw `1.684/3.208 rad/T` and peak lateral load
  `0.02497`. Direction consensus changes these to `1.683/3.176 rad/T` and
  `0.02471` while retaining nearly the same score. The candidate combining a
  carrier-rejected course residual with raw-yaw amplitude relief has the
  shortest sampled center path (`12.9077L`) and lower terminal yaw
  (`1.582/2.940 rad/T`) and lateral load (`0.02400`), but capture slows to
  `23.9360T` and mean distance rises to `2.434807L`. Because that result
  confounds course steering with whole-carrier relief, it supports the route
  signal but not either actuator in isolation. The allocator is similarly
  clean but slower, so reserved scalar headroom is not the missing capability.
- The inherited logs already establish that target-transverse speed is
  beat-contaminated and that anterior joint-state rejection materially lowers
  its RMS. The newly evaluated samples retain the carrier and validate the
  demodulated course/yaw consensus, but do not establish that its separate
  static oscillator-center offsets are the right actuator path. Their higher
  yaw/load histories make that actuator path the falsifiable part to replace.

## Policy hypothesis

Start from the evaluated direction-consensus candidate. Preserve its captured
response-released C-bend carrier, smooth final projection, normalized
body-frame line-of-sight course residual, anterior joint-phase rejection, and
signed excess-yaw agreement. Remove only the independent terminal head and
tail mean-curvature offsets. Instead, use course/yaw agreement as bounded
intervention confidence, retain carrier-rejected target geometry as the slow
turn direction, and asymmetrically scale the posterior traveling-wave target.
Observed tail-tangent velocity identifies the current half-cycle, so motion in
the requested direction is strengthened and the opposite half-cycle is
weakened without a clock. Separating slow direction from the residual activity
gate prevents leftover beat phase from becoming a symmetric amplitude boost.
The anterior oscillator, broad target steering, redirect handoff, and mean-tail
targets remain unchanged.

This tests a mechanism rather than a scalar retune. It should keep the faster
course/yaw-informed approach while moving terminal yaw, lateral load, and
posterior acceleration exposure toward the cleaner course-plus-relief rollout.
Falsify it if capture or either coherent wake view is lost; if arrival and mean
distance fail to beat that slower result; or if yaw, load, path directness,
or joint-limit histories do not improve jointly over the sampled static brake.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and asymmetric flapping
source_mechanism: sensory direction error biases the useful half-cycle of a low-dimensional propulsive rhythm instead of imposing a separate static posture
transferable_invariant: preserve the traveling-wave carrier and convert slow route-level turn demand into bounded state-phased posterior asymmetry
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, exact vortex phase, and source-task routes
policy_translation: use normalized body-frame target and velocity plus joint-state phase rejection for course/yaw confidence, retain carrier-rejected target geometry as slow direction, then use observed tail-tangent velocity to scale the two-joint posterior wave target on opposite half-cycles
falsification: reject if capture or wake coherence is lost, or if directness, terminal yaw/load, and joint-limit histories do not improve together relative to the sampled static brake

## Worker-side verification boundary

- Formal CFD is deferred to EvE and no performance improvement is claimed for
  this unevaluated candidate.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unsupported on this account. Running its prescribed checks directly gives
  PASS for the material reusable-guidance update and PASS for the solver
  editable boundary. The guidance checker initially exposed two identical
  assigned-parent markers in the rendered `README.md`; removing only the
  duplicate repaired that inherited metadata defect.
- Julia is absent from this host, so the configured include/finite-action probe
  cannot execute. The deterministic fallback finds one parameter entrypoint,
  one policy entrypoint, `69` returned fields, `67` referenced fields, no
  missing fields, balanced delimiters, and no executable clock, step, random,
  file-I/O, cylinder, or target-identity dependency. The inherited smooth
  projection remains the final command envelope.
- A read-only reconstruction on the strongest sampled state history is zero
  outside the `3L` gate and materially active on about `59.5%` of terminal
  samples. The posterior half-cycle gate spans approximately `0.932–1.026`,
  with both stronger and weaker half-cycles. This establishes signal scale and
  activation only, not a fluid-dynamic counterfactual.
- Mirroring lateral target/velocity, yaw, and joint state leaves the scalar
  half-cycle gate unchanged and reverses the posterior target exactly in a
  synthetic probe. The owned half-cycle gain bounds that gate to
  `[0.78,1.22]`; the mechanism reduces identically to the evaluated carrier
  whenever its terminal request is zero.
