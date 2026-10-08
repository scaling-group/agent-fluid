# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

All four sampled evaluations are valid direct-uniform still-water rollouts:
`U_infinity=[0,0,0]`, no cylinders, no prewarm, finite dynamics, and `capture`
termination. I inspected every combined keyframe sheet from release through
termination, including both the top-down mid-plane-vorticity row and the
oblique body/Lambda2 row. In all four, the fish self-propels on the same smooth
left-and-down capture arc. A compact alternating vorticity street is established
by `5T`, remains coherent through `18T`, and curves with the swimmer near the
target; the oblique views show corresponding alternating three-dimensional
structures without wake collapse or out-of-plane instability. There is no
passive advection, boundary exit, collision, or unstable precursor. The views
are effectively indistinguishable at their sampling cadence, so the useful
differences must be judged from trajectory and load histories.

The two independently written full course-observer samples are bit-identical:
they capture at `23.441015T`, score `-0.501691`, and have scoring mean/final
distance `2.399184/0.746948L`. Inside `3L`, their mean/peak absolute yaw,
target-line cross-track speed, and absolute moment are respectively
`1.68733/3.34971 rad/T`, `0.22592/0.58297U`, and `0.006393/0.013886`.
Withdrawing the main-route course residual only inside `1L` changes neither
the logged threshold crossings nor capture time and improves score/mean/final
distance only to `-0.501677/2.399172/0.746933L`; its yaw, cross-track, and load
balance is slightly worse or unchanged. It is therefore an informative
near-no-op rather than evidence for an ever-later handoff.

The strongest finite sample instead hands that route residual to the existing
terminal stabilizer continuously over `3.0L -> 0.75L`. It keeps the same
`6/3/2/1L` crossings and `23.441015T` capture, but improves score and scoring
mean/final distance to `-0.501134/2.398743/0.746369L`. This is a real aggregate
distance benefit, not comprehensive stabilization: inside `3L`, mean yaw and
mean/peak cross-track speed become `1.68837 rad/T` and
`0.22619/0.58481U`, while peak moment rises to `0.014319`; only peak yaw falls
narrowly to `3.34789 rad/T`. The coherent visual wake and essentially unchanged
joint/command envelopes support preserving the carrier, but the load trade
forbids describing this handoff as a peak-load remedy.

## One-candidate hypothesis

Replay the strongest sampled terminal route handoff as the single candidate.
Preserve the normalized carrier-rejected target-course observation at full
authority outside `3L` and in terminal desired-yaw classification. As the
existing bounded terminal-proximity coordinate opens, multiply only that
observation's contribution to the main geometric request by the complementary
authority. Preserve bearing/vector/rate steering, the progress-qualified
cadence handoff, anterior phase-selected correction, posterior traveling-wave
lag, and smooth command projection. This is an evidence-backed control-layer
scope change with no new gain, clock, memory, fixed coordinate, or route.

The expected outcome is deterministic reproduction of the sampled capture,
coherent wake, and improved mean/final distance. Falsify this replay if the
post-worker CFD does not reproduce capture-scale progress, if the pre-`3L`
trajectory changes, if the alternating wake or actuator feasibility regresses,
or if peak moment grows beyond the already observed trade. A later mechanism
should not strengthen or advance this handoff unless it also improves yaw,
cross-track motion, and load rather than scalar distance alone.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and terminal approach control
source_mechanism: a slow sensor-derived route command modulates a preserved rhythmic carrier and yields continuously to measured near-field stabilization
transferable_invariant: separate persistent route correction from the posterior-lagged propulsive carrier and hand off only the route layer when bounded terminal feedback becomes authoritative
nontransferable_details: published gains, dimensional cadence, robot morphology, species-specific kinematics, duty ratio, oscillator phase, exact vortex timing, capture radius, and prescribed routes
policy_translation: use normalized body-frame distance to complement the existing terminal-proximity signal and withdraw only the carrier-rejected course residual from the main two-joint steering request while preserving its terminal observer role and the full traveling carrier
falsification: reject if deterministic CFD fails to reproduce capture, coherent wake, pre-terminal progress, and the sampled mean/final-distance benefit, or if actuator feasibility or peak-load trade worsens

Formal CFD is intentionally deferred to the post-worker evaluator.

## Validation status

The solver boundary check passes. A deterministic schema audit finds `73`
returned fields, `71` unique direct `params.FIELD` references, and no undeclared
reference; each public policy function is defined exactly once. After removing
comments and normalizing only the inert `version` string, the candidate is
identical to the strongest evaluated handoff policy. The intended guidance
material-change check passes against the unique assigned parent. Its generated
wrapper cannot pass literally because the rendered `README.md` contains the
same assigned-parent marker twice, and the configured checker agent cannot
launch because its pinned model is unavailable. Julia is not installed, so the
lightweight executable smoke could not run; no formal CFD was run.
