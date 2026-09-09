# Multi-wake target-policy candidate notes

## Evidence-first diagnosis before the policy edit

The shared prewarm sheet shows the fixed developed four-cylinder wake reaching
the held fish at the upper-right release pose.  The inherited informative
failure leaves through the right boundary after `16.7914` released time: it
moves `(2.175,-0.869)L`, has `-0.1471` progress, and produces only `0.0154U`
mean streamwise motion relative to local flow.  Its released sheet shows no
sustained targetward turn.  This supports the inherited conclusion that the
seed lacks target-directed curvature rather than scalar drive.

The byte-identical champion samples instead turn immediately toward the target,
maintain a coherent posterior wake, and follow a direct upstream diagonal to
capture in `43.9505` time with `2.1391L` mean distance.  Mean body motion
`(-0.2471,-0.1020)` differs materially from mean local flow
`(-0.1342,-0.1556)`, so the useful traverse is controlled propulsion rather
than passive advection.  Preserve its bearing-to-curvature command,
target-favored posterior half-cycle bias, lagged traveling bend, and approach
envelope.

The reusable limitation is actuator distortion.  The champion reaches the
`260 deg/time` joint-rate and `1800 deg/time^2` acceleration caps on both
joints.  Three later mechanisms did not improve it: broad response-conditioned
release lowers RMS force/moment from `49.44/701.26` to `36.25/587.15` but
delays capture to `46.6730`; a small-bearing release raises loads to
`55.12/764.85`; and position-plus-velocity half-cycle timing raises them to
`53.18/736.58`.  All three still hit both rate and acceleration caps.  More
release-threshold or half-cycle phase tuning is therefore unsupported.

## Policy hypothesis

Keep the champion's raw anterior and posterior commands, then add one coupled
acceleration allocator.  When either raw joint command exceeds a
parameter-owned budget just inside the known envelope, scale both commands by
the same factor.  The existing episode clips each joint independently; common
scaling instead preserves the requested acceleration ratio, including the
posterior lag and target-favored asymmetry, while avoiding a hard-clipped
component.  Commands below the budget remain exactly champion-identical.

Expected evidence is the same immediate redirect and target capture, with a
coherent traveling bend under peak demand and preferably better mean distance,
arrival, or load history.  Falsify the mechanism if capture is delayed or lost,
the broad dogleg returns, the path and diagnostics remain indistinguishable, or
lower peaks merely remove useful authority.  Formal CFD is intentionally left
for the post-worker evaluation.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and bounded robotic-fish CPG actuation
source_mechanism: preserve a directed posterior-lagged traveling bend when rhythmic joint commands meet actuator constraints
transferable_invariant: constraint handling should retain the relative direction and posterior timing of the two-joint wave instead of independently distorting its components
nontransferable_details: published gains, species-specific kinematics, dimensional frequencies, exact vortex phases, actuator models, and task-specific routes
policy_translation: retain normalized body-frame bearing feedback and joint-state phase, then apply one common bounded scale to the two raw accelerations only when their peak exceeds a parameter-owned budget
falsification: reject if the direct diagonal or capture is delayed or lost, useful posterior asymmetry is weakened, or peak/load changes do not improve trajectory progress

## Pre-evaluation verification

The mandated guidance/provenance, pinned-Julia policy contract, deterministic
parameter-schema, and solver editable-boundary checks all pass.  An independent
check-runner confirms all `13` direct `params.FIELD` references are returned by
`target_policy_params()`.  A no-CFD sweep over `3,375` combinations of range,
bearing, joint angle, and joint rate returns finite actions, enforces the
parameter-owned budget in every state, exercises allocation in `3,200` states,
and preserves the exact zero-error equilibrium.  Inspection of the scale
definition confirms sub-budget commands are exactly unchanged and over-budget
commands retain their raw two-joint ratio.  No formal CFD rollout was run.
