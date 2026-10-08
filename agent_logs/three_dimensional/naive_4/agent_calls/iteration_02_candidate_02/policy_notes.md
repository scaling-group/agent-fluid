# Candidate wake-policy notes

## Evidence diagnosis before the edit

- All four sampled rollouts satisfy the required direct-uniform still-water
  contract (`U_infinity=(0,0,0)`, no prewarm, no cylinders). All terminate at
  the upper virtual boundary, so the evidence contains a useful finite leader
  but no success or improved termination class.
- The target-blind seed (`solver_064577d12113`) makes only `0.250L` of transient
  progress (minimum/final distance `12.078/12.380L`) before exiting at
  `8.547T`. Its combined sheet shows a coherent self-generated alternating
  wake in both the top-down vorticity and oblique Lambda2 rows, followed by a
  broad upward yaw arc. The carrier is productive; unregulated direction is
  the failure.
- The strongest sampled candidate (`solver_9391d49799dc`) applies bearing plus
  short-window bearing trend only to the posterior mean target. It improves
  minimum/final distance to `11.413/11.421L`, mean distance to `11.477L`, and
  survives to `9.740T`. Its top-down row shows sustained leftward translation
  with an organized alternating wake, and the oblique row confirms coherent
  three-dimensional tail shedding. However, the trajectory still bends upward
  and exits; heading spans `-0.883` to `0.554 rad`, both joint rates touch the
  limit, posterior angle reaches `38.2 deg`, and its raw posterior request
  reaches `101 rad/T^2` before the episode clamp. Thus this is a useful
  trajectory and steering signal, not a solved mean-bias mechanism.
- The informative failure (`solver_835ca80b5e55`) shifts both joint centers by
  bearing and yaw rate. Its visual sheet remains nearly wake-free through the
  early frames, then forms a compact curved wake during a late tight turn. The
  metrics agree with carrier suppression: joint angles stay near `10 deg` and
  peak body-force coefficient is only about `0.0028`, versus about `0.0257`
  for the leader. It lasts `13.288T` but reaches only `12.286L`, finishes at
  `13.411L`, and exits upward. The inherited clamped/common-center candidate
  `solver_15c26ee8292f` independently has the same negative topology
  (`12.296/13.495L` minimum/final distance). Delaying exit by weakening
  propulsion is not target control.
- The other posterior mean-bias candidate (`solver_f8150884d2df`) preserves
  the energetic carrier but ends close to the seed (`12.091/12.312L`) and
  exits at `8.899T`. Across the assigned-parent lesson, sampled results, and
  inherited worker notes, three mean-curvature translations therefore fail to
  arrest the upper yaw arc; only posterior-only bearing-trend feedback
  materially improves approach.

## Policy hypothesis

Keep the leader's anterior Van der Pol carrier, posterior phase lag, and
bounded bearing-plus-window-rate turn signal, but replace its static posterior
offset with state-phased half-cycle amplitude asymmetry. For a requested turn,
retain the posterior half-cycle whose tangent has the evidenced steering sign
and smoothly attenuate the opposite half-cycle; reverse the retained side when
the predicted bearing reverses. This creates a target-dependent average bend
without moving the anterior oscillator equilibrium or increasing the useful
half-cycle above the sampled carrier. It should preserve the leader's coherent
wake while giving the return turn authority that static posterior bias lost to
high-frequency tracking and actuator clipping.

Falsification: reject the mechanism if it loses the leader's `11.413L`
minimum-distance benchmark, weakens the alternating wake toward the
common-center failure, increases joint-limit residence, or repeats the upper
exit with bearing diverging after centerline crossing. A semantic improvement
would be capture, a non-boundary horizon, or a materially longer trajectory
that continues closing after the first alignment.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping control
source_mechanism: sensor-driven half-cycle amplitude or duty-ratio asymmetry superposed on a propulsive rhythm
transferable_invariant: persistent directional error can select one joint-state half-cycle for stronger relative action while the traveling bend continues and the selected side reverses with the error
nontransferable_details: published gains, dimensional beat rates, clocked CPG phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: map bounded body-frame bearing plus its short-window rate to smooth posterior half-cycle attenuation inferred from the lagged tail target in observed joint state, leaving the anterior state-feedback oscillator unchanged
falsification: reject if target progress or boundary survival fails to improve, if the wake loses alternating propulsion, or if state-phased attenuation creates persistent joint or acceleration limiting
