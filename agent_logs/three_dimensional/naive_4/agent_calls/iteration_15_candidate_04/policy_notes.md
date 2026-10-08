# Signed-intercept posterior half-cycle relief

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled solver rollouts satisfy the required direct, uniform
  still-water contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, and
  finite capture. I inspected both the top-down vorticity and oblique
  body/Lambda2 rows for the sampled-best `solver_5187bb13ebc0`, the distinct
  corridor variants, and the assigned parent's inherited regression. The
  sampled best self-propels from quiescent fluid, establishes a coherent
  alternating red/blue street by `4T`, retains compact paired three-dimensional
  structures behind the posterior traveling bend, and crosses the capture
  circle without boundary interaction, collision, wake collapse, or numerical
  instability.
- No supplied rollout has a failure termination. The informative mechanism
  failure is the assigned parent's phase-residual-direction result. Its wake
  remains coherent, but it delays every `8/6/4/2/1L` milestone, captures at
  `16.4285T` instead of `16.0545T`, and regresses score from the sampled best's
  `-0.055617` to `-0.073591`. Its terminal world velocity
  `(-0.654,-0.887)U` is strongly lateral compared with
  `(-1.175,-0.091)U` for the best. Because force and moment peaks also fall
  rather than diverge, this is route-command regression with an intact wake,
  not instability or inadequate propulsion. The carrier-phase residual should
  remain an authority selector; raw body-frame target/course error must retain
  redirect direction.
- The current four-solver sample isolates terminal control roles. Relative to
  `solver_5187bb13ebc0`, the otherwise matching full-carrier corridor release
  `solver_736250db9a8b` restores posterior wave amplitude along with anterior
  drive. It has the same `16.0545T` capture but worsens final distance from
  `0.744345L` to `0.745354L`, held mean distance from `1.938857L` to
  `1.939710L`, and score to `-0.056672`. Attenuating mean redirect in the
  corridor likewise regresses score to `-0.056973`. Thus the positive part of
  the corridor mechanism is role-specific: release residual anterior damping,
  retain target-directed mean steering, and do not broadly restore the
  posterior wave.
- The inherited factorial posterior speed-headroom guard lowered constraint
  residence but delayed milestones and regressed score to `-0.058139`; exact
  clamp projection is trajectory-equivalent. Those negative results rule out
  another saturation wrapper. The remaining testable terminal channel is the
  side of the posterior rhythmic lobe, not its global amplitude or the mean
  route command.

## One candidate and policy hypothesis

Start from the evaluated sampled-best intercept-conditioned anterior-release
policy. Preserve its state-feedback oscillator, raw-error redirect direction,
carrier-phase-residual duty selector, response-conditioned settling,
posterior-only mean curvature, one-sided redirect relief, mean-first allocator,
bounds, and exact speed-limit projection. Add one compact terminal mechanism:
retain the signed version of the already measured straight-course predicted
miss, map it to a bounded intercept correction, and—only during a closing,
reliable approach—attenuate the
posterior wave half-cycle that bends against correction of that signed miss.
The other half-cycle, all mean steering, and every command outside the terminal
gate remain unchanged.

This transfers half-cycle asymmetry without copying gains or a prescribed
phase. It should preserve anterior oscillator energy and target-directed mean
curvature while trimming only the terminal posterior lobe most likely to add
cross-track motion. Falsify it if fixed-trace changes appear outside the
closing approach or in mean steering, if capture or any earlier milestone
regresses, if the coherent alternating 3D wake weakens, or if lower terminal
miss is not accompanied by useful score, arrival, load, or limit behavior.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop terminal path following
source_mechanism: sensor-conditioned half-cycle attenuation preserves a rhythmic carrier while biasing its net turning response
transferable_invariant: when mean target steering already works, alter only the rhythmic half-cycle that opposes a measured terminal intercept correction instead of replacing route direction or shrinking the whole gait
nontransferable_details: published gains, duty ratios, dimensional frequencies, species-specific capture kinematics, prescribed oscillator phase, exact vortex phase, source-task capture radii, and task-specific routes
policy_translation: compute a reflection-odd signed miss from normalized body-frame target and velocity, infer phase from posterior-wave joint state, and add bounded one-sided relief only under proximity, closing, and course-reliability gates while raw target/course error retains all mean curvature
falsification: reject if nonterminal or aiding-lobe actions change, lateral reflection equivariance fails, wake coherence or capture is lost, milestones are delayed, or reduced posterior motion does not improve terminal target progress or loads

The candidate has no same-worker CFD result. Fixed-state and recorded-trace
checks can establish locality, boundedness, and symmetry only; downstream EvE
evaluation must establish any trajectory or wake improvement.

## Non-CFD verification after the policy edit

- Replay of the final source on all `2,919` sampled-best states leaves every
  anterior command and every action at or above the `1.75L` approach boundary
  exact. Six posterior commands change between `1.365L` and `1.235L`; all are
  on the intercept-opposing half-cycle, retain command sign, and reduce rather
  than increase instantaneous magnitude. The maximum difference is
  `0.794 rad/T^2`. These are fixed-trace action semantics, not a closed-loop
  improvement claim.
- A deterministic `19,683`-state sweep over joint state, exact joint-speed
  boundaries, bearing, body-frame velocity, and target side returns finite
  bounded commands with zero lateral-reflection error and no outward command
  at either speed boundary. Static schema inspection finds `37` direct
  `params.FIELD` references and all `37` are returned by
  `target_policy_params()`.
- The required dedicated checker was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this ChatGPT account. Its three prescribed commands
  were therefore run directly and separately: the material guidance/provenance
  check, lightweight Julia policy contract, and solver editable-boundary check
  all pass. No CFD was run.
