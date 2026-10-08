# Direction-selective terminal posterior envelope

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance and inherited optimizer note, all four
  sampled policies, scores, observations, metrics, diagnostics, and
  trajectories, and both the top-down vorticity and oblique Lambda2 rows of
  the combined keyframe sheets. Every rollout is a stable capture from direct
  uniform still water with `U_infinity=(0,0,0)`, no prewarm, and no cylinders.
  The fish self-propel from rest; both the sampled parent and the three
  comparator sheets show a coherent alternating planar wake and compact
  three-dimensional posterior structures through capture. There is no passive
  advection, wake breakup, collision, or out-of-plane instability. The useful
  distinction is terminal route regulation, not wake existence.
- The sampled parent is the alignment-qualified terminal posterior envelope.
  Relative to the three episode-equivalent phase-reference comparators, it
  improves score/mean distance from `-0.06459894/1.95082256L` to
  `-0.06454455/1.95080137L`, shortens center path from `13.23303L` to
  `13.21113L`, raises mean/final target-course alignment below `2.10L` from
  `0.66372/0.06785` to `0.67219/0.18179`, and reduces mean absolute yaw there
  from `1.99704` to `1.88833 rad/T`. Posterior acceleration-ceiling residence
  falls from `66.05%` to `65.70%` overall and from `75.38%` to `72.47%` in the
  approach, while the terminal tail-angle maximum falls from `35.48` to
  `34.91 deg`. The two visual rows retain the same coherent wake class.
- The gain is small and carries a propulsion cost: near-target mean speed falls
  from `0.90122U` to `0.88656U`, and capture moves from `18.01250T` to
  `18.02349T`. The sampled parent therefore validates the *active posterior
  wave* as a terminal stabilization surface, but its symmetric envelope
  withdraws useful as well as yaw-reinforcing posterior work. The three
  phase-reference-only comparators are the informative failed mechanism: they
  reproduce the same `18.01250T` trajectory and energetic terminal bend despite
  different source text, showing that scheduling an inactive reserve subterm
  cannot regulate the crossing.

## Single policy hypothesis

Preserve the sampled parent's odd body-frame target-to-curvature map, anterior
state-feedback carrier, cadence, far/middle posterior lag and emphasis, mean
steering, reserve-work guard, approach gates, half-cycle steering, and
reversal-preserving rate governor. Refine only its active terminal posterior
envelope from symmetric relief to direction-selective half-cycle relief. The
existing distance, course-misalignment, and observed-turn gates determine when
terminal relief is available. Within that window, attenuate the raw lagged
posterior wave only when its signed curvature opposes the bounded target
turn-rate error; preserve full posterior excursion when it points toward the
needed yaw correction. The sign test is continuous and reflection-equivariant,
and adds no clock, route, coordinate, hidden state, or scalar-only gain tune.

Expected evidence is exact preservation of the parent trajectory outside
`2.10L`, retention of its lower near yaw and better alignment, recovery of some
near-target speed, and capture no later than the `18.01250T` comparator while
keeping or improving the parent's mean distance and path. Falsify the mechanism
if pre-approach behavior moves, the signed half-cycle gate reinforces yaw error,
capture or score regresses, terminal path/alignment/yaw fails to improve,
posterior load relief disappears or migrates to the anterior joint, reflection
symmetry fails, or either coherent wake view deteriorates.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric half-cycle turning and sensor-modulated oscillators, combined with terminal capture staging and Lighthill-style posterior reactive propulsion
source_mechanism: modulate posterior amplitude by observed turn demand so the corrective half-cycle retains thrust while the half-cycle that reinforces terminal yaw is selectively relieved
transferable_invariant: when an active posterior traveling wave both propels and turns, terminal stabilization should preserve posterior work that reduces measured yaw error and withdraw only the oppositely directed half-cycle
nontransferable_details: published gains, dimensional cadence, species-specific duty ratios and amplitude envelopes, full-body kinematics, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: multiply the existing normalized distance/alignment/turn relief by a smooth opposition test between the raw lagged posterior wave and the bounded body-frame target turn-rate error, then apply the result only to the posterior oscillatory target
falsification: reject if pre-approach behavior changes, the terminal speed/arrival cost remains without better yaw and alignment, capture or sampled-best mean distance is lost, loads migrate without benefit, reflection fails, or either coherent visual wake deteriorates

## Lightweight validation

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable to this account. I ran its immutable
  commands directly. The guidance check initially exposed two identical
  assigned-parent markers in the rendered workspace `README.md`; removing only
  the duplicate preserved the parent selection, and the rerun passes. The
  repository boundary check also passes with only the allowed target-policy
  file changed under `solver/`.
- No Julia executable is installed or discoverable, so the check-runner's load
  probe cannot execute in this shell. The deterministic schema guard passes:
  all `62` distinct direct `params.FIELD` references resolve among the `64`
  fields returned by `target_policy_params`, and delimiter balance is zero.
- Focused gate probes give authority exactly `1.0` outside the terminal window,
  on a corrective posterior half-cycle, and at zero yaw correction. An
  opposing probe gives `0.72755`, while its reflected state gives the identical
  scalar authority; the raw wave target and resulting acceleration path change
  sign algebraically under that reflection. These are contract/mechanism
  checks, not CFD evidence; the rollout hypothesis remains for EvE evaluation.
