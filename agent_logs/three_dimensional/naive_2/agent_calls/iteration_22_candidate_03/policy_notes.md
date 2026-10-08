# Candidate visual diagnosis and policy hypothesis

## Evidence diagnosis before the edit

- All four sampled solver results satisfy the released contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window dynamics, and capture. The two
  `452903d...` repeats are the assigned parent and capture at `16.604496T`
  with score `-0.113729`, final distance `0.743958L`, and scored distance
  integral `1.998146L`. The two `3323ffe...` controls capture at
  `16.609995T` with score `-0.115560`, final distance `0.745621L`, and
  integral `1.999656L`. The exact pairs are repeatability checks, not
  held-out pose or flow evidence.
- I inspected both rows of the combined keyframe sheets for the assigned
  parent and the weaker speed-guard control, plus both rows for the inherited
  line-of-sight-rate descendant. Their top-down views show self-propelled
  targetward motion, shallow closed-loop capture arcs, and coherent
  alternating vorticity streets; their oblique views show finite,
  tail-connected three-dimensional Lambda2 structures through capture. None
  is passive advection, wake breakup, collision, or instability. The
  line-of-sight descendant is the informative regression because no sampled
  semantic failure exists.
- The assigned parent's approach-gated lateral carrier observer provides a
  narrow progress benefit over the speed-guard control, but not a load or
  saturation benefit. Its peak planar force/moment rise from
  `0.035828/0.017759` to `0.037165/0.018356`, acceleration-near-limit
  residence rises from `73.91%` to `74.10%`, and speed-near-limit residence
  rises from `27.42%` to `27.59%`. The route improvement should therefore be
  preserved while a separate response channel addresses residual load.
- The inherited approach-only inertial line-of-sight-rate feedforward is a
  completed negative control. It preserves capture and the wake class and
  reaches the capture boundary one step earlier at `16.598995T`, but worsens
  score to `-0.118996`, scored distance integral to `2.002387L`, and final
  distance to `0.749034L`. Directly advancing desired yaw with target-line
  rotation is therefore not the next mechanism to deepen or gain-tune.
- A controlled fit to the three distinct completed traces separates
  beat-synchronous hydrodynamic yaw moment from response load. On approach,
  `q1_carrier` and `q1_dot` explain `94.44--94.55%` of moment variance; inside
  `3L` they explain `94.85--95.02%`. The fitted angle coefficient is
  `0.02301--0.02318` and the velocity coefficient is
  `0.000946--0.000950` across the parent, speed-guard control, and
  line-of-sight descendant. The parent's approach residual has a 95th
  percentile magnitude of about `0.00470`, while the raw moment peak is
  `0.01836`. The stable phase fit supports residual feedback; it does not
  support cancelling the carrier moment.

## Sole candidate hypothesis

Preserve the assigned parent's full traveling-wave carrier, raw-course
anterior response, lateral and yaw carrier demodulators, posterior
phase-selective steering, and one-sided speed guard. Add one approach-only
hydrodynamic response mechanism: reconstruct the beat-synchronous yaw moment
from the already centered anterior joint angle and velocity, subtract it from
the measured normalized yaw moment, smoothly bound the residual at its
observed approach scale, and add a small sign-correct rejection term only to
the posterior turn state. Positive residual physical moment receives positive
tail-turn correction because the inherited actuator calibration maps positive
posterior turn state to negative physical yaw. The correction is
reflection-equivariant, body-frame, state-derived, and silent before the
existing approach gate.

Expected test: retain capture, the pre-approach route, and the connected
alternating wake while reducing residual yaw excursions or recovering the
parent's small force/moment and near-limit regressions without weakening
distance progress. Falsify this mechanism if capture is lost, the route or
wake class changes, the residual remains carrier-correlated, moment or force
peaks grow, joint contact or near-limit residence increases, or score and
distance integral regress. The new CFD result is not available to this worker.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and wake-disturbance residual control
source_mechanism: preserve rhythmic propulsion while sensor feedback rejects only the non-rhythmic directional load
transferable_invariant: remove the predictable beat-synchronous component from a body-frame response before applying a small bounded disturbance correction
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phases, maneuver timing, and task-specific routes
policy_translation: on approach reconstruct yaw moment from centered anterior joint angle and velocity, subtract it from measured normalized moment, and feed only the bounded residual into posterior turn state while leaving the carrier and actuator guards unchanged
falsification: reject if capture, approach, connected wake, phase separation, joint feasibility, force, moment, effort, distance integral, or score worsens

## Evaluation boundary

The moment model is evidence-calibrated only for this oscillator family and
the nominal direct-uniform still-water traces. A later evaluation should first
require capture and the same target-crossing/wake topology, then compare
distance integral, final crossing depth, arrival, phase correlation of moment
residual, peak and RMS force/moment, yaw excursions, joint contact, near-limit
residence, and requested effort. A changed carrier, morphology, actuator
integration, pose, or flow requires recalibration or a held-out test.
