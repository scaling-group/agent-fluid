# Wake-policy candidate notes

## Pre-edit evidence diagnosis

The assigned parent is the raw-bearing-reserve, course-slip, joint-state
half-cycle controller currently prefilled in `solver/`. Three sampled copies of
that policy are deterministic successes: each reaches the `0.75L` capture
circle in `36.4705`, with mean distance `1.6860L`, total/mean command energy
`48700/1335.3`, relative-crossflow RMS `0.2397`, and force/moment RMS
`63.59/953.42`. Their released keyframes show self-propelled motion rather than
passive advection: a sharp targetward redirect is followed by a coherent
leftward traverse through the interacting wake and direct entry into capture.
Both joints still touch the `4.5379` speed and `30.0` command caps.

The strongest sampled child adds a response-gated burst to the same
joint-state-aligned half-cycle mechanism. Its keyframes preserve the same safe
route topology but show a slightly earlier, tighter redirect; the metrics agree,
with arrival improving to `34.8205`, mean distance to `1.6270L`, and total
command energy to `47151`. The cost is higher mean command energy (`1354.1`),
relative crossflow (`0.2414`), and force/moment RMS (`77.09/1142.74`). Thus the
useful mechanism is extra redirect authority while bearing is large and not
closing, while the unresolved defect is the accompanying load increase. No
sampled solver in this workspace is a semantic failure; the most informative
failure evidence is inherited instead: a low-effort curvature-equilibrium
replacement became unstable at `121.517` with force/moment RMS
`16749.8/290421`, so low command effort cannot justify replacing the validated
carrier or ignoring measured load.

## Policy hypothesis

Preserve the assigned carrier, bearing-owned reserve, course-slip residual, and
base half-cycle asymmetry. Import the sampled response-gated redirect burst, but
multiply only its *extra* asymmetry by a smooth relief gate derived from the
absolute normalized body yaw moment. Typical sampled RMS moment is
`953/64^2 = 0.233` for the parent and `1143/64^2 = 0.279` for the ungated burst;
a dimensionless relief scale above those RMS values should leave ordinary
redirect authority mostly intact while suppressing burst amplification during
larger instantaneous load excursions. This is a single load-aware burst
mechanism; it does not alter gait scalars, base asymmetry, or actuator envelope.

Expected result: retain target reach and most of the `1.65`-time-unit arrival
gain of the ungated burst while moving force/moment RMS back toward the parent.
Reject the mechanism if capture is lost, arrival regresses to or beyond
`36.4705`, the route visibly changes into a broad excursion, or force/moment
loads do not fall meaningfully relative to `77.09/1142.74`.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and asymmetric-flapping turning
source_mechanism: sensor feedback modulates turning asymmetry around a continuing rhythmic propulsive carrier for direction tracking
transferable_invariant: preserve the traveling propulsive carrier while extra maneuver asymmetry is bounded and continuously gated by observed task response
nontransferable_details: published gains, clock-driven CPG phase, robot geometry, species kinematics, dimensional load thresholds, exact wake phase, and prescribed routes
policy_translation: use body-frame bearing and its observed window rate to request a joint-state-phased half-cycle burst, then smoothly attenuate only the extra burst with absolute `moment_z_L2`; retain the two-joint state-feedback carrier and bounded residual allocator
falsification: reject if target capture or route compactness is lost, if load RMS is not reduced from the ungated burst, or if the gate suppresses ordinary propulsion instead of only excessive redirect load
