# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still-water initialization (`U_infinity=[0,0,0]`), no cylinders,
  no prewarm, finite dynamics, and moving-window transport.  Their motion is
  therefore self-propelled rather than imposed advection.
- Both rows of every sampled combined keyframe sheet were inspected.  The
  transferred seed (`solver_e1a03f18d808`), response-release child
  (`solver_dc5e319e8345`), and curvature-release child
  (`solver_045019f39c2a`) all show a strong alternating mid-plane wake and
  compact three-dimensional Lambda2 structures.  They make useful initial
  progress but sweep below the target and exit the lower virtual boundary.
  The assigned parent (`solver_a1d9e06dfe8a`) retains a coherent, straighter
  wake after globally slowing and soft-limiting the carrier, but turns upward
  early, reaches only `8.752L`, and exits at `14.911T`.  Thrust absence and
  background-flow advection are not supported diagnoses.
- The newest geometry-gated curvature release is a real quantitative gain but
  not a semantic solution.  Relative to its response-release parent, it
  improves closest approach from `4.660L` at `18.568T` to `4.141L` at
  `20.669T`, extends survival from `28.369T` to `32.197T`, and keeps the same
  coherent wake; nevertheless it still exits below with final distance
  `9.570L`.  At `12T`, `14T`, and `16T` its recorded-state reconstruction
  reduced the contradicted positive mean-tail tangent from roughly
  `9.95/10.19/10.34 deg` to `7.31/3.79/0.41 deg`.  This establishes that
  withdrawing the wrong-polarity static bend helps, while showing that release
  alone cannot create the missing targetward redirect.
- The body-frame trace explains when authority is needed.  In the curvature-
  release rollout the lateral target component grows from `+2.34L` at `8T`
  to `+3.96L` at `12T` and `+4.19L` at `16T`, while heading grows from
  `0.575` to `0.828` and `0.903 rad`; the fish continues rotating away before
  eventually reducing heading, and inertia carries it below the target.  At
  closest approach the target is still `+3.98L` laterally off-axis.  Local
  flow remains only about `0.02U` while body speed is roughly `0.7--0.8U`, so
  a wake-rejection residual is not evidenced in this still-water rollout.
- The sampled and inherited negatives bound the intervention.  Merely gating
  the geometric request on the evaluator's roughly `0.0385T` yaw history did
  not change route topology; late cadence relief worsened closest approach to
  `5.347L`; and always-on tail mean-curvature controllers at both the tested
  `12 deg` bound and a much smaller course-released command produced immediate
  upper exits with closest approach above `12L`.  The common fast carrier also
  spends about `98%` of samples with at least one raw acceleration outside the
  `1800 deg/T^2` envelope, so another small post-carrier acceleration bias is
  unlikely to retain authority through clipping.

## Policy hypothesis

Restore the evaluated curvature-release child, which has the best sampled
closest approach and survival while preserving a coherent traveling wake.  Add
one compact half-cycle allocation mechanism upstream of acceleration clipping:
form a bounded signed maneuver command from the existing normalized body-frame
bearing/vector error, infer posterior carrier side from the joint-state tail
target, and strengthen the targetward half-cycle while weakening the opposite
half-cycle by the same small bounded fraction.  Gate the allocation smoothly
to zero near alignment.  This creates no always-on mean bend, hidden clock, or
world-frame route; it preserves carrier cadence and lets posterior joint phase
carry steering authority inside the existing two-joint oscillator.

Expected evidence is unchanged release and early wake formation, followed by
an earlier decrease in heading once the target becomes materially off-axis,
with a closer pass or a better termination class than the `4.141L` lower-exit
reference.  Falsify the mechanism if it recreates the inherited upper-exit
overturn, loses the deep early approach or alternating wake, preserves the same
lower exit without a meaningful distance/trajectory improvement, or increases
joint-limit exposure or load spikes.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and duty-ratio turning layered on posterior-lagged undulatory propulsion
source_mechanism: steer by making one observed propulsive half-cycle modestly stronger while preserving the traveling carrier
transferable_invariant: separate route error from joint phase and allocate bounded posterior carrier authority to the half-cycle that produces the requested turn
nontransferable_details: published gains, motor timing, dimensional cadence, species-specific envelopes, clock-driven phase, exact vortex phase, and task-specific routes
policy_translation: map normalized body-frame target error to a bounded signed command and joint-state posterior target to beat side, then modulate only posterior carrier amplitude before acceleration limiting while releasing continuously near alignment
falsification: reject the transfer if it loses carrier coherence or early progress, produces the sampled upper-exit topology, retains the lower exit without meaningful improvement, or worsens actuation and load exposure

## Pre-evaluation checks

- Recorded-state replay against the evaluated curvature-release trace leaves
  the action exactly unchanged while the new geometry gate is closed.  The
  posterior scale is about `0.998` at `8T`, `0.956` at `12T`, and remains
  bounded over the full trace in `[0.922, 1.078]`; the corresponding
  instantaneous carrier-target shift is phase-dependent rather than a held
  offset.  Only the tail action changes.  Reconstructed raw acceleration-
  envelope exposure changes slightly from `98.10%` to `98.02%`, with the same
  `113.52 rad/T^2` peak, so the branch does not algebraically worsen the
  inherited clipping burden on those states.
- All 62 direct `params.FIELD` references resolve in the 64-field object
  returned by `target_policy_params()`.  A 1,215-state grid over mirrored
  target error, joint angle/rate, and yaw rate remains finite; the new gate is
  mirror-symmetric, its signed command is antisymmetric, and aligned states
  are bit-for-bit identical to the evaluated curvature-release policy.
- The required check-runner was invoked, but its pinned model is unavailable
  for this account.  Following the inherited fallback, its three prescribed
  no-CFD commands were run directly and separately: the semantic guidance
  delta, lightweight Julia policy contract, and solver editable-boundary
  checks all pass.  These are algebraic and repository checks only; formal CFD
  remains deferred to EvE after this worker exits.
