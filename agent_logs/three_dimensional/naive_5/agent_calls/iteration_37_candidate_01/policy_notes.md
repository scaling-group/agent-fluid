# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and
  inertial moving-window transport. All terminate in capture with zero angle,
  speed, or applied-acceleration contacts. The current comparison therefore
  concerns integrated route response, arrival, loads, and wake organization,
  not a new termination class.
- I inspected every combined sheet from release through capture in both the
  top-down vorticity/body row and the oblique body/Lambda2 row. The strongest
  finite sample (`solver_64a9b2cc44b2`) and the assigned parent
  (`solver_2515fae158ed`) both visibly self-propel, shed an orderly alternating
  wake, retain compact three-dimensional vortices, and reach the target through
  the same shallow late hook. The two yaw-moment comparisons
  (`solver_611d5b2ed6fb` and `solver_aadb9456cac4`) remain in that same useful
  topology. None shows passive advection, boundary interaction, broad curling,
  wake breakup, numerical instability, or moving-window-induced rotation.
- The assigned parent's phase-rejected posterior reaction half-cycle is now a
  concrete mechanism failure. Its `18--24T` mean normalized course error and
  projected miss are `0.55184/1.79710L`. Adding a moment residual on top of it
  reaches `0.54473/1.77794L` and arrives `0.0825T` earlier, but the maximum
  head-path separation is only `0.0431L`. Replacing it with the stricter
  target-line/moment composition changes the path by at most `0.0125L` and
  arrives only `0.0220T` earlier. These outcomes preserve capture but do not
  support another posterior phase, moment threshold, or recovery-gain edit.
- The force-qualified sample is the best current finite result: relative to
  the parent it improves score from `-0.594833` to `-0.594050`, mean distance
  from `2.497000L` to `2.496011L`, and capture time from `25.9105T` to
  `25.8115T`. Its `18--24T` mean course error/miss also falls to
  `0.54411/1.77355L`. Yet its maximum path separation is only `0.0442L`, its
  `24T` miss is slightly worse (`1.010L` versus `0.992L`), and both visual rows
  retain the common hook. This is a bounded finite response signal, not a
  semantic route improvement.
- All four share maximum angle/rate/action near
  `0.7635 rad/4.5150 rad/T/29.6581 rad/T^2`; peak planar force and yaw moment
  remain within `0.01891--0.01910` and `0.01009--0.01014`. Across the middle
  corridor, velocity-normal force correlates about `0.994` with measured
  translational-course rotation. The sampled force branch therefore merits an
  isolated mechanism test, while the carrier, feasibility projection, and
  viability guards have no evidenced defect to retune.

## Policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, course-triggered
response-released redirect, target-line response, upstream vectoring, capture
modulation, coordinated command projection, and angle/rate guards. Remove the
falsified phase-rejected posterior reaction half-cycle. In its place, let
normalized body-frame target/velocity geometry continue to own the steering
side, while velocity-normal hydrodynamic force smoothly qualifies a small
same-sign two-joint curvature residual only when that force rotates the course
away from the target. Closing motion, translation confidence, redirect
release, and the established middle-distance window bound the response;
helpful force, far travel, weak translation, non-closing states, and the inner
capture corridor pass through.

This differs from the sampled force policy by omitting its separately falsified
instantaneous-sideslip posterior branch, so it isolates one response mechanism
rather than stacking two beat-synchronous explanations. The falsifiable
expectation is to retain the force sample's earlier arrival and lower
middle-course integral with a more interpretable command change, while
preserving capture, the coherent two-view wake, zero actuator contacts, and the
sampled `0.01910/0.01014` force/moment envelope. Reject it if arrival or mean
distance regresses to the assigned parent, the path again separates by less
than `0.05L`, middle projected miss does not fall, the controller reverses the
geometry-owned route, or wake, loads, or actuator viability degrade.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG steering
source_mechanism: separate slow geometric route authority from a bounded fast hydrodynamic response residual
transferable_invariant: target geometry owns turn direction while only measured adverse lateral response qualifies a small phase-selective correction, leaving helpful response and the propulsive rhythm intact
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, robot linkage geometry, exact vortex phases, source wake geometry, and prescribed routes
policy_translation: normalized body-frame velocity-to-target geometry defines course side, while velocity-normal force gates a bounded same-sign two-joint residual inside the closing middle corridor under the existing two-joint state-feedback contract
falsification: reject on unchanged middle route, lost or slower capture, geometry-side reversal, incoherent wake, actuator contact, or force and yaw-moment exposure above the sampled regime

## Non-CFD audit after the policy edit

- All 58 direct `params.FIELD` references are owned by the returned 58-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations, and the candidate remained non-empty throughout the edit.
- An 18,000-state grid spanning both lateral reflections, five distance
  regimes, negative/zero/positive closing speed, adverse/helpful/zero force,
  weak and strong translation, and beyond-limit joint angles/rates remains
  finite and within the `30 rad/T^2` policy envelope. Paired reflected states
  have zero numerical command error.
- Re-evaluating the assigned parent and candidate on all 4,711 reconstructed
  parent-trace states changes 1,135 post-guard command pairs, including 472 by
  more than `0.05 rad/T^2`; the maximum separation is
  `0.73823 rad/T^2`. Activation is confined to `18.876--25.119T` and
  `4.499--1.102L`, while the candidate's peak frozen-state command remains the
  parent's `29.65805 rad/T^2`. The isolation also differs from the sampled
  bundled force policy on 268 rows (139 above `0.05 rad/T^2`, maximum
  `0.61110 rad/T^2`). This establishes a material, bounded middle-response
  experiment and exact far/inner-capture pass-through; it is not CFD outcome
  evidence.
- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this ChatGPT account. Its three
  prescribed commands were run directly as the inherited fallback. The
  guidance check first exposed a duplicated assigned-parent marker in the
  rendered `README.md`; removing only that duplicate repaired the assignment.
  The material-guidance, Julia public-contract/schema, and solver editable-
  boundary checks then pass. No formal CFD was run.
