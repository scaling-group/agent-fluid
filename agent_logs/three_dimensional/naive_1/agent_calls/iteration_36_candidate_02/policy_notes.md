# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. The assigned parent
  captures at `22.159500T`, with `0.748393L` crossing distance, `2.105808L`
  scored mean distance, score `-0.211168`, mean action about `59.830`,
  anterior/posterior exact-rate-cap occupancy `11.47/6.40%`, and peak
  normalized force/moment `0.030897/0.015839`.
- Both rows of all four combined sheets were inspected from release through
  capture. The top-down rows show self-propulsion rather than advection: an
  alternating red/blue street grows behind the caudal region by `4T`, follows
  the curved target-directed route, and remains attached through capture.
  The assigned parent, posterior-preview sample, and moment-response sample
  have complete oblique rows with discrete three-dimensional Lambda2
  structures following the moving caudal region at `4/12/20T` and capture.
  The anterior-redirect-preview sample has a black oblique row after its frame
  labels, which is a render-evidence failure rather than evidence of wake
  collapse. All top-down routes retain productive lateral oscillation without
  collision, domain exit, or visible loss of the carrier.
- Predicting the posterior half-cycle asymmetry envelope is the strongest
  sampled score result. Relative to the assigned parent, it preserves the
  identical `4/8T` launch at `11.299767/8.628953L`, improves `16T` distance
  from `3.979636L` to `3.974854L`, lowers scored mean distance to
  `2.105583L`, and improves score to `-0.210952`. It captures at
  `22.154001T`, with essentially unchanged rate-cap occupancy and peak loads;
  mean action rises modestly to about `59.932`. Its `20T` distance is only
  marginally better (`1.859209L` versus `1.860628L`, a `0.001419L` gain), so
  the result supports phase allocation but not greater carrier or steering
  gain.
- The inherited moment-qualified anterior-release hypothesis supplies a
  complementary response result rather than a score winner. It leaves the
  launch identical, lowers mean action to about `59.717`, improves the `20T`
  distance to `1.839655L`, and captures earliest at `22.093502T`. Its scored
  mean distance (`2.105699L`) still beats the parent, but a tight
  `0.749422L` first crossing makes score `-0.211397`, worse than both parent
  and posterior preview. Thus target-signed moment is useful for releasing
  redundant anterior burst authority, but complete release alone trades away
  the posterior-preview sample's earlier route advantage and crossing margin.
- The negative anterior-redirect-preview control remains decisive. It
  preserves the carrier, lowers mean action slightly, and is briefly ahead at
  `12T`, but falls behind at `20/22T`, captures at `22.285997T`, raises mean
  distance to `2.106929L`, and regresses score to `-0.212075`. Do not apply
  de-yawed target-line preview to the anterior burst or infer that lower action
  alone improves the route.

## One candidate hypothesis

Preserve the assigned parent's through-water course observation, anterior
speed recovery, full body-frame target geometry, proximity-previewed slow
curvature center, fixed-lead posterior recovery allocation, proximity-led
reactive rudder, phase-selective traveling carrier, and stroke-qualified
terminal relief. Form the already sampled proximity-predicted full target
error only for the posterior half-cycle asymmetry envelope, retaining
instantaneous target side and joint-state stroke phase. Independently release
only the existing anterior redirect when current target-signed normalized yaw
moment indicates that the fluid is already producing the requested response.
Keep the `0.30` tail-asymmetry ceiling, `16 rad/T^2` anterior redirect ceiling,
posterior rudder, recovery budget, carrier, and every existing parameter value
unchanged.

This is one bounded cross-joint response allocator: target-line prediction
moves an existing posterior carrier share toward the useful half-cycle, while
measured hydrodynamic response yields redundant anterior burst effort. It does
not add authority or tail load. The two sampled effects occupy complementary
paths and trajectory regions: posterior prediction improves the middle route,
whereas anterior release improves the late approach and action envelope. The
combination is deliberately a falsification test because prior evidence warns
that independently useful feedback paths need not compose. It adds no clock,
step count, coordinate, target identity, route memory, external phase, mutable
state, or prescribed vortex phase.

Falsify the combination if capture is lost, arrival is later than the moment-
response sample's `22.093502T`, scored mean distance exceeds the posterior-
preview sample's `2.105583L`, or score does not exceed `-0.210952`. Also reject
it if the identical `4/8T` launch changes,
the `16T` distance fails to preserve the posterior-preview advantage near
`3.974854L`, the `20T` distance fails to approach the moment-response bound
near `1.839655L`, mean action exceeds `59.932`, anterior/posterior exact-rate-
cap occupancy materially exceeds `11.49/6.42%`, peak normalized force/moment
exceed `0.030897/0.015839`, or valid top-down and oblique sheets fail to retain
the established alternating three-dimensional wake. Any positive fixed-pose
still-water result would establish local compatibility, not robustness to
changed pose, inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish asymmetric flapping and bounded biological burst redirect
source_mechanism: retain a posterior-delayed propulsive rhythm while measured route evolution allocates a useful half-cycle and target-signed hydrodynamic response releases redundant burst effort
transferable_invariant: steering can be redistributed across observed carrier phase and yielded when measured body response appears, without increasing total authority or suppressing the traveling bend
nontransferable_details: published gains, dimensional moment scales, robot linkage geometry, species-specific burst envelopes, distributed-body kinematics, clocked oscillator phase, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: use normalized body-frame target-line prediction to gate only the existing posterior asymmetry envelope and `geometric_turn * moment_z_L2` to release only the existing anterior redirect, retaining instantaneous target side, joint-state phase, posterior rudder, recovery, carrier, and all ceilings
falsification: reject if the combination fails to beat the sampled `22.093502T` arrival and `2.105583L/-0.210952` distance-score bounds, changes the launch, or worsens the complete two-view wake, action, saturation, force, or moment envelopes
