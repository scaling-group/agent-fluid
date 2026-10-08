# Predicted-miss corridor course-allocation candidate

## Visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  still water (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the L64
  inertial moving window.  Every sample captures near `24.67T`; three v38
  samples are byte-identical and the distinct v39 sample is the best finite
  score at `-0.448571`.
- Both rows of the v38 and v39 combined sheets were inspected from release to
  capture.  Their top-down rows show wake-free release, self-propelled diagonal
  progress, a coherent alternating mid-plane vortex street, and the same
  compact final hook into the disk.  Their oblique rows retain compact
  three-dimensional Lambda2 structures through capture.  The sheets are
  visibly indistinguishable, so v39 is not a new wake or route class.  No
  failed-rollout keyframe is present in the current sample; the informative
  failure comparison is therefore limited to inherited audited evidence: the
  reference-velocity follower retained a coherent 3D wake but changed the far
  route by `8T`, passed at `0.993183L`, and exited left at `37.1470T` and
  `6.9973L`.
- V39 adds the existing body-frame velocity-course error to the coupled turn
  channel inside `2.10L`.  Relative to v38 it improves final course angle only
  from `58.834` to `58.221 deg`, predicted perpendicular miss from `0.64059`
  to `0.63638L`, mean scored distance from `2.348228` to `2.348208L`, and
  score by `0.000039`.  It arrives one control tick later (`24.6785T` versus
  `24.6730T`); near-range mean absolute course error stays `0.757`, visible
  trajectory and wake class do not change, posterior hard-stop occupancy
  remains zero, total exact-rate exposure stays about `13.9%`, and peak planar
  force/yaw-moment coefficients remain near `0.026/0.032/0.0156`.
- The terminal angle is not itself a failure: the fish captures while moving
  transversely because final projected miss is already below the `0.75L`
  capture radius.  Three completed nonsemantic/regressive iterations (v36
  sign veto, terminal carrier hold, and v38 course bridge) trigger bookshelf
  consultation.  Together with v39 they show that continuing to drive course
  angle toward zero is the wrong terminal error definition, while widespread
  gait corrections remain unsafe.

## Policy hypothesis

Start from the evaluated v39 allocation, but introduce one collision-corridor
mechanism.  Compute signed constant-velocity perpendicular miss as normalized
range times the already bounded body-frame course cross product.  Smoothly
admit both the post-passage posterior course bridge and v39's coupled-turn
residual only while that predicted miss lies outside an owned `0.60--0.90L`
corridor.  When projection is safely inside the corridor, return continuously
toward the evaluated v35 release behavior; do not change the anterior phase
anchor, posterior lag, carrier cadence, far route, steering bounds, stroke
reserve, or posterior coast.

This changes the semantic objective from terminal alignment to collision-course
maintenance.  Expected evidence is exact far-route noninterference, fewer
unnecessary terminal course corrections once projected miss is safe, retained
capture and coherent wake, and no regression in arrival, crossing margin,
hard-stop, rate, acceleration, force, or moment class.  Reject the mechanism
if it loses capture, alters any command outside `2.10L`, permits predicted miss
to grow after entering the corridor, or merely recreates the same always-on
course response without reducing its active terminal support.  The new CFD
outcome is not available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish coupled oscillators and terminal interception control
source_mechanism: bounded sensory direction feedback modulates a stable traveling-bend rhythm while the task-relevant interception error, rather than prescribed alignment, determines release
transferable_invariant: preserve the anterior phase anchor and posterior traveling wave; continue signed target steering only while normalized body-frame velocity projection predicts a lateral miss outside a safe corridor
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact capture geometry, prescribed paths, vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain v39's bounded posterior and coupled course paths, multiply only their post-passage support by a smooth gate on signed predicted miss magnitude, and leave all far-field carrier and safety layers unchanged
falsification: reject if capture, the established far route, coherent wake, zero posterior hard-stop occupancy, or low-load class is lost, or if the gate fails to reduce course support after projected miss enters the corridor

## Pre-evaluation validation

- A pure-function replay on all `4487` completed v39 states returns finite
  commands.  Relative to v39 it changes `269` state outputs, first at
  `22.2640T` and `1.85065L`, with no change at or beyond `2.10L`; maximum
  same-state acceleration difference is `5.7912 rad/T^2`, below the owned
  `31.416 rad/T^2` envelope.  This is a locality/materiality audit, not a
  coupled hydrodynamic result.
- On the same trace, the corridor reduces the reconstructed coupled residual's
  active support from `443` to `363` rows and its summed absolute request from
  `80.427` to `47.538`; at the final sampled state, predicted miss is
  `0.63638L`, corridor weight is `0.1213`, and residual magnitude falls from
  `0.34555` to `0.03151`.  This confirms that the edit does more than rename or
  retune an always-on gain while preserving the full response outside the
  corridor.
- Across sampled reflected observation pairs, signed predicted miss and the
  new raw residual are mirror-odd to machine precision, while the corridor
  gate is mirror-even.  The Julia public-contract probe returns two finite
  accelerations, and all `87` direct `params.FIELD` references resolve among
  the `89` fields returned by `target_policy_params()`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD checks were run
  directly and separately and all pass: reusable-guidance semantics, the Julia
  public contract, and the solver editable boundary.  No formal CFD is run by
  this worker.
