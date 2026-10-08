# Terminal stroke-headroom redistribution candidate

## Visual diagnosis before the policy edit

- All four sampled solver rollouts are byte-identical v41 policy replications
  under the frozen direct-uniform still-water contract: `U_infinity=[0,0,0]`,
  no cylinders, no prewarm, and the L64 inertial moving window.  Each captures
  at `24.640015T` and `0.748356L`, with mean distance `2.347937L`, score
  `-0.448328283`, and `284` moving-window shifts.  The exact replication makes
  v41 the strongest finite sampled controller rather than four independent
  mechanisms.
- Both rows of the combined keyframe sheet were inspected from release through
  capture.  The top-down row begins wake-free, then shows self-propelled
  diagonal progress, a coherent alternating vortex street, and a compact
  transverse hook into the capture disk.  The oblique row shows bounded,
  compact three-dimensional Lambda2 structures throughout the same maneuver;
  there is no passive advection, instability, or out-of-plane escape.  No
  failed-rollout keyframe is present in the current sample.  The informative
  failure boundary therefore remains the inherited fixed-trace-audited
  posterior reference-velocity feedforward: it changed the far route by `8T`,
  missed at `0.993183L`, and exited left at `37.1470T` despite a coherent wake.
- Relative to the inherited v40 predicted-miss corridor, v41's observed-phase
  allocation is a replicated small improvement: arrival advances from
  `24.662014T` to `24.640015T`, mean distance falls from `2.348173L` to
  `2.347937L`, score improves from `-0.448570730` to `-0.448328283`, and final
  constant-velocity projected miss falls from `0.637713L` to `0.631928L`.
  V41 preserves zero sampled posterior hard-stop occupancy, the roughly `13.8%`
  exact-rate class, and low peak absolute body-force/yaw-moment coefficients
  (`0.0230/0.0317/0.0156`).
- The remaining terminal defect is actuator allocation rather than target
  inference.  On the completed trace the posterior angle stays near
  `-0.75` to `-0.768 rad` (about `-43` to `-44 deg`) through the final
  `2.1L`, while the selected negative terminal pulse is on the half-cycle that
  points the already-negative posterior joint farther outward.  The evaluated
  stopping-stroke reserve must then reject that part of the pulse.  Sending
  the same residual continuously to both joints therefore spends some bounded
  steering on a joint with little outward stroke headroom even though the
  anterior joint remains dynamically active.

## Policy hypothesis

Preserve v41's anterior state-feedback oscillator, posterior lagged wave,
body-frame collision-course signal, phase gate, far route, steering-priority
envelope, posterior stopping-stroke reserve, and posterior rate coast.  Add one
state-dependent control-allocation mechanism after the phase gate: estimate
posterior stopping-stroke proximity from its observed angle, outward rate, and
the owned acceleration envelope.  When the phase-selected terminal residual
would push that joint farther outward, continuously transfer only its
unavailable posterior share to the anterior joint.  Keep the sum of the two
terminal steering shares unchanged; do not synthesize acceleration, alter the
route request, or redistribute ordinary carrier and route steering.

This tests whether the already useful v41 terminal pulse can act through
available joint headroom instead of being discarded by the posterior safety
filter.  Expected evidence is exact v41 behavior outside the terminal
residual, retained capture and coherent wake, a smaller projected miss or
earlier crossing, and no increase in the signed steering request, posterior
hard-stop occupancy, raw-command class, exact-rate class, or peak load class.
Reject the mechanism if it changes the far route, loses capture, makes the
anterior phase anchor dwell at its rate limit, raises peak loads, or merely
reproduces v41 because the transferred pulse has no coupled effect.  The new
CFD evaluation occurs only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish control and asymmetric fish turning
source_mechanism: preserve a stable anterior-to-posterior traveling bend while sensory steering is allocated within a useful observed half-cycle
transferable_invariant: retain the observed-state phase anchor and posterior lag, but spend a bounded target-derived residual through whichever joint has compatible stroke headroom rather than increasing the residual when one joint is constrained
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: keep v41's normalized body-frame predicted-miss residual and phase gate, estimate posterior stopping-stroke proximity from joint angle and outward rate, and conserve the signed two-joint terminal share while transferring only the outward unavailable part to the anterior joint
falsification: reject if capture, far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class is lost, or if anterior rate occupancy increases without a meaningful arrival or miss improvement

## Pre-evaluation validation

- A pure fixed-trace comparison against all `4480` completed v41 states changes
  `238` command pairs, first at `21.983505T` and `2.098608L`, and changes none
  at or beyond `2.10L`.  Maximum same-state anterior/posterior command changes
  are `0.421594/0.355824 rad/T^2`, well below the owned
  `31.415927 rad/T^2` acceleration envelope.  The transferred terminal share is
  active on `238` rows, peaks at `0.211154 rad/T^2`, and conserves the summed
  anterior-plus-posterior terminal share to `2.22e-16`.  This establishes
  locality and materiality, not a coupled CFD result.
- A synthetic reflected pair gives identical posterior-unavailability gates
  (`0.876039`) and exactly opposite redistributed joint deltas.  The public
  contract returns two finite accelerations, and all `87` direct
  `params.FIELD` references resolve among the `89` fields returned by
  `target_policy_params()`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this ChatGPT account.  Its three declared no-CFD checks
  were therefore run directly and separately: reusable-guidance semantics,
  the Julia public contract, and the solver editable-boundary audit all pass.
  No formal CFD was run by this worker.
