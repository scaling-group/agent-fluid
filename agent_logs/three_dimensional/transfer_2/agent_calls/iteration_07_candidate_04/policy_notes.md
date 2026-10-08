# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled evaluations use direct uniform still-water initialization
  (`U_infinity=[0,0,0]`), no cylinders, no prewarm, finite dynamics, and the
  moving-window transport.  Their translation and wakes are self-generated,
  not imposed advection.
- Both the top-down vorticity and oblique Lambda2 rows were inspected for the
  strongest finite score (`solver_b99a83cfb22d`) and the most informative
  trajectory contrast (`solver_99c121bdac44`), then checked against metrics,
  diagnostics, and trajectories.  Both sustain the common organized
  alternating mid-plane street and compact three-dimensional vortex packets.
  The remaining miss is route authority, not absent thrust or wake breakup.
- The tail-only sector pulse is the one sampled change that materially reduces
  passage error.  Relative to the prefilled posterior recapture it moves the
  closest pass from `3.031L` at `23.793T` to `2.606L` at `24.525T` and shifts
  the head from roughly `(10.18,6.71)L` to `(9.59,6.96)L`.  It begins before
  passage and therefore corrects more of the accumulated lateral miss, but it
  still exits left after `39.699T` with final distance `8.714L`.
- The other sampled variants close two tail-only alternatives.  Persisting
  opposing-half-cycle authority through route error reaches `2.996L` yet
  retains the broad upper exit; unloading the posterior carrier during the
  recapture hairpin reaches `3.024L`, statistically the same first pass as the
  `3.031L` prefill, and also exits above.  Another posterior gate, response
  threshold, or carrier floor is therefore not a new control mechanism.
- At `14--24T`, the sector-pulse fish is already self-propelled at about
  `0.62--0.72U`, while its velocity-to-target cross-course error grows from
  about `-0.39` to `-0.90`.  At closest approach the target is nearly abeam in
  the body frame and applied acceleration remains clipping-dominated.  A
  posterior-only tangent pulse shifts the route usefully but does not recruit
  enough of the body to rotate the translation direction before passage.

## Policy hypothesis

Start from the evaluated sector-pulse candidate, preserving its coherent
`0.55T/28 deg` state-feedback carrier, curvature release, posterior
half-cycle relief, and body-frame entry/release gates.  Change one actuator
primitive: while that same signed pulse is active, shift the anterior
oscillator equilibrium by a smaller same-sign angle while retaining the
existing total tail-tangent target.  The anterior and posterior joints then
form a distributed C-bend instead of asking only the posterior tangent to
redirect the whole translating body.  Center the Van der Pol drive on the
moving equilibrium so oscillation continues around the maneuver shape; leave
target-centered and all gate-closed states exactly unchanged.

The expected evidence is the sampled coherent early trajectory through pulse
onset, followed by earlier course rotation and a lateral passage below the
`2.606L` sector-pulse reference, ideally capture.  Falsify the mechanism if it
changes gate-closed actions, recreates the release-pose upper curl, destroys
the alternating wake, materially raises actuator/load exposure, or still
exits without either a closer pass or a semantically useful turn-back.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG maneuver control
source_mechanism: recruit distributed body curvature under large observed direction error, then release continuously back into the propulsive rhythm
transferable_invariant: a transient large-error redirect can distribute bounded curvature across controlled body joints while preserving and later restoring the traveling carrier
nontransferable_details: species-specific C-start shapes, published gains, motor timing, dimensional cadence, clock-driven phase, exact vortex phases, and task-specific routes
policy_translation: use the evaluated normalized body-frame sector pulse as the sole signed gate, center the anterior state-feedback oscillator on a modest pulse-proportional bend, and retain the posterior total-tangent command so the two joints form a bounded mirror-equivariant C-bend
falsification: reject the transfer if gate-closed behavior changes, the coherent carrier or deep approach is lost, limit or load exposure worsens materially, or the candidate cannot improve on the `2.606L` tail-only pulse or produce a useful new termination topology

## Pre-evaluation checks

- All `68` direct `params.FIELD` references resolve among the `70` fields
  returned by `target_policy_params()`.  The lightweight public-contract test
  returns two finite accelerations.
- A `1,458`-state grid confirms bit-for-bit equality with the evaluated
  tail-only sector policy whenever its pulse is closed.  The active pulse and
  new anterior drive branch are antisymmetric under lateral reflection, and
  the anterior equilibrium shift is bounded by `3.5 deg`.
- Fixed-state replay over all `7,218` states of the evaluated sector rollout
  activates the pulse on `1,650` states from approximately `14.047T` through
  `25.174T`; the other `5,568` actions remain bit-for-bit identical.  The
  maximum reconstructed head-equilibrium shift is `3.477 deg`, maximum raw
  action change is `9.869 rad/T^2`, and raw acceleration-envelope exposure
  changes from `92.242%` to `91.992%`.  This is an algebraic selectivity and
  boundedness result, not a prediction of closed-loop CFD performance.
- The configured check-runner was invoked but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Following the inherited fallback, its
  three prescribed no-CFD commands were run directly and separately: reusable
  guidance semantics, lightweight Julia policy contract, and solver editable-
  boundary checks all pass.  Formal CFD remains deferred to EvE.
