# De-gait terminal course feedback before posterior modulation

## Completed evidence and visual diagnosis before editing

- The four sampled solver artifacts are byte-identical v50 controllers and all
  reproduce direct-uniform, zero-background-flow capture at `17.41299 T`,
  score `-0.0595203`, final distance `0.745094 L`, and total/observed distance
  integrals `1.945327/1.329976 L`.  The repeated result is the strong finite
  comparator, not four distinct policy tests.
- I inspected the combined top-down and oblique sheets for the current v50
  reproductions and for the inherited v52 route-course and v53 posterior-course
  failures.  Every top-down row shows active self-propulsion on the same smooth
  target-signed arc: compact startup vorticity develops into an organized
  alternating street through capture, with no reversal, boundary exit,
  collision, or visible wake collapse.  One current combined sheet has a black
  oblique row, while another reproduction and both inherited failures show
  compact paired caudal Lambda2 structures at release, `4 T`, `12/16 T`, and
  capture with an occasional black intermediate frame.  The missing panels are
  rendering limitations; neither failed course placement creates a beneficial
  wake topology.
- The metrics make v52 and v53 informative mechanism failures despite capture.
  Sending instantaneous normalized course slip through the route request
  worsens score/total integral/final distance to
  `-0.0611859/1.946671 L/0.746705 L` and raises any-joint acceleration-limit
  residence from `40.11%` to `40.75%`.  Localizing the same cue to posterior
  wave shape is nearly neutral but still worse at
  `-0.0595473/1.945350 L/0.745115 L` and raises residence to `40.90%`.
  Both retain the v50 `0.98310 L/T` maximum speed and
  `0.032252/0.016092` peak normalized force/moment, so the extra occupancy has
  no compensating route, load, or wake benefit.
- Frozen reconstruction on the completed v50 trace identifies why moving the
  same cue between channels fails.  Over the `301` rows after distance first
  enters `2.1 L` at `15.763 T`, raw normalized course slip ranges from
  `-0.606` to `0.294` and has `-0.988` correlation with posterior joint angle.
  After subtracting the deliberately commanded route/redirect mean from that
  posterior angle, the centered course-versus-carrier slope is `-0.961` and
  the residual stays one-signed (`-0.468` to `-0.251`).  This supports a
  persistent course component only after the observed carrier contribution is
  rejected; raw instantaneous sway is not route error.

## One-candidate policy hypothesis

Preserve v50's state-feedback carrier, posterior lag, selective crossflow pose
confidence, route and redirect steering, launch allocation, carrier-first
spillover, half-cycle steering, geometry-qualified posterior response,
approach priority, and actuator projection.  Add one de-gaited terminal course
mechanism.  Compute the reflection-odd normalized target/velocity course slip,
remove a unit-gain posterior carrier-angle estimate after retaining the
controller's deliberate posterior route and redirect means, and use only the
signed bounded residual for a small posterior wave-shape correction.  Gate that
correction by near approach, observed positive closing, target-centerline
confidence, observed carrier motion, and the existing redirect release.  It
does not alter the anterior command, carrier cadence/amplitude, broad-route
mean curvature, or large-error redirect.

The next CFD rollout should remain identical to v50 outside the established
`2.1 L` approach region, preserve its coherent target-signed wake and
middle-route lead, and convert the one-signed de-gaited course residual into
earlier or deeper capture without increasing the established speed,
saturation, force, or moment envelope.  Falsify the mechanism if broad-route
actions change, the residual regains beat-sign alternation, capture or either
distance integral regresses, terminal radial closing weakens, posterior
limit residence grows without route benefit, or the readable two-view wake
loses coherence.  Formal CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and residual CPG modulation
source_mechanism: preserve a productive rhythmic carrier while applying bounded navigation feedback through a low-dimensional posterior wave-shape command
transferable_invariant: separate persistent course error from fast carrier-correlated lateral motion before supplementary steering modifies the propulsive wave
nontransferable_details: published oscillator gains, dimensional cadence, robot or species kinematics, full-body CPG state, exact vortex phases, and task-specific routes
policy_translation: subtract the observed de-meaned posterior carrier angle from normalized body-frame course slip, then gate a small signed posterior shape residual by approach, closing, geometry, carrier motion, and redirect release
falsification: reject if the residual remains beat-correlated, changes the broad route, fails to improve capture or distance integrals, consumes posterior headroom without closure benefit, or degrades the v50 wake and speed/action/load envelope
```

## Evidence boundary

All outcome and visual claims above come from sampled completed solver results,
the assigned-parent guidance, and inherited optimizer logs.  The proposed
de-gaited controller is one unevaluated policy hypothesis; no same-worker CFD
result is claimed.

## No-CFD implementation audit

- The sole materialized policy is
  `dogfish_target_control_v54_degaited_posterior_course_shape`, SHA-256
  `8c1e55c71279896c2d0cc9b79223c5241e1c4f6f61742cc2d0c47959d7fb5b71`.
  All `71` distinct direct `params.FIELD` references resolve among the `73`
  fields returned by `target_policy_params()`.
- Reconstruction on the completed v50 trace is byte-exact for all `2,865`
  states outside `2.1 L`.  Inside approach, the unit-gain rejection converts
  raw course slip from a beat-changing `[-0.606, 0.294]` signal to a one-signed
  `[-0.480, -0.273]` residual.  The geometry- and response-gated request is
  `[-0.371, -0.00012]`, changes only the posterior action on `220/301` frozen
  states, and is bounded by `0.681 rad/T^2`.  Exact-limit residence on those
  frozen states changes from `247` to `244`; this is an implementation/headroom
  check, not a closed-loop performance claim.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this ChatGPT account.  Its three exact no-CFD checks were
  run locally and separately.  The guidance check first exposed two identical
  assigned-parent markers in the rendered `README.md`; removing only the
  duplicate repaired provenance.  The rerun, lightweight Julia contract, and
  solver boundary check pass.  No formal CFD was run.
