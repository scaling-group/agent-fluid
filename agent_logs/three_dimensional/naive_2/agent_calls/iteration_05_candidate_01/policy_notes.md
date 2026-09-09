# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- All four sampled evaluations are valid direct-uniform still-water rollouts
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The combined sheets
  show self-propelled motion and a body-connected alternating wake in both the
  top-down vorticity and oblique Lambda2 rows; no sampled motion is advection
  by a background current or a numerical-instability failure.
- The inherited phase-compensated response controller
  `solver_77835bec7423` is now the strongest physical example. It preserves a
  coherent wake to `27.43T`, changes the repeated upper-boundary exit into a
  left-boundary exit, and reaches `3.174L`; the prefilled shared-half-cycle law
  exits the upper boundary at `9.25T` after reaching only `11.347L`. The score
  metrics agree with the visual trajectory: mean distance improves from
  `11.415L` to `8.902L` and the run is stable in both cases.
- The new topology is useful but exposes a terminal-approach defect. The best
  trace first crosses `5L` at `13.794T` with speed `0.999L/T`, then passes its
  minimum distance at `18.095T` with speed `0.982L/T` and continues past the
  target corridor to the left boundary. By the minimum, the body-frame target
  bearing is about `-1.03 rad` and the existing turn request is essentially
  saturated, so more far-field bearing gain is not the missing capability.
  Its mean speed is `0.800L/T`, and anterior/posterior joint rates occupy the
  `260 deg/T` neighborhood for about `10.5/11.0%` of samples, versus
  `2.0/4.4%` in the prefill. Local-flow, force, and moment magnitudes remain
  finite, so the miss is excess approach momentum and insufficient
  turn-to-thrust authority rather than wake collapse.
- The inherited broad joint-rate barrier is not a suitable remedy: prior logs
  show that it removed hard-rate occupancy but cut mean speed to `0.279L/T`,
  worsened closest distance to `11.643L`, and retained the upper exit. The
  next candidate therefore leaves the evidenced far-field carrier unchanged
  and schedules only the approach regime.

## Single candidate hypothesis

Restore the phase-compensated response controller exactly outside a normalized
approach radius. Inside that radius, use one smooth distance-conditioned
thrust-to-turn reallocation: reduce only the symmetric carrier contribution
while retaining the existing bounded half-cycle steering contribution. This
keeps a nonzero traveling rhythm, but gives the already correct-sign steering
request more relative authority as the fish closes, rather than applying a
global rate brake or another scalar carrier retune. It should reduce the
roughly `1L/T` fly-by, bend the path downward before the target passes behind,
and improve the `3.174L` closest approach or capture while preserving the
long, coherent far-field wake.

Falsify the candidate if it does not beat `3.174L` or produce a better
termination class, if it merely delays the same left-boundary overshoot, if
near-approach joint-rate occupancy or loads rise, or if carrier relief destroys
the alternating wake and targetward translation. The current worker makes no
claim about the unevaluated candidate's CFD outcome.

bookshelf_consulted: true
source_domain: biological burst redirect and robotic-fish closed-loop CPG approach control
source_mechanism: retain rhythmic propulsion far from the target, then continuously trade symmetric drive for bounded turn-producing asymmetry during close approach
transferable_invariant: when normalized target distance shrinks while a fast propulsive trajectory still lacks enough curvature, reduce thrust relative to existing feedback steering without removing the observable-state rhythm
nontransferable_details: published gains, species-specific C-start shapes, clocked CPG phase, robot linkage geometry, dimensional approach radii, exact vortex phases, and task-specific paths or maneuver timing
policy_translation: use `state.distance_L` to smoothly reduce the symmetric two-joint carrier inside a parameter-owned approach band while leaving body-frame bearing, slip, and phase-compensated yaw to control the existing shared half-cycle redirect
falsification: reject if closest distance stays at or above 3.174L, termination does not improve, the near-field wake or propulsion collapses, or actuator/load occupancy worsens

## Dry validation only

The configured guidance, Julia contract, and editable-boundary checks pass; no
CFD was run. An `18,225`-state grid produced finite actions strictly below the
`30 rad/T^2` smooth envelope, exact left/right reflection (maximum error
`0.0`), and exact agreement with `solver_77835bec7423` outside the `6L`
approach band. The carrier scales are `1.0`, `0.825`, and `0.65` at distances
`6L`, `4.5L`, and `3L`. These checks establish contract, boundedness,
symmetry, and isolation of the mechanism only; a later formal evaluation must
decide all physical falsifiers above.
