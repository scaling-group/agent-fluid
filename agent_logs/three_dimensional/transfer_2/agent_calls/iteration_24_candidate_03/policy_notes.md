# Evidence-selected predicted-miss corridor candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform still
  water (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the L64 inertial
  moving window.  Three byte-identical v39 samples capture at `24.678516T`,
  minimum/final distance `0.748602L`, mean scored distance `2.348208L`, and
  score `-0.448571249`.  The distinct v40 predicted-miss-corridor sample also
  captures, at `24.662014T`, `0.748606L`, `2.348173L`, and `-0.448570730`.
- The top-down and oblique sheets for v39 and v40 were inspected from release
  through capture.  Both begin wake-free, then show self-propelled diagonal
  progress, a coherent alternating mid-plane vortex street, compact
  three-dimensional Lambda2 structures, and the same bounded transverse hook
  into the target.  The routes and wake classes are visually indistinguishable;
  neither policy is passively advected, unstable, or escaping out of plane.
  No failed-rollout keyframe is sampled in this workspace, so the informative
  failure comparison remains the inherited audited follower-feedforward run:
  it retained a coherent wake but changed the far route by `8T`, missed at
  `0.993183L`, and exited left at `37.1470T` and `6.9973L`.
- V40 replaces terminal course-angle pursuit with a collision-corridor release:
  only the post-passage posterior course path and coupled course residual are
  tapered when constant-velocity projected miss is already safe.  Relative to
  v39 it first separates at `1.8461L`, leaves the established far route exact,
  captures three integration rows (`0.016502T`) earlier, improves mean scored
  distance by `0.00003436L`, and improves score by `0.000000519`.  It preserves
  zero sampled posterior hard-stop occupancy, essentially the same
  anterior/posterior exact-rate class (`9.233/4.862%` versus
  `9.294/4.858%`), and the same low peak body-force/yaw-moment class
  (`0.0229/0.0318/0.0157` versus `0.0233/0.0320/0.0156`).
- The difference is useful but not semantic.  Terminal course angle worsens
  slightly from `58.221` to `58.415 deg`, projected perpendicular miss grows
  from `0.63638` to `0.63771L`, final crossing margin changes by only
  `0.000004L`, and the visual trajectory is unchanged.  Thus the completed
  result supports the invariant that alignment feedback should release on a
  safe intercept, but it does not support tuning the corridor thresholds,
  claiming a new wake/route class, or treating course angle as the capture
  error.

## Policy hypothesis

Use the positively evaluated v40 policy as this workspace's one candidate.
Preserve its smooth, mirror-equivariant predicted-miss gate on the two existing
post-passage course paths while leaving the anterior phase anchor, lagged
posterior traveling wave, far route, steering-priority allocation, posterior
stroke reserve, and posterior coast unchanged.  This is evidence selection of
an already completed feedback mechanism, not a new scalar tune and not a claim
that its sub-milliscale score advantage generalizes.

Expected evidence is deterministic v40-family capture near `24.662T`, mean
distance no worse than `2.348174L`, score no worse than `-0.448571`, zero
posterior hard-stop occupancy, and the established coherent-wake, rate, and
low-load classes.  Falsify the selection if replication loses capture or the
small score/arrival advantage, changes commands outside `2.10L`, permits
projected miss to leave the safe corridor before capture, or regresses the
hard-stop, rate, raw-command, force, or moment class.  The new CFD evaluation
will occur only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish coupled oscillators and terminal interception control
source_mechanism: bounded sensory steering modulates a stable traveling-bend rhythm until the task-relevant intercept is safe, then releases without suppressing propulsion
transferable_invariant: preserve the anterior phase anchor and posterior traveling wave while normalized body-frame velocity projection, rather than body-course alignment alone, determines when terminal steering may withdraw
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact capture geometry, prescribed paths, vortex phases, Strouhal targets, and task-specific routes
policy_translation: select the evaluated v40 controller whose smooth predicted-miss gate tapers only the existing post-passage posterior and coupled course paths, without changing carrier or safety layers
falsification: reject if replication loses capture, established far-route noninterference, coherent wake, zero posterior hard-stop occupancy, or the low-load class, or if projected miss leaves the safe corridor before capture

## Pre-evaluation validation

- The single candidate is byte-identical to the completed v40 sample (LF
  SHA-256 `8122d88611c32f23241b9fe8c1f8f9e6f6e9430f3f014598a8f2f179d09efbeb`).
  This is evidence selection, not a same-worker CFD claim.
- The Julia public-contract probe returns exactly two finite accelerations
  (`-14.3858335`, `0.0005062`).  The schema audit resolves all `87` direct
  `params.FIELD` references among the `89` fields returned by
  `target_policy_params()`.
- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account.  Its three declared
  no-CFD checks were therefore executed directly and separately: reusable
  guidance semantics, the Julia policy contract, and the solver editable
  boundary all pass.  No formal CFD was run.
