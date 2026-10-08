# Phase-demodulated velocity-course candidate

## Evidence-led diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen direct-uniform contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, inertially still moving-window
  fill, and capture termination. There is no failed termination in this sample;
  the informative weaker result is the bidirectionally arbitrated signed-yaw
  variant rather than a domain-exit or instability case.
- I inspected the combined sheets for the best replicated signed-yaw sample
  and the weaker arbitration sample from release through capture, including
  both the top-down mid-plane vorticity row and oblique body/Lambda2 row. Both
  fish translate along a gently curving target approach while leaving a
  persistent alternating red/blue street and compact three-dimensional caudal
  structures. Neither shows a held-joint coast, collision, wake collapse, or
  passive drift. The traces agree: peak fish speed is `1.391--1.393U`, whereas
  peak sampled local-flow speed is only about `0.0327U`.
- The assigned parent is reproduced exactly by three sampled policies. It
  captures at `16.93205T`, scores `-0.20004481`, and has `2.08513L` mean
  distance, sublimit joint-speed peaks `4.5192/4.5239 rad/T`, `0.59921 rad`
  peak posterior angle, and `0.03693/0.01835` peak force/yaw moment. The fourth
  policy suppresses anterior-to-posterior transfer during adverse yaw. It
  captures about `0.0059T` earlier but regresses to score `-0.20096611`, mean
  distance `2.08585L`, and final distance `0.74483L`; its nearly unchanged
  wake and route show that duplicating the signed-yaw arbitration into the
  other transfer direction is not a useful new control primitive.
- The inherited optimizer logs also show that an absolute moment threshold was
  behaviorally inert and that replacing the established receiver-speed taper
  with a plateau gate regressed to `16.960T`, score `-0.204089`, and
  `2.08869L` mean distance. Together with the new arbitration result, this
  argues against another load threshold or headroom relaxation.
- A body-frame reconstruction of the replicated parent trace exposes a
  different missing capability. From `8--16T`, raw target-ray/velocity-course
  error has roughly `0.30--0.37 rad` RMS and repeatedly saturates both turn
  signs within each beat although distance decreases smoothly. Over `4--14T`,
  the normalized zero-centered anterior phase pair
  `(q1/amp, qdot1/(omega*amp))` explains the carrier-synchronous lateral
  velocity with rounded coefficients `(-0.27,-0.67)U`. Subtracting only that
  fitted oscillatory component reduces reconstructed course-error RMS to
  `0.29`, `0.26`, `0.18`, and `0.11 rad` over `8--12`, `12--14`, `14--15`,
  and `15--16T`, while retaining a nonzero mean target error. This replay does
  not evolve the body or fluid and is activation evidence, not evidence of a
  score or capture improvement.

## Single-candidate policy hypothesis

Preserve the replicated zero-centered oscillator, posterior traveling lag,
acceleration reserve, soft command envelope, high-onset positive-power speed
guards, signed adverse-yaw work allocation, receiver taper, and posterior
stopping-risk projection. Change only the broad steering observation: before
forming velocity course, subtract a bounded lateral-velocity estimate encoded
by the anterior oscillator's normalized angle/rate phase. Ramp this
demodulation with the existing measured-speed reliability gate, so launch and
low-speed target bearing are unchanged. Continue to use the actual body-frame
forward velocity and current target ray; no world coordinate, clock, stored
phase, or memorized route enters the policy.

This tests whether steering on translational drift rather than beat-synchronous
self-motion can reduce countersteering while preserving the productive wake.
Expect capture, the same alternating two-view wake, no speed or angle contact,
and lower cycle-scale turn switching; a useful result should match or improve
`16.932T` / `2.08513L` without exceeding `0.5993 rad` posterior angle or
`0.0370/0.0184` force/yaw-moment peaks. Falsify the mechanism if it removes
necessary mean steering, loses capture or coherent shedding, restores an
actuator contact, increases route error/load, or merely replaces course-error
oscillation with a persistent biased turn.

```text
bookshelf_consulted: true
source_domain: coupled-oscillator robotic-fish control and elongated-body reactive swimming
source_mechanism: use endogenous oscillator phase to separate carrier-synchronous lateral motion from the slower directional feedback signal while preserving the traveling bend
transferable_invariant: rhythmic self-motion and target-relative drift should be separated before broad steering feedback, using bounded state phase rather than external time or exact wake phase
nontransferable_details: published gains, dimensional beat frequency, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: estimate only the beat-synchronous body-frame lateral velocity from normalized anterior joint angle and rate, bound it, ramp it with measured swimming-speed reliability, and form target-course error from the residual velocity within the existing two-joint controller
falsification: reject if capture or alternating three-dimensional shedding is lost, mean target steering is biased away, actuator boundaries return, or route and load metrics fail to match the replicated signed-yaw parent
```

## Non-CFD activation check after the edit

An exact Julia policy replay on all `3,079` recorded parent states compared
this candidate with the replicated signed-yaw parent. The phase-demodulated
observation changes `2,302` posterior and `51` anterior outputs, with maximum
differences `18.9531` and `1.2614 rad/T^2`; the anterior differences are the
expected downstream consequence of changing the target-signed yaw-allocation
gate. All outputs are finite and remain within the inherited sublimit command
envelopes, with replay maxima `31.1018/29.8451 rad/T^2`. This establishes that
the observation mechanism is behaviorally active and bounded on prior states;
it does not predict the closed-loop fluid trajectory or claim improvement.
