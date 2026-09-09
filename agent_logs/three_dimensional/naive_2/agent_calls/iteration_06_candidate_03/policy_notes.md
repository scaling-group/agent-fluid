# Wake-policy candidate notes

## Evidence and visual diagnosis before editing

- All four sampled evaluations are valid direct-uniform still-water rollouts
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. In every combined
  sheet, the top-down row shows a body-connected alternating vortex street and
  the oblique row shows attached three-dimensional Lambda2 structures. Motion
  is therefore self-propelled rather than advected, and none of the failures
  is numerical instability.
- The prefilled distance-only approach relief `solver_8f636e61280c` keeps a
  compact wake and fast leftward translation, but remains high: its head is
  `(8.773,13.093)L` at the `3.600L` closest pass and it exits left at `26.70T`.
  The ungated phase-compensated controller `solver_77835bec7423` is slightly
  better geometrically (`3.174L`) and has the smallest sampled force peak, but
  similarly crosses the target x station about `3.26L` high and continues out
  of the left boundary.
- Approach scheduling is useful but not sufficient. Continuous distance/target-
  plane hold `solver_1fbf1e40b119` improves closest distance to `2.703L`, then
  curls upward and exits the upper boundary. Full-circle, misalignment-gated
  redirect `solver_4b6f0dc046cd` is the best geometric near-miss at `2.319L`:
  it reaches head `(8.489,11.762)L` at `18.03T`, but its late sharp turn also
  ends at the upper boundary. Its force/moment peaks (`0.512/0.043`) exceed the
  ungated controller's (`0.031/0.029`), so still more approach braking or an
  unqualified stronger turn is not supported.
- The remaining full-circle target error is measured in an instantaneously
  yawing body frame. Reconstructing it from `trajectory.csv` shows beat-scale
  sign reversals even while the target stays on one side: in
  `solver_4b6f0dc046cd`, raw pursuit is `+0.20 rad` at `12.50T`, `-0.80 rad` at
  `13.00T`, and `+0.05 rad` at `15.00T`. Integrating the already evidenced
  joint-rate carrier-yaw model and subtracting that predicted yaw from pursuit
  gives `-0.27`, `-0.55`, and `-0.46 rad` at those same samples. This preserves
  the correct-side request and increases smoothly toward the close pass. The
  prior phase-compensated yaw-rate mechanism therefore has an untested but
  directly observable target-angle counterpart.
- Inherited logs rule out broad carrier/rate braking and persistent equal-joint
  curvature: the former removed rate saturation but regressed closest approach
  to `11.643L`, while the latter weakened translation. The candidate should
  preserve the evidenced carrier, use no static curvature, and change the
  semantic target signal rather than tune another scalar gate.

## Single candidate hypothesis

Start from the best geometric near-miss's full-circle, approach-misalignment
redirect. Preserve its traveling-bend carrier, posterior lag, response-gated
shared half-cycle steering, and smooth acceleration envelope. Add one phase-
separation mechanism: use joint angles with the inherited carrier-yaw
coefficients to predict beat-correlated body yaw, subtract it from the raw
full-circle pursuit angle, wrap the residual, and use that residual for both
turn request and approach gating. Keep yaw-rate phase compensation for the
response channel. This should prevent carrier yaw from alternately releasing
and reversing terminal steering, begin the correct-side redirect earlier, and
retain the far-field propulsive scaffold without a clock, route, or static
joint equilibrium.

Falsify the mechanism if it loses coherent pre-approach translation, fails to
beat the sampled `2.319L` closest approach, repeats an upper/left boundary exit
without a tighter target-directed arc, or increases hard-limit occupancy and
force/moment peaks beyond the already load-heavy full-circle sample. Capture
or a better termination class with preserved wake coherence is the intended
semantic improvement; a scalar score change alone is insufficient.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and biological burst redirect
source_mechanism: separate the rhythmic carrier state from slower observed direction error, then apply a bounded response-gated redirect without discarding the propulsive rhythm
transferable_invariant: target feedback should be interpreted after removing predictable carrier-phase body motion so a persistent geometric error produces a persistent correct-side modulation
nontransferable_details: published CPG gains, species curvature, maneuver duration, robot linkage geometry, exact vortex phase, dimensional speed, and any task-specific route
policy_translation: predict carrier-correlated yaw from normalized two-joint state, subtract it from full body-frame pursuit angle, and feed the wrapped residual to the existing bounded half-cycle approach redirect
falsification: reject if closest distance does not beat 2.319L, termination topology does not improve, far-field wake/translation degrades, or actuator and load diagnostics exceed the full-circle near-miss

## Dry validation only

The mandated guidance, lightweight Julia contract, and editable-boundary
checks pass. All 23 direct `params.FIELD` references resolve to fields returned
by `target_policy_params()`. An 8,748-state grid spanning joint phase/rate,
fore/aft and left/right target geometry, lateral response, and yaw response
produced finite actions strictly inside the smooth `30 rad/T^2` envelope and
exact left/right reflection (maximum error `0.0`). These checks establish only
schema, boundedness, symmetry, and executable signal semantics; no CFD was run,
and the next formal rollout must decide the physical falsifiers above.
