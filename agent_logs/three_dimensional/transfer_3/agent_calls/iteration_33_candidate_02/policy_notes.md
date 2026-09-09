# Actuator-consistent phase recovery candidate

## Evidence and visual diagnosis recorded before editing

- All four assigned solver examples satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite dynamics,
  and capture at `18.6560--18.7440T`. The two exact
  `dogfish3d_actuator_consistent_tail_phase_v1` samples both capture at
  `18.6725T`, although their scores span `-0.13362-- -0.13219`. The prefilled
  raw helpful-moment relief reaches `18.6560T`, but the assigned-parent log
  records its exact-policy repeat near `18.9915T`; its apparent `0.0165T`
  advantage is therefore smaller than same-policy timing variation.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  the best-score exact phase sample, the slower stress-gated capture, and the
  prefilled helpful-moment sample. From wake-free release, each fish translates
  under its own motion and forms an alternating body-led street by `4T`; the
  street and compact three-dimensional structures remain organized through
  capture. Their nearly indistinguishable trajectory and wake topology, plus
  local-flow RMS near `0.018U` in the inherited analysis, support preserving
  the carrier rather than assigning the small score differences to advection
  or wake survival.
- The assigned optimizer logs provide the informative termination failure.
  Phase-conditioned route bearing keeps a coherent wake but reaches only
  `1.6947L`, turns into a large loop after about `20T`, and exits left at
  `32.5654T` with final range `10.7380L`. The top-down and oblique rows visibly
  change from continuous target closure to a sharp cross-route turn; this is a
  route-semantic failure, not wake breakup or numerical instability. Subtracting
  a fitted joint-phase projection from bearing should therefore be avoided.
- The latest inherited outcomes also close the instantaneous-response branch.
  One-sided carrier-demodulated moment recruitment captures at `18.6890T` but
  has mean distance `2.02295L` and effort inside the exact phase controller's
  sampled spread. Carrier-demodulated helpful-response relief captures later at
  `18.7495T` with mean distance `2.02850L`. A third exact actuator-consistent
  evaluation captures at `18.7275T` with mean distance `2.02493L`. Thus the
  semantic result that survives current evidence is replicated capture by the
  plain phase route; no moment allocator supplies a replicated route or effort
  improvement.

## Candidate hypothesis

Create exactly one recovery candidate by replacing the prefilled raw
helpful-moment amplitude relief with the exact sampled
`dogfish3d_actuator_consistent_tail_phase_v1` controller. Preserve normalized
body-frame bearing plus LOS-rate guidance, the distributed C-bend, the
state-feedback traveling carrier, response-reversing half-cycle steering,
persistent same-side feasible-action recruitment, bounded posterior phase
rotation, and componentwise feasibility projection. Remove the instantaneous
yaw-moment observation and its yaw-closure amplitude gate; add no scalar gain
change and no new route observation.

This is an evidence-backed robustness improvement over the assigned raw-moment
candidate, not a same-worker CFD claim. Support requires another capture with
both wake views coherent, arrival inside the directly observed
`18.6725--18.7275T` three-run band (or at least the inherited successful
`18.6725--19.0520T` band), posterior acceleration occupancy no higher than
`76.2%`, and force/moment RMS no higher than `0.01350/0.00703`. Falsify the
recovery if it loses capture, develops the inherited looping trajectory,
weakens the alternating wake, or exceeds those effort bounds.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: classical slender-fish propulsion, sensor-modulated robotic-fish CPG control, and wake-adaptive swimming
source_mechanism: retain a posterior-lagged traveling bend for propulsion and separate slow body-frame route demand from fast hydrodynamic response before allocating an extra feedback channel
transferable_invariant: preserve the productive state-feedback rhythm and normalized route loop unless a distinct observed disturbance signature supports the smallest bounded residual correction
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, cylinder geometry, and source-task routes
policy_translation: retain body-frame LOS C-bend guidance, observed joint phase, and previous feasible action; remove the unreplicated instantaneous moment allocator and do not treat the available seven-sample `0.0385T` window as a beat-scale state
falsification: reject if exact phase recovery loses capture, leaves the inherited successful timing band, weakens either wake view, exceeds `76.2%` posterior acceleration occupancy or `0.01350/0.00703` force/moment RMS, or if a future true beat-scale observable replicably separates route and effort without those costs

The new candidate's CFD evaluation occurs only after this worker exits and is
not used as evidence here.
