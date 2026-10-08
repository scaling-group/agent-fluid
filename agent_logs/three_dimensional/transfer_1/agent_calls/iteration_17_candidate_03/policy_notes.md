# Closing-response arbitration candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and `capture` termination.  Three functionally
  identical bidirectional-allocation policies reproduce capture at
  `18.765995 T`, score `-0.170272`, and distance integral `2.058347 L`.  The
  closing-response carrier-release comparator without reverse allocation
  captures at `18.754995 T`, score `-0.171145`, and distance integral
  `2.058863 L`.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows of the
  combined sheets for a reproduced bidirectional result and the one-way
  comparator from release through capture.  Both visibly self-propel along
  the same smooth target-directed arc from quiescent water.  Both form compact
  startup structures followed by a coherent alternating mid-plane wake and
  organized three-dimensional posterior structures.  Neither shows passive
  advection, wake collapse, collision, domain exit, or instability, and the
  sheets do not support a qualitative wake or route advantage for reverse
  allocation.
- The scalar preference for the combined policy is a terminal-sampling
  tradeoff, not a semantic route improvement.  Relative to closing-response
  release alone, the combined policy is farther away by
  `0.000015/0.003108/0.017821 L` at `8/12/16 T`, arrives `0.011 T` later, and
  has a worse observed distance integral (`1.451295` versus `1.450369 L`).
  Its deeper final discrete crossing (`0.747288` versus `0.748961 L`) reduces
  the terminal-hold contribution enough to improve total score and total
  integral.  Reverse allocation also lowers maximum speed from `0.9492` to
  `0.9402 L/T` and any-joint acceleration-limit residence from `41.96%` to
  `41.35%`, while both runs retain the same `0.03068/0.01565` peak normalized
  force/moment envelope.  It is therefore a mild regularizer in this stack,
  not evidenced closure authority.
- The inherited whole-wave route-rate projection is the informative semantic
  failure.  Its direct-uniform rollout forms an organized three-dimensional
  wake, but the top-down sheet shows a wrong-sign upward turn becoming nearly
  vertical rather than a target approach; it exits the domain at `8.4755 T`
  after improving only to `12.2107 L` and ends at `12.7296 L`.  The failure is
  controlled self-propulsion along the wrong route, not advection or numerical
  instability.  This candidate therefore preserves the validated head-only
  route-rate correction and does not revive fitted whole-wave rate rejection.
- The assigned parent's reverse allocation remains a valid single-change
  result on the slower v30 base: inherited logs report capture at `18.8705 T`,
  score `-0.18102`, and integral `2.06891 L`, improving v30 at `18.9970 T`,
  `-0.18597`, and `2.07455 L`.  The new sampled comparison shows that this
  benefit is not additive after positive-closing response already releases
  turn-relieved carrier cadence.
- A frozen-state reconstruction on the reproduced combined trace activates
  reverse allocation on `200/3412` states (`5.86%`), including `93` after
  `16 T`.  Every active state has productive-closing response above `0.9`,
  with mean `0.999972`; none occupies weak or nonpositive closure.  This audit
  locates the overlap between the two mechanisms but is not closed-loop CFD.

## One-candidate policy hypothesis

Preserve the sampled state-feedback traveling wave, posterior lag, raw
large-error redirect, mean-preserving whole-wave route projection, head-only
route-rate correction, raw half-cycle steering, closing-response carrier
release, approach scheduling, carrier-first allocation, and physical bounds.
Arbitrate only the reverse allocation path: recover posterior-rejected target
steering into anterior headroom in proportion to the complement of productive
normalized closure.  As useful closure appears and turn-relieved cadence is
restored, reverse recovery continuously yields; at weak or nonpositive
closure it remains available.  Head-to-tail recovery is unchanged, and no
rhythmic carrier demand crosses joints.

The expected result is to retain capture and the coherent target-directed wake
while recovering the one-way comparator's earlier middle/late approach and
avoiding simultaneous extra steering and restored cadence.  Falsify the
mechanism if capture is lost or later than `18.754995 T`, observed distance
integral exceeds `1.450369 L`, middle/late closure regresses, the arc or wake
changes qualitatively, or speed, limit residence, normalized force, or moment
materially exceeds `0.9492/41.96%/0.03068/0.01565` without compensating
progress.  Interpret a small scalar change separately from arrival and the
observed integral because the final discrete threshold sample affects the
terminal-hold score.

```text
bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish CPG control
source_mechanism: extra turning authority yields to renewed posterior propulsion after observed useful target response
transferable_invariant: separate target steering from rhythmic propulsion and arbitrate them with normalized measured response rather than applying both recovery paths at full authority
nontransferable_details: published gains, species burst timing, clocked CPG phase, linkage geometry, duty ratio, dimensional cadence, exact vortex phase, full-body kinematics, and prescribed routes
policy_translation: multiply only posterior-rejected steering returned to the anterior joint by the complement of bounded positive closing response, while preserving body-frame geometry, carrier-first composition, and the existing two-joint bounds
falsification: reject if capture or middle/late closure regresses, the target-directed wake changes, or speed, saturation, normalized force, or yaw moment rises without compensating progress
```

## Evidence boundary

All numerical and visual outcome claims above come from completed sampled CFD,
the assigned parent, and inherited optimizer logs.  This response-arbitrated
candidate receives formal CFD only after worker exit, so no same-worker
improvement is claimed.

## No-CFD implementation audit

- The deterministic schema audit finds all `60` directly referenced parameter
  names among the `62` fields returned by `target_policy_params()`.
- Replaying the policy algebra over all `3412` reconstructed states from a
  completed combined trace produces finite commands within the unchanged
  componentwise acceleration limit.  The posterior command is identical to
  the prefill throughout.  On the `200` states where the prefill's reverse
  path is active, the candidate reduces its largest anterior deviation from
  the one-way controller from `1.19019` to `0.000158 rad/T^2`, consistent with
  the near-unit productive-closing response.  This verifies targeting and
  envelope preservation only; it is not a closed-loop outcome.
