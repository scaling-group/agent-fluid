# Response-released redirect candidate

## Evidence read before the edit

All four sampled evaluations used direct uniform still-water initialization
with `U_infinity=(0,0,0)` and ended by leaving the lower virtual boundary. The
top-down vorticity and oblique Lambda2 rows show self-propelled fish with
coherent alternating wakes through termination; this is a steering-response
failure, not advection or missing propulsion.

The posterior-gated carrier in `solver_2e1178a92e4c` is the strongest finite
sample: it reached `2.443L` at `17.869T` and survived to `31.097T`. At `8T` its
full body-frame target direction was about `+0.263 rad` while yaw rate was
`-3.47 rad/T`; at `16T` those values were about `+0.659 rad` and `-1.59 rad/T`.
Thus, for this body-frame convention, negative yaw is the observed corrective
response to a positive target direction. The fish nevertheless carried that
turn past the line of sight: at minimum distance the target direction was
about `+1.421 rad`, forward speed remained `0.669U`, and yaw had reversed to
`+2.04 rad/T`. Anterior/posterior acceleration was clamped for about
`0.746/0.354` of the rollout.

The assigned parent in `solver_51d3a6e4c279` added a closing-deficit-gated
increase from `7` to `12 deg` curvature. It worsened minimum distance to
`2.729L`, retained the same lower-boundary exit, and still clamped the two
accelerations for about `0.714/0.328` of the run. Its keyframes show the same
long coherent wake and lateral pass, not a new useful topology. The inherited
score logs likewise contain no semantic escape from this class: later samples
reached `2.468L` and `3.661L` but still exited with final distances `9.657L`
and `9.595L`.

## Diagnosis and policy hypothesis

The parent's nominal yaw damping has the wrong response semantics for the
measured convention: `direction - gain * heading_rate` increases the turn
request when a positive direction has already produced corrective negative
yaw. More curvature alone therefore cannot test a response-released redirect.

Preserve the evidenced oscillator, posterior lag/gating, full target direction,
and closing-deficit curvature envelope. Replace the linear yaw term with a
reflection-invariant corrective-response gate:

```text
direction_command = bounded full body-frame target direction
corrective_rate = max(-direction_command * heading_rate, 0)
turn_request = direction_command * authority(corrective_rate)
```

`authority` stays positive and decreases continuously toward a parameter-owned
floor. Correct-sign yaw therefore releases mean curvature without reversing
the requested turn; zero or wrong-sign yaw keeps full redirect authority. This
is a feedback-architecture change, not scalar carrier tuning.

Expected test: compared with the assigned parent, the fish should avoid the
sustained early over-turn, keep the target nearer the velocity course, beat the
`2.443L` closest approach, or at minimum produce a materially different useful
trajectory/termination without increasing clamp residence. Falsify the
mechanism if early target progress degrades, the wake shortens into a tight
curl, the same lower exit and roughly `2.4--2.7L` miss remain, or acceleration
clamping/load excursions increase.

bookshelf_consulted: true
source_domain: biological C-start/burst redirects and sensor-modulated robotic-fish direction tracking
source_mechanism: apply bounded curvature for large direction error and release it when corrective turning response appears
transferable_invariant: steering authority should depend on both body-frame target error and the sign of measured yaw response, releasing only on corrective response
nontransferable_details: species kinematics, published gains, clocked CPG phase, dimensional yaw rates, exact maneuver timing, and task-specific routes
policy_translation: use normalized full target direction and heading rate to form a reflection-invariant corrective-response gate on the two-joint mean-curvature request while retaining the sampled lagged carrier
falsification: reject if early progress or wake coherence degrades, actuator-limit residence rises, or the policy retains the same powered lower-boundary near-miss without a better closest approach
