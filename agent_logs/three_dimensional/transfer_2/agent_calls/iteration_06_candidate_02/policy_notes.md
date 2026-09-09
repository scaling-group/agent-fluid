# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts and both inherited evaluated logs use direct
  uniform still-water initialization at `U_infinity=(0,0,0)`, with no
  cylinders or prewarm. Their motion and wakes are self-generated rather than
  ambient advection or a moving-window artifact.
- The top-down and oblique rows for the compact controllers show a persistent
  alternating mid-plane street and organized three-dimensional Lambda2
  structures. The strongest-score sample, `solver_b6bb94d9cdaf`, self-propels
  from `12.3277L` to `5.3570L`, but its center climbs to `15.2024L` and exits
  the upper boundary. `solver_59bc4ebdddec` preserves the same wake but its
  short-window response-release rule exits above the target after reaching
  only `7.5311L`. These runs support retaining the traveling-bend carrier and
  reject beat-scale response release as persistent course control.
- The prefill, `solver_ae0c621b2f7d`, is the most useful sampled trajectory
  despite its lower scalar score. Aligning both anterior and posterior
  steering signs preserves the coherent wake and improves closest approach to
  `2.5794L`. At that closest point (`19.8825T`), the head is
  `(8.6518,12.0558)L`, so the fish passes about `2.56L` above a nearly
  x-aligned target. It then continues past the target and leaves the left
  boundary at center `(0.7946,10.3816)L`, with final distance `8.7363L`.
  Thus the new sign is a real semantic improvement, but the remaining failure
  is lateral course correction and post-pass steering rather than propulsion.
- In that prefill, folded bearing and complete line of sight are both about
  `-1.32 rad` at the closest pass, and the current turn request is already
  saturated; the near miss is not caused by a weak instantaneous abeam signal.
  The yaw-rate brake nevertheless saturates with alternating signs earlier:
  at `2T` and `4T`, small bearings of `+0.05` and `-0.05 rad` become almost
  full opposite turn commands because recent yaw rates are `+1.86` and
  `-3.14 rad/T`. After the pass, folded bearing loses fore/aft information:
  at `28T` it is only `-0.285 rad` versus a normalized LOS aim of `-1.230 rad`,
  and the positive yaw-rate brake reverses the total command to `-0.421` even
  though geometry requests the other turn. This makes beat-scale body yaw own
  a route variable and weakens recovery. The rollout reaches maximum speed
  `1.084`, and joint-speed residence above 95% of the envelope is about 17%
  on each joint; any new steering law must not worsen those histories.
- The inherited full-LOS/speed-gated candidate `solver_2cea616ae897` does not
  validate LOS steering by itself: its posterior mean bend and anterior
  steering acceleration had opposing effective signs, both visual rows show
  an early upward curl, and it exits after `8.646T` with only `11.8989L`
  closest approach. The inherited instantaneous course-vector controller
  likewise curls upward before developing useful translation. These are
  concrete negative controls against reusing a conflicted actuator map or
  normalizing beat-scale velocity into a route direction.
- The complex 2D transfer `solver_e699ec5c28f1` develops a coherent wake and
  initially approaches the target, but turns to the lower boundary and
  requests acceleration beyond the physical envelope on about 73%/79% of
  rows. Its branch stack and raw authority are not a safe base for the next
  mechanism.

## Policy hypothesis

Preserve the prefill's joint-state oscillator, posterior lag, smooth command
bounds, and newly evidenced aligned anterior/posterior curvature sign. Replace
the folded bearing plus recent-yaw-rate brake with one persistent geometric
request: the complete target direction from normalized `target_body_L`, with
negative body x treated as forward and a small positive forward floor for the
directly-aft ambiguity. Map the bounded signed line-of-sight angle through the
same aligned mean-curvature actuator. Do not normalize velocity into a course
direction and do not let a beat-scale derivative reverse route steering.

Expected result: retain the organized traveling wake and early progress, but
build more downward cycle-mean curvature before the abeam pass and continue a
consistent recovery request if the target moves behind. A useful result must
improve the `2.5794L` closest approach or termination class without increasing
joint-speed residence, command-limit residence, or force/moment loads. Reject
the mechanism if it recreates the inherited early upward curl, still passes
more than `2.58L` above the target, repeats a boundary exit without contracting
the full line-of-sight error, or degrades wake coherence or actuator histories.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and classical fish mean-curvature turning
source_mechanism: preserve a rhythmic propulsive carrier while persistent body-relative direction error modulates a bounded average bend
transferable_invariant: separate joint-state rhythm generation from normalized target-geometry steering, and apply the slow route request through a consistently signed mean-curvature actuator
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: map the full normalized body-frame line of sight to the prefill's evidenced aligned two-joint mean bend, without recent-yaw-rate feedback or normalized instantaneous course direction
falsification: reject if the early upward curl returns, closest approach does not beat 2.5794L, the same boundary topology persists without line-of-sight contraction, or wake coherence and actuator/load histories worsen
