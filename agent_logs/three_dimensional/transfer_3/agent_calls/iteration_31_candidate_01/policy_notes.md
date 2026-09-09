# Actuator-consistent phase-route recovery candidate

## Evidence diagnosis recorded before policy selection

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture at `18.6560--18.7440T`. The assigned-parent rollout is
  also a capture. There is therefore no sampled termination failure; the
  informative negative result is failure of an allocator's claimed route or
  effort separation under exact replication.
- I inspected every sampled combined keyframe sheet from release to capture.
  In all four top-down rows the body advances toward the target while shedding
  a coherent alternating red/blue posterior vorticity street. The oblique rows
  independently show compact paired three-dimensional Lambda2 structures
  behind the moving body through target closure. None shows passive advection,
  growing wasteful lateral motion, wake collapse, collision, boundary exit, or
  instability. Direct-zero initialization and local-flow RMS
  `0.01807--0.01815U` confirm self-propulsion, so the close route/effort
  differences cannot be ranked from wake drama alone.
- The actuator-consistent prefill captures at `18.6725T`, score `-0.13362`,
  trajectory-mean distance `7.56353L`, anterior/posterior acceleration-limit
  occupancy `42.15%/76.11%`, action RMS `24.95/28.85 rad/T^2`, and vector-force/
  moment RMS `0.01350/0.00703`. It preserves the established normalized
  bearing-plus-LOS-rate route, distributed C-bend, response-reversing
  half-cycle path, persistent same-side stress gate, and bounded posterior
  phase rotation.
- Raw helpful-moment amplitude relief is the best sampled run at `18.6560T`,
  score `-0.13321`, with modestly lower occupancy, action, and loads. The
  assigned parent then replicated that exact policy and still captured, but
  its `3453` steps imply about `18.9915T` and its score falls to `-0.15772`.
  The inherited artifact exposes no matching trajectory/load history, so this
  completed repeat falsifies a robust route-speed claim and cannot establish a
  repeatable effort benefit. It does not justify another moment scale.
- The other current physical-response allocators also preserve capture and the
  wake but do not improve route cost: stress-confirmed raw-moment relief reaches
  `18.7440T` and the phase-demodulated residual reaches `18.7165T`. Inherited
  notes additionally report that one-sided carrier-demodulated effort relief,
  bidirectional residual allocation, and instantaneous LOS anterior release
  all fail their own replication or route bounds. The reusable evidence points
  back to separation of route geometry from instantaneous physical response.

## Policy hypothesis recorded before policy selection

Use the prefilled `dogfish3d_actuator_consistent_tail_phase_v1` policy exactly
as the single candidate. Preserve normalized body-frame bearing and LOS-rate
guidance, recoil-conditioned yaw response, continuous two-joint C-bend,
state-feedback traveling carrier, response-reversing half-cycle steering,
persistent same-side actuator-consistency recruitment, coefficient-norm-
preserving posterior phase rotation, and componentwise feasibility projection.
Do not give instantaneous yaw moment, force, flow, or LOS counter-response a
second allocator role. This is an evidence-led recovery/replication, not a
claim that the current worker has new CFD evidence.

Support requires capture inside the inherited successful
`18.6725--19.0520T` route band, coherent top-down and oblique wakes, posterior
acceleration-limit occupancy no greater than `76.2%`, and vector-force/moment
RMS no greater than `0.01350/0.00703`. Falsify the recovery if capture is lost,
arrival leaves that band, either wake weakens, or load/occupancy exceeds those
bounds. A later architecture should then require a genuinely beat-scale
observable rather than another scalar tune or instantaneous physical-response
gate.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and phase-lag steering of a propulsive traveling wave
source_mechanism: preserve the primary rhythmic carrier while bounded observed-state phase modulation supplies steering separately from the slow route command
transferable_invariant: slow body-frame target geometry owns route demand, the productive posterior-lagged rhythm remains intact, and only bounded joint-state phase response is recruited near persistent actuator stress
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, organized-wake synchronization, and task-specific routes
policy_translation: use normalized body-frame bearing and LOS rate for route guidance; use observed two-joint angle, velocity, previous feasible action, and recoil-conditioned yaw error for response-reversing half-cycle and posterior phase recruitment
falsification: reject if capture leaves 18.6725--19.0520T, either wake loses coherence, posterior acceleration occupancy exceeds 76.2%, or vector-force/moment RMS exceeds 0.01350/0.00703

The candidate's CFD outcome is evaluated only after this worker exits and is
not claimed as evidence here.
