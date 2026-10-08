# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

All four sampled evaluations report finite `capture` termination from direct
uniform still-water initialization with `U_infinity=[0,0,0]`, no cylinders,
and no prewarm. I inspected each combined keyframe sheet, including both the
top-down mid-plane-vorticity and oblique body/Lambda2 rows, from release through
capture. The highest-scoring full course-observer samples
`solver_343870fd8107` and `solver_a95f7416a3de` are bit-identical despite
independent policy texts; the assigned-parent role-separated sample
`solver_89e2a212c5d1` is the informative regression, and
`solver_477c7f626e4f` is the no-slow-course stabilization anchor.

In every sheet the fish self-propels along the same smooth left-and-down target
arc. A compact alternating vorticity street appears by `5T`, remains coherent
through `18T`, and curves with the swimmer near capture. The oblique row shows
the corresponding alternating three-dimensional Lambda2 structures without
out-of-plane instability or wake collapse. There is no visible passive
advection or new wake/trajectory class. The images therefore support preserving
the carrier and locating the small policy differences in trajectory and load
histories, not in a claimed vortex-topology change.

The two full course-observer samples capture at `23.441015T` with score and
scoring mean/final distance `-0.501691/2.399184/0.746948L`. They reach `6L` at
`15.306512T`; inside `3L`, recomputed mean/peak absolute yaw are
`1.68733/3.34971 rad/T`, mean/peak target-line cross-track speed are
`0.22592/0.58297U`, and mean/peak absolute moment are `0.006393/0.013886`.
The role-separated terminal desired-yaw reference follows the same crossings
through `1L`, then captures one sample earlier at `23.435516T`, but regresses
score and mean/final distance to `-0.502841/2.400084/0.748139L`; it also fails
to improve the mixed terminal defect (`1.68809/3.35551 rad/T` yaw,
`0.22577/0.58734U` cross-track speed, and `0.006403/0.014017` moment inside
`3L`). Restoring raw body-lateral slip only in the terminal desired-yaw role is
therefore a completed negative result. Conversely, the stabilization anchor
without a slow course term captures earlier at `23.375013T` but gives back the
full observer's mean-distance, mean-yaw, cross-track, and moment benefits. The
useful unresolved split is early/middle route correction versus late approach,
not terminal-reference selection.

## One-candidate hypothesis

Retain the replicated normalized carrier-rejected course observation, including
its use in the terminal desired-yaw reference, but continuously hand off only
its contribution to the main geometric steering request as the existing
`3.0L -> 0.75L` terminal stabilization window opens. Use the complement of the
same bounded proximity coordinate already driving the continuous and
phase-selected terminal stabilizers. This preserves full course authority
before `3L`, withdraws no bearing/vector/rate steering, changes no carrier,
posterior lag, cadence, curvature gain, or projection limit, and introduces no
clock, remembered route, or world coordinate. It is the complementary scope
test to the failed terminal-reference partition: slow far/middle route
correction yields to already-established near-field feedback rather than two
route roles acting simultaneously through capture.

The falsifiable expectation is to retain the full observer's earlier `6L`
crossing, coherent alternating wake, and mean distance/load advantages while
recovering some of the stabilization anchor's `3L`-to-capture timing and
reducing the final-`1L` cross-track reversal or peak yaw. Reject the mechanism
if capture is lost, pre-`3L` progress changes, score/mean distance regress to
the anchor, terminal yaw/cross-track/moment fail to improve together enough to
offset any arrival loss, or joint-speed/projected-command feasibility worsens.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and terminal approach control
source_mechanism: a slow sensor-derived route command modulates a preserved rhythmic carrier, then yields continuously to near-field yaw/slip stabilization
transferable_invariant: separate persistent target-course correction from the propulsive carrier and hand it off when bounded measured terminal feedback becomes authoritative
nontransferable_details: published gains, dimensional cadence, robot morphology, species-specific envelopes, exact vortex phase, duty ratio, and prescribed routes
policy_translation: multiply only the normalized body-frame course residual in the main geometric request by the complement of the existing terminal-proximity coordinate; preserve the residual in terminal desired-yaw classification and preserve all two-joint carrier and stabilizer actuation
falsification: reject if CFD loses capture or wake coherence, gives back the replicated pre-terminal progress and mean-load gains, fails to improve terminal arrival/cross-track/yaw balance, or worsens actuator feasibility

Formal CFD is intentionally deferred to the post-worker evaluator.

## Validation status

The prescribed guidance/material-change check and solver boundary check pass.
A deterministic schema audit finds `73` returned parameter fields, `71` unique
direct `params.FIELD` references, and no undeclared reference; each public
policy function is defined exactly once. The mandated check-runner was invoked,
but its pinned `gpt-5.4-mini` model is unsupported by this account and failed
before inspection. Julia is not installed in the workspace image, so its
lightweight executable contract smoke could not launch; no formal CFD was run.
