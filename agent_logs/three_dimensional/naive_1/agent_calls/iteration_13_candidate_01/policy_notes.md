# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four current solver samples satisfy the released-flow contract: direct
  uniform `U_infinity=[0,0,0]`, no prewarm, no cylinders, and finite capture.
  Three bitwise-identical reactive-rudder baselines capture at `24.337509T`,
  minimum/final distance `0.749625L`, mean distance `2.224316L`, and score
  `-0.325566`. Their agreement establishes a reproducible carrier and route,
  but the threshold margin remains only `0.000375L`.
- The distinct sampled policy continuously removes at most 20% of the
  posterior rudder when normalized closing speed falls from `0.35` toward
  `0.10L/T`. It retains capture and improves it narrowly but consistently in
  every reported scalar: `24.326511T`, `0.749329L` minimum/final distance,
  `2.224097L` mean distance, and `-0.325310` score. This is two control steps
  earlier than the replicated baseline, not evidence for a large performance
  gain or for generalization beyond this released pose.
- In the combined sheet for that best finite sample, the fish translates from
  rest while shedding an alternating red/blue caudal street, bends toward the
  target during the final approach, and retains visible oblique Lambda2
  structures through capture. The informative opposite allocation, which
  adds up to 20% rudder under the same closing deficit, has a nearly identical
  top-down wake and still captures, but later at `24.414513T`, with worse
  `0.749996L` minimum distance and `2.224632L` mean distance. Its oblique row is
  black and cannot support a three-dimensional-wake comparison. Thus the
  supported finite difference concerns terminal steering allocation, not wake
  strength inferred from rendering.
- The assigned parent independently proposed terminal rudder release but its
  rollout failed before producing CFD evidence because it referenced absent
  observation field `state.window_closing_speed_L`. The adapter explicitly
  exposes `state.closing_speed_L`, which the successful sampled release policy
  uses. Observation-schema validation is therefore part of the mechanism, not
  a cosmetic repair.

## One candidate hypothesis

Promote the sampled response-scheduled release as the single candidate. Keep
the reproduced joint-state oscillator, slip-aware anterior center, full
body-frame target geometry, phase-selective posterior carrier, and
distance/error-gated opposite-sign rudder unchanged. Add only the evidenced
allocation mechanism: measured low closure smoothly reduces the posterior
mean rudder by at most 20%, while leaving the traveling carrier active. This
tests terminal steering release rather than another global gain change and
uses only an available normalized response observation.

Expected result: reproduce capture no later than the baseline's `24.337509T`
without changing the pre-terminal route, alternating top-down wake, or visible
oblique structure, and keep mean distance at or below `2.224316L`. Falsify the
candidate if capture is lost or delayed, if minimum/mean distance regress
beyond the replicated baseline, if the established joint/load envelope
materially worsens, or if the trajectory diverges before the rudder gate is
active. Treat the sampled improvement as pose-specific until another released
condition confirms it.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve rhythmic propulsion while observed approach response continuously releases a steering load after its useful redirect
transferable_invariant: separate the propulsive carrier from mean steering allocation and reduce only the steering residual when normalized response shows over-command
nontransferable_details: species-specific burst timing, published CPG gains, linkage geometry, dimensional speeds, exact beat or vortex phase, and task-specific routes
policy_translation: joint state continues the two-joint traveling carrier while verified body-frame distance, target error, and `closing_speed_L` gates remove at most one fifth of the posterior mean rudder
falsification: reject if capture is lost or later than 24.337509T, mean distance exceeds 2.224316L, or the pre-terminal route, wake, saturation, force, or moment envelope materially degrades
