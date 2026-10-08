# Wake-policy candidate notes

## Evidence diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
developed, interacting cylinder streets; the target is inside the converged
second-row wake. All four sampled released sheets show the same useful
control topology: a sharp targetward redirect at release, followed by a
self-propelled leftward traverse across the advecting wake and first-crossing
capture. The response-only burst child is the strongest finite comparison:
it reaches in `34.821`, has mean distance `1.6270L`, total command energy
`47151`, relative-crossflow RMS `0.2414`, and force/moment RMS
`77.09/1142.74`. The prefilled unsigned full-load gate preserves the visible
route but is worse on each of those measures (`35.035`, `1.6351L`, `47359`,
`0.2448`, and `78.35/1216.43`). Partial unsigned and signed-assisting moment
gates lower force/moment RMS to roughly `71.9/1064--1086`, but arrive later
and spend more total command energy than response-only. Every sampled child
still reaches both `4.537856` joint-speed limits and both `30.0` command
limits.

There is no failed termination among the current four sampled siblings. The
most informative inherited failures therefore remain the predictive-bearing
child, which put trend into persistent route steering and exited after
`18.304` with negative progress, and the wholesale low-effort carrier
replacement, which became unstable after `121.517` with force/moment RMS
`16749.8/290421`. Together with the images, these rule out changing the
carrier or withdrawing persistent raw-bearing steering merely to lower a
load scalar.

## Policy hypothesis

Preserve the evidenced oscillator, slip-corrected mean residual, raw-bearing
reserve, base half-cycle asymmetry, and bearing-response release. Remove the
unsupported yaw-moment gate. Gate only the optional redirect burst when an
observed joint is near its speed limit *and* the previous acceleration is
still pushing that joint farther in the same direction. This actuator-state
pressure is dimensionless, sign-explicit, and cannot suppress the base
asymmetry or persistent route request. The hypothesis is that it will retain
the response-only route/arrival benefit while avoiding optional burst effort
at limit-bound samples; reject it if capture is lost, arrival or mean distance
regresses materially, or neither limit/load/effort behavior improves.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG control
source_mechanism: apply a strong curvature burst for large course error, then release the burst when observed maneuver response appears while retaining rhythmic propulsion
transferable_invariant: transient steering authority should be gated by normalized observed geometry and response state, without withdrawing the persistent carrier
nontransferable_details: species-specific C-start shapes, published CPG gains, dimensional joint limits, prescribed timing, exact vortex phase, and task-specific routes
policy_translation: retain body-frame bearing-response gating and multiply only the extra half-cycle burst by a smooth gate derived from normalized joint-speed proximity and same-direction previous acceleration
falsification: reject if target capture is lost, route/arrival materially regresses, or sampled speed-limit pressure fails to reduce effort or load relative to the response-only child
