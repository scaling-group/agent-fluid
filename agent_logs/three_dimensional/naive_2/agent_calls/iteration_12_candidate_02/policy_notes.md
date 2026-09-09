# Collision-cone burst-redirect candidate

## Evidence and visual diagnosis before editing

All four sampled rollouts and the assigned-parent rollout satisfy the direct
uniform still-water contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm).
Across their combined sheets, the top-down rows show leftward self-propulsion
and alternating body-connected vorticity, while the oblique rows show compact
three-dimensional Lambda2 structures through the useful approach.  The common
failure is therefore terminal course control, not advection or wake collapse.
The best sampled scalar score reaches only `4.650L`; the more useful sampled
approach reaches `2.703L`, confirming that scalar rank does not identify the
capture mechanism.

Inherited course-residual steering is the useful far/middle controller.  It
changed the old upper-boundary topology, first reached `1.276L`, and retained
low-load, joint-reserve, coherent-wake behavior.  Adding a positive terminal
mean bend reached `1.033L`; a closing-speed damped hold reached `1.008L` but
coasted through the target region at `1.011L/T`.  A velocity-horizon aim and a
common-mode PD/braking variant regressed to `1.158L` and `2.167L`.  Thus static
posture, arbitrary lead projection, and more drive relief do not survive as a
terminal answer.

The newly completed assigned parent reversed only the terminal common-bend
sign.  Its keyframes retain the cruise wake and visibly replace the previous
lower-left escape with a nearly target-height left exit, but it misses at
`1.106L` and ends at `8.686L`.  At closest approach (`16.918T`) the head is
`(9.498,8.512)L`, velocity is `(-0.751,-0.423)L/T`, both joints have settled
near `-8.1 deg`, and heading rate is already negative.  The target remains
about `0.99L` above the head and the target/course error is near `+pi/2` while
distance begins increasing.  Correct-sign static curvature eventually changes
the recovery side, but acts too late to put the translational course through
the `0.75L` capture neighborhood.  Strengthening or prolonging that coasting
posture would repeat a falsified mechanism.

## Single candidate hypothesis

Preserve the inherited traveling-bend carrier and course-residual half-cycle
steering outside the terminal miss.  Inside a smooth `3L` region, compute the
constant-velocity closest-pass vector from normalized body-frame target and
velocity observations.  When the fish is closing but that predicted miss lies
outside a controller-owned capture corridor, recruit a bounded, response-signed
common-curvature burst.  Release the burst continuously as soon as the observed
course enters the corridor or closing ceases, restoring the full posterior-lag
beat instead of holding a quiet posture.  This is a collision-cone feedback and
actuator-allocation change, not another scalar gain adjustment.

Support requires capture, or at minimum a pass below `1.008L` plus a better
termination/recovery side while retaining the coherent cruise wake, joint
reserve, and low loads.  Falsify if the route loses the inherited close
approach, the predicted miss remains outside the corridor despite a sustained
burst, a hard terminal curl or `40 deg` dwell appears, or the same left escape
persists without capture or a closer pass.

bookshelf_consulted: true
source_domain: biological C-start burst redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: recruit strong bounded curvature only for a geometrically observed miss, then release into the propulsive traveling wave when directional response becomes useful
transferable_invariant: separate persistent propulsion from a short response-gated redirect whose activation and release are determined by body-frame target-course geometry
nontransferable_details: species-specific C-start kinematics, published gains, robot linkage geometry, dimensional response times, clock phase, exact vortex phase, and task-specific routes
policy_translation: use target and velocity in the same normalized body frame to predict closest-pass offset; gate response-signed two-joint mean curvature by closing motion and excess miss, while preserving the course-residual posterior-lag carrier outside the burst
falsification: reject if capture/closest pass and termination do not improve together, or if wake coherence, far-field translation, joint reserve, or load quality regress

## Dry validation only

The required guidance, Julia contract, and editable-boundary checks pass.  A
`250,000`-state grid spanning joint angles/rates, target sides and fore/aft
geometry, and body velocity produced finite commands strictly inside the
smooth `30 rad/T^2` envelope with exact left/right reflection (maximum error
`0.0`).  Every direct `params.FIELD` reference is owned by
`target_policy_params()`.  At zero joint state, an aligned predicted intercept
leaves the burst inactive `(0,0)`, while a closing off-corridor example gives
the response-signed action `(-18.070,-25.420) rad/T^2`.  These checks establish
schema, boundedness, symmetry, and semantic activation only; the post-worker
CFD evaluation must decide the physical hypothesis and falsifiers above.
