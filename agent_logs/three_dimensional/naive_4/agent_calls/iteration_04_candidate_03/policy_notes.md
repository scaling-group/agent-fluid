# Speed-reliable course-alignment candidate notes

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations used direct uniform initialization in still
  water at `U_infinity=(0,0,0)`, with no prewarm snapshot or cylinders. They
  remained finite and self-propelled but terminated at the upper virtual
  boundary, so the current problem is target-course regulation rather than
  passive advection, collision, or numerical instability.
- Both visual rows distinguish the strongest course-feedback sample
  `solver_ab59732b5ad0` from the informative one-sided phase-authority failure
  `solver_b80f3041d568`. Their top-down rows show alternating red/blue caudal
  vorticity growing from still water, and their oblique rows show coherent 3D
  Lambda2 structures rather than a planar rendering artifact. The course
  sample leaves a much longer wake and path; the phase-authority sample bends
  steeply upward and exits by `9.053T`.
- The visual difference agrees with the metrics. Course feedback improves the
  inherited phase-authority sample's `11.448/11.465L` minimum/final distance
  to `6.218/6.272L` and extends survival from `9.053T` to `16.879T`. It reaches
  `0.849U` and triggers 179 moving-window shifts. This is the first sampled
  evidence that regulating inertial motion, rather than only body bearing,
  produces a meaningfully different useful trajectory in this lineage.
- The improvement is incomplete. The course-feedback path first moves down to
  about `y=13.555L`, then drifts upward and exits at `y=15.201L`; closest
  approach occurs only near termination, still `6.218L` from the target.
  Its fixed mixture `bearing - 0.55*course_angle` does not represent true
  course-to-line-of-sight error once swimming speed is reliable: it retains a
  body-bearing request even when the velocity vector is already aligned and
  under-corrects course error when it is not.
- Increasing continuous curvature or acceleration is not supported. The
  strongest sample already returns exactly clamped anterior and posterior
  acceleration in about `49.9%` and `60.8%` of its logged samples. The sampled
  half-cycle, one-sided phase-authority, relative-crossflow, and moment-residual
  alternatives all kept the upper-exit class and finished at least `4.6L`
  farther away, so this candidate preserves the successful posterior mean-
  curvature actuator and changes only how inertial course response is read.

## Policy hypothesis

Preserve the evidenced Van der Pol carrier, posterior lag, bounded posterior
mean curvature, target limit, and acceleration clamps. Replace the fixed
bearing/course mixture with a smooth observation-reliability transition. At
release or during reverse/weak forward motion, command from body-frame target
bearing because course angle is ill-conditioned. As forward speed grows, fade
continuously to the actual line-of-sight-minus-course angle, so steering
regulates where the fish is traveling rather than where its oscillating body
axis points. This is a feedback-architecture change; no propulsion or steering
limit is increased.

The downstream rollout should keep the course sample's coherent alternating
3D wake and substantial leftward progress while reducing the late upward drift,
beating `6.218L` closest approach, or changing the upper-exit termination class.
Falsify the mechanism if release motion stalls, beat-scale velocity makes the
steering chatter into a shorter path, clamp residence materially increases, or
the `6.218/6.272L` distance and `16.879T` survival benchmarks regress.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and response-gated biological redirects
source_mechanism: transition from body-direction steering to observed course regulation when locomotion supplies a reliable velocity direction
transferable_invariant: preserve the propulsive rhythm while a bounded target-relative feedback law regulates actual travel direction, and fall back to body geometry only when course observation is weak
nontransferable_details: published gains and speed thresholds, clocked CPG phase, species-specific kinematics, dimensional velocities, exact vortex phases, and task-specific routes
policy_translation: compute body-frame target bearing and normalized forward/lateral velocity, use forward speed to blend smoothly from bearing at release to line-of-sight-minus-course error during swimming, and retain posterior-only bounded mean curvature
falsification: reject if the alternating wake or forward progress weakens, acceleration-limit residence grows, or closest approach, final distance, and upper-boundary survival do not improve over `6.218L`, `6.272L`, and `16.879T`

The candidate has no same-worker CFD result; these are hypotheses for the
downstream evaluator.

## Non-CFD verification

- The required guidance-provenance, lightweight policy-contract, parameter-
  ownership, and editable-boundary checks pass. No CFD was run in this
  workspace.
- Julia mock states verify two finite bounded accelerations at release, during
  reverse motion, and with nonfinite bearing/velocity inputs. Simultaneously
  reflecting bearing, lateral velocity, both joint angles, and both joint
  rates reverses both accelerations to numerical tolerance.
- As a counterfactual signal audit only, replaying recorded course-sample
  states changes the mean bounded turn request rather than any limit: the mean
  absolute request change is about `0.163`, with unchanged `12 deg` curvature
  and `1800 deg/T^2` acceleration ceilings. This does not predict the new
  closed-loop trajectory.
