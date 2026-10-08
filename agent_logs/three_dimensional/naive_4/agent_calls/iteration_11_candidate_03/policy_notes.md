# Wake policy candidate notes

## Evidence diagnosis

- All four sampled rollouts satisfy the experiment contract: direct uniform
  initialization, `U_infinity=[0,0,0]`, no cylinders, finite dynamics, and
  capture. The combined sheets were read from release through termination in
  both the top-down mid-plane and oblique Lambda2 rows.
- `solver_5739c176b0d4`, `solver_a0cc85d2f5b2`, and the assigned prefill
  `solver_bf77448adfd7` have identical CFD trajectories and capture at
  `16.0435T` with score `-0.058311`. The prefill's exact-boundary
  velocity-limit projection therefore made no semantic change relative to the
  unprojected carrier-phase-residual policy. It should not be stacked as if it
  were an evidenced hydrodynamic improvement.
- In the strongest sampled sheet (`solver_5739c176b0d4`), the fish is visibly
  self-propelled: the body advances against still water while a coherent
  alternating reverse-street-like mid-plane wake grows behind it, and the
  oblique row retains compact three-dimensional Lambda2 structures through
  capture. There is no wake collapse, passive advection, collision, domain
  exit, or instability. Posterior and anterior joint speeds both touch the
  `260 deg/T` limit, while acceleration-limit residence is `22.7%` posterior
  and `47.8%` anterior; nevertheless, the inherited velocity projection does
  not alter the sampled path.
- `solver_1199437e225a` is the informative regression. Its same wake class
  remains coherent, but every approach milestone is later: `8L` at `9.246T`
  versus `9.202T`, `2L` at `15.026T` versus `14.905T`, and `0.8L` at
  `16.170T` versus `16.000T`. It captures at `16.225T` with score `-0.064416`
  and finishes with much more world-frame lateral motion
  (`[-0.869,-0.621]U` versus `[-1.096,-0.232]U`). Mean absolute body-force
  coefficients and yaw moment remain close to the fastest run, so the slower
  progress is a route/control difference rather than missing propulsion or a
  dramatic load event. This comparison does not isolate terminal unloading
  because that sample also lacks the successful carrier-phase residual.
- Reconstructing the fastest rollout's normalized body-frame bearing, course,
  and joint-phase residual shows the remaining selector flaw. Unrestricted
  subtraction enlarges `abs(response_error)` on `20.98%` of states and crosses
  zero on `3.84%`. Its mean reconstructed strong-redirect gate is `0.42088`.
  Removing a predicted carrier component only when it has the same sign as the
  raw error, capped so it cannot cross zero, lowers the fixed-trace gate to
  `0.40787`; the reduction persists from the `8-12L` transit through the
  sub-`1.2L` approach.

## Policy hypothesis

Use a one-sided carrier-phase residual solely to select high redirect
authority. The normalized anterior phase model may remove only the portion of
the raw target-versus-course error that it explains in the same direction,
and the removal is capped by the raw magnitude. Raw body-frame error continues
to determine bend direction and magnitude once the gate opens. This preserves
the captured carrier, cruise law, mean-first posterior allocation, and
approach scheduling while making phase subtraction attenuation-only by
construction. Remove the inherited exact-speed projection because sampled
CFD proves it is trajectory-inactive and the episode already enforces that
boundary.

Falsification: reject the candidate if it loses capture, delays the `8/6/4/2L`
milestones, disrupts the alternating three-dimensional wake, increases
acceleration-limit residence or force/moment peaks materially, or returns the
upper-exit topology. Also reject the mechanism if a held-out pose shows that
the one-sided residual suppresses a persistent correction rather than only a
beat-correlated selector excursion.

bookshelf_consulted: true
source_domain: robotic-fish CPG residual control and tail-beat averaging, with wake-control separation of persistent route error from fast oscillatory response
source_mechanism: modulate a low-dimensional rhythmic carrier through a bounded navigation residual instead of treating every oscillatory lateral response as a new route demand
transferable_invariant: slow body-frame target geometry owns turn direction; repeatable carrier-phase response may only reduce excess high-authority duty and must not invent or reverse the route error
nontransferable_details: published CPG gains, body-wave envelopes, species kinematics, dimensional frequencies, exact vortex phases, and source-task routes
policy_translation: use normalized `phi1/amplitude` and `phi_dot1/(omega*amplitude)` to predict a beat component, subtract it only when aligned with raw bearing-minus-course error, cap removal at that raw magnitude, and retain raw error for redirect direction
falsification: loss or delay of capture, weaker distance milestones, wake decoherence, larger limiting or loads, a renewed upper exit, or held-out evidence that the capped residual removes persistent route correction
