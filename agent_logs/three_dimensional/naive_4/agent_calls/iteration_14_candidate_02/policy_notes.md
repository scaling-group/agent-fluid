# Intercept-conditioned anterior energy release

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the required direct, uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, and finite capture.
  I inspected both rows of the combined sheets for the assigned parent
  `solver_3b5e36735c7f` and the prior-best
  `solver_94565263e129`. Their top-down rows show self-propelled motion and a
  coherent alternating red/blue wake established by `4T` and retained through
  capture. Their oblique rows likewise retain compact paired three-dimensional
  Lambda2 structures behind the posterior body. Neither shows passive
  advection, wake collapse, collision, boundary interaction, or instability.
- The assigned parent's predicted-miss corridor is the informative negative
  control in this all-capture sample. Relative to the otherwise matching
  prior-best policy, it leaves the `8/6/4/2L` milestones and `16.049T` capture
  unchanged, but worsens final distance from `0.745461L` to `0.745652L` and
  score from `-0.056774` to `-0.056973`. The inherited fixed-trace audit says
  it changed only six posterior commands, all by attenuating mean steering.
  Its wake sheet remains visually indistinguishable from the prior best.
  Thus a safe projected miss is not evidence that terminal steering is
  redundant, and another curvature-release or clamp-equivalent wrapper is not
  justified.
- The prior-best response-conditioned approach law remains the strongest
  sampled route. It reaches `8/6/4/2L` at
  `9.202/11.154/13.013/14.905T`, captures at `16.049T`, and preserves rhythmic
  authority whenever either raw or carrier-residual course mismatch requests
  redirect. At the final sample it still carries speed `1.177U`; the remaining
  settling channel is therefore a small terminal energy decision, not a need
  to rebuild propulsion or steering.
- An in-memory replay of the proposed control-role reassignment on all `2,918`
  prior-best states leaves every state at or above `1.75L` and every posterior
  command exact. Below `1.75L`, it changes 35 feasible anterior commands,
  always by removing a damping component in the measured joint-velocity
  direction; the maximum command delta is `9.71 rad/T^2`. This is materially
  different from the parent's six-command posterior steering relief while
  remaining local to an already closing, capture-directed approach.

## Policy hypothesis

Return the parent's high-authority mean-steering path to the evaluated
prior-best response-conditioned law. Retain its carrier-phase-residual
selector, raw-error turn direction, one-sided opposing-wave relief,
mean-first posterior allocator, posterior approach relief, bounds, and exact
speed-limit projection. Keep the assigned parent's normalized body-frame
predicted-miss observation, but give it one narrower role: only when proximity,
target closing, reliable course measurement, and a safe projected intercept
all agree, continuously release the residual anterior damping. Posterior wave
relief and all mean steering remain unchanged. The released damping injects
energy through the observed anterior joint velocity rather than through a
clocked burst, fixed route, or scalar-only gain change; full settling reopens
as soon as the measured intercept becomes unsafe.

Expected result: retain the prior-best coherent wake and far/middle route,
while carrying slightly more anterior oscillator energy through the final
capture crossing. Falsify it if any pre-approach or posterior command changes
on fixed-trace replay, capture or an earlier milestone regresses, the
alternating wake weakens, the corridor gate creates chatter, or extra terminal
energy increases limit residence or loads without improving arrival/final
distance.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal biological capture
source_mechanism: preserve target-directed steering while sensor feedback releases locomotor energy only for a measured terminal intercept
transferable_invariant: when measured translation already crosses a capture neighborhood, remove residual gait braking before removing steering authority, and restore braking continuously if the projected intercept degrades
nontransferable_details: published gains, dimensional burst timing, species-specific capture kinematics, exact vortex phase, source-task capture radii, prescribed CPG phase, and task-specific routes
policy_translation: form a reflection-even predicted-miss magnitude from normalized body-frame target and velocity; gate only anterior velocity damping by proximity, closing, course reliability, and safe miss, while raw bearing/course feedback retains redirect direction and all posterior control roles
falsification: reject if commands change outside the closing approach, posterior commands differ on inherited states, capture or wake coherence is lost, or added terminal oscillator energy worsens progress, saturation, or loads

The candidate has no same-worker CFD result. Fixed-trace replay can establish
locality and action semantics; only the later EvE rollout can establish a wake
or trajectory improvement.

## Non-CFD verification after the policy edit

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. Its three
  prescribed commands were then run directly and separately. The first run of
  the guidance check exposed two identical assigned-parent markers in the
  rendered workspace `README.md`; removing only the duplicate restored unique
  provenance. The material guidance/provenance check, lightweight Julia policy
  contract, and solver editable-boundary check all pass.
- Static schema inspection finds `35` direct `params.FIELD` references and all
  `35` fields are returned by `target_policy_params()`. A deterministic
  `19,683`-state sweep over joint state, exact speed boundaries, target side,
  bearing, forward/lateral velocity, and target geometry returns finite bounded
  actions with zero lateral-reflection error and no outward action at either
  exact joint-speed boundary.
- Replay of the final source against the prior-best trace confirms the
  pre-edit audit: exactly 35 anterior commands change between `1.746L` and the
  last pre-capture state at `0.752L`; every earlier and every posterior command
  is exact. The largest change is `9.708 rad/T^2`. These are counterfactual
  command semantics, not a same-worker closed-loop result. No CFD was run.
