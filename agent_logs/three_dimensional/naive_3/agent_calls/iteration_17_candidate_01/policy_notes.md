# Posterior acceleration-reserve velocity-course candidate

## Visual diagnosis and completed evidence

- Every sampled and inherited rollout reports direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  Translation and wake development are therefore controller-generated rather
  than ambient advection or moving-window transport.
- Among the four solver samples, the `2.989L` response-released redirect has
  the strongest broad approach. Its top-down row shows a coherent alternating
  vorticity street and its oblique row shows persistent three-dimensional
  Lambda2 structures while swimming speed reaches `1.032U`, versus only
  `0.032U` peak local flow. Near the pass its joints become nearly fixed, the
  useful wake fades, and the trajectory hooks into the upper boundary. The
  `4.859L` anterior-stiffness sample is the informative visual failure: the
  alternating wake survives, but speed falls to `0.947U`, raw acceleration
  exceedance rises to about `53/64%`, and the upper-exit topology remains.
- The assigned parent's body-frame target-ray/velocity-course controller is
  the only inherited semantic advance. It preserves the zero-centered
  traveling carrier and coherent wake, reaches `0.857L`, and changes the
  repeated upper hook into a left exit. At closest approach it is still moving
  at `0.845U`, its wrapped course error is about `-1.42 rad`, and the posterior
  turn request is saturated. This is an active tangent miss, not passive
  advection, low-speed sensing failure, or loss of propulsion.
- Completed terminal overlays did not supply the missing authority. Posterior
  curvature escalation, both signs of anterior center shift, uniform and
  phase-selective posterior relief, measured-moment rejection, and corrected
  anterior half-cycle allocation all remain within `0.834--0.876L` and retain
  the left exit. The posterior-curvature case reaches about `44.3 deg` against
  the `45 deg` angle limit, while the baseline course controller's raw
  acceleration exceedance is about `58/68%` for joints 1/2. More nominal bend
  or another phase/load residual is therefore unsupported.
- A decomposition of the completed `0.857L` trace exposes an actuator-allocation
  failure. With the physical posterior acceleration clipped at `1800 deg/T^2`,
  mean `turn_request * applied_a2` falls from about `1.83` over `2--3L` to
  `0.21` over `1--2L` and `-2.91` inside `1L`: the carrier consumes the shared
  envelope and can erase or reverse nominal steering near capture. Replaying
  the same recorded states through a `35%` steering-reserve split changes
  those diagnostic values to about `6.28`, `4.75`, and `4.20`. This replay is
  only a command-level falsification check, not a claim about the unevaluated
  closed-loop trajectory.

## Policy hypothesis written before the solver edit

Start from the demonstrated `0.857L` velocity-course controller. Preserve its
full-quadrant normalized target ray, measured body-frame course error,
zero-centered anterior Van der Pol oscillator, posterior lag, damping, and
`12 deg` nominal mean-curvature request. Add one terminal acceleration-reserve
mechanism at the posterior joint. Below `6L`, blend smoothly toward an explicit
allocation of the physical acceleration envelope: soft-bound the oscillatory
carrier inside the unreserved portion and place the target-signed steering
acceleration in a `35%` reserve. The sum remains within the same physical
limit, so steering cannot be hidden by carrier clipping and no actuator limit,
route, clock, morphology, or environment code changes.

The expected signature is the inherited broad approach and alternating wake
outside `6L`, followed by lower posterior bang-bang occupancy and sustained
turn-aligned posterior work through the final `3L`, enough to cross the
`0.75L` capture circle. Falsify the mechanism if the sub-`1L` approach or
coherent wake is lost, applied effort becomes persistently one-sided, the
posterior carrier collapses, or the rollout repeats a `>=0.834L` left-exit
near-miss without a distinct tighter arc.

```text
bookshelf_consulted: true
source_domain: terminal capture control, sensor-modulated robotic-fish direction tracking, and constrained traveling-wave propulsion
source_mechanism: preserve the rhythmic propulsive scaffold while explicitly allocating bounded actuator authority to slow target-course correction near capture
transferable_invariant: when carrier saturation masks a persistent steering request, reserve part of the fixed actuator envelope for target-signed corrective work instead of increasing nominal curvature or the physical limit
nontransferable_details: published gains, robot linkage geometry, species-specific gait envelopes, dimensional cadence, clock phase, exact vortex phases, task-specific routes, and source actuator ratings
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and the two-joint state-feedback carrier; use normalized distance to blend the posterior command into a soft-bounded carrier plus a turn-request-aligned share of the existing acceleration envelope
falsification: reject if broad sub-1L approach or alternating 3D shedding degrades, limit occupancy or one-sided effort worsens, the carrier collapses, or capture and terminal topology fail to improve beyond the completed 0.834--0.876L plateau
```
