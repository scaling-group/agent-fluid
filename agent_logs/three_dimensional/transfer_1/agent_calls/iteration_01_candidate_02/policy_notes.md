# Candidate hypothesis: response-gated redirect curvature

## Prior evidence diagnosis

The sole sampled rollout is the exact transferred clean-B iteration-20 policy,
so it is both this workspace's best finite-distance example and its informative
failure. The observation and diagnostics confirm the required direct uniform
still-water initialization (`U_infinity=[0,0,0]`), no cylinders or prewarm,
and a numerically stable `left_domain` termination at `27.49T`.

Both rows of `wake_keyframes.jpg` show self-propulsion rather than advection.
The top-down row develops an alternating, spatially coherent wake and the
oblique Lambda2 row confirms genuinely three-dimensional shed structures from
the body/caudal system. This useful drive closes distance from `12.328L` to
`4.780L` by `17.853T`. The motion is nevertheless a broad downward arc: mean
heading grows from `29 deg` to roughly `40 deg` at closest approach and then to
about `97 deg` near termination, while the target has moved to the opposite
body-side turn direction. Distance increases monotonically after the closest
approach until the center reaches `y=0.798L` and the head reaches `y=0.310L`.
The trajectory also shows sustained propulsion near `0.8 U`, bounded force and
moment coefficients (approximately `|F|<=0.030`, `|Mz|<=0.016`), and no
instability. Thus the visible miss is not a wake disruption or a coasting
failure: the transferred controller preserves thrust but its target-turn
request does not reverse the persistent wrong-way yaw.

## Policy hypothesis

Preserve the evidenced traveling-bend drive. Add one mechanism: a bounded
large-error redirect curvature, analogous to a response-gated C-start. It is
driven only by normalized body-frame target angle and observed recent turn
rate. Large target error with absent or wrong-sign yaw shifts the anterior
oscillator center and posterior mean tangent in the requested yaw direction;
the shift fades once a correct-sign turn response appears, releasing the gait
back toward its propulsive rhythm. This replaces the inherited negative-request
posterior curvature mapping whose observed positive mean yaw was opposite the
required correction. Small-error steering remains with the existing
state-phase half-cycle bias.

Falsification: reject this transfer if the rollout still follows the same
downward exit topology, if the redirect bends the yaw farther from the target,
or if added mean curvature destroys the coherent wake and materially degrades
the early distance closure. A useful result should visibly turn back toward
the target after the first growing body-frame error and improve the termination
class or minimum distance without persistent actuator saturation.

bookshelf_consulted: true
source_domain: biological C-start redirect and robotic-fish mean-curvature steering
source_mechanism: large heading error produces bounded body curvature that releases when the heading response appears
transferable_invariant: gate a strong turn reserve by target-relative error and observed turn response while retaining a posterior-emphasized traveling bend
nontransferable_details: species kinematics, published gains, dimensional beat timing, exact bend envelope, and any prescribed route or vortex phase
policy_translation: normalized body-frame vector angle selects signed two-joint mean curvature; recent yaw response continuously suppresses that curvature once it has the requested sign
falsification: same lower-boundary exit or worsened early closure, wrong-sign yaw under the reserve, loss of coherent propulsion, or persistent saturation
