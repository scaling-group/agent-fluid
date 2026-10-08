# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet shows the held fish at the common upper-right
  release pose while the four staggered wakes develop into interacting vortex
  streets around and downstream of the target. This anchors every comparison
  to the same developed initial flow; it is not candidate-specific credit.
- The released sheets show active propulsion rather than passive advection.
  Both the gain-`1.7` anchor and the three gain-`1.9` replicas make an early
  left-down heading correction, shed a dense alternating tail trail, cross the
  merged wake corridor, and enter the `0.75L` ring without collision, exit, or
  instability. The anchor's mean leftward speed (`0.274L/time`) exceeds the
  magnitude of its mean local leftward flow (`0.163L/time`), consistent with
  the visibly self-propelled diagonal traverse.
- Gain `1.7` is the current finite anchor: it reaches at `39.710`, with mean
  distance `1.874L`, relative-crossflow RMS `0.2265`, force/moment RMS
  `38.40/618.59`, and power-proxy mean `103.06`. Raising only bearing gain to
  `1.9` reproduces a slightly flatter visible approach three times but regresses
  arrival to `40.034`, mean distance to `1.901L`, crossflow RMS to `0.2329`,
  force/moment RMS to `41.31/657.28`, and maximum joint angles from
  `0.507/0.528` to `0.523/0.548` rad. Its lower command-energy mean does not
  offset the longer episode, higher total command energy, and larger loads.
- The inherited gain-`1.725` interpolation supplies the decisive negative
  result missing from the assigned parent lesson. Its sheet retains the same
  self-propelled route and capture, but it arrives at `40.832`, raises mean
  distance to `1.915L`, total command energy to `56614`, crossflow RMS to
  `0.2364`, force/moment RMS to `42.50/674.61`, and maximum joint angles to
  `0.526/0.556` rad. Together with the gain-`1.9` replicas, this rejects a
  monotonic or smoothly interpolated bearing-gain continuation above `1.7`.
- The gain-`1.7` anchor still reaches both joint-rate and acceleration envelopes,
  and posterior angle excursion remains larger than anterior excursion. The
  inherited target-blind domain exit and multi-signal instability bound the
  next test against weakening the entire oscillator, reversing curvature, or
  adding unscaled velocity/moment feedback.

## Candidate hypothesis

Restore and lock the evaluated `steering_gain=1.7`, `0.55`-period, 28-degree
anterior oscillator, positive two-joint bearing center, phase-lag target, and
12-degree outer steering bound. Change only posterior `tail_damping` from
`0.65` to `0.70`. This modest increment directly damps the joint whose maximum
angle is larger, with no new observation, coordinate, route, elapsed-time, or
wake-identity dependence. The expected effect is to trim posterior overshoot,
crossflow, and load excursions while preserving the visible turn-then-diagonal
capture topology and the anterior propulsion phase.

The later CFD rollout falsifies this isolated damping test if it loses capture,
arrives later than `39.710`, raises mean distance above `1.874L`, or fails to
reduce the gain-`1.7` posterior excursion and crossflow/load values without a
material propulsion penalty. If falsified, later workers should restore
`tail_damping=0.65` and avoid further bearing-gain interpolation; a smaller
damping bracket should precede any new feedback mechanism.
