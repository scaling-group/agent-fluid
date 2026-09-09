# Wake-policy candidate diagnosis

## Evidence read before editing

- The assigned-parent guidance and all four sampled evaluations describe the
  frozen direct-uniform still-water experiment: `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, and finite `left_domain` terminations. The current
  candidate is the sampled phase-compensated bearing controller
  `solver_5c5f9d80447b`; no sampled failure is numerical or ambient advection.
- Both rows of the combined keyframe sheets show self-propulsion rather than
  drift. Alternating mid-plane vortices and compact oblique Lambda2 structures
  persist through the turns. Trajectory cross-checks bound local-flow magnitude
  below `0.030U` in every sample, while speeds reach `0.90--0.94L/T`; therefore
  the posterior-lag traveling bend is useful and wake rejection is not the
  missing mechanism in these quiescent runs.
- The phase-compensated bearing controller and achieved-course/yaw-rate cascade
  follow nearly the same upper route: they pass above the target, reach only
  `3.003L` and `3.114L`, then exit left near `y=11.2--11.6L`. Thus changing the
  outer signal from bearing to achieved course did not make bounded posterior
  mean curvature more effective; another course or rate gain would not be a
  semantic test.
- The response-gated yaw brake has the opposite long-turn failure, passing
  below the target and exiting the lower boundary after reaching `5.323L`.
  More importantly, inherited logs identify a direct achieved-course steering
  parent that reached `1.044L`, demonstrating useful route geometry but with
  persistent acceleration clipping. The sampled terminal cadence-relief child
  `solver_39c7e6e70772` retains the coherent wake yet regresses to `1.542L` at
  `18.43T`, passes below the target, and exits the lower boundary. At closest
  approach it is still moving at `0.738L/T`; reducing oscillator frequency over
  `4--1.25L` did not create capture or a better termination class.
- Raw joint acceleration is at the envelope on roughly `58--75%` of logged
  rows across the samples, although joint rates stay below `260 deg/T`. This
  supports changing how steering is distributed over the observed beat rather
  than restoring an always-on shared acceleration or increasing its gain.

## One candidate mechanism

Preserve the evidenced `0.55T`, `28 deg` joint-state oscillator, posterior lag,
far-field cadence schedule, and normalized target-versus-achieved-course route
error. Replace the failed distance-based terminal drive relief and always-on
shared steering with one bounded half-cycle steering actuator. A smooth phase
indicator from the observed summed joint tangent and velocity selects the bend
half-cycle aligned with the signed route request; only then is a same-sign
two-joint steering acceleration applied. There is no clock, mutable phase,
world coordinate, route, or scalar-only gain experiment.

Expected test: recover the direct course servo's useful descent while keeping
the coherent traveling wake, but concentrate redirect authority in a favorable
observed bend half-cycle so the fish can release or reverse steering without an
always-on offset. A semantic improvement is capture, a closest approach below
`1.044L`, or avoiding both the sampled above-target left exit and below-target
lower exit with bounded returned accelerations.

Falsification: reject phase-selective steering if early closure or wake
coherence degrades, if the route stays above the target like the two
mean-curvature loops, if it repeats the lower-boundary pass without improving
the inherited `1.044L` near miss, or if joint angle/rate saturation grows. If
the route is retained but capture still fails, later work should diagnose
near-target yaw and lateral slip directly rather than reapply cadence relief or
raise the course gain.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking with asymmetric flapping and duty-ratio turning
source_mechanism: preserve a rhythmic traveling wave while observed target error strengthens only the favorable bend half-cycle
transferable_invariant: separate the propulsive carrier from bounded steering whose sign comes from body-frame route error and whose authority is scheduled by observed joint phase
nontransferable_details: published CPG gains, robot geometry, dimensional cadence, prescribed duty ratios, exact vortex phase, and task-specific routes
policy_translation: map normalized target-versus-achieved-course error to a bounded turn request, infer a smooth half-cycle indicator from the two joint angles and velocities, and gate a same-sign two-joint acceleration without changing the carrier or using time
falsification: reject if the coherent wake or early closure is lost, action remains persistently clipped without a closer pass, or either inherited left-exit or lower-exit topology persists

## Non-CFD verification

- The lightweight Julia contract call returns two finite accelerations and
  keeps both within the owned `1800 deg/T^2` limit. Mirroring target lateral
  position, body-frame lateral velocity, joint angles, and joint velocities
  produces exactly sign-mirrored actions.
- A strong synthetic route request gives half-cycle gates of `1.334` and
  `0.666` for equal-and-opposite observed joint phases while retaining the
  same steering sign. This verifies phase-selective authority rather than a
  scalar course-gain change; it is a signal audit, not CFD evidence.
- The required guidance-materiality, policy-contract/schema, and editable-
  boundary checks pass. No CFD rollout was run in this workspace.
