# Replicated response-gated interception candidate

## Visual and metric diagnosis before editing

All four sampled solver evaluations and the assigned-parent evaluation satisfy
the frozen evidence contract: direct uniform initialization in still water
with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected both the
top-down mid-plane vorticity and oblique Lambda2 rows for the best finite
capture, the approach-hold failure, and the newly evaluated assigned-parent
failure. The sampled capture follows a direct descending targetward line while
leaving a compact, body-connected alternating wake. The approach hold remains
self-propelled but curls upward into a large off-target loop after closest
approach. The parent's startup recovery also retains an organized wake, yet
departs from the capture route early and bends steeply downward until it exits
the lower boundary. Propulsion and three-dimensional wake formation are not
the missing mechanisms in either failure; preserving the established route
and terminal response handoff is decisive.

The response-gated predicted-miss policy is the strongest replicated sampled
controller: two byte-identical evaluations capture at `15.983--15.994T`, with
mean distance `1.906--1.909L`, zero joint-angle dwell beyond `40 deg`, peak
planar force `0.0342--0.0367`, peak moment `0.0173--0.0185`, and a direct
compact-wake trajectory. The prefilled base predicted-miss sibling also
captures at `16.011T` and similar load/rate scale, so the posterior pulse is
not independently causal. However, the inherited lineage shows that adding
carrier-separated yaw response to the base handoff improved a repeat miss
from `0.96311L` to `0.81002L`, and the complete response/pulse composite is the
only variant with two current captures.

The assigned parent's low-envelope anti-damping is a concrete negative result.
It raised speed at `2T` from about `0.097` to `0.389L/T`, but broke capture,
worsened closest approach to `3.863L`, and exited the lower boundary at
`23.716T` with final distance `9.061L`. Low loads and a coherent wake did not
rescue the changed trajectory. Do not retain or scalar-tune that carrier
recovery on this sensitive interception route.

## Single candidate hypothesis

Replace the weaker prefilled base with the exact best sampled composite. Keep
the established traveling-bend carrier, body-frame course and constant-course
predicted miss, and bounded terminal mean curvature. Add the evidenced
carrier-separated yaw gate that relinquishes rhythmic half-cycle steering only
after measured yaw is corrective, plus its small joint-phase-gated posterior
mid-stroke pulse. This changes the terminal response mechanism without changing
carrier gains, startup energy, world-frame routes, or any scalar value from
the replicated capture policy.

Support requires repeat capture in the `15.983--16.011T` neighborhood while
preserving the direct trajectory, compact alternating wake, zero `>40 deg`
joint dwell, and roughly `0.037/0.019` peak planar force/moment scale. Falsify
the composite on loss of capture, a changed route class, wake degradation,
materially greater rate-limit occupancy or loads, or instability. The current
evidence does not isolate the posterior pulse; ablate it only in a future
paired-repeat design rather than infer benefit from the small score difference.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve rhythmic propulsion, use measured directional response to release redirect authority, and gate a small posterior wave-shape change by observed joint phase
transferable_invariant: hand steering authority away only after phase-separated body response confirms the requested turn, while keeping posterior modulation bounded and rhythm-synchronous
nontransferable_details: C-start timing and curvature, published CPG gains, robot linkage geometry, dimensional frequencies, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target and velocity for predicted miss, subtract an owned two-joint-rate carrier model from heading rate, gate half-cycle handoff by corrective residual yaw, and gate a bounded posterior pulse by normalized anterior joint speed
falsification: reject if repeat capture, direct trajectory, compact wake, joint reserve, and low normalized loads do not remain jointly favorable

## Dry validation only

The candidate SHA-256 is `c8459795cfc38bc3ebbebc4120c1427abe9622491e2bc3fae39385b55f1805ca`,
byte-identical to sampled capture `solver_d32fb3a02de7`. After removing one
duplicate assigned-parent marker from the rendered workspace README, all three
mandated check-runner stages pass: guidance materiality and notes, the
lightweight Julia policy contract, and the solver editable-boundary check. The
deterministic schema audit finds all `28/28` direct `params.FIELD` references
owned by `target_policy_params()`.

A `59,049`-state grid spanning body-frame target geometry and velocity,
distance, both joint angles and rates, and heading response produced finite
commands strictly inside the smooth `30 rad/T^2` envelope (maximum magnitude
`29.99999999994`) with exact left/right reflection (maximum error `0.0`). These
checks establish provenance, schema, boundedness, and equivariance; they are
not a new CFD evaluation. Repeat capture and the physical falsifiers above
remain for downstream evaluation.
