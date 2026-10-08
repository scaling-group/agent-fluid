# Force-phase terminal wave candidate

## Visual and trace diagnosis before the policy edit

- All sampled and inherited episodes are contract-valid direct-uniform still
  water (`U_infinity=(0,0,0)`, no cylinders, no prewarm). In the combined
  sheets, both the top-down vorticity row and oblique Lambda2 row show wakes
  attached to and translating with the fish, so their motion is self-propelled
  rather than moving-window advection.
- The assigned `solver_b3b6be8f076f` prefill preserves a strong alternating
  wake but holds a same-sign bend in the high corridor, reaches only
  `4.278496L`, and exits the upper margin. The sampled posterior-redistribution
  failure `solver_b6ed3f84ab58` also retains a visually strong wake, yet reaches
  only `5.386122L`, touches the angle boundary, and carries roughly tenfold the
  low-load near-miss force/moment scale. These views confirm that added wake
  strength or nominal acceleration headroom is not terminal steering authority.
- The strongest sampled finite trajectory, `solver_4f3d51f38935`, retains a
  coherent broad downward wake to a `0.832836L` miss and then crosses left of
  the target at about `0.662L/T`. Its deeper terminal C-bend rotates body
  heading to about `1.460 rad`, but projected miss remains about `0.806L` and
  the body/course slip is about `0.757 rad`; the edit changed orientation more
  than translational course. The inherited response-release baseline remains
  stronger at `0.829828L`, and a closing-gated depth variant reached only
  `0.827823L`, without capture or a better termination.
- The newly completed assigned-parent slip-gated posterior S-bend keeps the
  same coherent visual route but worsens the minimum to `0.846679L` and still
  exits left. Its target-side terminal force integral is slightly more positive
  than the sampled deeper-bend case, yet its projected miss at closest approach
  grows to about `0.831L`. A sampled sibling's bearing-divergence anterior pulse
  also remains outside capture at `0.831781L`. Together with earlier failed
  release, entry, frequency, static-depth, posterior-pulse, and posterior-
  damping variants, this closes both another posterior recovery and another
  small anterior pulse.
- Across the last `1.75L` of the deeper-bend trajectory, target-normal planar
  force is strongly oscillatory but nearly cancels: its signed integral to
  closest approach is about `0.00001`, versus positive and negative magnitudes
  of about `0.00197` and `0.00196`. Both joints have largely settled into the
  redirect by closest approach. The missing mechanism is therefore not another
  detector for the already-obvious miss; it is a way to preserve oscillatory
  propulsion while converting the alternating terminal load into a net
  target-side impulse.

## Policy hypothesis

Recover the evidenced response-released carrier outside the capture approach.
When normalized distance, projected miss, positive closing speed, and observable
course agree that a terminal correction is needed, smoothly replace the
settling static redirect with the traveling-bend carrier. During only that
terminal wave, project measured planar force normal to measured velocity and
compare its sign with the body-frame course error. Pump each joint along its
observed velocity when the force rotates the course toward the target, and damp
joint motion when force rotates it away. This changes the force-phase duty/energy
distribution without an external clock, an exact prescribed vortex phase, or a
posterior-only recovery stroke. The modulation is bounded, smooth, reflection
equivariant, and vanishes at range, on a safe intercept, at negligible speed,
or after positive closing ends.

Expected evidence is an unchanged far-field downward route and coherent 3D
wake, renewed joint oscillation inside the approach zone, a positive net
target-normal terminal force integral, and enough velocity rotation to cross
the `0.75L` capture radius. Falsify the mechanism if it does not beat the
`0.827823L` best completed minimum, changes body yaw without reducing projected
miss, repeats the high-corridor/static-latch topology, or increases angle
contact, force/moment scale, acceleration/speed-limit residence, or wake
incoherence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and asymmetric-flapping duty-ratio control
source_mechanism: sensory feedback redistributes oscillator effort between hydrodynamically useful and adverse portions of a propulsive cycle while retaining the traveling carrier
transferable_invariant: when static curvature rotates the body but alternating lateral loads cancel without rotating course, retain a traveling bend and use measured force quality to pump useful joint phases and damp adverse phases
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, dimensional beat timing, clocked CPG phase, exact vortex phases, world coordinates, and task-specific routes
policy_translation: normalized body-frame target and velocity define projected miss and desired course-rotation sign; normalized body-frame force defines actual course-rotation sign; smooth distance, miss, speed, and closing gates blend the static redirect into a two-joint traveling wave whose state-derived joint phases are pumped or damped by force alignment
falsification: reject if the rollout does not beat `0.827823L`, fails to make terminal target-normal force net positive, changes only body heading, or worsens route topology, wake coherence, angle clearance, loads, or actuator-limit residence

## Non-CFD implementation audit

Replaying the assigned-parent and candidate policies on all `7303` frozen
assigned-parent trajectory rows changes `413` commands. Every change is inside
`0.849--1.748L` and `25.075--27.341T`, with zero differences at or beyond
`1.75L`. The mean L1 command change on affected rows is about
`10.30 rad/T^2`; maximum component changes are about `9.84` anterior and
`15.57 rad/T^2` posterior. A terminal soft acceleration map and joint-angle
headroom keep frozen-state hard-clamp incidence exactly unchanged at `2733`
rows for both policies. The candidate owns all directly referenced parameter
fields, remains finite in the contract state, and negates both accelerations
under reflected target, velocity, force, yaw, and joint states. These checks
establish locality, material activation, boundedness, schema coverage, and
reflection equivariance only; they do not predict the unevaluated CFD result.
