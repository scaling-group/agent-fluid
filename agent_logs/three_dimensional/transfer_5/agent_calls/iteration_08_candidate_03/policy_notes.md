# Consensus half-cycle terminal-steering candidate

## Evidence diagnosis before editing

- All four sampled solver evaluations are contract-valid, direct-uniform
  still-water rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm), and
  all terminate in capture. The comparison therefore uses the highest-scoring
  finite sample, `solver_3b3fa6c1a86f`, against the informative weak prefill,
  `solver_8c3d920cc8a5`, and uses the inherited static-posture boundary as the
  semantic failure: replacing most of the carrier previously produced a weak
  wake and early upper-boundary exits.
- Both rows of all four combined keyframe sheets show self-propelled progress,
  not advection. A coherent alternating mid-plane street is established by
  about `4T`; the oblique Lambda2 row retains paired three-dimensional shed
  structures through the same broad gradual-turn route and capture. There is
  no visible wake collapse, collision, boundary encounter, or instability to
  repair, and the small terminal differences are below keyframe resolution.
- The sampled direction-consensus policy is the strongest score
  (`-0.5357785`, capture at `23.8590T`, mean distance `2.434115L`), but its
  improvement over the ungated phase-demodulated bend is not a clean terminal
  regulation result. It arrives `0.0275T` later and has a slightly worse mean
  distance than `solver_8ce1bc88a53c`; mean absolute yaw inside `3L` is almost
  unchanged (`1.683` versus `1.684 rad/T`), while peak yaw falls only from
  `3.208` to `3.176 rad/T`, mean lateral load from `0.011795` to `0.011767`,
  and mean target-cross-track speed from `0.23935` to `0.23764 U`. Anterior
  high-command exposure instead rises from `56.8%` to `57.9%`.
- Offline sign reconstruction on the evaluated consensus trajectory agrees
  with its inherited hypothesis: carrier-rejected course and yaw request the
  same correction for about `74.7%` of samples inside `3L`, but only `41.2%`
  inside `1L`, and the Boolean agreement state switches 15 times during the
  final `3L`. These values diagnose cue and switching structure on the logged
  path; they are not a closed-loop counterfactual.
- The inherited full-request course injection is a concrete negative result.
  `solver_a97ee4cd2284` preserved capture and visibly coherent propulsion, and
  reduced mean cross-track speed inside `3L` to `0.2162 U`, but regressed to
  score `-0.537562`, arrival `23.9415T`, and mean distance `2.435712L`.
  Because that residual entered geometric demand before target-rate feedback,
  approach scaling, redirect, oscillator centers, and half-cycle steering, it
  does not isolate whether the rhythmic actuator path itself is useful.

## Policy hypothesis

Use `solver_3b3fa6c1a86f` as the sole evaluated carrier. Preserve its
traveling-wave oscillator, same-sign response-released C-bend, carrier-rejected
course/yaw observations, direction-consensus gate, and smooth final projection.
Change one actuator mechanism: remove the consensus residual from the anterior
oscillator center and posterior mean tangent, and apply it only as a bounded
direct steering-acceleration residual with posterior emphasis and the existing
observed tail-side/tail-motion half-cycle gate. The baseline target request
still controls the established C-bend and redirect, so this terminal path
cannot feed back through target-rate demand, approach scheduling, or carrier
centers as the failed full-request injection did.

The expected result is retained capture and alternating-wake coherence with
less persistent terminal curvature, lower peak/mean yaw or load, and no worse
high-command exposure, while preserving more of the consensus policy's radial
closing advantage than the full-request course injection. Falsify the
translation if capture is lost; if arrival exceeds `23.94T` or mean distance
exceeds `2.4357L` without a material load/yaw benefit; if the coherent wake or
route topology changes adversely; or if command and speed-limit exposure
increase. The direct acceleration scale is derived conservatively from the
evaluated terminal command range, not from a published gain.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal capture control
source_mechanism: bounded sensory steering asymmetry modulates a stable rhythmic carrier while posterior motion retains propulsive emphasis
transferable_invariant: preserve the traveling-wave carrier and route a small route-scale correction through observed-phase steering rather than replacing the rhythm or shifting a separate static oscillator center
nontransferable_details: published gains, dimensional cadence, robot linkage kinematics, species-specific envelopes, exact vortex phase, and source-task routes
policy_translation: retain normalized body-frame target course and carrier-rejected yaw consensus, then use observed tail angle and velocity to phase-weight a bounded two-joint acceleration residual with posterior emphasis
falsification: reject if capture or wake coherence is lost, or if directness, terminal yaw and loads, and joint/command exposure do not jointly improve over the evaluated consensus and full-request boundaries

## Verification boundary

The candidate's CFD evaluation runs only after this worker exits. Static,
contract, symmetry, and boundedness checks are not evidence of fluid-dynamic
improvement.

- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable with this ChatGPT account. Running its
  prescribed checks directly gives PASS for the material reusable-guidance
  change and PASS for the solver editable-boundary check.
- Julia is not installed, so the exact include/contract probe cannot execute.
  The deterministic fallback finds one `target_policy_params` definition, one
  `target_policy` definition, `69` returned parameter fields, `67` referenced
  fields, no missing field, balanced delimiters/blocks, a nonempty candidate,
  and no clock, randomness, file-I/O, or mutable-global token.
- By construction, the new normalized terminal cue is in `[-1,1]`, its
  observed-phase gate is in `[0.55,1.45]`, and its pre-projection contribution
  is bounded by `5.8 rad/T^2` anteriorly and `14.5 rad/T^2` posteriorly. The
  inherited smooth projection keeps each final command strictly below the
  owned `1800 deg/T^2` envelope.
- Mirroring body-frame target/velocity, yaw, and joint lateral state reverses
  both consensus direction and terminal acceleration while leaving the
  half-cycle gate invariant. This is a static reflection-equivariance check,
  not a rollout claim.
