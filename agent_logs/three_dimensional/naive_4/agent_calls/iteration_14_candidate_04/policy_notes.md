# Intercept-corridor carrier release

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct, uniform still-water contract:
  `U_infinity=(0,0,0)`, `initialization_mode=uniform_direct`, no cylinders,
  and no prewarm. I inspected both rows of the combined keyframe sheets for
  the best-scoring response-conditioned parent `solver_94565263e129`, the
  isolated speed-headroom regression `solver_56b21819ac4d`, and the distinct
  capture-corridor result `solver_3b5e36735c7f`. Their top-down rows show
  self-propulsion from quiescent fluid, a coherent alternating red/blue wake by
  about `4T`, a strong traveling posterior bend, and a target-directed turn
  through capture. Their oblique rows retain compact three-dimensional
  Lambda2 structures behind the posterior body. None shows passive advection,
  wake collapse, collision, boundary interaction, or numerical instability.
- No failure-class visualization is supplied: all four examples capture. The
  informative failure is instead a mechanism regression within the same
  visible regime. Adding the narrow outward-wave speed guard to the assigned
  parent lowers posterior speed-limit residence from `6.066%` to `5.850%`,
  acceleration-limit residence from `22.892%` to `22.751%`, and peak
  force/moment from `0.03926/0.01945` to `0.03814/0.01927`. Yet it delays the
  `8/6/4/2L` crossings from `9.202/11.154/13.013/14.905T` to
  `9.191/11.160/13.041/14.922T`, captures at `16.077T` rather than `16.049T`,
  and worsens score from `-0.056774` to `-0.058139`. The reduced limiting is
  therefore not useful control progress on this route.
- Attenuating high-authority mean redirect inside a predicted capture corridor
  is also negative evidence. `solver_3b5e36735c7f` preserves every reported
  milestone and the `16.049T` capture, and lowers mean posterior action from
  `24.923` to `24.901 rad/T^2`, but increases mean/held distance from
  `1.939780L` to `1.939940L`, final distance from `0.745461L` to `0.745652L`,
  and worsens score to `-0.056973`. Its last-state heading and velocity remain
  almost identical to the parent, matching the visual absence of a distinct
  terminal maneuver. A capture-feasible course is not evidence that the
  already successful mean redirect should be weakened.
- The useful evidence is role-specific. The assigned parent's earlier
  response-conditioned change improved score from `-0.058311` to `-0.056774`
  by letting approach damping and wave reduction yield whenever raw or
  carrier-residual redirect duty was high. On its trace, the locally straight
  predicted miss repeatedly lies well inside the `0.75L` capture neighborhood
  even when beat-scale angular mismatch makes redirect duty small: it is about
  `0.09L` at the `2L` crossing and `0.08L` at the `1.25L` crossing. Thus the
  measured intercept corridor supplies independent evidence that settling is
  premature, without implying that mean curvature should be removed.

## Policy hypothesis

Preserve the sampled-best carrier, raw-error redirect direction,
carrier-phase-residual authority selector, mean-first posterior allocation,
one-sided opposing-wave relief, approach-conditioned redirect onset, bounds,
and exact speed-limit projection. Add one continuous role-allocation
mechanism. Compute the reflection-even closest miss of the locally straight
course from normalized body-frame target and velocity. Only while proximity,
target closing, and course reliability agree, use a comfortably interior
intercept corridor as a second reason for approach settling to yield. The
high-authority and cruise mean-curvature laws remain bit-for-bit unchanged;
the new signal can only restore anterior rhythmic drive and posterior wave
amplitude that the existing approach gate would otherwise reduce.

This tests whether preserving the carrier on an already capture-directed
course advances late distance milestones without disturbing the proven route
command. Falsify it if any command changes outside the closing approach, the
mean redirect changes, carrier release increases lateral oscillation or loads,
the coherent wake weakens, a distance milestone or capture regresses, or the
score fails to recover the parent despite any effort reduction.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal fish capture
source_mechanism: sensor feedback preserves rhythmic propulsion while terminal gait relief is scheduled separately from route curvature
transferable_invariant: reduce rhythmic drive near a target only when measured translation is not already a reliable capture intercept or corrective steering no longer needs the carrier
nontransferable_details: published gains, dimensional lookahead, species-specific capture kinematics, prescribed oscillator or vortex phase, exact source-task capture radii, and memorized routes
policy_translation: form a bounded reflection-even closest-miss signal from normalized body-frame target and velocity; combine it with proximity, closing, and speed reliability to release only approach damping and posterior-wave reduction while retaining all target-directed mean curvature
falsification: reject if release occurs outside a closing reliable approach, changes mean steering, breaks lateral reflection equivariance, raises loads without earlier progress, or loses the sampled parent's coherent wake, milestones, capture, or score

The candidate has no same-worker CFD result. Fixed-trace replay may establish
locality, symmetry, and which commands change; only the later EvE evaluation
can establish a wake or trajectory improvement.

## Non-CFD verification

- Replay on all `2,918` recorded assigned-parent states returns finite bounded
  commands and leaves every action at or above the `1.75L` approach boundary
  exact. It changes 59 closing-approach rows, first at `1.746L`; the maximum
  anterior/posterior command differences are `9.708/5.185 rad/T^2`. On the
  fixed states, mean approach absolute action decreases from
  `27.207/26.107` to `27.054/25.963 rad/T^2`, and acceleration-limit rows fall
  from `1435/669` to `1433/668`. These are counterfactual action semantics,
  not closed-loop trajectory, load, or wake evidence.
- A deterministic `270,000`-state sweep over joint state, body-frame target,
  bearing, and body velocity returns finite bounded commands with exactly zero
  lateral-reflection error. The parameter-schema, material-guidance,
  lightweight Julia policy-contract, and editable-boundary checks pass.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. Its three
  prescribed checks were therefore run directly and separately; all pass. No
  CFD was run.
