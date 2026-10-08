# Wake-policy candidate notes

## Evidence diagnosis

All four sampled solver results are deterministic fixed-pose captures with the
same `24.326511T` arrival, `0.749329L` crossing, `2.224097L` mean distance,
trajectory bytes, and direct-uniform still-water initialization. Their
top-down sheets show the same target-directed curved route and a coherent
alternating wake from release through capture. Three combined sheets contain
the same complete oblique row, whose discrete Lambda2 structures persist to
the terminal frame; one oblique row is blank even though its top-down sheet
and numerical trace are identical, so that blank is a render failure rather
than contrary flow evidence.

The sampled controller already preserves capture, finite rhythmic motion, and
the established load/saturation envelope. Its remaining closing-speed relief
uses a one-step difference of articulated-head distance. On the sampled trace,
the corresponding gate is phase-sensitive: inside `0.75--1.0L` it ranges from
zero to `0.964`. A directly normalized translational diagnostic has clearer
terminal meaning. The center-velocity projection onto the instantaneous
head-to-target unit vector has mean alignment cosine `0.629` over
`1.0--1.25L`, falls to `0.265` over `0.75--1.0L`, and becomes transverse or
away only near the crossing, while cross-track motion retains one sign. This
supports testing response-conditioned steering allocation, not another rudder
gain or carrier change.

## Policy hypothesis

Keep the full-angle geometry, anterior redirect, phase-selective posterior
carrier, reactive-rudder sign, and evidenced `20%` maximum relief. Replace the
one-step closing-speed trigger with one compact approach-hold mechanism: below
`1.5L`, smoothly release posterior rudder as normalized center translation
loses alignment with the current head-to-target vector. Use only
`target_body_L`, `distance_L`, and `velocity_body_U`; do not alter the carrier.
This should leave the preterminal route byte-equivalent until the new distance
gate opens, reduce steering allocated to increasingly cross-track translation,
and avoid relying on articulated-head beat phase.

Falsify the transfer if capture is lost or occurs after `24.326511T`, mean
distance exceeds `2.224097L`, behavior changes outside `1.5L`, action effort or
rate-cap occupancy rises, peak normalized force/moment exceeds the inherited
envelope, or either view shows propulsion/wake collapse. Even a faster fixed-
pose capture would not establish robustness without pose or hydrodynamic
perturbations.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: preserve a rhythmic carrier while continuously reallocating a bounded steering residual from sensed approach response
transferable_invariant: separate propulsion from steering and reduce only excess near-target steering when normalized body-frame translation loses target alignment
nontransferable_details: published gains, clock phases, species-specific kinematics, exact vortex timing, and source-task routes
policy_translation: multiply the existing posterior rudder by a smooth distance-and-alignment authority in the two-joint state-feedback law while leaving the carrier unchanged
falsification: reject on later or failed capture, worse distance integral, preterminal route change, carrier decay, increased saturation or effort, or larger force/moment peaks
