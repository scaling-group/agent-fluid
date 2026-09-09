# Predicted-miss posterior residual candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen-flow contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I inspected the combined sheets for the scalar-best capture
`solver_f792c48d0852`, the centered prefill `solver_e0a2513d969f`, and the
lowest-score sampled capture `solver_dc562b1ee0c2` from release through
termination. This included both the top-down mid-plane vorticity row and the
oblique body/Lambda2 row. In every case the fish self-propels along the same
nearly direct down-left route behind a compact alternating, body-connected 3D
wake with localized posterior structures. The sheets show neither passive
advection, wake breakup, boundary interaction, nor numerical instability.
There is no sampled non-capture sheet, so the useful failure contrast is the
terminal-course criterion falsified by otherwise finite captures, while the
inherited `1.01--1.22L` left exits remain the semantic failure boundary.

The unified response-plus-predicted-miss prefill remains the best evidenced
terminal controller. It captures earliest at `15.5008T`, crosses with velocity
`(-1.286,-0.014)L/T`, and has only `0.179L` raw target-relative predicted
course miss and `0.411/T` absolute target-line rate. Its compact wake, zero
joint dwell above `40 deg`, and roughly `0.0365/0.0180` normalized peak planar
force/moment establish a useful physical baseline. The target-line-rate shared
handoff `solver_f792c48d0852` improves scalar score to `-0.01965` and retains
capture, but arrives at `15.6893T` with velocity `(-1.112,-0.671)L/T`,
`0.674L` predicted miss, and `1.562/T` target-line rate. It therefore fails
its own `<0.590L` terminal-margin criterion despite nearly arresting body yaw.

The newly evaluated actuator contrasts sharpen that negative. Posterior
phase-lag modulation `solver_dc562b1ee0c2` captures at `15.7509T` but worsens
score to `-0.02201`, crosses at `(-0.977,-0.880)L/T`, and ends with `0.727L`
predicted miss and `1.715/T` line rate. Persistent two-estimate target-line
consensus `solver_8600d052eff8` also captures and improves score relative to
the phase-lag variant (`-0.02023`), yet crosses at
`(-0.899,-0.950)L/T` with `0.747L` miss and `1.738/T` line rate. Their sheets
retain the same coherent wake and route, so these are terminal actuator and
observation failures rather than propulsion failures. Instantaneous or
window-consensus target-line feedback and phase-lag shaping should not replace
the prefill's centered shared redirect.

## Single candidate hypothesis

Start from `solver_e0a2513d969f`, preserving its owned state-feedback
oscillator, posterior lag and pulse, pursuit/course blend, constant-course
predictor, bounded mean bend, response-separated yaw gate, common
geometry/response release, shared two-joint half-cycle steering, and smooth
command envelope. Add one terminal posterior residual to the existing
rhythmic actuator: while the target remains ahead on a closing intercept, use
the signed normalized predicted miss cubed to add tail-only half-cycle
authority. Cubing makes the residual negligible on the evidenced centered
`0.179L` course while increasing it smoothly on the repeated `0.67--0.75L`
lateral class. The shared redirect always remains active, the residual cannot
change the far-field carrier, and no target-line derivative, clock phase,
static curvature, or route is introduced.

The hypothesis is that a small posterior reactive-thrust residual can remove
large target-normal translation without replacing the shared mechanism that
already produced the centered capture. Support requires capture with raw
terminal course miss below `0.590L`, preferably near or below `0.179L`, and
arrival/score comparable to the `15.5008T/-0.02109` prefill, while retaining
the direct compact wake, negligible `>40 deg` dwell, near-rate occupancy in
the inherited class, and normalized peak planar force/moment near or below
`0.037/0.019`. Falsify on a miss or left exit, terminal miss at or above
`0.590L`, slower lateral capture without margin improvement, altered
far-field translation, wake decoherence, joint/load growth, nonfinite
commands, or loss of reflection equivariance. Formal CFD remains deferred to
EvE; this candidate's future outcome is not evidence in these notes.

bookshelf_consulted: true
source_domain: elongated-body reactive thrust and sensor-modulated robotic-fish CPG residual control
source_mechanism: preserve an autonomous anterior-led traveling carrier while bounded directional feedback allocates a small posterior rhythmic residual
transferable_invariant: large target-relative predicted miss can recruit posterior tail authority without replacing the shared propulsive-and-steering carrier that already works on centered courses
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific kinematics, exact phase lags, vortex phases, task coordinates, capture routes, and source-task waypoints
policy_translation: cube the signed normalized body-frame predicted miss and use it only as a closing terminal tail half-cycle residual around the unchanged two-joint state-feedback carrier and common response-plus-miss handoff
falsification: reject if capture margin, centered-route preservation, arrival, coherent wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The mandated guidance-materiality, Julia policy-contract/parameter-schema, and
solver editable-boundary checks pass. A deterministic `59,049`-state grid over
normalized body-frame target geometry and velocity, distance, heading
response, and both joint angles and rates produced finite commands within the
smooth `30 rad/T^2` envelope with exact left/right reflection (maximum error
`0.0`). The posterior residual changed the parent command by as much as
`13.67255 rad/T^2` on the deliberately broad stress grid, while a far receding
state changed by exactly `0.0`; the mechanism is active and closing-scheduled,
not a comment or scalar-only carrier edit. These checks are algebraic only;
formal CFD remains deferred to EvE.
