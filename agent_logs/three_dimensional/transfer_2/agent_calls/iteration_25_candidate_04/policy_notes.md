# Terminal phase-selective collision-course candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform still
  water (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the L64 inertial
  moving window.  Three byte-identical v40 predicted-miss-corridor samples
  capture at `24.662014T`, minimum/final distance `0.748606L`, mean distance
  `2.348173L`, and score `-0.448570730`.  The distinct v39 parent captures at
  `24.678516T`, `0.748602L`, `2.348208L`, and `-0.448571249`.
- Both rows of the v39 and v40 combined keyframe sheets were inspected from
  release through capture.  Their top-down rows begin wake-free and show
  self-propelled diagonal progress, a coherent alternating mid-plane vortex
  street, and the same compact transverse terminal hook.  Their oblique rows
  retain compact three-dimensional Lambda2 structures through capture.  The
  trajectories and wake classes are visually indistinguishable; neither is
  passively advected, unstable, or escaping out of plane.
- No failed-rollout keyframe is present in the current sample.  The informative
  failure comparison is therefore limited to the inherited audited evidence,
  not an invented visual claim: posterior reference-velocity feedforward
  retained a coherent wake but changed the far route by `8T`, missed at
  `0.993183L`, and exited left at `37.1470T` and `6.9973L`.
- V40's collision-corridor release is reproducible but nonsemantic.  Relative
  to v39 it captures only three integration rows (`0.016502T`) earlier and
  improves mean distance by `0.000034L`, while final projected miss grows
  slightly from `0.63638L` to `0.63771L`, terminal course angle worsens from
  `58.221` to `58.415 deg`, and the visual route, roughly `13.9%` exact-rate
  exposure, zero posterior hard-stop occupancy, and low peak planar
  force/yaw-moment class remain unchanged.  The completed v38 course bridge,
  v39 coupled residual, and v40 magnitude corridor constitute three local
  iterations without a new trajectory or termination class, triggering the
  structured bookshelf consultation.
- Fixed-trace geometry explains why magnitude tuning is weak: v40's
  instantaneous projected miss oscillates from about `0.699L` at `1.00L`
  range to `0.896L` at `0.90L`, `0.781L` at `0.80L`, and `0.638L` at capture
  as the state-feedback gait advances.  Another corridor gain would react to
  the same within-beat course variation without changing how steering is
  allocated to the observed bend cycle.

## Policy hypothesis

Start from the replicated v40 controller and change one actuator mechanism,
not a scalar.  Preserve the anterior state-feedback oscillator, lagged
posterior traveling wave, sector and course-preview paths, predicted-miss
corridor, steering-priority envelope, posterior stroke braking, posterior
coast, and all route-scale gains.  Separate the extra collision-corridor
course residual from the mean-curvature request.  Apply that same bounded
residual only as a coupled steering pulse on the observed lagged tail-wave
half-cycle aligned with its signed turn request; let it vanish continuously on
the opposed half-cycle.  Phase is inferred only from anterior joint position
and rate, with no clock or stored oscillator state.

This tests whether terminal course support is more effective when allocated
within the traveling bend than when held as a small mean curvature.  Expected
evidence is exact v40 behavior outside the terminal residual's support,
retained capture and coherent wake, no increase in the existing turn-request
or acceleration envelopes, no posterior hard-stop return, and a material
reduction in unnecessary terminal residual duty or load without worsening
arrival or distance integral.  Reject the mechanism if capture is lost, the
far trajectory changes, the terminal pulse increases peak command/load class,
or it merely produces an inert/noisy same-route perturbation with no semantic
benefit.  The new CFD outcome is not available to this worker and is not
claimed here.

bookshelf_consulted: true
source_domain: asymmetric fish turning and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: bounded half-cycle asymmetry steers by allocating correction within a stable anterior-to-posterior traveling bend rather than replacing the rhythm with static curvature
transferable_invariant: preserve the anterior phase anchor and posterior lag, infer phase from observed joint state, and spend a bounded target-derived steering residual only on the half-cycle aligned with the requested turn
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v40's normalized body-frame predicted-miss residual and safety gates, remove that residual from mean-curvature drive, and apply it through a mirror-equivariant gate formed from the observed anterior oscillator's lagged tail-wave state
falsification: reject if capture, far-route noninterference, coherent wake, zero posterior hard-stop occupancy, or the low-load class is lost, or if phase selection raises peak command while providing no meaningful terminal improvement

## Pre-evaluation validation

- A pure-function reconstruction of all `4484` completed v40 states returns
  finite commands.  Relative to v40, the candidate changes `407` state
  outputs, first at `21.983506T` and `2.098608L`, with exactly zero same-state
  difference at or beyond `2.10L`; maximum same-state acceleration difference
  is `3.06625 rad/T^2`.
- V40's collision-course residual is nonzero on `407` reconstructed rows.  The
  lagged-wave phase gate retains a bounded portion on `245` and sets it exactly
  to zero on `162`; summed absolute allocated residual is `24.7088` versus
  `68.1656` before phase allocation, and the sampled gate spans `[0,0.70969]`.
  The gate uses `drive.tail_wave_side` rather than total tail tangent because
  the latter remains one-sided while the posterior joint is near its stroke
  reserve and would reduce the edit to scalar attenuation.
- A reflected synthetic terminal observation gives equal phase gates and
  opposite signed course residual, lagged-wave phase, and allocated residual
  to machine precision.  The public policy probe returns two finite joint
  accelerations.  These are contract, locality, and symmetry checks only, not
  coupled hydrodynamic evidence.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this ChatGPT account.  Its three declared no-CFD checks
  were therefore run directly and separately: reusable-guidance semantics,
  the exact Julia public contract, and the solver editable-boundary audit all
  pass.  The deterministic schema guard resolves all `87` direct
  `params.FIELD` references among the `89` fields returned by
  `target_policy_params()`.  No formal CFD was run.
