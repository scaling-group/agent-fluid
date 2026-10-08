# Wake-policy candidate notes

## Evidence diagnosis before policy selection

- All four sampled solver policies have SHA-256
  `452903db94b971aed60f8a7830a0f2e19faebb59e44d73d0e428556cc7dc9781`,
  matching the prefilled candidate. Their combined keyframe sheets are also
  byte-identical. Each direct-uniform, zero-inflow rollout captures at
  `16.604496T`, crosses at `0.743958L`, has distance integral `1.998146L`, and
  scores `-0.113729`. The inherited optimizer score logs reproduce the same
  result through the three preceding completed selections.
- In the top-down row, the fish self-propels from release, turns continuously
  along the target-directed arc, and leaves an alternating wake that remains
  connected to the tail at the head crossing. The oblique row confirms finite,
  alternating three-dimensional Lambda2 structures rather than planar-only
  motion or background advection. The uniform-direct diagnostics and zero
  background velocity exclude a prewarm or imposed-flow explanation.
- The sampled set contains no failure example: it is four exact successful
  controls. The nearest informative changed comparison is therefore the
  inherited qualified terminal yaw-response release. It crossed one step
  earlier but regressed to `0.744276L`, distance integral `1.998380L`, and
  score `-0.114037`; other inherited closure, projected-corridor, moment, and
  local-flow residual interventions also failed to improve the carrier.
- Large instantaneous endpoint values are not a diagnosed miss here. At
  capture the control is still moving at `1.132762U`, with heading error
  `0.409227 rad` and yaw rate `2.238745 rad/T`, yet the planar head crosses the
  target successfully. Across the trace, the wake and motion remain finite;
  peak planar force and yaw moment are `0.037165` and `0.018356`, and the
  narrow speed guard keeps both joint speeds at the released `4.537856 rad/T`
  limit without removing reversal commands.

## Candidate hypothesis

Preserve the exact response-demodulated, speed-guarded controller as this
worker's single candidate. The current evidence identifies neither a failed
semantic class nor a held-out disturbance response that could falsifiably
select another observation or mechanism. In particular, do not reinterpret
the successful high-yaw crossing phase as a reason for terminal damping or
drive relief. This preservation choice is falsified by a completed held-out
pose, target, or flow rollout that exposes a repeatable response deficit, or
by a single bounded body-frame mechanism that improves that semantic result
without degrading nominal capture, route cost, crossing depth, wake
connectivity, joint feasibility, force, or moment.

bookshelf_consulted: true
source_domain: biological and robotic-fish terminal capture control
source_mechanism: far/middle/near scheduling with propulsion preservation and conditional near-target yaw or slip correction
transferable_invariant: separate the propulsive carrier from terminal correction, and recruit the latter only for an observed response deficit
nontransferable_details: published gains, species-specific kinematics, prescribed phases, task routes, and the shelf's generic near-target damping suggestion are not evidence for this first-crossing controller
policy_translation: screen the existing normalized body-frame bearing, course, crossflow, and demodulated-yaw channels for a terminal deficit; none is present, so add no channel and retain the exact two-joint feedback candidate
falsification: reopen one bounded terminal primitive only if held-out evidence shows a specific miss correlated with yaw or slip and the intervention preserves the demonstrated nominal approach and load envelope
