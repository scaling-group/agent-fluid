# Head-point intercept-corridor terminal release

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the Phase-2 evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture from
  `12.327720 L` at `25.118523 T` after 268 window shifts. Three byte-identical
  intercept-corridor policies reproduce score `-0.5280772274`, mean distance
  `2.4290872138 L`, and final distance `0.7461352944 L`. Together with the
  assigned parent's separately completed identical rollout, this is four-way
  reproduction of the current best mechanism rather than a new semantic
  improvement.
- The force-vetoed intercept sample is the most informative current negative
  contrast. It retains capture at the same step but regresses to score
  `-0.5280778498`, mean distance `2.4290877051 L`, and final distance
  `0.7461359501 L`. Its outer joint extrema and trajectory topology remain
  unchanged. Instantaneous lateral force therefore should not be stacked
  onto, or given veto authority over, this already supported geometric
  response.
- I inspected the complete combined sheets for the strongest reproduced
  intercept rollout and the force-veto regression, including both top-down
  vorticity and oblique body/Lambda2 rows. They are visually coincident at
  sheet resolution: the fish self-propels along a compact target-directed arc,
  leaves a coherent alternating planar wake and finite 3D vortex packets, and
  transitions to a quiet held-bend glide before capture. Neither shows passive
  advection, wasteful terminal oscillation, a loop, collision, domain-exit
  precursor, out-of-plane excursion, or numerical instability. The ranking is
  a subtle terminal allocation result, not evidence for changing the outer
  traveling carrier or its posterior lag.
- Telemetry reinforces that boundary. Below `1.6 L`, the reproduced parent has
  action maxima near `0.09772/0.24610 rad/T^2`, peak force norm `0.002193`,
  peak moment magnitude `0.0005650`, posterior angle below `0.2172 rad`, no
  joint-stop dwell, and no command above `30 rad/T^2`. Its translational
  center-velocity miss contracts monotonically from about `0.685 L` to
  `0.228 L`; thus extra damping, mean-bend unloading, phase allocation, or
  larger release is unsupported.
- The surviving intercept calculation nevertheless uses center velocity even
  though both `distance_L` and capture are defined at the head. Reconstructing
  the observable head-point kinematics from the stored parent trajectory gives
  a monotonically contracting miss of about `0.429 L` to `0.086 L` below
  `1.6 L`. This calculation uses range closure and inertial line-of-sight rate,
  where body rotation cancels as `turn_rate_recent - bearing_window_rate`; it
  does not infer a lever arm or morphology. A `0.34/0.15 L` smooth corridor is
  active on 158 of the 226 stored terminal states and fully active on 47,
  versus 160 and 42 for the center-velocity gate. Mean support changes only
  from `0.4542` to `0.4596`, with maximum support difference about `0.0344`,
  so this is a distinct capture-point semantic without a larger authority
  regime.

## Policy hypothesis

Preserve the reproduced parent's state-feedback oscillator, posterior lag,
target-angle redirect, scalar closure preview, shared two-joint mean-curvature
equilibrium, helpful-crossflow and settled-response gates, coupled carrier
release, and all command limits. Replace only the center-translation intercept
estimate with a head-point interception cone. Combine normalized observed
range closure with the inertial line-of-sight rate reconstructed from the
matched-window body bearing and turn rates; use their radial/tangential
velocity vector to predict the head's constant-velocity cross-track miss. The
same maximum `3.5%` paired release is earned only inside a compact head-miss
corridor, while positive closure, late proximity, helpful relative crossflow,
and settled two-joint response remain mandatory.

This is one new approach-hold state-feedback mechanism, not scalar-only gain
tuning: the controlled prediction point changes from the body center to the
actual capture point without adding force cancellation, yaw damping, static
curvature, beat-side logic, joint-role splitting, clock state, or a route. The
reconstructed corridor closely matches the parent's activation budget and all
outer commands remain protected by the inherited late response gates. Reject
it if stored-state replay is dormant or materially enlarges release, if the
outer path changes, capture is delayed or lost, mean/final distance or
head-point miss worsens, a late loop develops, or terminal oscillation, joint
stops, saturation, load growth, instability, or wake degradation returns.

bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated robotic-fish rhythmic direction tracking
source_mechanism: relax corrective rhythmic allocation only after the measured capture point demonstrates a bounded viable intercept while retaining the propulsive scaffold
transferable_invariant: target-relative range and line-of-sight response can continuously release a redirect after normalized capture-point kinematics predict a small miss
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and lever arms, duty ratios, clock or vortex phase, capture radius, and task-specific routes
policy_translation: reconstruct normalized inertial line-of-sight rate from matched-window body bearing and turn rates, combine it with positive head-range closure, and gate only the inherited small coupled carrier release by the resulting bounded head-point miss
falsification: reject if the gate is inactive or materially enlarges release, affects the outer path or mean bend, delays or loses capture, worsens distance or head miss, or restores oscillation, joint stops, saturation, load spikes, instability, or wake loss

The new candidate's CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.

## Non-CFD implementation audit

- The prescribed guidance check passes after removing the duplicated prefill
  marker from the rendered workspace README. The lightweight Julia contract
  returns two finite accelerations. The deterministic schema audit finds all
  77 direct `params.FIELD` references in the 78-field object returned by
  `target_policy_params()`; the extra field is the version label. The solver
  boundary check also passes.
- Replaying the candidate and evaluated parent algebra on all 4,567 stored
  parent states gives exactly zero command difference at and beyond `1.6 L`.
  Inside the band, the new predictor changes 118 of 226 stored commands; mean
  absolute changes are about `0.0000156/0.0000352 rad/T^2`, maxima are about
  `0.0000970/0.0002266 rad/T^2`, and final-step difference is zero. Parent and
  candidate gate means are `0.4542` and `0.4596`, respectively, so the new
  semantic does not materially enlarge release authority.
- This audit establishes observation use, bounded activation, finite output,
  schema integrity, and exact outer noninterference on a stored trajectory
  only. Capture, score, loads, trajectory response, and wake structure remain
  future coupled-flow evidence.
