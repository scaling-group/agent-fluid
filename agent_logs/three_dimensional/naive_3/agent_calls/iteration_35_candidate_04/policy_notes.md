# Agreement-gated terminal yaw-damping candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts and the two inherited terminal-relief rollouts
  satisfy the frozen contract: direct uniform initialization in still water
  with `U_infinity=(0,0,0)`, no cylinders or prewarm, and capture termination.
  The strongest finite sample is the three-times-replicated assigned-parent
  policy (`solver_db2418f56ce7`, `solver_cf5406a979f8`, and
  `solver_6334f1f4fe88`): capture at `16.932T`, score `-0.200045`, and mean
  distance `2.08513L` with sublimit joint-speed peaks of
  `258.93/259.20 deg/T`.
- I inspected the combined sheets from release through capture for that
  replicated parent, the weaker sampled bidirectional allocator
  (`solver_292735cefd5b`), and inherited step-33/34 capture-corridor variants.
  Their top-down rows all show target-directed translation with a continuous
  alternating red/blue wake; their oblique rows retain compact caudal
  Lambda2 structures through the capture sphere. There is no held-joint
  coast, passive advection, collision, boundary exit, or visible wake collapse.
  This is consistent with the parent trace's `1.391U` peak fish speed versus
  only `0.0327U` peak sampled local-flow speed.
- The sampled bidirectional adverse-yaw allocator captures slightly earlier
  at `16.926T`, but worsens score to `-0.200966`, mean distance to `2.08585L`,
  and crossing distance to `0.74483L`; it supplies no visual or mechanical
  benefit over the replicated parent. Preserve the parent's one-sided signed
  load residual rather than mirroring it.
- Two later inherited policies independently relieve terminal course steering
  when straight-line closing geometry predicts capture. Both preserve the
  same coherent wake and capture slightly earlier, but regress to
  `-0.204337/2.08858L` and `-0.202941/2.08746L` score/mean distance versus the
  parent's `-0.200045/2.08513L`. Their whole-trace load and joint maxima remain
  essentially inherited rather than improving. Thus a collision-cone scalar
  does not establish that terminal steering is redundant.
- The parent trace identifies why steering relief is the wrong direction:
  inside `2L`, absolute yaw rate peaks at `4.443 rad/T`, and the body-frame
  course correction opposes the instantaneous yaw sign in 168 of 183 logged
  samples. The course loop is already performing cycle-resolved yaw braking
  during approach. Removing part of it while a projected center-velocity ray
  happens to intersect the capture circle weakens useful corrective work.

## Single-candidate policy hypothesis

Preserve the replicated parent unchanged outside the terminal neighborhood:
the zero-centered anterior oscillator, lagged posterior carrier, body-frame
velocity-course steering, acceleration reserve, C1 acceleration envelope,
phase-local speed guards, target-signed measured-yaw work allocation, and
posterior stopping-risk projection all remain intact. Add one bounded
response-conditioned mechanism after formation of the existing steering
signal. Near the target and only at reliable swimming speed, measure normalized
body yaw rate. If the existing target-course signal already opposes that yaw,
increase the same-sign signal by a small bounded amount; if it agrees with the
yaw or passes through zero, add nothing. This preserves every useful steering
half-cycle and cannot reverse the target-course request.

The expected semantic effect is capture with a deeper or cleaner crossing,
equal or better mean distance, and lower terminal yaw without changing the
broad route or alternating wake. Falsify the mechanism if capture is lost,
arrival is later than `16.932T`, score or mean distance is worse than
`-0.200045/2.08513L`, terminal yaw is not reduced from `4.443 rad/T`, any joint
limit is touched, or posterior excursion and force/yaw-moment peaks exceed
`0.5993 rad` and `0.0370/0.0184` without a semantic gain.

```text
bookshelf_consulted: true
source_domain: biological terminal approach and sensor-modulated robotic-fish CPG control
source_mechanism: retain the propulsive rhythm while bounded measured-response feedback damps excess terminal yaw
transferable_invariant: near capture, keep active propulsion and apply corrective work only when the target-relative request and measured yaw response identify the same braking direction
nontransferable_details: published gains, dimensional yaw rates, species-specific kinematics, prescribed approach stages, exact vortex phases, capture radius, and task-specific routes
policy_translation: use normalized body-frame distance, course-speed confidence, target-course signal, and `heading_rate` to add a bounded same-sign increment only when the inherited course request opposes measured yaw; leave both joint carrier dynamics and every safety layer unchanged
falsification: reject if broad-route equivalence, capture, or alternating three-dimensional shedding is lost; if terminal yaw does not fall; or if arrival, distance integral, joint viability, posterior angle, or load peaks regress beyond the replicated parent
```

No formal CFD is run in this worker. The candidate's rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Projecting the observation gate over all 3,079 recorded parent states changes
207 samples from `15.718T` through capture and changes zero samples at or
beyond the parameter-owned `2.25L` terminal boundary. The largest added
steering signal is `0.04333 rad`, below its `0.06 rad` bound. This establishes
that the candidate is a terminal, behaviorally non-inert feedback test rather
than a broad-route or scalar carrier edit; it does not predict the coupled body
or fluid response.
