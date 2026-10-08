# Response-retained cadence through monotone capture approach

## Completed evidence and visual diagnosis before editing

- The four sampled solver artifacts are byte-identical v50 controllers.  All
  start directly from uniform still water with `U_infinity=(0,0,0)` and
  reproduce capture at `17.41299 T`, score `-0.0595203`, final distance
  `0.745094 L`, and total/observed distance integrals
  `1.945327/1.329976 L`.  They are one strong finite comparator reproduced
  four times, not four distinct mechanisms.
- I inspected both rows of a readable sampled v50 combined sheet.  The
  top-down sequence shows active self-propulsion on a smooth target-signed arc:
  compact startup vorticity develops into an organized alternating posterior
  street through capture, with no reversal, domain exit, collision, or wake
  collapse.  The oblique row shows compact paired caudal Lambda2 structures at
  release, `4 T`, `12/16 T`, and capture.  This is a productive carrier to
  preserve, not a wake topology that calls for replacement.
- The assigned parent's de-gaited terminal course-shape residual is the
  informative failure.  It retains the same capture step but worsens score,
  final distance, and total/observed integrals to
  `-0.0599417`, `0.745503 L`, and `1.945667/1.329978 L`.  Its top-down sheet is
  visually indistinguishable from v50 and its oblique row is black, so it
  supplies neither a route nor a readable three-dimensional wake benefit.
  The other inherited step-39 terminal mechanism, posterior half-cycle duty
  asymmetry, regresses farther to `-0.0622763`, `0.747766 L`, and
  `1.947549/1.329991 L` at the same capture step.  Together these outcomes
  argue against another terminal steering placement or scalar reshaping of
  those residuals.
- V50 enters the normalized `2.1 L` approach region at `15.7630 T` and its
  distance then decreases on all `301` logged samples.  Instantaneous closing
  is `0.5448-1.0510 L/T` (mean `0.8199 L/T`), while planar speed is only
  `0.8094-0.8757 L/T` (mean `0.8399 L/T`) versus the full-route maximum
  `0.9831 L/T`.  Terminal peak normalized force/moment is
  `0.02635/0.01370`, below the full-route `0.03225/0.01609` envelope.  The
  route therefore does not exhibit the overspeed, loss of closure, or load
  spike that would justify making distance alone taper all cadence authority.

## Sole candidate and policy hypothesis

Preserve v50's normalized body-frame target sensing, state-feedback traveling
carrier, posterior lag, selective crossflow pose confidence, route and redirect
steering, axis-selective launch residual, carrier-first spillover, half-cycle
steering, geometrically qualified posterior curvature, and componentwise
actuator projection.  Add one bounded response mechanism: inside the existing
approach region, retain a small fraction of the carrier's cadence boost only
while measured closing remains positive and normalized turn load leaves
propulsion priority.  The retained fraction vanishes continuously at the
approach boundary, when closing is absent, or under full turn demand.  It does
not change amplitude, lag, steering sign, the far/middle route, or any physical
limit.

This tests whether the current distance taper coasts a demonstrably monotone,
low-load approach too soon.  The next CFD rollout should remain identical to
v50 outside `2.1 L`, preserve its target-signed arc and organized two-view
wake, then cross earlier or more deeply enough to improve score or either
distance integral without materially increasing speed, saturation, force, or
moment.  Falsify the mechanism if approach distance ceases to be monotone,
capture or integral regresses, steering loses authority, the carrier wake
decoheres, or the established envelope is exceeded.  Formal CFD occurs only
after this worker exits.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: preserve a productive rhythmic carrier while sensor feedback modulates a low-dimensional cadence command, and avoid coasting before capture is secured
transferable_invariant: when normalized target geometry already closes monotonically without overspeed or load growth, positive closing response may retain propulsion through approach while turn demand remains the higher-priority release signal
nontransferable_details: published oscillator gains, dimensional cadence, species-specific kinematics, full-body CPG states, exact vortex phases, fixed approach distances, and task-specific routes
policy_translation: within the normalized approach region, blend a bounded fraction of the existing cadence gate back in using positive body-frame closing response times unused normalized turn authority; leave carrier amplitude, lag, steering, and far-route behavior unchanged
falsification: reject if capture time/depth or distance integrals fail to improve, monotone closing is lost, turning is weakened, saturation or speed/load grows materially, or the coherent top-down and oblique wake does not survive
```

## Pre-edit frozen-trace scope check

Using the completed v50 states only, a retention fraction of `0.35` changes no
action outside `2.1 L`.  Within approach it raises mean frequency scale only
from `1.07643` to `1.08632`, changes projected action by at most
`1.2453 rad/T^2`, and leaves reconstructed any-joint exact-limit residence at
`48.33%`.  This establishes locality, boundedness, and available projection
behavior only; it is not a closed-loop performance claim.

## Evidence boundary

All outcome and visual claims above come from sampled completed solvers, the
assigned-parent guidance, and inherited optimizer logs.  The cadence-retention
controller below is one unevaluated candidate hypothesis.

## No-CFD implementation audit

- The sole materialized policy is
  `dogfish_target_control_v55_response_retained_approach_cadence`, SHA-256
  `432848a20b3108b5d77c9e3dde5e5500acdd739b44debf34dc85f5e382124042`.
  All `69` distinct direct `params.FIELD` references resolve among the `71`
  fields returned by `target_policy_params()`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this ChatGPT account.  Its three prescribed commands were
  then run locally and separately.  The guidance check exposed two identical
  assigned-parent markers in the rendered `README.md`; removing only the
  duplicate second marker repaired provenance.  The rerun, lightweight Julia
  contract check, and solver editable-boundary check all pass.
- No formal CFD rollout was run.  The next evaluator must decide whether the
  bounded cadence retention improves closed-loop capture semantics.
