# Capture-corridor redirect release

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled solvers are finite captures from the required direct,
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. I inspected both rows of the combined sheets for the
  best-scoring assigned parent `solver_94565263e129` and the distinct
  posterior-speed-guard sample `solver_29c7c83f8e3e`. In both top-down rows,
  the fish develops a coherent alternating red/blue wake by `4T` and keeps a
  strong traveling bend through capture. Both oblique rows show compact paired
  three-dimensional Lambda2 structures behind the posterior body. The fish is
  self-propelled rather than advected, and neither sheet shows wake collapse,
  boundary interaction, collision, or numerical instability.
- No failure-class visualization is present in the sampled workspace: every
  supplied rollout captures. Earlier upper exits, near misses, and broad
  U-turns are available only as inherited numeric/textual evidence, so they
  are not assigned a new visual cause here. The closest useful contrast is
  between the assigned parent, which captures at `16.049T` with score
  `-0.056774`, and the speed-guard sample, which preserves the same visible
  regime but captures at `16.071T` with score `-0.057037`. The two unguarded
  phase-residual samples capture at `16.044T`, score `-0.058311`, and have
  byte-identical trajectories despite source-level anti-windup differences.
  Thus another clamp-equivalent wrapper would not test new physics.
- The assigned parent's response-conditioned terminal relief is the only
  sampled edit that produces a materially different terminal state: compared
  with the `16.044T` baseline it finishes with world velocity
  `(-1.174,-0.081)U` rather than `(-1.096,-0.232)U`, reaches a smaller final
  distance (`0.74546L` versus `0.74696L`), and improves the held-distance score
  despite arriving `0.0055T` later. This supports retaining its rule that
  approach damping yields while a genuine redirect remains necessary.
- Its remaining terminal conflict is geometric. On the last recorded parent
  state, the raw target-versus-course mismatch is about `0.72 rad` and keeps
  high-authority redirect open, but the body-frame target/velocity cross
  product predicts a straight-course closest miss of only about `0.49L` while
  the target is closing. A fixed-trace audit with a conservative `0.55L`
  corridor and `0.15L` transition first activates at distance `1.69L`, affects
  only 112 approach samples, and averages `0.592` when active. It therefore
  distinguishes an already capture-directed approach from a large angular
  error without changing release, cruise, or middle-distance control.

## Policy hypothesis

Preserve the sampled-best carrier, carrier-phase-residual selector, raw-error
turn direction, mean-first posterior allocation, one-sided opposing-wave
relief, response-conditioned approach settling, bounds, and exact speed-limit
projection. Add one continuous capture-corridor mechanism. From normalized
body-frame target and velocity, compute the speed-normalized target/velocity
cross product, the predicted perpendicular miss for a locally straight
course. Only while the existing proximity-plus-closing gate is active and
course measurement is reliable, smoothly reduce only the raw and residual
high-authority mean-curvature copies when that predicted miss lies safely
inside the owned corridor. The original redirect demand continues to own
carrier settling, wave relief, and acceleration allocation, and the corridor
command is admitted only when it retains posterior command sign and requires
no more instantaneous acceleration than the sampled parent. The low-authority
cruise bend remains, and full mean redirect reopens immediately if the measured
miss leaves the corridor. This is state feedback, not a memorized route or
time-to-go stage.

The expected result is the same coherent wake and all far/middle milestones,
with less unnecessary terminal mean curvature and yaw once the measured course
already intersects the capture neighborhood. Falsify it if any command changes
outside the closing approach, capture is delayed or lost, the predicted miss
gate chatters with carrier phase, the wake weakens, or acceleration/load relief
does not compensate for worse target progress.

bookshelf_consulted: true
source_domain: robotic-fish path following and terminal biological capture
source_mechanism: sensor feedback preserves rhythmic propulsion while terminal steering authority yields only after measured motion enters a target-intercept corridor
transferable_invariant: near a target, distinguish angular pose mismatch from predicted translational miss and keep strong curvature only when the measured course would miss the capture neighborhood
nontransferable_details: published gains, species-specific capture maneuvers, dimensional lookahead distances, prescribed CPG or vortex phase, exact source-task capture radii, and task-specific routes
policy_translation: use normalized body-frame target and velocity to form a reflection-even closest-miss magnitude; proximity, target closing, and course reliability gate smooth attenuation of only the high-authority posterior mean-curvature copies, while raw bearing retains direction and the parent demand retains wave allocation and carrier settling
falsification: reject if release or far-field commands change, capture or wake coherence is lost, the same high terminal yaw persists without progress benefit, or corridor release opens when measured motion is not closing toward the target

The candidate has no same-worker CFD result. Fixed-trace replay may establish
locality, boundedness, reflection symmetry, and command semantics; only the
later EvE rollout can establish trajectory or wake improvement.

## Non-CFD refinement and verification

- A first direct translation attenuated the redirect gates everywhere they
  were consumed. Fixed-trace replay rejected it before handoff: on the parent
  states it reduced anterior effort but exposed a larger posterior wave through
  the nonlinear allocator, increasing approach posterior acceleration-limit
  residence from `31.2%` to `40.6%`. A smaller requested mean bend is therefore
  not automatically actuator relief; later workers should replay the complete
  allocator rather than infer demand from curvature alone.
- The final translation leaves the original gates in charge of approach
  settling, wave relief, and acceleration headroom, and uses corridor-scaled
  copies only for posterior mean curvature. A pointwise dominance guard rejects
  the corridor branch if it changes command sign or exceeds parent magnitude.
  On all `2,918` recorded parent states, every command at or above `1.75L` is
  exact. Six feasible posterior commands change below that boundary, beginning
  at `1.626L`; all six are same-sign relief. Fixed-trace approach mean posterior
  action falls from `26.107` to `25.813 rad/T^2`, while anterior action and both
  joints' acceleration-limit residence are unchanged. These are counterfactual
  command semantics, not a closed-loop improvement claim.
- The lightweight Julia contract passes. A `6,561`-state sweep over joint
  angles, exact-limit joint velocities, body-frame target geometry, and body
  velocity returns finite bounded commands with exact lateral-reflection
  equivariance. The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. Its three
  prescribed commands were therefore run directly and separately: the material
  guidance/provenance check, Julia policy-contract check, and solver editable-
  boundary check all pass. The duplicated assigned-parent marker exposed by the
  first guidance check was removed from the rendered workspace `README.md`
  before the successful rerun. No CFD was run.
