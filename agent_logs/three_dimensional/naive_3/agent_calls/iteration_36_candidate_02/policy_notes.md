# Course-alignment-hold adverse-yaw allocation candidate

## Evidence-led diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, and capture termination. Three samples are byte-
  identical copies of the assigned parent and reproduce capture at `16.932T`,
  score `-0.200045`, mean distance `2.08513L`, and final distance `0.74389L`.
  Joint-speed peaks remain below the hard stops at `4.5192/4.5239 rad/T`, and
  peak force/yaw moment are `0.03693/0.01835`.
- I read the assigned parent's combined sheet from release through capture in
  both views. Its top-down row develops a coherent alternating red/blue street
  behind a continuously translating fish; the oblique row retains compact
  three-dimensional Lambda2 structures behind the caudal region through the
  capture sphere. The trace confirms self-propulsion rather than ambient or
  moving-window advection: peak body speed is `1.391U`, while peak sampled
  local-flow speed is only `0.03270U`. There is no held-joint coast, wake
  collapse, collision, boundary exit, or visible hard-stop posture.
- The distinct sampled sibling mirrors adverse-yaw arbitration onto the
  anterior-to-posterior transfer. Its two visual rows are effectively
  unchanged and it captures `0.006T` sooner, but mean distance worsens to
  `2.08585L`, final distance to `0.74483L`, and score to `-0.200966`; higher
  peak speed (`1.393U`) therefore does not validate symmetric arbitration.
  Preserve the parent's one-sided target-signed residual.
- The inherited completed continuations isolate what not to change. Increasing
  posterior steering reserve under adverse yaw regressed to score `-0.204068`
  and mean distance `2.08817L`, with posterior excursion growing from
  `0.5992` to `0.6722 rad`. A collision-cone steering release also regressed
  to `-0.201977/2.08671L`. Most discriminatingly, multiplying the parent's
  adverse-yaw residual by a course-loss gate regressed to
  `-0.201551/2.08639L`, despite preserving capture and the coherent wake.
  Thus neither more posterior steering nor less correction on an already
  radial course is supported.
- A static projection of the assigned-parent equations over its recorded
  states shows that the existing signed residual is phase-local: posterior
  positive-power
  donor events occur in 113 samples, and its target-aligned adverse-yaw branch
  is eligible in 82 samples from `7.040T` to `14.262T`. Every eligible sample
  also has measured yaw rate opposing the requested turn. The proposed
  alignment-hold increment changes only 13 recorded-state outputs from
  `8.113T` to `13.893T`, with at most `0.118 rad/T^2` additional anterior
  acceleration and the inherited `0.99` acceleration ceiling still enforced.
  This projection establishes bounded overlap only; it does not advance the
  body or fluid and is not CFD evidence.

## Single-candidate policy hypothesis

Preserve the assigned parent's zero-centered anterior oscillator, lagged
posterior carrier, normalized body-frame target/velocity-course steering,
terminal posterior acceleration reserve, soft acceleration shoulder, narrow
positive-power speed guards, bidirectional base work transfer, one-sided
target-signed adverse-yaw residual, and posterior stopping-risk projection.
Add one smooth alignment-hold increment to that existing residual. It is
available only during the same posterior-donor event, only when the receiving
anterior positive-power stroke agrees with body-frame turn intent and opposes
measured yaw moment, and only as velocity course approaches the target ray.
The base transfer and inherited signed residual remain unchanged outside this
intersection; receiver speed and acceleration headroom remain prerequisites.

This tests the implication of the completed course-loss regression rather than
retuning the carrier: correction removed during nearly radial motion was
useful, so protect that motion with a small amount of additional phase-local
counter-yaw work. Expect capture and both coherent wake views, no exact joint
contact, and improvement over `-0.200045/2.08513L` without arrival later than
`16.932T`. Falsify the mechanism if it loses capture or alternating shedding,
touches a joint limit, fails to improve route score/mean distance, or exceeds
`0.5993 rad` posterior excursion and `0.0370/0.0184` force/yaw-moment peaks.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and adaptive wake-response control
source_mechanism: preserve a coupled propulsive rhythm while measured response allocates bounded corrective work through a phase-compatible residual
transferable_invariant: retain the traveling carrier and add correction only when target-relative intent, adverse yaw response, receiver phase, and useful target-directed translation agree
nontransferable_details: published gains, dimensional beat frequencies, species-specific kinematics, full-body oscillator networks, exact vortex phases, capture geometry, and task-specific routes
policy_translation: combine wrapped body-frame velocity-course error with normalized yaw moment and joint-state donor/receiver headroom; smoothly augment only the inherited target-aligned posterior-to-anterior residual as course efficiency approaches unity
falsification: reject if capture or coherent alternating three-dimensional shedding is lost, a speed or acceleration stop returns, score or mean distance does not beat the replicated parent, or posterior excursion and hydrodynamic loads exceed the sampled parent envelope
```

Formal CFD is intentionally deferred to the downstream EvE evaluator.
