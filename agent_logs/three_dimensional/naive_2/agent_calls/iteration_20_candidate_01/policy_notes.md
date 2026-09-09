# Response-released posterior redirect candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen evidence contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I inspected both the top-down mid-plane vorticity and oblique
body/Lambda2 rows. The three captures are self-propelled on nearly identical
direct down-left routes and retain compact, body-connected alternating wakes
through the capture sphere. The informative proximity-braked failure remains
self-propelled but curls upward after its closest pass, develops broader late
structures, touches both `45 deg` joint limits, reaches only `4.64998L`, and
exits left with peak normalized planar force/moment of `0.620/0.261`. The
remaining problem is terminal feedback quality, not missing thrust or wake.

The prefilled predicted-miss composite has two byte-identical sampled
evaluations. Both capture at `15.983--15.994T`, with zero joint-angle dwell
beyond `40 deg`, about `18.0--18.6%` near-rate-limit occupancy per joint, and
peak normalized planar force/moment of `0.0342--0.0367/0.0173--0.0185`.
The sampled response-release sibling changes only the posterior mid-stroke
pulse: it fades that redirect when carrier-separated yaw is already corrective.
It preserves the same direct visual trajectory and compact alternating wake,
captures at `0.74859L/16.0160T`, retains zero `>40 deg` dwell, and lowers the
sampled peak force/moment to `0.03316/0.01660`. Rate occupancy remains
`18.58%/18.10%`, and arrival is one logged step slower than the inherited
no-pulse reference at `16.0105T`; therefore the evidence supports a modest
load-quality refinement, not a speed, effort, or rate-reserve claim.

Inherited logs sharpen the boundary. Low-envelope startup anti-damping broke
the direct route and missed by `3.863L`; replacing terminal raw bearing with a
joint-angle carrier-phase estimate still missed by `1.0728L`; and repeated
evaluations of the unreleased pulse composite include `1.016--1.216L`
left-domain misses despite current sampled captures. Do not add either failed
mechanism or infer robustness from one threshold crossing.

## Single candidate hypothesis

Promote the sampled response-release policy without scalar changes. Preserve
the evidenced traveling-bend carrier, body-frame pursuit/course blend,
constant-course time-to-closest and signed miss, bounded terminal mean bend,
and yaw-response-gated half-cycle handoff. Multiply only the posterior
mid-stroke redirect by the complement of the existing corrective-yaw gate, so
the transient disappears when measured response already turns correctly while
the propulsive carrier remains fully active.

Support requires repeat capture on the direct compact-wake route with zero
`>40 deg` dwell and peak force/moment no worse than the unreleased composite's
roughly `0.037/0.019` envelope. Falsify on another `1.0--1.2L` left-domain
miss, loss of capture or wake coherence, increased joint-rate occupancy or
loads, or a materially slower approach. The current worker does not claim a
new CFD result; these criteria are for downstream evaluation.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological redirect-to-cruise maneuvers
source_mechanism: release bounded asymmetric steering once sensed directional response is corrective, returning authority to the propulsive rhythm
transferable_invariant: recruit a steering transient only while normalized target error persists and carrier-separated yaw has not yet responded in the requested direction
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, species-specific C-start shape and timing, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: gate the body-frame predicted-miss posterior pulse by one minus the existing bounded corrective-yaw response gate while preserving the two-joint state-feedback carrier and far-field controller
falsification: reject if repeat capture, the direct compact wake, low joint-angle dwell, and reduced load peaks do not survive together, or if arrival and rate occupancy materially worsen

## Dry validation only

The candidate SHA-256 is
`bfaa8a9850e9b1c53dfd8c0264b7f2bd8866416874ec560689ff4d3275885532`,
byte-identical to the sampled response-release capture. After removing the
duplicate assigned-parent marker from the rendered workspace `README.md`, the
mandated guidance-materiality check, lightweight Julia policy-contract check,
and solver editable-boundary check all pass. A separate deterministic audit
confirms that all `28/28` direct `params.FIELD` references are returned by
`target_policy_params()`. These checks establish provenance, executable
semantics, and schema ownership only; no CFD was run in this workspace.
