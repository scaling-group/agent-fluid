# Wake-policy candidate notes

## Prior-evidence visual diagnosis

The shared prewarm sheet establishes the common initial condition: the fish is
held high and downstream while four developed vortex streets merge through the
target region. The released sheets separate useful self-propulsion from mere
advection. The assigned parent (`solver_218fe3a7d254`) turns onto a coherent
left/down route, passes below the target, then curves back upward and reaches
the `0.75L` circle after `62.304` released time units. Its displacement
`(-10.922,-4.153)L`, final/minimum distance `0.74959L`, and modest RMS
crossflow/force/moment (`0.222/27.25/525.79`) confirm controlled swimming, not a
visually inferred vortex benefit.

The sampled steering-prioritized allocator (`solver_72a47313c277`) preserves
that route topology and target reach but traverses the wake corridor sooner:
arrival improves to `49.142`, mean distance falls from `2.4600L` to `2.1560L`,
total command energy falls from `89487` to `62522`, and mean command energy and
power proxy fall from `1436.3/110.07` to `1272.3/101.56`. Its commands stop at
the candidate-owned `30.0` acceleration envelope instead of the episode hard
limit `31.416`. This is a semantic and actuation improvement, despite modestly
higher RMS force/moment (`39.05/617.13`) and unchanged maximum lateral target
offset (`4.293L`). Both successes still touch the joint-speed limit, so the
evidence supports the allocator but does not establish complete saturation
relief.

The informative failure (`solver_0c51696bec78`) does not support broad gait
slowing or replacing the residual interface with a curvature-equilibrium
carrier. Its sheet remains far downstream, reverses repeatedly, then blows up;
the `unstable_dynamics` termination, minimum distance `9.238L`, RMS relative
crossflow `1.138`, and RMS force/moment `16749.8/290421` agree with the visible
loss of control. Low command-energy mean alone is therefore not evidence of a
useful wake policy.

## Candidate policy hypothesis

Replace the assigned parent's raw carrier-plus-steering sum with the sampled,
evaluated direction-prioritized allocator. Preserve the successful
`0.55`-period traveling-bend carrier, bearing residual sign, and joint shares.
For each joint, reserve `20%` of the finite steering request inside a `30.0`
acceleration envelope, then clamp the carrier plus remaining residual into the
available budget. The mechanism changes how propulsion and steering compete
near saturation; it is not scalar-only gain tuning.

Expected test: reproduce target reach with the sampled improvement in arrival,
distance integral, and effort while remaining below the episode acceleration
limit. Falsify the transfer if this materialization loses target reach, returns
to the seed-like lower exit, raises effort without an arrival benefit, or if
speed-limit contact dominates and destroys the reserved steering effect. The
current candidate's CFD evaluation occurs after this worker exits and is not
claimed here.

The shelf's terminal-capture scheduling primitive was considered but not
combined with this candidate: neither successful rollout is a near miss, and
the allocator already improves first crossing. Later workers should test
distance/closing-rate scheduling only if evidence shows overshoot, loss after a
closest approach, or a capture/dwell objective that this first-crossing task
does not expose.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG and residual path-following control
source_mechanism: bounded sensor-conditioned steering residual layered on a rhythmic locomotor carrier
transferable_invariant: persistent body-frame direction error needs explicit finite authority while the joint-state traveling bend retains the remaining propulsion budget
nontransferable_details: published gains, actuator ratings, clocked phase, species kinematics, exact vortex phases, and source-task routes
policy_translation: retain the evaluated body-frame bearing residual and reserve a finite share of a candidate-owned acceleration envelope before allocating the joint-state carrier
falsification: reject if semantic success or coherent targetward propulsion is lost, or if the bounded allocation fails to improve arrival, effort, or acceleration headroom
