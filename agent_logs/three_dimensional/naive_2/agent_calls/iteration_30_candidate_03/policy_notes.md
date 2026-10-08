# Plateau-aware selection of the replicated capture carrier

## Visual diagnosis before candidate selection

- All four sampled solver examples are the same completed result, not four
  controller comparisons: their candidate policies, trajectories, and
  combined keyframe sheets are byte-identical. Each starts from direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm; each
  captures at `16.604496T` with score `-0.1137286`, distance integral
  `1.998146L`, crossing distance `0.743958L`, and 237 moving-window shifts.
- I inspected the top-down vorticity and oblique Lambda2 rows of the shared
  combined sheet from release through capture. The fish accelerates from rest
  and travels left/down toward the target on a shallow curved route. The
  alternating mid-plane wake and compact tail-connected three-dimensional
  structures show self-propulsion rather than advection; there is no inherited
  wake, collision, boundary exit, wake breakup, or numerical instability.
- No visually distinct failure example exists in this workspace: all ten
  available sampled and inherited combined sheets and trajectories have the
  same respective hashes. The most informative negative comparison is
  therefore textual completed evidence in the assigned-parent guidance and
  inherited optimizer notes, not a fabricated image contrast. It records that
  terminal yaw release, posterior relief, projected-corridor gating,
  line-of-sight-rate feedforward, bearing or moment residualization, and local-
  flow phase subtraction retained finite or capturing behavior but worsened
  target cost. The local-flow residual, for example, held arrival fixed while
  regressing score/integral/crossing depth from
  `-0.113729/1.998146L/0.743958L` to
  `-0.115121/1.999280L/0.745252L`, without a feasibility or load benefit.
- The current trajectory cross-check agrees with the visual diagnosis: distance
  falls from `12.3277L` to capture, final head position is
  `(9.6910,9.7756)L`, and the recorded peak planar force component and yaw
  moment remain about `0.0290` and `0.01836` in their normalized units. Joint
  speeds reach the released `260 deg/T` envelope, supporting preservation of
  the incumbent's narrow one-sided speed guard rather than another carrier
  gain change.

## Sole candidate and falsifiable policy hypothesis

Select the prefilled normalized body-frame controller byte-for-byte as the one
multi-wake target-policy candidate in `solver/`. It preserves the demonstrated
full traveling-wave carrier, raw target geometry and anterior course center,
mean-preserving joint-phase demodulation of body yaw and lateral response,
unmodified relative-crossflow feedback, posterior phase-compatible steering,
smooth acceleration bounding, and final-one-percent outward speed guard.

This is a controlled negative selection rather than a same-worker improvement
claim. After at least three completed conservative selections and multiple
changed-controller regressions, the available nominal evidence identifies no
remaining response deficit that distinguishes a new bounded feedback channel.
The next evaluation should reproduce capture, the two-view connected wake,
`16.604496T` arrival, `1.998146L` distance integral, `0.743958L` crossing,
and the sampled joint/action/load envelope. Falsify preservation if nominal
replication fails; reopen one mechanism only when a completed nonduplicate or
held-out rollout exposes a specific directional, disturbance, or feasibility
deficit that the incumbent does not handle.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion, sensor-modulated robotic-fish CPG direction tracking, asymmetric flapping, and wake-interaction control
source_mechanism: preserve a productive rhythmic carrier and separate it from bounded route or disturbance feedback, adding a channel only for an independently observed response deficit
transferable_invariant: carrier-correlated lateral motion is not itself an error; when a state-feedback traveling wave captures and multiple distinct perturbations preserve wake class but worsen target cost without improving feasibility or loads, retain the carrier until nonduplicate evidence identifies a deficit
nontransferable_details: published gains, dimensional frequency or speed, species and robot kinematics, exact vortex phases, fitted coefficients from other gaits, capture thresholds, and source-task routes
policy_translation: retain the evaluated two-joint body-frame carrier and its demonstrated response separation; do not adopt a new primitive or scalar retune because the current direct-still-water samples collapse to one successful trajectory and inherited mechanism tests regress it
falsification: reopen one compact state-feedback primitive only if a completed nonduplicate or held-out trajectory isolates a repeatable deficit and the translation improves capture or route cost while preserving wake connectivity, joint feasibility, effort, force, and moment

## Evidence boundary

No CFD result is claimed for this workspace's candidate. Favorable values are
from the four completed sampled rollouts; changed-controller negative results
are inherited completed evidence. Exact nominal repetitions establish
determinism only, not robustness to another initial pose, target, or flow.
