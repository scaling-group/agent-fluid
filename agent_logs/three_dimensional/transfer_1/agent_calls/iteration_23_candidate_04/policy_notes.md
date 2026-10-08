# Closure-arbitrated hydrodynamic pose candidate

## Completed evidence and visual diagnosis before editing

- The assigned parent and three sampled policy-equivalent v38 rollouts are
  direct-uniform still-water evaluations with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, finite dynamics, and exact reproduced `capture` at
  `18.232491 T`.  Each has score `-0.126500`, total/observed distance
  integrals `2.012983/1.399804 L`, final distance `0.749906 L`, mean/max speed
  `0.70322/0.95194 L/T`, any-joint acceleration-limit residence `41.54%`, and
  peak normalized force/moment `0.03068/0.01579`.
- I inspected the combined sheets for the assigned-parent v38 rollout and the
  sampled v39 comparator from release through capture, including both the
  top-down mid-plane vorticity rows and oblique body/Lambda2 rows.  Both fish
  visibly self-propel from quiescent water on the same smooth target-directed
  arc.  Compact startup structures become a coherent alternating posterior
  street and paired three-dimensional structures; neither rollout shows
  passive advection, wake breakup, collision, domain exit, or numerical
  instability.  Their small route difference is not visibly resolvable in
  the keyframes, so the trajectory, load, and action evidence decides between
  them.
- The v39 comparator unions lateral-load magnitude with the v38 band-pass
  crossflow confidence.  It captures `0.033001 T` earlier at `18.199490 T`,
  but regresses total/observed distance integrals to `2.015906/1.402567 L`
  and score to `-0.129466`.  It trails v38 by about `0.042/0.038 L` at `8/12
  T`, increases maximum speed to `0.96131 L/T`, and only catches up after `12
  T`; its small reductions in acceleration-limit residence (`41.37%`) and
  peak moment (`0.01558`) do not compensate for worse broad-route closure.
- Frozen-trace reconstruction explains why the union is not selective.  With
  the tested `0.012` normalized lateral-force scale, mean load confidence on
  the v38 trace is `0.834` before `4 T` and `0.911-0.918` thereafter.  The
  soft union therefore raises mean hydrodynamic confidence to `0.968-0.989`
  throughout the route, even when crossflow confidence alone has yielded to
  `0.684-0.848`.  By contrast, the already-owned normalized closing-deficit
  response falls from about `0.47/0.33` over `0-1/1-2 T` to `0.08` over `2-4
  T` and approximately zero after `4 T`.  It can distinguish launch recovery
  from the productive middle and terminal route without elapsed time or
  coordinates.
- Inherited optimizer logs establish the mechanism boundary behind v38: a
  monotone crossflow-pose law lost middle-route closure and raised speed and
  saturation, while a band-pass confidence that yields at both vanishing and
  disturbance-scale flow led the reproduced v34 controller at every sampled
  checkpoint.  The current three valid two-view reproductions now confirm
  that v38's route-wide lead and coherent 3D wake were not a one-run or black-
  oblique-sheet artifact.  The older whole-wave route-rate projection remains
  the informative failure: it kept an organized wake but turned wrong-sign,
  exited at `8.4755 T`, and raised normalized force/moment by roughly tenfold.

## One-candidate policy hypothesis

Preserve v38's state-feedback traveling wave, posterior lag, raw large-error
redirect, mean-preserving whole-wave pose projection, head-only route-rate
correction, raw half-cycle steering, response-released cadence, geometry-gated
bearing-divergence recovery, approach schedule, carrier-first rejected-head-
steering allocation, and componentwise acceleration bounds.

Add one response-arbitrated sensing mechanism.  Retain the phase-odd band-pass
local-crossflow confidence as the primary proportional gait-pose correction.
Normalize lateral body force and allow it to fill only the remaining
crossflow-confidence headroom, multiplied by the existing bounded
closing-deficit response.  At rest or weak closure this supplies a small
multisensory recovery; as positive target closure establishes, load authority
yields and the controller becomes v38.  Joint phase remains the only sign, so
persistent force cannot become a one-sided route command.  The added sensor
does not enter raw redirect geometry, bearing or yaw rates, the carrier,
half-cycle selection, or direct actuation.

Frozen-trace evaluation predicts that the added confidence is concentrated in
the first two periods: mean confidence rises from `0.739/0.742` to
`0.839/0.819` over `0-1/1-2 T`, is only `0.005` above v38 over `2-4 T`, and is
effectively identical to v38 thereafter.  This is a mechanism and boundedness
check, not a closed-loop performance claim.  The candidate should retain the
validated wake and middle route while carrying a small launch lead into
capture.  Falsify it if capture is later than `18.24 T`, observed integral
exceeds `1.400 L`, no early lead survives at `4-16 T`, the alternating wake or
target-signed arc degrades, or maximum speed, acceleration-limit residence,
normalized force, or moment materially exceeds the sampled v38-v39 envelope
`0.962/41.6%/0.03068/0.01579`.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and adaptive wake interaction
source_mechanism: preserve a productive rhythmic carrier while a small bounded sensory residual supplies recovery and yields when task-level response is already effective
transferable_invariant: secondary hydrodynamic sensing should add authority only under observed response deficit, remain bounded and body-frame, and release continuously when target closure becomes productive
nontransferable_details: published gains, species or robot kinematics, clocked CPG phase, dimensional load scales, exact vortex phases, organized-wake synchronization, full-body envelopes, and prescribed routes
policy_translation: use normalized lateral-force magnitude only to fill unused band-pass crossflow confidence, gate that fill by normalized closing deficit, keep observed joint phase as the odd sign, and apply the result only to proportional gait-pose rejection under the two-joint state-feedback contract
falsification: reject if the startup residual fails to produce a persistent route lead, if middle or terminal closure regresses toward the unconditional load union, if capture or wake coherence is lost, or if speed, saturation, force, or moment exceeds the established envelope
```

## Evidence boundary

All outcome claims above come from completed assigned-parent, sampled-solver,
and inherited-log evidence.  The candidate introduced in this workspace will
be evaluated only after the worker exits; no same-worker CFD result is claimed.

## No-CFD implementation audit

- The candidate policy SHA-256 is
  `3ef14b90e335154cb35a9804fa702abd9f7d7bfaa209618249d949e93cad7518`.
  Relative to v38, executable changes are limited to one owned normalized load
  scale, reading normalized lateral body force, the response-gated confidence
  fill, and using that bounded confidence in the existing proportional
  carrier-pose term.
- With crossflow confidence `0.6` and normalized load confidence `1.0`, the
  synthetic weak-closure state produces total confidence `0.8`; a productive-
  closure state returns to `0.6000015`, and a zero-load state returns exactly
  to `0.6`.  A `19,683`-state sweep over distance, bearing, joint state,
  crossflow, lateral load, and closure returns two finite accelerations within
  the unchanged componentwise limit.
- The deterministic schema audit covers all `62` direct `params.FIELD`
  references with fields returned by `target_policy_params()`.  The material-
  guidance check, lightweight Julia contract, and solver editable-boundary
  check pass.  The rendered `README.md` duplicated the same assigned-parent
  marker; the duplicate listing was removed so the prescribed checker could
  identify the one actual copied parent.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its exact three no-CFD commands were run
  locally and pass.  No formal CFD was run.
