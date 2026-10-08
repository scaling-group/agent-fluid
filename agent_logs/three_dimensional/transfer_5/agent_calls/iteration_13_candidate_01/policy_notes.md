# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis

All four sampled episodes satisfy the released contract: direct uniform
quiescent initialization, no cylinders or prewarm snapshot, stable dynamics,
and capture. In the best-scoring v30 load-selective sheet and the least useful
finite comparators, the top-down row starts empty and develops a coherent
alternating red/blue street behind a broad target-directed turn. The oblique
row independently shows compact alternating three-dimensional Lambda2
structures persisting through the curved approach. The fish is self-propelled,
not advected, and neither wake collapse nor a different trajectory topology
supports replacing the carrier.

The traces distinguish the terminal mechanisms that the nearly coincident
images cannot. Relative to the v24 course-brake baseline (`23.831520T`, mean
distance `2.434073L`), the inherited load-selective counter-tangent keeps the
same arrival and improves mean distance to `2.433642L`, yielding the best
sampled score. It is not a clean damping result: inside `3L`, peak yaw rises
from `3.208` to `3.264 rad/T`, mean target-transverse speed rises from `0.239`
to `0.245U`, and mean yaw moment remains essentially unchanged
(`0.00640` versus `0.00639`). Thus the assigned-parent call for a distinct
response observable was useful, but the inherited step-12 counter-tangent
actuator translated it into extra yaw-supporting curvature.

The posterior half-cycle amplitude-relief sibling supplies the positive
mechanism evidence. It retains the continuous course bend and capture, improves
mean distance slightly to `2.433993L`, and lowers inside-`3L` mean absolute yaw
to `1.606 rad/T`, target-transverse speed to `0.233U`, lateral force to
`0.00889`, and yaw moment to `0.00614`. Its cost is a small arrival delay to
`23.875523T`. Joint-angle-limit exposure is zero in all four samples, while
joint-speed and projected-command exposure remain similar, so another
feasibility projection or whole-body gain change is not the evidenced need.

## Candidate hypothesis

Use v30 amplitude relief as the sole actuator change, but admit it only when
the normalized yaw moment reinforces carrier-rejected excess yaw. Target
course retains the evaluated mean C-bend; excess yaw chooses the dissipative
direction; observed posterior tangent selects the yaw-supporting half-cycle;
and moment supplies only a smooth urgency multiplier. Since reinforcing moment
occurs during roughly half of the terminal samples, this should retain the
relief run's yaw/load cleanup while restoring some of its small propulsion and
arrival cost. Far from the target, on the opposite half-cycle, and while fluid
moment already brakes yaw, the evaluated carrier remains unchanged.

Support requires capture with coherent wakes, mean-distance progress no worse
than v24, arrival better than the ungated relief run, and terminal yaw,
transverse speed, force/moment, joint-speed exposure, and projected-command
exposure jointly closer to the relief run than to the counter-tangent run.
Falsify if gating erases the cleanup, repeats the counter-tangent peak-yaw
increase, weakens the alternating wake, or loses capture.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish asymmetric flapping
source_mechanism: preserve a target-steered traveling carrier while a normalized hydrodynamic load admits bounded relief of only the unwanted posterior half-cycle
transferable_invariant: separate slow route curvature from fast load response, and alter rhythmic actuation only when observed state and load jointly identify a yaw-supporting stroke
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: body-frame course keeps the continuous C-bend; carrier-rejected yaw and observed tail tangent select posterior half-cycle amplitude relief; normalized yaw moment smoothly gates its urgency
falsification: reject if capture or wake coherence regresses, arrival does not improve over ungated relief, or terminal yaw, transverse motion, loads, joint-speed exposure, and projected commands fail to improve jointly over v24
