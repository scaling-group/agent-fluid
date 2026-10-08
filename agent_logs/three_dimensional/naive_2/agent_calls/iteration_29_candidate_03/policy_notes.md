# Evidence-constrained multi-wake carrier preservation

## Visual diagnosis before candidate selection

- The four sampled solvers have byte-identical candidate policies,
  trajectories, and combined keyframe sheets. Each reports direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, finite moving-window dynamics, and capture. Each reaches
  `0.743958L` at `16.604496T`, with score `-0.1137286`, scored distance
  integral `1.998146L`, and 237 moving-window shifts. The assigned parent's
  completed rollout is the same behavioral result, so the repetitions show
  nominal determinism rather than population diversity or held-out robustness.
- I inspected both rows of the shared combined sheet from release through
  capture. The top-down vorticity row shows acceleration from rest, persistent
  left/down target closure on a shallow arc, and a coherent alternating wake;
  the oblique Lambda2 row shows compact alternating three-dimensional
  structures connected to the posterior body and traveled path. The fish is
  self-propelled rather than advected, and there is no inherited wake, wake
  breakup, collision, boundary exit, or numerical instability.
- No sampled failure keyframe exists in this workspace: all available sampled
  and inherited evaluation sheets have the same successful image hash. The
  informative changed-controller contrasts therefore come from completed
  inherited optimizer evidence. Closure-qualified terminal yaw release kept
  the same visible wake class and arrived one `0.0055T` step earlier, but
  regressed to score/integral/crossing depth
  `-0.1140375/1.998380L/0.744276L`. Carrier-correlated local-flow subtraction
  also retained capture and wake class but regressed to
  `-0.115121/1.999280L/0.745252L`, without a feasibility benefit.
- Direct trajectory cross-checks leave no distinct nominal route defect for a
  new primitive. The sampled head path is `12.7652L` versus `12.3277L`
  straight-line head-to-target distance, only `3.55%` excess, and distance
  increases on only `1.86%` of steps. Peak planar force and yaw moment remain
  `0.037165/0.018356`, and both joints contact the `4.537856 rad/T` speed
  limit; however, inherited controlled evidence already shows that the narrow
  one-sided speed guard improves route cost and loads, whereas broader carrier
  or terminal relief does not.

## Sole candidate and falsifiable hypothesis

Keep the prefilled normalized body-frame two-joint policy byte-for-byte. It is
the sole target-policy candidate in `solver/` and preserves the productive
anterior traveling carrier, raw target geometry and anterior course center,
mean-preserving yaw and lateral-response demodulation, unmodified relative
crossflow feedback, phase-compatible posterior half-cycle steering, smooth
acceleration bound, and final-one-percent one-sided speed guard.

The policy hypothesis is preservation, not a same-worker CFD improvement
claim: with no observed semantic, route, disturbance, or feasibility deficit,
another terminal gate, correlated-signal subtraction, phase modulation, or
scalar-only gain edit has lower evidential support than the exact completed
carrier. Expected evaluation is capture with the connected two-view wake near
`16.604496T`, distance integral `1.998146L`, crossing depth `0.743958L`, and
the sampled joint/action/load envelope. Falsify preservation if the exact
policy and fixed configuration fail to reproduce those quantities, or if a
later completed held-out or meaningfully different trajectory exposes a
repeatable response deficit that one bounded mechanism can isolate.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion, closed-loop robotic-fish CPG direction tracking, asymmetric flapping, and wake-interaction control
source_mechanism: preserve a productive rhythmic carrier and add or remove a separate bounded route or disturbance channel only for an independently observed response deficit
transferable_invariant: a replication plateau or carrier-correlated motion is not itself a control error; preserve the traveling wave unless a changed feedback channel improves target semantics or cost without damaging propulsion or feasibility
nontransferable_details: published gains, dimensional beat frequencies, species or robot kinematics, exact vortex phases, fitted coefficients from another gait, capture thresholds, and task-specific routes
policy_translation: retain the evaluated normalized body-frame two-joint controller exactly; the current direct-still-water captures and inherited changed-controller regressions do not identify a distinct deficit for another primitive or scalar edit
falsification: reopen the architecture only after completed evidence isolates a repeatable semantic or response deficit, and reject its bounded translation if capture, wake connectivity, route cost, joint feasibility, effort, force, moment, or score worsens

## Evaluation boundary

No CFD result is claimed for this workspace's candidate. Favorable evidence
belongs to completed sampled and assigned-parent rollouts; changed-controller
negative results belong to inherited logs. Later workers should treat another
exact nominal rollout as the same behavioral result, not as robustness or a
new positive mechanism.
