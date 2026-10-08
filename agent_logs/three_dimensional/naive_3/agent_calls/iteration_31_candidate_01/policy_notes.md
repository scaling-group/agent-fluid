# Wake-policy candidate notes

## Evidence diagnosis

All four sampled rollouts satisfy the direct-uniform still-water contract
(`U_infinity=0`, no prewarm) and terminate in capture.  In both rows of the
combined sheets, the fish advances under its own traveling bend: the top-down
views retain alternating signed vorticity through the target approach, and the
oblique views retain compact three-dimensional Lambda2 structures rather than
showing passive advection.  This agrees with the diagnostics: peak local flow
is only `0.031--0.033U` while peak fish speed is `1.374--1.392U`.

The duplicated bidirectional work-reallocation baseline captures at `16.988T`
with score `-0.204764` and mean distance `2.08931L`.  A joint-phase-only
counter-yaw selector improves only slightly (`16.965T`, `-0.204466`,
`2.08904L`).  The assigned parent instead gates extra anterior work by measured
target-opposed yaw moment and is the strongest sample (`16.932T`, `-0.200045`,
`2.08513L`).  Its improvement is small but semantic and repeatable against two
identical baseline samples.  It also raises peak force/moment from
`0.03634/0.01804` to `0.03693/0.01835` and posterior angle from `0.5700` to
`0.5992 rad`, so simply increasing the boost is not supported.

## Policy hypothesis

Preserve the zero-centered anterior oscillator, posterior traveling carrier,
course-error steering, acceleration reserve, soft envelope, paired speed-work
reallocation, and stopping-margin barrier.  Materially change only the
adverse-yaw residual: extra posterior-to-anterior work must now be confirmed by
both target-opposed measured moment and target-opposed measured body yaw rate.
The existing speed-block, receiver-headroom, positive-work, and target-aligned
receiver gates remain in series.  This response-confirmed residual should keep
the parent's useful corrective impulses while rejecting oscillatory moment
peaks that have not produced adverse body rotation.

Falsify the candidate if it loses capture, does not improve the parent's
`16.932T/-0.200045/2.08513L` arrival-score-distance combination, loses either
view's coherent wake, or exceeds the parent's `0.03693/0.01835` load peaks,
`0.5992 rad` posterior excursion, or sampled sublimit joint speeds.

bookshelf_consulted: true
source_domain: Wake-interaction disturbance rejection and sensor-modulated robotic-fish CPG control.
source_mechanism: Separate the slow route request from a small fast feedback residual, and modulate rhythmic work only when sensed load produces the unwanted body response.
transferable_invariant: Correct only target-opposed hydrodynamic yaw that is accompanied by target-opposed body rotation while preserving the propulsive rhythm.
nontransferable_details: Published gains, species or robot kinematics, dimensional frequencies, exact vortex phase, cylinder-wake synchronization, and task-specific routes.
policy_translation: Use normalized body-frame target/course error for the slow turn request and the product of normalized `moment_z_L2` and `heading_rate` gates for the fast residual; apply it only to already available phase-local posterior-to-anterior work.
falsification: Reject if capture, score, mean distance, wake coherence, sublimit speed viability, or load/angle envelopes regress relative to the assigned parent.
