# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts and the assigned-parent rollouts report direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. Translation and wake formation are therefore
  released-swimmer behavior rather than background advection.
- The prefilled `dogfish3d_intercept_guarded_speed_reserve_v1` bytes are the
  sampled baseline. Its three sampled copies capture at `0.7466--0.7494L`
  after `18.287--18.601T`; the assigned parent's latest exact copy also
  captures at `0.7482L`. The sampled posterior wave-shape copy captures at
  `0.7480L`, but inherited exact misses make that phase-dependent mechanism
  less reliable than the baseline and do not justify restoring or tuning it.
- I inspected both rows of the combined keyframe sheets for the highest-scoring
  sampled capture and the inherited exact-baseline miss at `1.7276L`. Both
  visibly self-propel with an organized alternating mid-plane vortex street
  and compact oblique Lambda2 structures. The failed fish continues laying
  down an active wake through its lower-boundary exit; there is no carrier
  collapse, ambient advection, or numerical instability to cure.
- The trajectory cross-check localizes the useful difference before capture.
  At the first `3L` crossing, all three sampled baseline captures place the
  head at `y=10.55--10.68L`, whereas the exact-baseline miss is already lower
  at `y=9.92L`, despite similar speed (`0.87--0.90L/T`) and an apparently safe
  instantaneous projected miss of `0.16L`. By the first `2.75L` crossing one
  half-beat later, its projected miss has opened to `2.24L` and the achieved-
  course error to `0.96 rad`; it never enters the capture circle. The three
  captures instead remain on the upper approach and arrive with an active
  carrier at `0.83--0.88L/T`.
- Existing inherited evidence rejects scalar route-gain or cadence tuning,
  carrier suppression, total-command governors, half-cycle allocation,
  projected-miss replacement, posterior phase shaping, capture-corridor
  steering release, and terminal yaw damping. The remaining evidenced gap is
  a phase-independent steering realization that can resist the pre-gate lower
  drift without removing the traveling bend.

## One candidate hypothesis

Retain the exact achieved-course/intercept speed-reserve controller and add
one small terminal mean-curvature state servo. From `4L` inward, while the
existing response logic still requests steering, a bounded target-signed mean
bend is tracked through the average joint angle and velocity at bandwidth
well below the carrier. The original carrier, additive steering, intercept
guard, cadence, and actuator reserve are unchanged. This is intended to turn
the high-frequency sign-changing course request into a small persistent bend,
not to suppress a half-cycle or retune a scalar route gain.

Expected test: preserve the far-field trajectory and both coherent wake views,
retain capture, and reduce sensitivity to the lower terminal branch visible
before `2.75L`. The mechanism is useful only if later exact repeats retain the
baseline arrival and load envelope while improving terminal path reliability;
one threshold crossing alone is not evidence of superiority.

Falsification: reject the mean-curvature residual and restore the exact
baseline if it changes commands outside `4L`, weakens or phase-distorts either
wake view, increases clipping, speed-limit residence, force, or yaw moment
beyond the sampled envelope, or produces another lower pass. Do not answer a
failure by tuning only the curvature magnitude or by stacking a prior failed
terminal mechanism.

bookshelf_consulted: true
source_domain: robotic-fish turning by average tail-beat bias and sensor-modulated rhythmic direction tracking
source_mechanism: realize turning as a bounded mean-curvature state objective subordinate to an active propulsive rhythm
transferable_invariant: a slow target-directed average bend can redirect the achieved course without replacing the posteriorly lagged traveling wave
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, explicit oscillator or vortex phase, and task-specific coordinates or routes
policy_translation: inside a normalized body-frame distance gate, track a small turn-command-signed average of the two joint angles using only joint angle and velocity feedback while leaving the evaluated carrier and intercept logic intact
falsification: reject if exact replay loses capture or far-field closure, weakens either wake view, changes the carrier phase, or exceeds the baseline actuator and load envelope
