# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, and
  inertial moving-window transport. All four self-propel to capture with zero
  angle, rate, or applied-acceleration contacts, so this iteration is about
  response allocation rather than repairing propulsion or termination.
- I inspected every combined sheet from release through capture, including the
  top-down vorticity row and oblique body/Lambda2 row. The best-score assigned
  parent (`solver_2515fae158ed`) and the informative adverse-moment sibling
  (`solver_9660f26c87c3`) both build an orderly alternating wake, translate
  toward the target under their own actuation, and retain compact coherent
  three-dimensional vortices through the same late target-side hook. The
  no-recovery sample (`solver_cd2b31e85ca6`) and instantaneous-sideslip sample
  (`solver_7c8c0623a821`) show the same topology. There is no visible passive
  advection, boundary event, wake breakup, numerical instability, or
  moving-window-induced body rotation to justify changing the carrier.
- The assigned phase-rejected posterior parent captures deepest and has the
  best scalar score: `0.748269L` at `25.9105T`, mean distance `2.497000L`,
  score `-0.594833`, and peak planar force/yaw moment
  `0.01893/0.01011`. Relative to the no-recovery sample it improves arrival by
  only `0.0605T` and mean distance by `0.001175L`, while the visual route is
  unchanged. Its phase-rejected posterior recovery is therefore a finite
  parent advantage, not evidence for strengthening that scalar or retuning its
  corridor.
- The sampled adverse-yaw-moment residual supplies a complementary finite
  response result. It captures fastest at `25.8335T` and has the best mean
  distance, `2.496768L`; at `22/24T` its projected miss is
  `2.067/0.963L`, versus `2.107/0.992L` for the assigned parent. It remains
  contact-free and slightly lowers peak planar force/yaw moment to
  `0.01890/0.01003`, but crosses more shallowly at `0.749181L` and does not
  visibly separate from the common route. This supports testing its fast
  response qualification with the parent's full-beat posterior estimator, but
  does not support a stronger moment gain or a claim of semantic improvement.
- The inherited logs explain why the two mechanisms are separable. Raw
  body-normal velocity was strongly beat-phase-confounded and its recovery
  gate did not reduce full-beat miss; the assigned parent instead demodulates
  persistent course error and changes only joint 2. The moment sibling uses
  geometry-owned target-line response for direction and lets normalized yaw
  moment select the complementary adverse half-cycle, adding the same bounded
  increment to both joints. This is a small slow-response/fast-response
  combination rather than two competing route selectors.

## Policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, response-released
course/miss redirect, target-line residual, upstream and capture-scale
posterior wave shaping, phase-rejected middle-course recovery, coordinated
acceleration projection, and angle/rate viability guards. Add exactly one fast
response residual using the already sampled normalization: inside the closing
middle corridor, when inertial target-line rotation still requests more turn
and normalized yaw moment accelerates the body against that geometry-owned
side, add a bounded same-sign two-joint command on the target-side anterior
joint-state half-cycle. Helpful moment, adequate response, weak or non-closing
translation, far travel, and the inner capture approach pass through exactly.

The falsifiable expectation is that combining the parent's persistent
course-error demodulation with the sampled fast response phase improves the
`22/24T` projected miss and arrival while retaining the parent's deeper
crossing, coherent two-view wake, zero actuator contacts, and approximately
`0.019/0.0102` peak force/moment regime. Reject the combination if it loses
capture, changes only the existing shallow-hook cluster, chatters commands,
increases load or contact exposure, or fails to beat both the parent's
`25.9105T` arrival and the moment sibling's `2.496768L` mean distance. Do not
respond to such a rejection by increasing the moment scalar; a later worker
should instead seek a new measured response or a held-out robustness test.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish rhythmic steering
source_mechanism: separate slow persistent target-route correction from a bounded fast load-response residual placed on a useful state-derived half-cycle
transferable_invariant: target geometry owns steering direction while a normalized measured yaw response may qualify when a small rhythmic correction is applied
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, robot linkage geometry, clock phase, exact vortex phase, cylinder layouts, and prescribed routes
policy_translation: retain normalized body-frame phase-rejected course recovery on joint 2, and let adverse normalized yaw moment gate a bounded same-sign two-joint half-cycle only under closing target-line response deficit
falsification: reject on lost or slower capture, unchanged shallow-hook behavior, command chatter, wake incoherence, actuator contact, or peak force and yaw moment above the sampled regime

## Non-CFD audit after the policy edit

- All `63` direct `params.FIELD` names are owned by the `63` fields returned
  from `target_policy_params()`. The prescribed public-contract state returns
  two finite accelerations.
- A deterministic `6,000`-state stress grid spanning lateral reflections,
  beyond-limit angles and rates, helpful/adverse moments, and
  negative/zero/positive closing response remains finite and inside the
  `30 rad/T^2` policy envelope. Paired reflected states have zero command
  reflection error.
- Against the unmodified assigned-parent policy on a deterministic
  `15,360`-state mechanism grid, the candidate changes `2,048` command pairs,
  including `502` by more than `0.05 rad/T^2`; maximum separation is
  `0.54063 rad/T^2`, and candidate peak command is `29.88166 rad/T^2`. This
  establishes that the fast response block is material and bounded, not CFD
  evidence of improvement.
- The material-guidance, Julia public-contract/schema, and solver
  editable-boundary commands prescribed by `.codex/agents/check-runner.toml`
  all pass directly. The required check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this ChatGPT account, matching the
  inherited infrastructure limitation. No formal CFD was run.
