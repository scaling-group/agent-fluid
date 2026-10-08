# Phase-selective stroke-recovery candidate

## Evidence diagnosis before the policy edit

- All four current sampled rollouts satisfy the frozen evidence contract:
  direct uniform still-water initialization with `U_infinity=[0,0,0]`, no
  cylinders or prewarm snapshot, finite dynamics, and moving-window transport.
  Three byte-identical course-preview policies capture at `24.5795T` and
  `0.74697L`; this replication is the strongest finite evidence, not three
  independent controller mechanisms.
- Both visual rows were inspected for a replicated course-preview capture, the
  prefilled stroke-aware capture, and the inherited steering-priority upper
  exit.  The top-down vorticity sheets show self-propelled, coherent alternating
  wakes on the common early diagonal.  The inherited failure approaches to
  `1.07599L`, pivots sharply after passage, and carries its wake into an upper
  boundary exit at `37.823T`; the successful course-preview trajectories bend
  before that late pivot and cross the capture circle near `24.6T`.  The
  oblique body/Lambda2 sheets retain compact three-dimensional wake structures
  through both the successful redirect and the failed late turn, so wake
  breakup or passive advection is not the missing control capability.
- The prefilled stroke-aware child preserves capture but is slightly slower and
  lower scoring than the replicated course-preview parent: `24.6180T` versus
  `24.5795T`, mean distance `2.36225L` versus `2.36044L`, and score
  `-0.462756` versus `-0.460673`.  That small scalar loss accompanies a large
  physical improvement: posterior hard-limit occupancy falls from `23.38%` to
  `12.60%`, and peak absolute body-frame force coefficients and yaw-moment
  coefficient fall from `0.269/0.178/0.143` to `0.165/0.118/0.089`.
  Raw acceleration-envelope exposure (`72.84%` to `72.65%`) and joint-rate
  exposure (`15.15%` to `15.10%`) are essentially unchanged.  The evidence
  therefore supports the proprioceptive stroke guard but does not support
  stronger scalar relief or claiming that it solved command saturation.
- The assigned-parent note attributes semantic capture to a body-frame
  translational-course preview that is dormant outside `6.5L`, starts on the
  inherited trajectory at `13.442T`, and releases with lost closing progress.
  It explicitly warns that capture margin is only about `0.003L`.  Preserve
  that route mechanism and the prefilled guard's stalled/outward behavior.

## Policy hypothesis

Retain the prefilled stroke-aware course-preview controller and change only the
posterior guard's beat-phase allocation.  Normalize inward posterior joint
speed by the state-feedback carrier's natural angle-rate scale.  When the joint
is near its stroke boundary and steering pushes farther outward, keep the
evaluated relief fully active while the joint is stalled or moving outward;
continuously return steering priority only as measured joint motion carries the
tail inward.  This uses proprioceptive joint angle and velocity, preserves the
course-preview request and all far-field behavior, and does not increase the
existing steering or acceleration bounds.

Falsification: reject the phase-selective release if formal CFD loses capture,
changes the established far diagonal or preview timing, raises posterior
hard-limit occupancy above the prefilled `12.60%`, or returns peak force/moment
to the replicated parent's `0.269/0.178/0.143` class.  A useful result should
retain capture and the reduced-load class while recovering some of the
prefilled child's small arrival/mean-distance penalty.  Raw-command exposure
must be assessed separately because this mechanism is not output clipping.

## Bookshelf protocol

The mandatory three-consecutive-stagnant-iterations trigger is not met: the
immediately preceding completed iterations introduced course-preview semantic
capture and then a distinct stroke-aware allocator that retained capture while
materially reducing hard-limit loads.  The shelf was nevertheless consulted
under the requested protocol, and its phase-aware, sensor-modulated rhythmic
control invariant informed this structural edit; it is not being used to
justify a scalar-only gain change.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric-flapping CPG control with sensor-feedback direction tracking
source_mechanism: modulate bounded steering within the observed propulsion half-cycle and return authority continuously when proprioceptive response moves the actuator away from constraint
transferable_invariant: use measured rhythmic state to withdraw only the control allocation that reinforces an active constraint, while preserving the complementary recovery phase and propulsive carrier
nontransferable_details: published gains, dimensional cadence, motor model, duty ratio, full-body gait, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: normalize posterior joint angle and inward joint velocity by owned carrier scales, keep stroke relief active for stalled or outward motion, and blend it back toward the evaluated steering-priority allocation only during observed inward recovery
falsification: reject if capture is lost, the far course changes, hard-limit occupancy rises above the stroke-aware parent, or peak force and yaw moment return to the unguarded capture class

## Pre-evaluation checks

- All direct `params.FIELD` references resolve among the `84` fields returned
  by `target_policy_params()`, and the prescribed public-contract state returns
  two finite accelerations.
- A `972`-state deterministic grid spanning target distance and lateral side,
  bearing, translational velocity, posterior angle, and posterior rate is
  finite.  Fixed-state comparison is exactly identical to the evaluated v28
  parent below the `36 deg` guard boundary.  Mirrored near-boundary probes are
  exactly identical to v28 when stalled or moving outward and interpolate
  strictly between v28 relief and the original allocation during inward
  recovery.
- The reusable-guidance semantic check and solver editable-boundary audit
  pass.  The rendered README initially duplicated the same assigned-parent
  marker documented in the inherited logs; deleting only the duplicate
  repaired parent selection.  The configured check-runner was invoked, but its
  pinned `gpt-5.4-mini` model is unsupported on this account, so its three
  prescribed commands were run directly and separately.  No formal CFD was
  run.
