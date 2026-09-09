# Posterior-selective carrier governor candidate

## Evidence read before the policy edit

- All four sampled rollouts satisfy the frozen release contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders, no prewarm snapshot,
  stable finite moving-window transport, and `capture` termination. Because
  this batch contains no non-capture, the visual contrast uses the strongest
  finite sample `solver_f7169bba556d` and the weakest, most informative sample
  `solver_a47435301f18` rather than inventing a failure class.
- Both rows of all four combined keyframe sheets were inspected from release
  through capture. The top-down rows show self-propulsion from blank still
  water, target-directed translation, a coherent alternating posterior wake,
  and a late curved crossing of the capture circle. The oblique rows show
  compact three-dimensional Lambda2 structures shed behind the caudal region;
  none shows passive advection, collision, wake collapse, or instability.
  The governor variants preserve this useful wake class, so the unresolved
  distinction is actuator allocation, route efficiency, and load—not missing
  propulsion or steering sign.
- The inherited guidance rejects indiscriminate instantaneous carrier
  suppression based on older results, while the inherited optimizer logs
  identify the whole-command governor as a mixed result and propose separating
  rhythmic carrier from steering. The current samples now provide that missing
  evaluation. Relative to two unguarded response-aware repeats at
  `19.162--19.338T`, integrals `2.06924--2.07622L`, and paths
  `12.304--12.309L`, both carrier-separated governors capture at `18.111T`
  and advance every `10/8/6/4/2L` milestone. This is a semantic improvement
  beyond the repeat spread and overturns the blanket negative conclusion.
- The two implementations expose a joint-specific boundary. The independently
  aligned carrier guard reaches `18.111T/2.00209L/12.281L`, reduces posterior
  greater-than-99%-rate residence from `4.35--4.36%` to `0.43%`, keeps
  anterior residence near `8.17%`, and lowers maximum joint angle from about
  `33.7` to `31.3 deg`. The shared phase-preserving governor has the best
  integral/path at `1.99710L/12.198L`, but raises anterior rate residence to
  `10.45%` and peak planar force/yaw moment to `0.02729/0.01435`, versus the
  unguarded `0.02535--0.02537/0.01335--0.01356` class. Its posterior residence
  remains `3.55%`. Common attenuation therefore redistributes the constraint
  into the anterior joint; posterior outward-work withdrawal is the effect
  consistently associated with useful timing and posterior headroom.

## One-candidate architecture and falsification

Preserve the complete response-aware capture scaffold and the sampled exact
carrier/steering decomposition. Leave the anterior carrier and both bounded
steering residuals unchanged. Add one smooth governor only to posterior
carrier acceleration when the measured posterior joint rate is in the final
two percent of its owned envelope and that carrier acceleration reinforces the
measured posterior motion. Reversal authority remains exact. This is an
actuator-role ablation, not a scalar-only tuning exercise: it tests whether the
useful improvement comes from preventing posterior carrier overdrive without
either suppressing the anterior wave generator or scaling target steering.

Expected signature: retain the independently guarded sample's early
milestones, `18.111T` capture class, short path, low distance integral,
approximately `0.43%` posterior rate residence, and coherent two-view wake,
while keeping anterior rate residence at or below the unguarded `8.35%`
boundary and recovering force/moment toward the inherited class. Falsify if
arrival/integral return to the unguarded repeat band, posterior rate residence
or outward impulse returns, path exceeds `12.31L`, anterior residence or loads
worsen, joint margin erodes, or capture/wake coherence is lost. If falsified,
restore the evaluated independent carrier guard; do not tune the threshold or
add another terminal steering scalar.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive-thrust allocation and sensor-modulated robotic-fish rhythmic control
source_mechanism: assign the anterior joint to sustain and steer the traveling bend while measured actuator response selectively limits counterproductive posterior rhythmic work
transferable_invariant: withdraw only outward posterior carrier work near a normalized posterior actuator boundary while preserving anterior rhythm, target-conditioned steering, and reversal authority
nontransferable_details: elongated-body coefficients, published CPG gains, dimensional cadence, species-specific envelopes, robot motor models, exact vortex phase, full-body kinematics, world coordinates, and task-specific routes
policy_translation: decompose the existing two-joint state-feedback command into carrier and steering terms, leave the anterior carrier and both steering residuals exact, and smoothly attenuate posterior carrier acceleration only when normalized posterior rate proximity and positive carrier action-velocity alignment agree
falsification: reject unless early progress and capture coexist with low posterior rate residence, unshifted anterior residence, recovered load class, short path, joint margin, and coherent top-down and oblique wakes

## Post-edit non-CFD validation

- The guidance provenance checker passes after correcting the rendered
  `README.md` duplicate marker for the assigned parent; the revised lesson is
  materially different from that parent and is grounded in the current four
  samples plus inherited optimizer logs.
- The solver editable-boundary check passes, exactly one downstream target
  candidate remains, and no sibling candidate or solver edit was introduced.
- Static schema comparison finds no direct `params.FIELD` reference missing
  from `target_policy_params()`. The candidate contains no clock, step, random,
  file-I/O, cylinder, case, or memorized-route token.
- The literal `julia` command configured by the checker is absent from `PATH`,
  but the available Julia 1.12.6 executable successfully includes the policy
  and verifies finite bounded actions, owned parameters, and mirrored-state
  reflection equivariance. No formal CFD rollout was run.
