# Terminal stroke-headroom redistribution candidate

## Visual diagnosis before the policy edit

- All four sampled solvers are exact replications of the v41 terminal
  phase-allocation policy: their policy, trajectory, and combined-keyframe
  hashes match.  Each uses direct uniform still water
  (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the L64 inertial
  moving window; each captures at `24.640015T`, minimum/final distance
  `0.748356L`, mean distance `2.347937L`, and score `-0.448328283`.
- The combined sheet and both view-specific sheets were inspected from release
  through capture.  The top-down view starts wake-free and then shows
  self-propelled diagonal progress, a coherent alternating mid-plane vortex
  street, and a compact terminal hook into the target disk.  The oblique view
  shows bounded three-dimensional Lambda2 structures persisting through the
  same maneuver.  There is no visible passive advection, out-of-plane escape,
  instability, or terminal collision-like load event; the diagnostics agree,
  with low peak planar body-force/yaw-moment coefficients of about
  `0.0230/0.0317/0.0156`.
- No sampled failure keyframe exists, so failure contrast is limited to
  inherited completed logs rather than an invented visual comparison.
  Posterior reference-velocity feedforward changed the established far route
  by `8T`, missed at `0.993183L`, and exited left at `37.147T`; broad
  dual-joint rate barriers also changed capture into pass-and-exit failures.
  Those negatives rule out another widespread phase/rate correction and make
  strict terminal locality a requirement.
- V41's observed-phase allocation is a small but replicated improvement over
  the inherited v40 corridor parent: capture is `0.021999T` earlier, mean
  distance is `0.000236L` lower, score is `0.000242448` higher, and final
  projected miss falls from `0.637713L` to `0.631928L`, while the coherent
  route, zero posterior hard-stop occupancy, and low load/rate classes remain.
  The remaining completed-trace defect is allocation: through the final
  `2.1L`, the posterior angle stays near `-0.75` to `-0.768 rad` while the
  selected negative terminal pulse points it farther outward, so the evaluated
  stopping-stroke reserve must discard part of an otherwise bounded request.

## Policy hypothesis

Preserve v41's anterior state-feedback phase anchor, posterior traveling-wave
lag, normalized body-frame predicted-miss signal, terminal phase gate, far
route, steering-priority envelope, posterior braking reserve, and posterior
rate coast.  Add one allocation mechanism after the phase gate: predict
posterior stroke proximity from its observed angle and outward rate using the
owned acceleration envelope.  When the terminal pulse would push the
posterior joint farther outward, continuously transfer only the predicted
unavailable part of that posterior share to the anterior joint.  Conserve the
sum of the two terminal shares and do not synthesize acceleration, alter the
route request, or redistribute the ordinary carrier and route steering.

The formal post-worker rollout should retain exact v41 behavior outside the
`2.10L` terminal support, capture, the coherent wake, zero posterior hard-stop
occupancy, and the low-load class while improving arrival or projected miss.
Reject the mechanism if it changes the far route, loses capture, increases
anterior rate-limit dwelling or peak loads, or is dynamically inert because
the transferred share is clipped.  Fixed-trace checks below establish only
locality, boundedness, conservation, and reflection symmetry; they are not CFD
evidence.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish control and asymmetric fish turning
source_mechanism: sensory steering is allocated within a useful observed half-cycle while preserving the stable anterior-to-posterior traveling bend
transferable_invariant: retain the joint-state phase anchor and posterior lag, but spend an existing bounded target-derived residual through compatible actuator stroke headroom instead of increasing the residual when one joint is constrained
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: keep v41's normalized body-frame predicted-miss residual and phase gate, estimate posterior stopping-stroke proximity from joint angle and outward rate, and conserve the signed two-joint terminal share while transferring only its predicted-unavailable outward tail portion to the anterior joint
falsification: reject if capture, far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class is lost, or if anterior rate occupancy increases without a meaningful arrival or miss improvement

## Pre-evaluation validation

- A pure fixed-trace comparison against all `4480` completed v41 states changes
  `238` command pairs, first at `21.983505T` and `2.098608L`, and changes none
  at or beyond `2.10L`.  Maximum same-state anterior/posterior command changes
  are `0.421595/0.355824 rad/T^2`, far below the owned
  `31.415927 rad/T^2` acceleration envelope.
- The transferred terminal share is active on the same `238` rows and peaks at
  `0.211154 rad/T^2`.  The anterior-plus-posterior terminal share is conserved
  to `5.56e-17`, and a synthetic reflected joint state produces identical
  unavailability and exactly opposite transfer to machine precision.  These
  are locality, boundedness, conservation, and mechanism-symmetry checks, not
  coupled hydrodynamic evidence.
- The Julia public-policy probe returns two finite accelerations
  (`-14.3858335`, `0.0005062`).  The deterministic schema audit resolves all
  `87` direct `params.FIELD` references among the `89` fields returned by
  `target_policy_params()`.
- The configured no-CFD check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account.  Its three prescribed
  commands were therefore run directly and separately: reusable-guidance
  semantics, the Julia public contract, and the solver editable-boundary audit
  all pass.
- Formal CFD is reserved for the post-worker evaluator; no new score, capture,
  wake, or load result is claimed here.
