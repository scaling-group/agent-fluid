# Evidence-preserving multi-wake target-policy candidate

## Visual and metric diagnosis before candidate selection

- All four sampled solver examples are the same completed experiment: their
  policy, trajectory, and combined-keyframe SHA-256 hashes are identical. Each
  uses direct uniform quiescent initialization with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and 237 moving-window shifts. Each captures
  at `16.604496T`, with score `-0.1137286`, `1.998146L` scored distance
  integral, and `0.743958L` final/minimum distance. The four copies establish
  deterministic nominal repeatability, not four mechanisms or held-out
  robustness.
- I inspected the shared combined keyframe sheet from release through capture.
  The top-down row shows acceleration from rest and self-propelled left/down
  closure on a shallow target-crossing arc, with an alternating mid-plane wake
  attached to the moving tail. The oblique row independently shows finite,
  three-dimensional Lambda2 structures connected to the posterior body and
  traveled path. Neither view shows passive background advection, collision,
  wake breakup, a domain exit, or an instability precursor.
- The metrics agree with the images: the head crosses at
  `(9.691019,9.775620)L`; the final inertial velocity is
  `(-1.100098,-0.270060)U`; the final measured yaw rate is
  `2.238745 rad/T`; joint 2 has just left the `260 deg/T` speed limit; and the
  inherited summary reports bounded peak planar force/moment near
  `0.037165/0.018356`. These endpoint values are right-censored by
  first-crossing success and do not demonstrate post-capture instability.
- No informative failure sheet exists in this workspace: every sampled and
  inherited combined sheet is byte-identical to the successful one. The
  required visual comparison can therefore only establish that the failure
  contrast is unavailable; I do not invent one. Assigned-parent guidance and
  completed inherited logs provide the available negative controls. Terminal
  yaw release, posterior half-cycle relief, projected-corridor gating,
  line-of-sight or bearing-rate terms, moment residuals, extra curvature, and
  carrier-correlated local-flow subtraction retained finite or capturing wakes
  but worsened route cost, crossing depth, or approach. In particular, local-
  flow subtraction regressed the demonstrated
  `0.743958L/1.998146L/-0.113729` crossing/integral/score tuple to
  `0.745252L/1.999280L/-0.115121` without a feasibility benefit.
- The assigned parent records four consecutive completed evidence-preserving
  selections, so the structured bookshelf consultation is required. The
  shelf's traveling-wave, asymmetry, disturbance-residual, and approach-hold
  primitives either already exist in this controller or correspond to the
  completed negative controls. Consultation does not supply evidence for a
  scalar retune or for reacting to the final successful sample.

## Sole candidate and falsifiable hypothesis

Select the prefilled normalized body-frame two-joint controller byte-for-byte
as this workspace's exactly one candidate. It preserves the full posterior-lag
carrier, raw target geometry for the anterior center, mean-preserving yaw and
lateral-response demodulation, phase-compatible posterior steering, smooth
acceleration bounds, and the narrow one-sided joint-speed guard. No sibling,
dormant parameter, scalar-only gain change, or unevidenced terminal channel is
introduced.

The falsifiable nominal expectation is another capture with the connected
two-view wake and the demonstrated arrival, distance-integral, crossing-depth,
joint-feasibility, effort, force, and moment envelope. Reject this selection if
that nominal behavior fails to reproduce. Reopen one compact mechanism only
after a nonduplicate or held-out pose, target, or flow produces a pre-capture
miss, recession, wake loss, or repeatable directional-response error; do not
infer such a deficit merely from nonzero speed or yaw in the success frame.

bookshelf_consulted: true
source_domain: classical undulatory propulsion, closed-loop robotic-fish CPG modulation, wake-adaptive swimming, and terminal prey-capture control
source_mechanism: preserve a posterior-lag traveling carrier and add a bounded route, disturbance, or terminal modulation only for an observed response deficit
transferable_invariant: keep productive rhythmic propulsion separate from slow body-frame route feedback and require pre-capture behavioral evidence before recruiting a fast correction
nontransferable_details: published gains, species-specific kinematics, dimensional beat rates and speeds, exact vortex phases, capture thresholds, and task-specific routes
policy_translation: null translation for this candidate; retain the normalized response-demodulated two-joint controller because current evidence shows completed capture and no distinct error for another feedback channel
falsification: reject preservation if nominal capture or wake connectivity fails to reproduce, or if nonduplicate held-out evidence shows one bounded primitive improves a pre-capture deficit without worsening route cost, crossing depth, joint feasibility, effort, force, or moment

## Evidence boundary

All favorable and negative results above belong to completed sampled or
inherited rollouts. This workspace's candidate receives CFD evaluation only
after the worker exits, so no same-worker performance claim is made.
