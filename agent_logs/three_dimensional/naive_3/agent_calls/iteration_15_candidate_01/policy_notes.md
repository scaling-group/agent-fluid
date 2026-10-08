# Terminal posterior counter-moment relief candidate

## Visual diagnosis and completed evidence

- All sampled and inherited rollouts used direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  Their translation and wake development are therefore controller-generated,
  not ambient advection or moving-window transport.
- Among the four solver examples, the `2.989L` response-released redirect is
  the strongest finite approach. Its top-down row shows a regular alternating
  vorticity street through the approach and its oblique row shows persistent
  three-dimensional Lambda2 structures. It reaches `1.032U` while peak local
  flow is only `0.032U`, then loses useful rhythmic correction and hooks to the
  upper boundary. At closest approach it is still moving at `0.769U` and the
  target remains nearly `3L` away, so that controller lacks course authority
  rather than propulsion.
- The `4.859L` anterior half-cycle stiffness case is the informative visual
  failure. It retains alternating shedding in both views, but peak speed falls
  to `0.947U`, raw acceleration-envelope exceedance rises to about `53/64%`
  for joints 1/2 (versus `34/45%` in the `2.989L` case), and termination stays
  a boundary exit. This rejects another anterior restoring-stiffness
  asymmetry.
- The assigned parent's speed-gated target-ray/velocity-course controller is
  the only completed observation change to produce a semantic trajectory
  improvement: it preserves the zero-centered traveling carrier and coherent
  3D wake, reaches `0.857L`, and changes the common upper hook to a left exit.
  At the tangent miss it is still moving at `0.845U`; the wrapped course error
  is about `-1.42 rad`, so its bounded posterior curvature request is already
  saturated. Raw acceleration exceedance is about `58/68%`.
- The inherited terminal continuations bound the missing mechanism. Raising
  posterior mean curvature toward `18 deg` reached only `0.832L`; a same-sign
  `8 deg` anterior center shift reached `0.838L` while increasing maximum
  anterior excursion from `26.3` to `34.3 deg`; and a sampled opposite-sign
  anterior assist reached `0.866L` with posterior excursion near `44.4 deg`.
  None captured or changed the left-exit termination. More scalar posterior
  authority or another static anterior center shift is therefore unsupported.

## Policy hypothesis written before the solver edit

Start from the assigned parent's velocity-course controller and preserve its
full-quadrant target ray, measured body-frame course observation, anterior Van
der Pol oscillator, posterior lag, damping, and `12 deg` mean-curvature cap.
Add one terminal posterior half-cycle allocation mechanism. Completed carrier
data show that yaw-moment sign follows anterior-angle sign; because required
yaw has sign opposite the turn request, `q1 * turn_request > 0` identifies the
counter-moment part of the cycle. Inside `3.5L`, and only while wrapped course
error remains large, smoothly reduce the lagged posterior carrier on that
half-cycle while leaving the useful half-cycle and posterior mean curvature
unchanged.

The expected effect is the assigned parent's unchanged broad sub-`1L`
trajectory followed by a net target-signed terminal impulse without spending
the nearly exhausted posterior angle margin or shifting the anterior rhythm.
The distance, error, and joint-phase gates are continuous, body-frame, and
memoryless. Falsify the mechanism if it loses the alternating 3D wake, cannot
reproduce a sub-`1L` pass, raises either acceleration or angle-limit occupancy,
or repeats the left exit without capture or a distinctly tighter recovery arc.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping, constrained by classical posterior traveling-wave propulsion
source_mechanism: allocate posterior work asymmetrically across the two beat half-cycles while preserving the rhythmic carrier
transferable_invariant: when broad direction tracking works but terminal mean curvature saturates, reduce only the cycle portion whose observed phase produces counter-turn moment and retain the useful propulsive half
nontransferable_details: published duty ratios and gains, robot linkage geometry, species-specific envelopes, dimensional cadence, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame target-ray versus velocity-course steering; use observed anterior joint angle as the evidenced phase signal; near the target and at large wrapped course error, smoothly attenuate only the lagged posterior carrier when anterior-angle sign matches turn-request sign
falsification: reject if broad sub-1L approach or alternating 3D shedding is lost, actuator occupancy increases, or terminal distance and termination topology do not improve beyond the inherited 0.832--0.857L misses
```
