# Candidate diagnosis and hypothesis

The assigned parent (`solver_e749afa61520`) is the strongest sampled finite
rollout: direct uniform still-water initialization, capture at `15.1403T`,
score `-0.01094`, and mean distance `1.89264L`.  Both keyframe rows show
self-propulsion rather than advection: the fish follows a direct targetward
route while a compact alternating top-down vortex street and coherent oblique
hairpin/Lambda2 wake grow behind the body through capture.  Its terminal
constant-course miss is nevertheless `0.651L`, speed is `1.479L/T`, posterior
`>40deg` dwell is `1.269%`, and the two joints occupy the `>235deg/T` band for
`23.685/21.654%` of samples.  Peak normalized planar force/moment are
`0.04041/0.01902`.

The three current contrasts retain the same direct route and visually similar
compact 3D wake, so their terminal differences are controller evidence rather
than passive still-water transport.  Miss-conditioned posterior drive relief
(`solver_902d980c2b63`) and response release of the posterior residual
(`solver_ecdfb0e3af2e`) both capture but worsen score to `-0.01891/-0.01847`
and leave `0.635/0.573L` terminal course misses.  Posterior-reserve allocation
(`solver_bcdc57eba4e8`) is slower and scores `-0.01764`, but uniquely reduces
the reconstructed miss to `0.363L` with comparable `0.03970/0.01889` peak
force/moment.  It also transfers `>40deg` dwell to the anterior joint
(`0.285%`) while retaining `0.996%` posterior dwell and essentially unchanged
near-rate occupancy.  Thus broad thrust relief and response-only release are
negative contrasts; kinematic-reserve allocation is the useful but incomplete
mechanism.

The candidate keeps the evidenced carrier, geometry/response handoff, and
cubic predicted-miss residual.  It makes that residual a tail-first,
dual-reserve-aware allocation: posterior angle/rate reserve retains primary
authority; lost posterior share spills to the head only while the head also
has angle/rate reserve; authority that neither joint can accept is shed.  The
change is confined to the closing terminal intercept, is smooth and reflection
equivariant through absolute joint-state reserves, and introduces no route,
clock, or world-frame signal.

Falsification: reject the mechanism if it loses capture or the direct compact
wake; if terminal miss does not improve on the parent's `0.651L`; if arrival or
distance integral worsens without a repeatable margin gain; or if either
`>40deg` dwell, near-rate occupancy, or the established approximately
`0.041/0.020` force/moment class worsens.  A single centered capture is useful
mechanism evidence, not robustness proof; later workers should require repeats
or a different initial condition before claiming margin robustness.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG and asymmetric-flapping turning
source_mechanism: sensor-feedback modulation of a propulsive rhythm with bounded half-cycle asymmetry
transferable_invariant: preserve the traveling carrier while scheduling directional rhythmic authority by observed steering demand and actuator availability
nontransferable_details: published CPG gains, hardware duty ratios, species kinematics, dimensional frequencies, and prescribed routes
policy_translation: use normalized body-frame predicted miss for direction and smooth absolute two-joint angle/rate reserves for tail-first spillover within the state-feedback carrier
falsification: discard if course margin, capture, wake coherence, joint reserve, and load class do not improve together

## Static validation

The required guidance, Julia contract, parameter-schema, and solver-boundary
checks pass without running CFD.  An additional sweep of 2,025 reflected
soft-limit state pairs found both accelerations finite, bounded by the owned
`maximum_joint_acceleration`, and reflection equivariant to `1e-12` absolute
and relative tolerance.  This validates the controller contract only; the
candidate's capture, wake, and terminal-margin hypothesis remains unevaluated
until the downstream CFD rollout.
