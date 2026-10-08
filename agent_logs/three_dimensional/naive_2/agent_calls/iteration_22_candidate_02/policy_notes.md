# Candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The assigned parent `solver_a176917716bd` and its exact sampled repeat
  `solver_0f91f918d286` captured at `16.604496T`, with score `-0.1137286345`,
  final/minimum distance `0.743958L`, and direct uniform still-water
  initialization. The inherited optimizer scores show this follows exact
  captures at score `-0.1183068810` and then `-0.1155603837`.
- The most informative comparison is the exact pair
  `solver_a2617fc44329`/`solver_a25f2f42902a`. It also captured on a nearly
  identical route, but at `16.609995T`, score `-0.1155603837`, and
  `0.745621L`. The only controller difference is the absence of the parent's
  approach-gated lateral carrier demodulation.
- Both combined keyframe sheets were inspected. Their top-down rows show
  self-propulsion from quiescent water, a shallow target-directed arc, and a
  coherent alternating wake that remains connected to the posterior body up
  to capture. Their oblique Lambda2 rows show compact three-dimensional
  structures shed along the same path without visible wake collapse,
  collision, boundary exit, or instability. The parent arrives one recorded
  step earlier, but the view-level difference is deliberately small.
- The traces support that visual reading. Relative to the comparison, the
  parent reduces scored mean distance from `1.999656L` to `1.998146L` and
  arrival from `16.609995T` to `16.604496T`, while peak planar force/moment
  rise from `0.03583/0.01776` to `0.03717/0.01836` and acceleration
  near-limit residence rises from about `35.4%` to `36.5%`. Thus the inherited
  lateral demodulation is a narrow route improvement, not an effort or load
  improvement.
- A one-carrier-period rolling-mean separation on each unique completed trace
  exposes another observer problem. Inside `3L`, the raw body-frame bearing's
  beat residual is fit by centered anterior phase with coefficients about
  `(-0.6245, -0.0150)` for `(q1_carrier, q1_dot)` at `R^2=0.9991` in the
  parent and `(-0.6195, -0.0152)` at `R^2=0.9990` in the comparison. In the
  parent, removing that component would reduce bearing RMS inside `3L` from
  about `0.384` to `0.143 rad`; at the last pre-capture sample it changes raw
  bearing `-0.286` to a directional estimate near `+0.009 rad`. Raw bearing is
  therefore mostly carrier attitude at beat scale even though the target
  route itself varies slowly.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and wake-interaction control
source_mechanism: separate persistent target-direction feedback from rhythmic carrier response before modulating a propulsive gait
transferable_invariant: self-generated beat motion and slow route error require distinct observation channels so carrier phase is not mistaken for a reversal of the requested turn
nontransferable_details: published CPG gains and frequencies, species-specific envelopes, exact vortex phases, dimensional trajectories, and task-specific routes
policy_translation: preserve the parent's carrier and raw-course anterior lever; inside the already evidenced approach window, subtract the fitted centered-joint phase component from bearing before posterior mean-curvature, yaw-request, and half-cycle logic
falsification: reject if capture is lost or delayed, the shallow route or connected alternating wake changes adversely, bearing remains phase-correlated, or joint contact, near-limit action, force, or moment grows beyond the parent tradeoff

## Single candidate hypothesis

Add one approach-gated carrier-demodulated bearing observer. Use the
cross-rollout central coefficients `-0.62` and `-0.015` only to reconstruct the
rhythmic bearing component; subtract that component from raw bearing in the
posterior route state. Keep raw bearing for the anterior centerline window and
keep the raw velocity-course anterior lever, propulsion oscillator, lateral
and yaw demodulation, posterior half-cycle structure, and speed guard
unchanged. This should stop posterior steering polarity from changing merely
because the body is at the opposite carrier phase, while leaving the
demonstrated far route exactly unchanged. The formal CFD result is deferred to
the downstream evaluator and is not claimed here.

## Non-CFD validation

- The guidance-parent checker passes after removing a duplicate rendering of
  the same assigned parent from the workspace `README.md`.
- The solver edit-boundary checker passes: only
  `cases/dogfish_3d_shape_policy/candidate_target_policy.jl` differs inside
  `solver/`.
- A deterministic static schema check finds one public policy pair and confirms
  that all 34 direct `params.FIELD` references are returned by
  `target_policy_params()`. The prescribed Julia runtime smoke command could
  not be executed because this workspace image has no `julia` executable; no
  CFD was run.
