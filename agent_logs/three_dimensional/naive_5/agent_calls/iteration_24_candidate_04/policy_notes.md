# Wake-policy candidate notes

## Evidence diagnosis before editing

All four sampled rollouts satisfy the direct-uniform still-water contract with
`U_infinity=(0,0,0)`, no cylinders, and no prewarm, and all terminate in
capture.  Three sampled candidates byte-match in their combined visual sheet
and trajectory, capturing at `0.749242L/26.2955T`; the assigned parent is the
only distinct rollout and captures at `0.749090L/26.3010T`.  Thus the samples
provide one controlled mechanism comparison, not four independent routes or
held-out robustness.

In both unique combined sheets, the top-down row shows genuine self-propelled
translation and an organized alternating vorticity street through the late
downward hook.  The oblique row shows a compact coherent three-dimensional
Lambda2 wake following the same path.  Wake advection trails the fish through
252 inertial moving-window shifts, so neither imposed flow nor storage motion
explains the approach.  No sampled non-capture sheet is available; the
informative failures are inherited logs in which terminal waveforms, recoil,
damping, deeper curvature, and beat-scale projected-intercept holds kept a
coherent wake but missed at about `0.828--1.096L` or diverged earlier.

The common acceleration projection remains the strongest sampled carrier
improvement: all four current traces have zero angle, exact-speed, and
acceleration contacts, maxima near `0.766/0.772 rad`, `4.513/4.507 rad/T`, and
`29.726/29.686 rad/T^2`, and peak planar force/yaw moment remains
`0.01883/0.00979`.  Preserve that carrier and its viability filters.

The assigned parent's new fixed-yaw capture-corridor residual does not survive
its falsification boundary.  Relative to the three command-projected samples,
it changes no peak limit or load statistic, delays first crossing by one
`0.0055T` step, reduces terminal speed only from `0.64841` to `0.64421L/T`, and
changes projected miss only from `0.70533` to `0.70389L`.  The terminal
topology remains a fast tangential crossing.  This is not a material clearance
or trajectory improvement, so another scalar increase of its yaw target or
half-cycle acceleration is unsupported.

The translational diagnosis is sharper than a yaw deficit.  On the assigned
parent, projected miss is about `2.04L` at distance `2.50L`, `1.81L` at
`2.00L`, `0.90L` at `1.00L`, and `0.704L` at capture.  Terminal radial closing
is only `0.220L/T` of `0.644L/T` total speed, while the course is about 94%
tangential in the normalized target frame.  Adding near-target yaw authority
therefore acts after the propulsive carrier has already built a largely
tangential velocity.  The next candidate should change the propulsion-versus-
steering allocation in the middle approach without replacing the productive
rhythm or reopening a failed pulse/braking waveform.

## Policy hypothesis

Retain the assigned parent's target/course selector, same-sign redirect,
terminal release veto, positive line-of-sight and capture-corridor residuals,
coordinated acceleration projection, and angle/rate viability guards.  Add one
continuous tangential-energy relief mechanism to the anterior carrier: between
the middle and near approach, use target distance and the dimensionless
body-frame course cross product to smoothly reduce only the phase-energy pump
when motion is strongly tangential to the target line.  Leave the oscillator's
restoring dynamics, posterior lagged follower, every steering residual,
sub-threshold gait, and all downstream safety authority unchanged.  This is an
observation-gated propulsion/steering arbitration, not a global gain retune or
an explicit reverse/braking pulse.

The falsifiable expectation is a materially smaller tangential-speed fraction
or projected miss on approach while retaining capture, the coherent two-view
wake, zero actuator contacts, and comparable force/moment peaks.  Reject the
mechanism if the middle-distance route or rhythm collapses, capture is lost or
materially delayed, terminal speed changes without improving course geometry,
limit contacts return, or peak planar force/yaw moment exceeds the assigned
parent.  Formal CFD occurs only after this worker exits and is not claimed
here.

bookshelf_consulted: true
source_domain: reactive traveling-wave fish propulsion and sensor-modulated robotic-fish CPG terminal control
source_mechanism: posterior-coordinated rhythmic bending supplies propulsion while bounded observed-state modulation reallocates authority between cruise and approach behavior
transferable_invariant: preserve the stable traveling-bend scaffold, but reduce active rhythmic energy injection when normalized target-frame motion is dominated by tangential rather than closing velocity so existing steering has time and authority to redirect the course
nontransferable_details: published gains, dimensional frequencies, species-specific amplitudes, exact vortex phases, approach radii, and task-specific routes
policy_translation: retain normalized body-frame target feedback and both-joint safety projections; smoothly attenuate only the anterior phase pump inside a distance window and above a dimensionless course-tangency threshold, leaving restoring, lag, steering, and braking terms intact
falsification: reject if coherent propulsion or capture is lost, the far or low-tangency carrier changes, projected miss or tangential-speed fraction does not improve, arrival regresses materially, or actuator contacts and hydrodynamic loads rise

## Non-CFD implementation audit

- On the completed assigned-parent trace, the normalized relief gate is
  nonzero only from `22.462T` onward as distance falls below `2.75L`.  The
  phase-pump scale is about `0.965` at `2.50L`, `0.743` at `2.00L`, `0.478` at
  `1.50L`, and reaches its bounded `0.35` floor near `1.00L`.  Low-tangency
  and farther states pass through exactly.
- Reconstructing body-frame observations and the seven-sample bearing/turn
  window from the parent trajectory changes `485/4782` final two-joint
  commands over `22.462--26.301T`, with maximum command difference about
  `2.112 rad/T^2` and zero changes at or beyond `2.75L`.  This establishes
  material, localized activation only; replaying states is not a closed-loop
  CFD prediction.
- The lightweight policy contract, finite/bounded output check, exact far-state
  comparison, and reflected near-state comparison pass.  The new gate leaves
  the posterior command unchanged directly, and reflected observations negate
  both final commands to floating-point tolerance.  The solver boundary check
  also passes; no CFD was run in this workspace.
