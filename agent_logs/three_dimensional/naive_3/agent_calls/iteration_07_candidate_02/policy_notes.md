# Wake-policy candidate notes

## Inherited and sampled evidence

- All four sampled evaluations satisfy the frozen rollout contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders, and no prewarm.
  The motion and wake are policy-generated rather than ambient advection.
- The combined sheets show the reusable carrier clearly. Their top-down rows
  develop coherent alternating signed-vorticity wakes, and their oblique rows
  resolve persistent three-dimensional Lambda2 structures. The continuously
  beating variants retain those structures through the useful approach, so
  the missing capability is target-normal redirection rather than propulsion.
- The unrelieved bearing-minus-body-slip controller remains the inherited
  geometric benchmark: it descends to center `y=12.324L` and reaches `2.960L`
  at `17.70T`, but full-quadrant error grows past about `-1.5 rad` as it passes
  high and hooks into the upper boundary. Three distance-only carrier
  reallocations miss farther at `3.032L`, `3.162L`, and `3.592L`; the weakest
  becomes nearly motionless in joint space while coasting at about `0.7U`.
- The distributed C-bend also becomes static, reaching `2.999L` before both
  joint rates fall to about `0.001 rad/T` after `18T`. Its bent posture and
  freed actuator reserve do not supply corrective hydrodynamic action.
- The assigned parent's close/misaligned/still-closing posterior half-cycle
  relief avoids that stall and visibly preserves alternating shedding, but it
  reaches only `3.013L`, finishes at `7.457L`, and repeats `left_domain` at
  center `y=15.202L`. At `18T`, full-quadrant error is about `-1.62 rad` while
  both joints are still active; subsequent target-side error grows beyond
  `2 rad`. Selective carrier attenuation therefore preserves rhythm but does
  not rotate the body wave into the missing redirect.
- The sampled traces are nearly identical through roughly `12T`. The useful
  bearing/slip carrier should remain unchanged there. The differentiating
  intervention should begin only when full-quadrant target error is material
  and should release from observed yaw response, not from elapsed time or a
  distance-only stage.

## Policy hypothesis

Restore the unattenuated bearing/slip traveling carrier and keep the anterior
Van der Pol oscillator zero-centered and undamped. Add one response-gated
posterior wave-shape mechanism. When full-quadrant body-frame target error is
large and the body has not developed yaw toward the requested side, infer the
target-side anterior half-cycle from joint state and blend the posterior target
from its usual lagged traveling-wave value toward the current anterior bend.
This produces a transient same-sign C-like shape only during the supporting
half-cycle; the opposite half-cycle and all small-error travel retain the
demonstrated carrier. Target-directed measured yaw continuously releases the
blend.

An offline replay of the new algebra on the assigned parent's recorded states
activates a greater-than-`0.01` phase blend in about `25.7%` of samples after
`12T`. Capping the blend at `0.15` projects posterior raw-envelope exceedance
at about `74.1%` over that interval versus `70.2%` in the parent; a `0.35` cap
would project `77.1%`. This is only a bounded command audit, not a prediction
of the closed-loop trajectory, and motivates the smaller cap.

The rollout should retain broad-approach wake coherence and joint cycling while
changing the shape, rather than merely the amplitude, of the active redirect.
Falsify the mechanism if the trajectory changes materially before large error,
the tail or wake stalls, posterior limit occupancy worsens substantially, or
closest approach/termination does not improve on the `2.960L` unrelieved
benchmark and repeated upper-exit topology.

bookshelf_consulted: true
source_domain: biological C-start redirection combined with robotic-fish CPG phase and wave-shape modulation
source_mechanism: unresolved directional error recruits a transient same-sign body bend within a continuing rhythm, and observed heading response releases back to the traveling wave
transferable_invariant: preserve the propulsive oscillator, reshape only the target-supporting half-cycle into coordinated whole-body curvature, and release the redirect from measured response
nontransferable_details: species-specific C-start angles, published gains, dimensional timing, clock phase, exact vortex phases, and task-specific routes
policy_translation: use normalized full-quadrant `target_body_L`, body-frame slip, measured heading rate, and joint-state phase to blend the posterior lag target toward the anterior bend only while target-directed yaw is deficient
falsification: reject if broad-approach motion changes, active cycling or coherent shedding collapses, actuator-limit occupancy rises materially, or the `2.960L` miss and upper-boundary exit do not improve
