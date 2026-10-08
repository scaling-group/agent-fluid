# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

All four sampled evaluations terminate in finite capture from the required
direct-uniform still-water initialization with `U_infinity=[0,0,0]`, no
cylinders, and no prewarm snapshot. The two independent full-observer texts
(`solver_a95f7416a3de` and `solver_343870fd8107`) reproduce bit-identical CFD,
so they provide the assigned-parent anchor. The broad main-request handoff
(`solver_bc6f1708043d`) is the strongest finite example; the late
progress-qualified handoff (`solver_42a8e74d0972`) is the informative relative
failure because it barely changes the parent despite adding a terminal layer.

I inspected the combined keyframe sheets for the strongest and informative
failure, including both the top-down mid-plane-vorticity row and oblique
body/Lambda2 row from release through capture. Both fish self-propel along the
same smooth left-and-down target arc. A compact alternating vorticity street
forms behind the body, the corresponding three-dimensional Lambda2 structures
remain coherent as the path curves toward the target, and neither sheet shows
passive advection, wake collapse, or out-of-plane instability. The visual
sampling cannot distinguish the variants, so the measured difference is a
near-field route/load balance rather than a new wake class.

The replicated full observer captures at `23.441015T` with score and scoring
mean/final distance `-0.501691/2.399184/0.746948L`. With identical pre-`3L`
motion and the same capture sample, withdrawing only its main-request course
term over the full `3.0L -> 0.75L` stabilization window improves those values
to `-0.501134/2.398743/0.746369L`. This positive distance result is mixed:
inside `3L`, mean absolute yaw rises from `1.68733` to `1.68837 rad/T`,
mean/peak target-line cross-track speed rises from `0.22592/0.58297U` to
`0.22619/0.58481U`, and peak absolute moment rises from `0.013886` to
`0.014319`, although peak yaw falls narrowly from `3.34971` to
`3.34789 rad/T`. The late handoff, which starts only at `1L` and also removes
the course term from terminal desired-yaw classification, reaches the same
capture sample at `-0.501677/2.399172/0.746933L`; it is effectively neutral
and slightly worsens terminal yaw/cross-track metrics. Thus the useful effect
requires cumulative main-route handoff across the established terminal window,
but unconditional withdrawal gives back some of the observer's load balance.

## One-candidate hypothesis

Use the stronger broad handoff as the structural parent, but qualify its
continuous terminal-proximity coordinate by the already sampled normalized
target-progress release. Full carrier-rejected course authority remains before
`3L`. Inside the terminal window, only the course residual in the main
geometric request yields, and only in proportion to positive target-radial
translation and swimmer-speed confidence. When the beat becomes substantially
lateral, the slow course term continuously returns; its terminal desired-yaw
role, all bearing/vector/rate feedback, base and reserve propulsion, the
posterior traveling wave, terminal stabilizers, and smooth command projection
remain unchanged. This is an observation-conditioned control-layer handoff,
not another gain or distance-threshold retune.

The falsifiable expectation is to preserve the full observer's pre-`3L` path,
the broad handoff's mean/final-distance benefit, and the same coherent wake,
while avoiding its unconditional authority loss during low-quality progress
and recovering some terminal cross-track/yaw/moment balance. Reject the
mechanism if capture is lost, pre-`3L` motion changes, distance metrics return
to the full-observer/late-handoff level, terminal motion or load fails to
improve over the broad handoff, or joint/command feasibility worsens.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG path following and terminal approach control
source_mechanism: sensor feedback modulates a slow route command around a preserved rhythmic carrier, with near-target authority handed to measured stabilization only when target-directed translation is established
transferable_invariant: keep traveling-wave propulsion and slow route correction separate, and withdraw only the route residual when normalized observations show both terminal proximity and useful target-directed progress
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, duty ratios, exact oscillator or vortex phase, capture radius, and prescribed routes
policy_translation: multiply the existing terminal-proximity handoff of the body-frame carrier-rejected course residual by the bounded target-radial progress fraction and swimmer-speed gate; retain that residual in desired-yaw classification and leave the two-joint carrier and stabilizers unchanged
falsification: reject if CFD changes pre-terminal motion or wake coherence, loses capture, gives back the broad handoff's distance benefit, fails to recover terminal cross-track/yaw/load balance, or worsens actuator feasibility

The new candidate has no same-worker CFD result; formal evaluation remains for
the post-worker evaluator.

## Validation status

The solver boundary check passes. Static contract validation finds one
`target_policy_params` definition, one `target_policy` definition, `73`
returned parameter fields, `71` unique direct `params.FIELD` references, and
no undeclared reference. The guidance checker's semantic comparison passes
when the duplicated assigned-parent ID is resolved to
`optimizer_95b42efd39b8`, but its unmodified wrapper exits before that
comparison because the rendered root `README.md` contains the same copied
parent marker twice. The mandated check-runner was invoked and failed before
inspection because its pinned `gpt-5.4-mini` model is unavailable for this
ChatGPT account. Julia is not installed, so the lightweight executable mock
state check could not launch. No formal CFD was run.
