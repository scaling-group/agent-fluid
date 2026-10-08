# Narrow alignment-turnaround release candidate

## Evidence diagnosis before the edit

- Every sampled rollout satisfies the Phase 2 contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  dynamics, and capture at about `16.0545T` after 2,919 steps and 239 moving-
  window shifts. There is no failure-class sample in this workspace, so the
  useful contrast is the best distinct capture against the repeated assigned-
  parent capture and the inherited active-damping negative result.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the assigned parent, the best sampled alignment-turnaround release, and
  the inherited terminal yaw-damping sibling. In all three, the initially
  quiescent flow develops a spatially trailing alternating wake by `3-4T`;
  the fish self-propels along the same finite target-directed arc, and compact
  three-dimensional caudal structures remain coherent through capture. There
  is no visible passive advection, wake collapse, collision, virtual exit, or
  numerical breakup. The rendered cadence does not distinguish the terminal
  variants, so it supports preserving the carrier and cruise route rather
  than changing propulsion.
- Diagnostics resolve the terminal differences. The assigned-parent
  alignment-escape policy is reproduced twice at final distance
  `0.746952891L`, distance integral `1.930771544L`, and score `-0.048053160`.
  The small-bearing alignment-turnaround release preserves the same capture
  time and all visible wake structure while improving final distance to
  `0.746211886L`, distance integral to `1.930147117L`, and score to
  `-0.047280745`. It is the only sampled policy with a meaningfully different
  terminal crossing.
- The inherited active terminal yaw-damping sibling is a useful negative
  control. A `2 deg` posterior counter-curvature gated by windowed bearing
  reopening retains capture at `16.0545T`, but regresses to final distance
  `0.746960163L`, distance integral `1.930777800L`, and score `-0.048060870`.
  Thus the large terminal yaw and reopening bearing do not establish the
  phase/sign of a helpful new posterior action; active damping is unsupported
  even though the wake remains coherent.
- Trace reconstruction in the inherited notes localizes the supported
  opportunity: body-frame bearing crosses zero near `0.86L` and then reopens,
  while the carrier-residual yaw correction remains active. The best sampled
  mechanism removes only that supplemental mean curvature inside a smooth
  small-bearing cone and restores it as unresolved bearing grows. This is a
  response-allocation change, not scalar carrier tuning.

## Policy hypothesis

Promote the best sampled narrow alignment-turnaround release as the sole
candidate change from the assigned parent. Preserve the oscillator, base
target/course redirect, posterior traveling wave, one-sided wave relief,
approach law, acceleration allocation, and exact speed-limit projection.
During a closing approach, use instantaneous bearing rate normalized by the
joint-state carrier frequency to detect growth of absolute body-frame bearing;
inside a smooth small-bearing cone, release only supplemental carrier-residual
yaw curvature. Keep the existing corridor-and-measured-yaw release in
parallel. The supplemental branch returns continuously outside the cone, so a
large unresolved turn cannot coast.

The prior closed-loop result supports retained capture, milestones, and wake
coherence plus a deeper crossing than the assigned parent. Falsify the
candidate if it fails deterministic reproduction, changes the pre-approach
route, delays or loses capture, weakens either wake view, persists at large
bearing, or regresses distance integral, crossing distance, limiting, or
loads. This worker does not claim the post-exit evaluation as evidence.

bookshelf_consulted: true
source_domain: biological burst redirects, robotic-fish sensor-modulated CPG direction tracking, and terminal capture control
source_mechanism: retain a rhythmic locomotor carrier, add bounded response feedback, and release supplemental turning authority when measured alignment shows the correction has become counterproductive
transferable_invariant: separate productive traveling-wave propulsion and base route steering from a bounded response correction that can release continuously on normalized body-frame alignment evidence
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact vortex phases, full-body waveforms, capture geometry, and task-specific routes
policy_translation: use body-frame bearing, bearing rate normalized by carrier frequency, target distance, and closing response to taper only supplemental posterior yaw-residual curvature within a smooth alignment cone under the two-joint acceleration contract
falsification: reject if cruise milestones or two-view wake coherence change, capture is delayed or lost, release persists for a large bearing error, or terminal distance, integral, limiting, or loads regress

## Non-CFD verification

- The candidate SHA-256 is
  `2bbbe01212171be1bb516f5d66fba104f83eedc31ab8e0835d99f9d48f8e960a`,
  byte-identical to the strongest sampled alignment-turnaround policy.
- The dedicated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. After repairing the inherited duplicate
  assigned-parent marker in the rendered workspace `README.md`, its three
  prescribed commands were run directly and separately: the material-guidance
  check, lightweight policy contract/schema check, and solver editable-boundary
  check all pass.
- No formal CFD was run. The next evaluation remains the required independent
  reproduction test for the prior closed-loop evidence.
