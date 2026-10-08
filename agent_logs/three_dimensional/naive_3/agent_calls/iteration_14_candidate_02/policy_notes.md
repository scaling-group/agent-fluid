# Terminal distributed-curvature candidate

## Visual diagnosis and completed evidence

- All four sampled solver rollouts, the assigned parent's completed rollout,
  and the sampled terminal-curvature continuation report direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. Their translation and wakes are controller-generated rather than
  ambient advection or moving-window transport.
- The sampled `2.989L` response-released rollout has the strongest approach
  among the four solver examples. Its top-down row shows coherent alternating
  vorticity and its oblique row shows three-dimensional Lambda2 structures
  during self-propulsion to about `1.03U`, while peak local flow is only about
  `0.03U`. After the pass, rhythmic wake production fades and the path hooks
  into the upper boundary. The `4.859L` anterior-stiffness rollout is the
  informative visual failure: it retains alternating shedding but reduces
  peak speed to about `0.95U`, raises raw acceleration-limit occupancy to
  roughly `53/64%`, and never develops the needed target-directed course.
  This rules out another global anterior phase-stiffness edit.
- The assigned parent's speed-gated body-frame target-ray/velocity-course
  controller changes that topology while leaving the zero-centered traveling
  carrier intact. Its two visual rows retain a coherent self-propelled 3D wake,
  it reaches `0.857L`, and it exits the left rather than upper boundary. At
  closest approach (`19.058T`) it is still moving at `0.845U`; its head is at
  `(8.847,10.343)L`, full target bearing is `-1.019 rad`, and wrapped course
  error is `-1.421 rad`. The nearly tangent miss is therefore not caused by an
  unreliable low-speed course estimate, and the turn request is already
  saturated, so reducing the steering scale cannot add terminal authority.
- A sampled continuation raised posterior mean-curvature authority smoothly
  from `12 deg` toward `18 deg` inside `3L`. It preserved an almost identical
  wake and trajectory, changed heading at closest approach from `0.732` to
  `0.811 rad`, and lowered the miss only from `0.857L` to `0.832L`; speed
  remained `0.846U` and course error remained `-1.379 rad`. This is a concrete
  negative result for scalar-only posterior curvature escalation: it has the
  correct sign but weak leverage and still misses the `0.75L` capture circle.
  Earlier carrier-wide approach relief also worsened closest distance to
  `3.592L`, so propulsion must not be suppressed before terminal proximity.

## Policy hypothesis written before the solver edit

Start from the reproducible speed-gated target-ray/velocity-course controller.
Preserve its far-field observation, zero-centered anterior Van der Pol
oscillator, posterior lag, damping, and `12 deg` posterior mean-curvature cap.
Add one terminal-only distributed-curvature primitive: below `2.5L`, smoothly
shift the center of the still-active anterior oscillator by at most `8 deg` in
the saturated course-error direction. Construct the posterior traveling target
from the centered anterior state so the edit adds body curvature without
removing the carrier or increasing the posterior steering cap.

The expected effect is no pre-terminal trajectory change, followed by more
direct yaw leverage during the last `1.5L` of the known near-miss. The
controller releases continuously when distance or wrapped course error
recovers; it has no timer, hidden mode, world route, or fixed direction.
Falsify it if the broad sub-`1L` approach or alternating wake is lost, angle or
acceleration occupancy rises materially, terminal cross-track offset does not
fall below the `0.832L` reference, or termination occurs without capture and
without a distinct recovery arc.

```text
bookshelf_consulted: true
source_domain: biological fast-start turning and sensor-modulated robotic-fish CPG direction control
source_mechanism: recruit a bounded distributed body bend for large directional error, then release it into the continuing rhythmic carrier as alignment recovers
transferable_invariant: when posterior-only steering has the correct sign but insufficient terminal yaw leverage, add a bounded target-signed mean bend across the available joints while preserving state-feedback oscillation and release it with observed geometric recovery
nontransferable_details: species-specific C-start timing and curvature, published gains, robot linkage geometry, dimensional cadence, clock phase, exact vortex phase, and task-specific routes
policy_translation: derive a wrapped error between normalized full-quadrant target_body_L and velocity_body_U course; preserve the posterior mean-curvature channel; inside a smooth normalized distance gate shift the anterior oscillator center by the bounded error request and build posterior lag from the centered joint state
falsification: reject if the pre-terminal course or alternating 3D wake changes, the sub-1L approach is lost, actuator-limit occupancy rises materially, or terminal offset does not beat the 0.832L posterior-only reference and no new recovery topology appears
```
