# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets. The fish and target begin outside
  and inside the merged second-row wake respectively, and the prewarm is
  identical across candidates, so it is initial-condition rather than policy
  evidence.
- The four sampled released sheets all reach the target by actively swimming:
  each fish executes a sharp clockwise redirect and leaves a dense alternating
  posterior wake while traversing upstream about `10.91L`. The inherited
  bearing-trend failure is the useful topology contrast: it never establishes
  upstream propulsion, moves `+2.39L` downstream, and exits the right boundary
  after `18.304` with negative progress. Its low `11.62/328.69` RMS
  force/moment is therefore not useful efficiency.
- Three sampled evaluations of the constant `0.25` half-cycle allocator are
  numerically identical: target reach in `36.4705`, mean distance `1.68603L`,
  total/mean command energy `48700/1335.33`, RMS relative crossflow `0.23970`,
  and RMS force/moment `63.59/953.42`. This deterministic same-prewarm result
  is the direct parent comparison.
- The response-scheduled burst child preserves the visible redirect/upstream
  route and improves arrival to `34.8205`, mean distance to `1.62700L`, and
  total command energy to `47151`. The improvement is not free: mean command
  energy rises to `1354.13`, RMS relative crossflow to `0.24143`, and RMS
  force/moment to `77.09/1142.74`. Both parent and child still touch the joint
  speed and `30.0` acceleration limits; the child's slightly smaller maximum
  joint angles do not explain away the load increase.
- Earlier inherited one-mechanism tests rule out nearby substitutions. A
  direct signed relative-crossflow residual still captured but regressed
  arrival, route, force, and moment; joint-speed gating of constant asymmetry
  arrived at `37.2624` and raised force/moment to `69.02/1065.10` relative to
  the constant parent. The validated carrier, steering sign, course-slip role,
  raw-bearing reserve, base half-cycle asymmetry, and envelope therefore stay
  intact.

## Candidate policy hypothesis

Start from the evaluated response-scheduled burst and add one load-release
gate to its *extra* half-cycle asymmetry. Large raw bearing with an unmet
bearing response may still request the burst, but the magnitude of normalized
body-frame yaw moment smoothly withdraws that extra authority as load grows.
The constant `0.25` asymmetry, mean steering, raw-bearing reserve, and rhythmic
carrier remain active, so the mechanism cannot coast or replace target
geometry with instantaneous wake phase. The moment input is already normalized
as `moment_z_L2`; the burst child's raw `1142.74` RMS moment corresponds to
about `0.279` after the episode's `64^2` normalization, which anchors the
candidate-owned `0.30` soft quadratic gate. The gate does not apply a signed
disturbance command or copy a dimensional load threshold.

Expected test: retain capture, the coherent redirect, and upstream traverse,
while reducing at least one of the burst parent's `77.09/1142.74` RMS
force/moment or `1354.13` mean command energy without giving back its complete
route improvement. Falsify the mechanism if capture is lost, arrival exceeds
the constant-asymmetry parent's `36.4705`, the initial redirect/propulsive wake
collapses, or neither load nor effort improves. The new CFD evaluation occurs
after this worker exits; no same-worker result is claimed.

bookshelf_consulted: true
source_domain: biological burst redirects, robotic-fish closed-loop asymmetric turning, and wake-adaptive swimming
source_mechanism: strong bounded asymmetric turning for large route error should release when measured body response or load appears while the rhythmic carrier and persistent route request remain active
transferable_invariant: measured normalized response may gate only temporary extra turning authority; persistent body-frame target geometry must retain mean steering and the traveling bend
nontransferable_details: published gains, dimensional load thresholds, species and robot kinematics, clock phase, exact vortex phase, single-cylinder synchronization, and task-specific routes
policy_translation: preserve the evaluated raw-bearing response scheduler and multiply only its added half-cycle burst by a smooth availability function of absolute `moment_z_L2`
falsification: reject if target reach or coherent upstream propulsion is lost, arrival exceeds 36.4705, or the added release gate improves neither load nor effort relative to the evaluated burst parent
