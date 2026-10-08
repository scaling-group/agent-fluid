# Acceleration-projected completion-gated capture candidate

## Evidence and visual diagnosis before editing

- All four current solver samples satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture at `26.411 T` and
  `0.7496068 L` with score `-0.71050181`. Three use the unprojected
  completion-gated controller and one uses only a policy-boundary acceleration
  projection; their evaluated combined, top-down, and oblique keyframe sheets
  are byte-identical.
- In the top-down row, the fish establishes an alternating red/blue wake by
  `8 T`, sustains a continuous closing path through `16 T`, and turns the
  coherent wake and body trajectory into the capture circle between `24 T`
  and `26.411 T`. The oblique row independently shows compact alternating
  three-dimensional Lambda2 structures shed behind the posterior body through
  the terminal bend, without a visible wake collapse, collision, or unstable
  load event. Because the background is quiescent and the trajectory closes
  from `12.3277 L` to capture, this is organized self-propulsion rather than
  ambient advection or wasteful standing oscillation.
- The unprojected policy requests at least one joint acceleration beyond the
  evaluator's `31.4159 rad/T^2` envelope in `3963/4802` rows (`82.53%`), with
  component peaks `74.1975/85.6413 rad/T^2`. The isolated projected sample
  bounds both peaks at `31.4159 rad/T^2`; after removing only the two issued
  acceleration columns, its complete trajectory is byte-identical to the
  unprojected capture, as are its combined keyframes, arrival, distance, and
  score. This confirms that matching the evaluator's componentwise projection
  is idempotent for the applied dynamics.
- There is no current failed rollout. The informative inherited failure is the
  earlier projection-plus-joint-speed guard: it retained capture but arrived
  `0.4015 T` later, worsened mean distance from `2.6134 L` to `2.6382 L` and
  score from `-0.71050` to `-0.73429`, and showed no material force or moment
  benefit. Earlier inherited seed and response-gated failures missed at
  `4.7800 L` and `2.4625 L`, respectively, so the completion-gated redirect,
  posterior-lag carrier, and target-relative steering semantics should remain
  unchanged.

## Policy hypothesis

Promote the already evaluated isolated acceleration projection into the one
candidate. Preserve every term of the completion-gated redirect, normalized
body-frame target guidance, posterior-lag state-feedback carrier, cadence
schedule, and half-cycle steering. Add a parameter-owned `1800 deg/T^2` limit,
finite-sanitize each final joint command, and clamp it componentwise at the
public policy boundary. Do not add the unsupported joint-speed guard or a new
terminal approach mechanism: the current two-view evidence shows clean capture
rather than a terminal-regime deficit.

Expected result: reproduce the sampled `26.411 T` capture, applied joint
history, trajectory, coherent wake, loads, and score to deterministic
tolerance while issuing no nonfinite or over-envelope command. Falsify the
candidate if any non-command trajectory column, capture result, wake structure,
or score changes materially, or if a returned acceleration exceeds the
parameter-owned bound. The current worker claims no same-worker CFD result.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control under a physical two-joint actuator envelope
source_mechanism: preserve the observed-state propulsive rhythm and steering feedback while enforcing feasibility at the actuator interface
transferable_invariant: a componentwise feasibility projection can bound issued commands without changing already projected plant dynamics or the lower-amplitude state-feedback gait
nontransferable_details: published gains, robot motor and torque models, clocked CPG phase, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame completion-gated steering and the observed-joint posterior-lag carrier, then finite-sanitize and clamp both final accelerations to the parameter-owned limit without the empirically slower joint-speed guard
falsification: reject if the projected policy changes applied joint histories, non-command trajectory values, wake, loads, capture time, or score, or if any issued command remains nonfinite or outside the declared envelope
