# Restore the replicated actuator-consistent phase route

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no prewarm, no cylinders,
  finite dynamics, and capture. Their local-flow magnitude RMS is tightly
  grouped at `0.01807--0.01816U`, so the trajectories are self-propelled rather
  than advected by an environmental flow.
- I inspected every combined keyframe sheet from release through termination.
  The best-score actuator-consistent replicate (`solver_ed121cf46867`) and the
  slower assigned-parent stress-gated moment residual
  (`solver_bdf6dd947707`) provide the informative visual contrast because the
  current sample contains no termination failure. In both top-down rows the
  body advances continuously toward the target behind a coherent alternating
  vorticity street; in both oblique rows compact Lambda2 structures form at
  the moving tail and remain behind the fish through capture. Neither view
  shows passive advection, wasteful growing sway, wake collapse, collision,
  boundary approach, or instability. The nearly indistinguishable wake
  topology supports preserving the carrier but does not support the added
  instantaneous-moment allocator.
- The plain actuator-consistent policy has two current same-hash captures at
  `18.6725T`, with scores `-0.132185` and `-0.133625`, mean distances
  `2.02018--2.02129L`, posterior acceleration-limit occupancy
  `75.46--76.14%`, and force/moment RMS
  `0.01331--0.01350 / 0.00693--0.00703`. This is the replicated route
  reference, not a claim that its clipping is solved.
- The assigned-parent stress-gated raw-moment residual captures more slowly at
  `18.7440T`, score `-0.133635`, mean distance `2.02198L`; its posterior
  occupancy (`75.47%`) and force/moment RMS (`0.01343/0.00699`) remain inside
  the baseline spread. It therefore adds response logic without a resolved
  route or effort benefit.
- A helpful raw-moment sample captures at `18.6560T` with favorable load
  values, but the inherited exact-policy repeat scores `-0.157720` and needs
  `3453` steps instead of the current baseline's `3395`. Inherited one-sided
  carrier-demodulated opposition also spans materially different effort
  outcomes across exact-policy runs, and the latest inherited
  carrier-demodulated helpful-response candidate captures at only
  `-0.140740`. Together these completed results falsify an improvement claim
  for instantaneous yaw-moment allocation; more moment gates or residual-scale
  tuning would not be a new mechanism.

## Policy hypothesis recorded before editing

Remove the assigned parent's stress-gated yaw-moment residual and restore the
sampled `dogfish3d_actuator_consistent_tail_phase_v1` controller exactly.
Preserve normalized body-frame bearing and LOS-rate guidance,
recoil-conditioned yaw error, the distributed C-bend, state-feedback traveling
carrier, response-reversing half-cycle steering, persistent same-side actuator
gate, coefficient-norm-preserving posterior phase rotation, and componentwise
acceleration projection. This changes one response semantic: physical yaw
moment no longer releases a route actuator when its current evidence is
indistinguishable from carrier-phase response and has failed replication.

Support requires capture within the inherited `18.6725--19.0080T` band with a
coherent body-led wake in both views and mean distance no greater than the
slower same-hash baseline value `2.02129L`. Treat effort as unresolved unless
posterior acceleration occupancy and force/moment RMS fall below the current
same-hash lower bounds (`75.46%` and `0.01331/0.00693`) on replication.
Falsify the rollback if it loses capture, leaves the arrival band, breaks wake
coherence, or exceeds the sampled baseline route/load envelope. In that case a
later worker should test a genuinely beat-scale/history observation or a
different route actuator, not another instantaneous moment gate.

bookshelf_consulted: true
source_domain: sensor-feedback modulation of rhythmic robotic-fish CPG control and wake-adaptive swimming
source_mechanism: keep a productive traveling rhythm primary and modulate it only with a physical-response channel whose effect is distinguishable and repeatable
transferable_invariant: preserve normalized slow route feedback and the observed traveling bend; reject a redundant fast response channel when replicated rollouts do not separate it from self-generated carrier dynamics
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, full-body waveforms, exact vortex phases, organized-wake synchronization, and task-specific routes
policy_translation: retain body-frame LOS C-bend guidance and observed two-joint phase recruitment while removing the unsupported instantaneous yaw-moment release from the posterior half-cycle path
falsification: reject if the restored policy loses capture, leaves 18.6725--19.0080T, weakens either wake view, exceeds mean distance 2.02129L, or moves outside the sampled baseline load envelope

The current candidate's CFD result is not available in this worker and is not
claimed here; it becomes evidence only after this worker exits.
