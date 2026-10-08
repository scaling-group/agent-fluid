# Posterior wave-allocation candidate

## Visual and trace diagnosis before the edit

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm) in an inertial
  moving window. Motion in both views is therefore self-propulsion rather than
  imposed advection or frame transport.
- The assigned parent, `solver_8b43d67d5abc`, is the strongest finite approach
  in the current sample. Its top-down row retains a compact alternating
  vorticity street through `38.484T`, and the oblique row confirms a coherent
  three-dimensional Lambda2 trail. It reaches `4.516L` near
  `(9.117,14.056)L` at `25.223T`, then passes above the target and exits left
  at `(0.798,13.778)L` with final distance `9.695L`. Thus the carrier is useful
  but the target remains about `4.56L` below its closest corridor.
- The parent's direct, sign-corrected route allocation is a small semantic
  improvement over the response-gated `solver_aaab22dcaa09`: minimum distance
  falls from `4.676L` to `4.516L` and left-exit height falls from `13.990L` to
  `13.778L`, while the long wake survives. It also outperforms the alternative
  phase-rejected course bias in `solver_74980306a278`, which reaches `5.016L`
  and exits at `y=14.360L`.
- That improvement calibrates steering side but also falsifies anterior route
  selection as sufficient authority. Replaying the parent's observations
  gives mean selectors of about `-0.81` over `12--20T` and `-0.94` over
  `20--30T`, yet mean center height stays at `14.055L` and `14.038L`; mean yaw
  response even changes sign between those intervals. One or both joint speeds
  exceed `250 deg/T` in roughly `57--58%` of those samples and one or both
  candidate accelerations reach the `30 rad/T^2` clamp in roughly `62%`.
  Stronger anterior drive or another selector-gain increase would therefore
  spend more command against the same limited channel rather than change the
  spatial wave shape.
- The informative `solver_12fc3441a636` failure agrees with the images and
  diagnostics: its alternating wake bends upward, terminates at only
  `20.790T`, and exits the upper margin at `(12.027,15.200)L`. Preserving the
  parent's response-calibrated negative side and long-wake scaffold is safer
  than returning to raw gait-contaminated yaw closure.

## Policy hypothesis

Preserve the assigned parent's state-feedback oscillator, symmetric anterior
phase pump, sign-corrected bearing/course selector, anterior half-cycle
allocation, soft headroom, and lagged posterior follower. Add one new spatial
allocation mechanism at the posterior target: use the same bounded route side
to redistribute the existing lagged tail wave between its two observed
half-cycles. A signed absolute-value transform of the lagged tail target makes
the requested-side excursion larger and the opposite excursion smaller while
leaving the zero-error traveling wave exactly unchanged. This changes wave
shape rather than adding a scalar propulsion gain, uses only joint state and
normalized body-frame geometry, and gives a saturated anterior request a
second moment arm without replacing the coherent carrier. The new posterior
component is faded by unused acceleration headroom, so a tail command already
at the parent's envelope is left unchanged.

Expected evidence is a coherent long wake whose centerline bends downward
before the `x=9L` station, a closest approach below `4.516L`, and a lower
left-exit corridor if capture is not yet achieved. Falsify the mechanism if it
returns to the early upper curl, loses the alternating three-dimensional wake,
fails to lower the parent corridor, produces the opposite turn, or increases
angle/speed/acceleration limit residence instead of redistributing it.

bookshelf_consulted: true
source_domain: robotic-fish CPG asymmetric flapping and elongated-body tail mechanics
source_mechanism: preserve the rhythmic traveling carrier while redistributing posterior excursion between the turn-useful and opposing half-cycles
transferable_invariant: a persistent direction error can steer by bounded half-cycle wave-shape asymmetry at the posterior moment arm without replacing the propulsive rhythm
nontransferable_details: published gains, clocked CPG phase, robot linkage geometry, species-specific amplitude envelopes, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: retain the parent's normalized body-frame route selector and anterior carrier, then apply its calibrated side to a bounded signed-absolute transform of the joint-state-derived lagged tail target
falsification: reject if the long wake collapses, the trajectory does not bend toward a lower corridor or beat 4.516L, the turn side reverses, or actuator-limit residence increases

## Non-CFD implementation audit

On the frozen `solver_8b43d67d5abc` states, an ungated posterior transform
would have raised raw tail-acceleration clamp residence from about `24.9%` to
`27.9%`. The final state-dependent headroom gate leaves the frozen-trace rate
at `24.9%`, preserves exact reflection equivariance, and bounds the tail-target
multiplier to `0.71--1.29`. This is an implementation/signal check only, not a
claim about the unevaluated flow response.
