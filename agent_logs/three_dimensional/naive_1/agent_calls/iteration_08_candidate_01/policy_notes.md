# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The assigned parent, all four sampled solvers, and the informative inherited
failures satisfy the frozen evidence contract: direct uniform still-water
initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
dynamics, and moving-window transport. I inspected the combined keyframe
sheets for the best-scored capture, the assigned parent, the inherited
rate-guard failure, and the inherited terminal-course failure. In both visual
rows the successful controllers self-propel along a target-directed curve: the
top-down row retains an alternating vorticity street and the oblique row shows
compact three-dimensional caudal Lambda2 structures through first crossing.
The rate-guard failure retains a similarly energetic alternating wake but
rotates onto the high-side exit, so wake coherence does not establish route
authority.

The sampled controller differences bound what is supported. The unprojected
base redirect captures at `19.228T`; the assigned parent's terminal raw
body-lateral-velocity lead captures at `19.129T`; and the two final-command
projection variants capture at `19.135T` and `19.140T`. Their mean scored
distance spans only `2.1185--2.1277L`. The parent's small timing change is
therefore inside repeat variability, not evidence for further lead-gain
tuning. In contrast, final projection at the episode's existing
`1800 deg/T^2` envelope is a replicated interface result: both projected
policies preserve capture and the same wake/route class, bound returned
accelerations at `31.416 rad/T^2`, and leave joint-rate contact near
`10.7--10.8%`/`14.5--14.6%`. This is public-command envelope ownership, not
rate relief.

Two inherited negative results constrain the edit. Outward-rate guards remove
rate contact but lose capture at `5.3386L` and `5.0277L`, so this candidate
does not modify the carrier near the velocity limit. Replacing raw lateral
velocity with a terminal line-of-sight transverse-course residual is also
falsified: it narrowly misses at `0.9490L` near `20.014T`, with the target
already aft/lateral in the body frame, then continues away and exits at
`32.065T` and `8.7907L`. The terminal image retains a coherent wake along the
wrong departure path. This candidate therefore does not retry an instantaneous
course residual or add another terminal steering gain.

## Policy hypothesis

Preserve the assigned parent's joint-state oscillator, posterior lag,
target-side-authoritative differential curvature, one-sided yaw release, and
terminal raw lateral-velocity lead exactly. Add only a policy-owned
`1800 deg/T^2` parameter and clamp the two completed acceleration commands.
Because the downstream plant already applies the identical envelope, the
projection should preserve the parent's captured applied trajectory while
removing unrealizable public demand. It deliberately makes no claim of lower
joint-rate contact or same-worker CFD improvement.

Falsify the composition if either returned command exceeds the owned envelope,
the lightweight contract produces a non-finite action, capture or wake
coherence is lost, or arrival, mean distance, rate contact, or loads leave the
successful sampled band. A later rate-relief mechanism must preserve carrier
phase and mean curvature rather than use a pointwise outward-rate gate.

bookshelf_consulted: true
source_domain: actuator-limited robotic-fish sensor-feedback CPG control
source_mechanism: preserve a low-dimensional propulsive rhythm while body-frame feedback modulates direction, then bound only the completed actuator command
transferable_invariant: route feedback and traveling-wave phase remain intact when interface projection removes only demand that the physical plant cannot apply
nontransferable_details: published gains, dimensional beat settings, motor models, species-specific kinematics, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: retain the parent's normalized target geometry, terminal body-lateral motion, yaw-release, and two-joint carrier equations, then clamp each completed acceleration at a parameter-owned envelope already imposed by the plant
falsification: any out-of-envelope or non-finite return, lost capture or coherent wake, changed successful route class, or a false claim that unchanged rate contact is actuator relief
