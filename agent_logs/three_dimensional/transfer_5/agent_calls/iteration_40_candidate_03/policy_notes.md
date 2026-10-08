# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

All four sampled solver evaluations are valid finite captures from direct
uniform still water: `U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot,
and no unstable termination. I inspected every combined keyframe sheet from
release through capture, including both the top-down mid-plane-vorticity row
and the oblique body/Lambda2 row. The fish self-propels along the same smooth
left-and-down arc in every sample. A compact alternating wake forms by about
`5T`, remains coherent as the swimmer turns, and has matching three-dimensional
Lambda2 structures without out-of-plane instability or collapse. The sheets
are visually indistinguishable at their cadence, so they support preserving
the carrier and locating the remaining defect in terminal load/trajectory
histories rather than claiming a new vortex topology.

The independently written broad terminal route handoffs
`solver_bc6f1708043d` and `solver_bcd55e3d0db4` are bit-identical and are the
strongest aggregate-distance samples. They retain the full observer's
`23.441015T` capture and pre-`3L` path while improving score and scoring
mean/final distance from `-0.501691/2.399184/0.746948L` to
`-0.501134/2.398743/0.746369L`. This remains a mixed result: inside `3L`, mean
yaw and mean/peak target-line cross-track speed are
`1.68837 rad/T` and `0.22619/0.58481U`, and peak moment rises from the full
observer's `0.013886` to `0.014319`. The `solver_42a8e74d0972` handoff confined
below `1L` is an informative near-no-op at score `-0.501677`; it does not
resolve that terminal trade.

The inherited evaluated progress-qualified broad handoff is also a concrete
negative result. Returning slow-route authority whenever target-directed
translation quality weakens keeps the same capture sample and narrowly reduces
inside-`3L` mean/peak yaw and peak moment to `1.68726/3.34642 rad/T` and
`0.014167`, but regresses score and mean/final distance to
`-0.501734/2.399219/0.746987L`. It therefore gives back the broad handoff's
distance benefit without a semantic trajectory or load improvement and should
not be replayed or strengthened.

Phase-resolved evidence points to a different actuator coordinate. In the best
broad handoff, all `29` terminal samples with absolute moment above `0.012`
occur during large same-sign/common two-joint acceleration and average
`0.01260` moment. The peak `0.014319` event occurs at `1.217L` with projected
commands `(-30.72,-27.63) rad/T^2`: common acceleration is `-29.17`, while the
differential component is only `-1.55 rad/T^2`. Across all `135` terminal
samples whose common magnitude exceeds `24 rad/T^2`, mean absolute moment is
`0.01037`, versus `0.00524` below that threshold. Conversely, peak yaw and
peak cross-track speed occur under strongly opposite-sign commands. High
common-command samples also retain good radial progress, so wholesale carrier
or posterior-speed suppression is not justified; only the extreme common
tail-tangent command is an admissible load target.

## One-candidate hypothesis

Use the strongest sampled broad route handoff as the structural parent. After
its existing component-wise smooth acceleration projection, decompose the two
commands into common tail-tangent and differential inter-joint coordinates.
Inside the existing normalized `3.0L -> 0.75L` terminal window, continuously
attenuate only the common coordinate's excess above `85%` of the per-joint
command limit, with at most `25%` relief. Preserve its sign, preserve the
differential coordinate exactly, and leave sub-threshold strokes unchanged.
Recombine the two commands without changing the public contract. This is one
bounded actuator-coupling mechanism, not a gain increase, flow/moment gate,
clock, route memory, or world-coordinate command.

The intended effect is to retain the broad handoff's capture, pre-terminal
motion, coherent carrier, and mean/final-distance advantage while reducing the
isolated near-common acceleration pulses that coincide with peak moment. The
design deliberately does not claim to solve the opposite-sign peak-yaw or
cross-track phase. Falsify it if post-worker CFD loses capture, regresses score
or mean/final distance toward the full observer, changes motion before `3L`,
fails to reduce peak moment below `0.014319`, worsens yaw/cross-track motion,
or increases joint-limit residence or command infeasibility.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and two-joint traveling-wave propulsion
source_mechanism: posterior lateral acceleration is a primary reactive thrust and load coordinate, while useful locomotion depends on retaining a directed inter-joint wave rather than suppressing the whole rhythm
transferable_invariant: separate extreme posterior tail-tangent acceleration from the inter-joint traveling-wave coordinate and relieve only the former when terminal state feedback makes full propulsive loading unnecessary
nontransferable_details: published gains, dimensional cadence, species morphology and kinematics, full-body wave envelopes, exact vortex phase, task route, capture radius, and the numerical activation threshold
policy_translation: in the existing normalized terminal window, decompose the smoothly projected two-joint command into common and differential coordinates, softly reduce only high common magnitude, and preserve the differential command and all body-frame route and carrier feedback
falsification: reject if CFD does not preserve capture, coherent wake, pre-3L progress, and broad-handoff distance quality while reducing peak moment without worse yaw, cross-track motion, or actuator feasibility

Formal CFD is intentionally deferred to the post-worker evaluator.

## Validation status

The solver boundary check passes. Static schema validation finds `75` returned
parameter fields, `73` unique direct `params.FIELD` references, and no
undeclared reference; each public policy function is defined exactly once, and
strings and brackets are lexically balanced. Relative to the evaluated broad
handoff, the solver diff contains only the two owned projection parameters and
the final common/differential projection. Applying that final projection to
the parent's recorded commands as a non-dynamic audit changes zero samples
outside `3L`, activates on `101/601` terminal samples, preserves the
differential coordinate to floating-point precision, and produces at most
`16.2%` realized common relief. At the recorded peak-moment sample it reduces
the common command by `10.4%`, from actions `(-30.72,-27.63)` to
`(-27.69,-24.59) rad/T^2`; only post-worker CFD can determine the coupled
trajectory effect.

The prescribed guidance checker reports a rendered-input failure before its
semantic comparison because root `README.md` repeats the same assigned-parent
marker twice. Running its unchanged semantic rules against that unique parent
passes. The configured check-runner was invoked but its pinned `gpt-5.4-mini`
model is unavailable for this ChatGPT account, so it could not inspect the
workspace. Julia is not installed, so the lightweight executable mock-state
smoke could not run. No formal CFD was run.
