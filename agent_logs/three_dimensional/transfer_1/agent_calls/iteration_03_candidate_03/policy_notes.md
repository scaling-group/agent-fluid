# Completion-gated redirect candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts report direct uniform initialization in still
  water (`U_infinity=(0,0,0)`), no cylinders, and no prewarm.  Their motion is
  self-propelled rather than ambient advection.
- In the assigned transferred-seed rollout (`solver_2f352671b105`), both the
  top-down vorticity row and oblique Lambda2 row show a coherent alternating
  three-dimensional wake.  Distance falls from `12.3277 L` to `4.7800 L` by
  `17.853 T`, but the path then curls downward and exits the lower boundary at
  `27.495 T`.  Local flow near the fish is only about `0.02 U` while body speed
  is about `0.8 U`, so the failure is persistent target steering rather than
  advection, thrust loss, or numerical instability.
- The response-gated redirect (`solver_8556f8eb9ecb`) preserves the organized
  wake and changes the trajectory usefully, improving closest approach to
  `2.4625 L`.  It nevertheless passes above/left of the target and exits.  Its
  inherited note identifies premature redirect release: correct-sign yaw from
  one tail-beat can remove the mean bend while the macroscopic body-frame
  target angle is still large.
- The completion-gated redirect (`solver_06efdad50479`) is the only sampled
  semantic success.  Its top-down row shows sustained target-directed
  curvature rather than the seed's lower exit or the response-gated upper
  miss; the oblique row retains discrete paired Lambda2 structures all the way
  into the capture corridor.  Metrics agree: it captures at `26.411 T` with
  final/minimum distance `0.7496 L`, mean-distance score term `2.6134 L`, and
  no instability.  Raw action still exceeds the acceleration envelope in
  `82.5%` of rows and a joint reaches the speed bound in `11.4%`, but both are
  materially below the response-gated near-miss (`95.7%` and `21.2%`).
- Terminal carrier relief is not a supported addition.  The sampled terminal
  maneuver-relief policy (`solver_10962d00368d`) misses at `1.2329 L`, later
  exits left, raises peak speed to `1.47 L/T`, and has `89.9%` raw action
  clipping.  An inherited capture-turn-hold log likewise records a `1.3896 L`
  miss.  Those results do not justify changing cadence or amplitude on top of
  the successful redirect.

## Policy hypothesis

Replace the assigned seed with a faithful copy of the sampled
completion-gated redirect.  Preserve its state-feedback oscillator, posterior
lag, route curvature, and half-cycle steering.  When normalized body-frame
target angle is large, hold a bounded target-signed distributed curvature;
allow observed correct-sign yaw to release that burst only as the geometric
error gate contracts.  This is the smallest evidence-backed architecture
change from the parent and deliberately avoids an unevaluated scalar tuning or
the falsified terminal drive-relief branch.

Expected result: reproduce the sampled capture topology while retaining the
coherent three-dimensional wake and the improved saturation profile.  Falsify
the transfer if it loses capture under the same evaluator, reverts to either
boundary-exit topology, collapses early closing/wake coherence, or exhibits
materially worse clipping or load spikes.  No same-worker CFD result is
claimed; formal evaluation occurs after this worker exits.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG steering
source_mechanism: sustain a bounded large-error curvature burst and release it into the posterior-lag propulsive rhythm only after an observed macroscopic steering response
transferable_invariant: burst-turn completion is contraction of normalized target-relative geometry, not an instantaneous correct-sign yaw sample within an oscillatory gait
nontransferable_details: species-specific C-start shape, published gains, dimensional beat timing, robot geometry, exact vortex phases, and task-specific routes
policy_translation: body-frame target angle sets a bounded shared redirect; recent yaw can reduce it only in proportion to geometric completion, while the two-joint state-feedback carrier and posterior lag remain unchanged
falsification: reject if the same fixed evaluation loses capture, early progress or wake coherence degrades, a boundary-exit topology returns, or saturation and loads materially worsen
