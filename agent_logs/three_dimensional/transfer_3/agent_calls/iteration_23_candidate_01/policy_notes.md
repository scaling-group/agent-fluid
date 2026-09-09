# Error-conditioned hydrodynamic-release candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture termination. The fastest actuator-consistent sheet
  and the slower demand-lead sheet both show body-led self-propulsion. Their
  top-down rows retain a coherent alternating posterior vortex street from
  release through capture, and their oblique rows retain compact paired
  three-dimensional Lambda2 structures behind the swimmer. Neither view shows
  passive advection, wake collapse, collision, a boundary excursion, or a
  terminal loop; the sparse visual cadence does not resolve the small route
  differences, so trajectory and load diagnostics decide the comparison.
- Persistent same-side actuator gating is still the fastest sampled route. It
  captures at `18.67250T`, scores `-0.133625`, and has mean score distance
  `2.02129L`. Its cost is concentrated posterior clipping: action RMS is
  `24.95/28.85 rad/T^2`, anterior/posterior 99%-limit occupancy is
  `42.68%/76.41%`, and force/moment RMS is `0.01350/0.00703`.
- Releasing posterior phase whenever the measured hydrodynamic yaw moment
  already helps the requested recoil-conditioned correction is a useful but
  over-broad ablation. It preserves capture and the coherent wake, lowers
  action RMS to `24.41/28.56 rad/T^2`, limit occupancy to `40.95%/74.41%`,
  and force/moment RMS to `0.01306/0.00679`, but delays capture to
  `18.78799T`. The demand-lead and complementary amplitude-handoff variants
  also capture at `18.78799T` and `18.74950T`; neither improves the fast
  route. Thus helpful moment is a valid release cue, but its sign alone does
  not establish that the requested yaw correction is sufficiently satisfied.
- Local-flow RMS remains `0.01798--0.01809U` across the cohort, consistent
  with the visual diagnosis of a self-generated carrier in quiescent water.
  The evidence does not support adding wake rejection, route coordinates,
  carrier effort, range scheduling, or a larger steering gain.

## Policy hypothesis recorded before editing

Start from the sampled hydrodynamic-opposition policy, preserving its
normalized body-frame bearing and LOS-rate route request, recoil-conditioned
yaw response, continuous two-joint C-bend, response-reversing half-cycle,
persistent same-side actuator gate, fixed-norm posterior phase rotation, and
explicit componentwise feasibility projection.

Change one response-selection mechanism. Keep helpful hydrodynamic moment as
the release signal, but scale its release authority by correction satisfaction:
`1 - abs(tanh(yaw_rate_error / yaw_rate_error_scale))`. A large normalized yaw
error therefore retains the fast actuator-consistent phase response even when
the instantaneous moment has the correct sign; as observed yaw response closes
the error, helpful moment progressively releases phase steering. The product
of helpful-moment alignment and correction satisfaction is bounded and even
under reflection, uses no clock or mutable memory, and introduces no new gain.
It should interpolate physically between the fast no-release route and the
lower-load sign-only release rather than merely tune either branch's scalar.

Support requires capture no later than the hydrodynamic-release parent's
`18.78799T`, with stronger support from arrival nearer `18.67250T` while
retaining a material part of the parent's load relief. Falsify the mechanism
if capture is lost, arrival exceeds the half-cycle comparator near `18.931T`,
the alternating wake weakens, posterior occupancy exceeds `76.4%`, or
force/moment RMS exceeds `0.01574/0.00810`. The still-water evidence does not
establish robustness under stronger ambient flow.

The structured bookshelf reconsultation trigger is not met. The inherited
three-iteration window contains new actuator-consistency, sign-persistence,
and hydrodynamic-response mechanisms together with an earlier semantic timing
improvement over the replicated half-cycle baseline. This edit is derived from
the sampled hydrodynamic ablation rather than a shelf source, so no source-
transfer block is asserted.

The new CFD outcome is intentionally not claimed here; it becomes evidence
only after this worker exits.
