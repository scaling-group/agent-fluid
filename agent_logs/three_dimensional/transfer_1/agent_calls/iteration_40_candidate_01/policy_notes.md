# Step 40 wake-policy diagnosis

## Evidence read before the edit

- All four sampled evaluations satisfy the released experiment contract:
  direct uniform `U_infinity=(0,0,0)`, no cylinders, and no prewarm. All four
  capture at `0.74846--0.74986L` after `18.2875--18.6560T`. Three are exact
  evaluations of the intercept-guarded speed-reserve baseline (policy SHA-256
  `567de354e2bf646dce0776b20e284aabc896c7816eafff848839efa2937b9dac`);
  the fourth is the outer unsupported-bearing qualifier already rejected by
  its inherited exact replay at `1.18462L`.
- In the highest-scoring sampled sheet, the fish moves under its own actuation
  from release toward the target while laying down a coherent alternating
  mid-plane vorticity street. The oblique row shows bilateral Lambda2
  structures from `4T` through its `18.6560T` capture. The three baseline
  sheets have the same productive traveling-wake topology. Distance progress,
  nonzero inertial velocity, and direct-zero background flow confirm this is
  self-propulsion rather than advection.
- The assigned parent's exact LOS-rate policy captures at `0.74957L` and
  `18.8980T`; its combined sheet likewise retains both organized wake views
  through target crossing. Its head/tail action-clamp fractions are
  `68.42%/70.78%`, speed-limit residence is `10.54%/11.35%`, and peak
  body-force/moment coefficients are `0.01476/0.02872/0.01566`, all inside but
  not better than the established baseline envelope.
- The inherited sibling rollout with the same LOS policy SHA-256
  `fa1e73606ad3cccf13d12579377fd177abd8f6fa5b6fc00b42c1d1b501503db6`
  is the most relevant failure comparison. Its top-down street and bilateral
  oblique structures remain active through a `1.59620L` closest pass and
  continue afterward as the fish turns below the target and exits at
  `10.33579L`. Metrics confirm stable direct-uniform self-propulsion, not
  carrier collapse or instability: closest-pass speed is about `0.829L/T`,
  action clipping is `70.25%/71.79%`, speed-limit residence is
  `8.42%/9.37%`, and peak load coefficients remain
  `0.01490/0.02822/0.01573`.
- The LOS residual therefore has a mixed exact-byte record: the original
  inherited capture at `0.74605L`, the assigned-parent capture at `0.74957L`,
  and the sibling lower exit at `1.59620L`. Its successful parent repeat also
  scores `-0.16030` at `18.8980T`, whereas the three exact baseline samples
  all capture earlier (`18.2875--18.6010T`) and score higher
  (`-0.15733--0.15140`) with the same coherent wake and actuator/load class.
  This falsifies promoting or tuning the LOS residual as a robust improvement.

## Candidate hypothesis

Restore exactly the sampled `dogfish3d_intercept_guarded_speed_reserve_v1`
controller and remove the stale unsupported-bearing qualifier from the
prefilled solver. This is one rollback candidate, not a parameter tune: retain
the normalized achieved-course servo, response-conditioned inner intercept
guard, additive two-joint steering allocation, posterior-lagged traveling bend,
and sparse outward-only carrier reserve whose three sampled exact evaluations
all capture. Do not add the mixed-reliability LOS residual, partial-retention
cue, or another terminal geometry stack.

The next CFD evaluation supports the rollback if it captures while retaining
far-field closure, both wake views, and the existing actuator/load envelope.
Falsify it if it loses capture, returns to the coherent-wake lower-exit branch,
weakens the traveling bend, or materially worsens clipping, joint-speed
residence, force, or moment. No same-worker CFD result is claimed.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking over an independently sustained rhythmic carrier
source_mechanism: bounded geometry-driven steering residual separated from the propulsive body wave
transferable_invariant: preserve an independently active traveling bend and admit steering feedback only when repeated task evidence shows a reliable response benefit
nontransferable_details: published gains, clocked CPG phase, robot morphology, dimensional cadence, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame achieved-course feedback and the evaluated two-joint traveling bend, but omit the added LOS and bearing residuals because their exact-repeat evidence does not beat the three-capture baseline
falsification: reconsider a separate response residual only if independent exact repeats improve capture reliability, arrival, loads, or actuator use without changing far-field closure or either organized wake view

## Non-CFD validation

- The installed solver file is byte-identical to all three sampled baseline
  captures, with SHA-256
  `567de354e2bf646dce0776b20e284aabc896c7816eafff848839efa2937b9dac`.
- The semantic guidance check passes with a material reusable update, including
  the deterministic parameter-schema guard. The solver editable-boundary check
  also passes.
- Julia 1.12.6 loads the candidate and returns the finite two-joint action
  `(-15.078363043496848, -1.6932057383289447)` for the prescribed contract
  probe. No CFD was run.
