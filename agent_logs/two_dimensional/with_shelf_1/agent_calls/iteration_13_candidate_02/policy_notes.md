# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting cylinder streets.  This common wake state is
  identical across candidates and supplies no candidate-specific advantage.
- Every sampled released sheet is a finite target reach.  Each fish makes a
  sharp initial targetward redirect, leaves a coherent posterior trail during
  a sustained leftward traverse, and enters the `0.75L` circle directly.  The
  roughly `-10.92L` head displacement in x while mean local flow is only about
  `-0.20U` confirms active upstream propulsion rather than passive advection.
  No sampled failure keyframe exists in this workspace, so the failure
  contrast is limited to inherited recorded evidence: putting bearing trend in
  persistent route steering exited after `18.304` with negative progress, and
  a wholesale slower carrier became unstable with force/moment RMS
  `16749.8/290421`.
- The assigned parent and its exact sampled copy reach in `34.8205`, with
  `1.62700L` mean distance, `47151` total command energy, `0.24143` RMS
  relative crossflow, and `77.09/1142.74` RMS force/moment.  They establish the
  response-scheduled burst baseline and preserve raw-bearing ownership of mean
  steering.
- Restricting assisting yaw-moment credit to the anterior targetward
  half-cycle preserves the visible route and reaches in `34.8535`, but raises
  force/moment RMS to `82.35/1231.74`.  Joint phase is therefore not a useful
  unloading gate in this shared wake.
- The strongest sampled controller credits assisting-sign normalized yaw
  moment on both half-cycles and also releases only surplus burst as normalized
  joint-speed pressure rises.  It preserves capture while improving arrival to
  `34.7105`, mean distance to `1.62283L`, total/mean command energy to
  `46986/1353.65`, relative crossflow to `0.24023`, and force/moment RMS to
  `68.96/1036.40`.  Both it and the parent still touch the `30.0` acceleration
  and joint-speed limits.  Because the sampled controller adds both response
  credits relative to the parent, the evidence supports the compatible pair,
  not an isolated claim that speed magnitude is a wake-load proxy; inherited
  logs report a different speed-only gate regressing arrival to `37.262` and
  increasing load.

## Policy hypothesis

Promote the strongest sampled pair as one bounded surplus-burst release
mechanism.  Persistent raw-bearing mean steering, course-slip feedback,
reserve scheduling, base half-cycle asymmetry, and the joint-state traveling
carrier remain unchanged.  Assisting-sign body-frame yaw moment may withdraw
only the optional response burst, and endogenous joint-speed pressure may
withdraw an additional bounded share of that same burst; neither signal can
remove base asymmetry or route authority.  The next CFD rollout is a
deterministic replication test of the sampled dominance, not evidence already
owned by this worker.  Reject the candidate if capture or coherent upstream
propulsion is lost, or if arrival, mean distance, effort, crossflow, and load
do not retain the sampled joint improvement.  A later ablation or changed wake
phase is required before attributing benefit to speed relief alone or claiming
robustness.

bookshelf_consulted: true
source_domain: organized-wake fish interaction and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a rhythmic propulsive carrier while bounded observed response releases only surplus asymmetric turning authority
transferable_invariant: keep persistent route ownership separate from fast environmental and actuator response; helpful response may reduce optional maneuver authority but cannot erase propulsion or base steering
nontransferable_details: exact vortex phase, single-cylinder synchronization, trout muscle timing, robot morphology, published gains, dimensional frequencies, species kinematics, and task-specific routes
policy_translation: use normalized body-frame bearing and `moment_z_L2` plus two-joint speed normalized by the carrier scale to attenuate only the extra response-gated half-cycle burst; retain the established state-feedback carrier, raw-bearing mean steering, reserve, course response, and base asymmetry
falsification: reject if target reach or coherent leftward propulsion is lost, if the sampled arrival-distance-effort-load improvement fails to reproduce, or if an isolated or changed-wake test shows speed relief has no benefit or damages capture
