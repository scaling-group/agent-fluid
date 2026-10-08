# Posterior wave speed-headroom candidate

## Visual and quantitative diagnosis recorded before the policy edit

- All four allocated rollouts are finite captures from the required direct,
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. I inspected both rows of the combined keyframe sheet for the
  allocated `solver_358993c5a88b` and the assigned parent's distinct
  response-conditioned release `solver_210913739316`. In both top-down rows,
  the fish translates under its own traveling bend and develops a coherent
  alternating red/blue wake by `4T`; both oblique rows retain compact 3D
  Lambda2 structures behind the posterior body through capture. Neither shows
  advection, wake collapse, boundary interaction, or numerical instability.
  Their visible paths are nearly indistinguishable, so the trace and control
  semantics must decide what to change.
- The four allocated files reduce to one closed-loop trajectory. The
  carrier-phase-residual candidates and the exact-speed anti-windup variants
  all cross capture on the same `2917`th step at `16.0435T`, reach
  `0.746962L`, have mean/held distance `1.941006L`, and score `-0.058311`.
  Their functional differences either consist only of comments or project an
  outward command only after a joint is already at the integrator's exact
  `260 deg/T` hard boundary. Thus the sampled anti-windup is physically clean
  command bookkeeping, but it cannot change the clamped next joint state,
  wake, route, or target score.
- The assigned parent's response-conditioned approach release is the most
  informative mechanism failure available with complete visuals. It preserves
  capture at the same sampled step, but regresses to `0.748557L`, raises held
  mean distance from `1.941006L` to `1.942360L`, and lowers score from
  `-0.058311` to `-0.059985`. Combined with the inherited fixed-trace result
  that it restores drive on 92 anterior and 62 posterior approach commands,
  this supplies no evidence that releasing approach relief from instantaneous
  redirect consensus improves the route. The established approach gate and
  mean redirect should remain intact.
- Inherited logs report that the successful carrier-phase residual captures
  with a coherent wake but spends `22.7%` of posterior samples at the exact
  acceleration limit. Exact velocity-boundary projection changes 143 of 2917
  logged posterior commands and reduces fixed-trace mean posterior action from
  `25.514` to `24.871 rad/T^2`, yet the four allocated evaluations prove that
  this cleanup is state- and score-equivalent. A useful next actuator test must
  act before the clamp while preserving the mean steering channel; shared
  anterior bias, two-sided lobe amplification, yaw-rate steering, and broad
  approach carrier release remain contradicted by inherited evidence.

## Policy hypothesis

Preserve the evaluated carrier-phase residual, raw redirect direction,
mean-first posterior allocator, approach schedule, one-sided opposing-lobe
relief, bounds, and exact velocity-limit projection. Add one state-dependent
speed-headroom mechanism inside the posterior allocator: normalize measured
posterior speed by the owned physical limit, smoothly open a guard only in a
narrow pre-limit band, and attenuate only the wave acceleration component when
it has the same sign as posterior velocity. Inward wave action, mean-curvature
tracking and damping, every command below the guard, and the entire anterior
carrier pass through unchanged. Apply the identical rule to the raw and
phase-residual branches so their relief-only comparison remains meaningful.
Accept the guarded allocation only when the resulting total posterior command
retains the unguarded sign and has no larger magnitude; otherwise keep the
evaluated allocation. This dominance check prevents a removed wave component
from exposing a larger opposing mean command.

This creates a semantic test that the exact-boundary anti-windup could not:
the rhythmic component begins yielding before it consumes all posterior speed
headroom, while target-directed mean curvature keeps priority. Expect reduced
posterior velocity-limit residence without increasing acceleration-limit
residence or losing the coherent traveling wake and `16.0435T` capture.
Falsify the mechanism if any
below-onset or inward-wave command changes, reflection symmetry fails, the mean
redirect is attenuated, posterior limiting is merely shifted to the anterior
joint, wake strength or early milestones weaken, or capture/score regresses.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control under bounded actuation
source_mechanism: preserve a rhythmic locomotor carrier while observed actuator state continuously yields the oscillatory component that is consuming constraint headroom
transferable_invariant: when propulsion and route correction share a bounded posterior actuator, preserve the target-directed mean component and attenuate only the outward rhythmic component as measured speed approaches its limit
nontransferable_details: published CPG gains, dimensional frequencies, motor models, species-specific envelopes, prescribed phases, exact vortex phases, and task-specific routes
policy_translation: normalize posterior joint velocity by its owned limit, smoothly gate only same-sign posterior wave acceleration in a pre-limit band, and leave mean curvature, inward wave action, the anterior oscillator, and all body-frame navigation feedback unchanged
falsification: reject if below-band or inward-wave commands change, lateral reflection equivariance fails, posterior limiting is not reduced, the coherent wake or early target progress weakens, or capture and score regress

The new candidate has no same-worker CFD evidence. Only contract, symmetry,
boundedness, branch-locality, and fixed-trace command effects will be claimed
before downstream evaluation.

## Non-CFD refinement and verification

- A direct first translation attenuated every outward posterior wave near the
  speed boundary. Fixed-trace replay rejected it before handoff: removing a
  wave that opposed the mean could expose an opposite total command, producing
  a `60.26 rad/T^2` maximum change and raising mean posterior action from
  `24.871` to `27.169 rad/T^2`. The final pointwise sign-and-magnitude dominance
  check prevents both effects; this rejected local translation is not the
  candidate left in `solver/`.
- On the evaluated `solver_358993c5a88b` command-aligned trace, the final
  candidate leaves every anterior command and every posterior command below
  `0.96` normalized speed exact. It changes 13 posterior commands between
  normalized speeds `0.9641` and `0.9761`, never reverses a command or increases
  its magnitude, lowers fixed-trace mean posterior action from `24.8709` to
  `24.8264 rad/T^2`, and reduces one-step predicted posterior speed-limit rows
  from 169 to 160. It leaves fixed-trace acceleration-limit rows at 663, so no
  acceleration-residence improvement is claimed.
- A deterministic `141,750`-state sweep over joint state, bearing, body-frame
  velocity, and target geometry returned finite bounded actions with exact
  lateral-reflection equivariance. The anterior action and every below-band
  posterior action match the evaluated parent exactly. These are locality and
  semantics checks on inherited states, not a wake, trajectory, or score claim.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. I ran its three
  prescribed commands separately: the material-guidance check, lightweight
  Julia policy contract, and solver editable-boundary check all pass. The
  guidance check first exposed a duplicate rendering of the same assigned
  parent in workspace `README.md`; removing only that duplicate restored the
  unique-parent comparison. A separate schema audit confirms all 34 direct
  `params.FIELD` references are returned by `target_policy_params()`.
