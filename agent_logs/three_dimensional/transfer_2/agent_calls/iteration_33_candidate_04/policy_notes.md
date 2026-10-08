# Candidate wake-policy notes

## Evidence diagnosis before policy edit

- The four sampled solver artifacts are exact nominal replications: their
  candidate policies, `trajectory.csv` files, combined sheets, and both
  view-specific sheets have matching hashes.  Each starts from direct uniform
  still water (`U_infinity=[0,0,0]`), captures at `24.640015T` and
  `0.748356L`, has mean distance `2.347937L`, and scores `-0.448328`.
  Consequently there is no distinct sampled failure image to contrast with
  the best finite rollout; the inherited failed-controller results provide the
  available negative comparison.
- In the top-down row, the fish is self-propelled rather than advected: it
  leaves the release point in quiescent water, turns onto the target-directed
  route, and carries a coherent alternating mid-plane street through capture.
  The oblique Lambda2 row confirms compact paired three-dimensional wake
  structures rather than a planar rendering artifact.  The lateral motion is
  propulsive and remains coherent, although the final hook contains a strong
  body bend.  Metrics agree: capture is stable, progress is `0.939295`, peak
  planar body-frame force/yaw-moment coefficients remain in the low
  `0.023/0.032/0.0156` class, and there is no collision, exit, or instability.
- The remaining control defect is allocation consistency, not missing turn
  magnitude.  V41 applies its bounded terminal course residual only on the
  joint-state half-cycle aligned with that residual, yet cadence relief still
  uses the continuously combined route-plus-terminal request.  On the sampled
  trace the residual exists only from `21.9835T` (`2.0986L`) to capture; its
  phase proxy is exactly zero on 156 of 401 residual-bearing rows.  Thus the
  carrier is sometimes scheduled for steering load that the actuator does not
  apply.  An offline fixed-trace audit shows that substituting phase-realized
  residual load changes only those 401 terminal rows and changes normalized
  turn load by at most about `0.046`.
- Sampled optimizer guidance sharpens the boundary.  V42 transferred
  posterior steering rejected by the stroke reserve into the anterior joint
  and regressed score/final margin while raising raw acceleration exposure;
  V43 instead coupled the anterior share to posterior safety realization and
  again regressed score and margin.  The candidate must neither recover nor
  veto steering across joints.  It changes only the cadence scheduler's view
  of the already phase-selected residual and preserves every V41 steering and
  safety path.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG control and asymmetric flapping
source_mechanism: sensor-conditioned modulation of a low-dimensional rhythmic drive with joint-state phase allocation
transferable_invariant: rhythmic-drive scheduling should respond to the steering authority actually available in the observed beat phase, rather than to an unavailable continuous request
nontransferable_details: published oscillator gains, dimensional beat frequencies, species-specific envelopes, exact wake phase, and task-specific routes
policy_translation: derive a mirror-equivariant terminal phase share from normalized anterior joint angle and rate, use the phase-realized existing course residual in cadence turn-load feedback, and leave the two-joint steering and safety filters unchanged
falsification: reject if commands change before the 2.10L terminal window, capture or crossing margin is lost, arrival and mean distance fail to improve beyond deterministic noise, or rate/load/wake classes regress

## Candidate hypothesis

Implement one phase-consistent CPG feedback mechanism.  The anterior joint
state supplies a clock-free proxy for the lagged posterior wave.  Before
computing drive frequency, apply the same signed half-cycle rule used by the
terminal actuator to the existing bounded terminal residual, and compute
cadence turn load from that realized share.  Do not change residual magnitude,
joint steering shares, posterior reserve/coast filters, route feedback, or any
gain.  The expected effect is strictly local: avoid needless cadence relief on
unallocated terminal half-cycles while retaining V41's coherent far route and
capture hook.  Formal CFD after worker exit must decide whether that modest
phase-consistent propulsion change advances capture or merely perturbs the
same trajectory class.

## Post-edit static audit

- Replaying both policy functions on the inherited 4,480-state trace without
  advancing the flow changes exactly 401 rows.  The first change is at
  `21.983505T/2.098608L`, the last is the capture row, and every row outside
  `2.10L` is bitwise unchanged.
- Maximum raw-command differences on that fixed trace are only
  `0.04603 rad/T^2` anterior and `0.04203 rad/T^2` posterior.  This establishes
  locality and boundedness, not a CFD outcome; arrival, trajectory, wake, and
  score remain claims for the later formal evaluation.
