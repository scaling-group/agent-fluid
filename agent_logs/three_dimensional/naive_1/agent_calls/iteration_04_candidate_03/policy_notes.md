# Phase 2 candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled episodes use the required direct uniform still-water
initialization (`U_infinity=[0,0,0]`), with no cylinders or prewarm snapshot.
The top-down and oblique rows therefore show self-propelled motion and
self-generated three-dimensional wakes rather than background advection.

The slip-damped anterior rectifier is the strongest finite sample
(`solver_882a60521f5f`). Its top-down row retains a broad leftward trajectory
through `11.20T`, and its oblique row shows a coherent alternating caudal wake
through termination. Relative to the target-blind seed it improves
minimum/final distance from `12.078/12.380L` to `10.062/10.062L`, increases
leftward center travel from `0.925L` to `3.455L`, and raises mean speed from
`0.229U` to `0.387U`. This is useful propulsion and approach progress, but not
directional control: center `y` still rises by `1.202L`, the fish again exits
the upper boundary, and the target is still more than `10L` away.

The traces expose an actuation-allocation failure in that otherwise useful
mechanism. The rectifier is intended to strengthen the target-side anterior
stroke and brake the opposing stroke, but its additive residual is stacked on
a carrier whose raw command is already outside the `1800 deg/T^2` envelope.
Raw requests exceed that envelope on `55.4%` of joint-1 samples and `55.0%` of
joint-2 samples in the best rollout, compared with `32.3%` and `33.5%` in the
seed. Consequently, external clipping can erase the distinction between an
opposing stroke plus braking and the same saturated carrier without braking.

The assigned parent's posterior large-error redirect does not supply a useful
fallback. `solver_307c6b5c665e` sharpens the visible late curl, exits at
`9.12T`, and regresses to `11.838/12.054L` minimum/final distance. Its
same-sign posterior lag-target offset should therefore not be stacked onto
the current best anterior law; the sampled result did not produce the
predicted recovery and sacrificed most of the extra leftward travel.

## One candidate hypothesis

Keep the best sample's body-frame bearing-minus-lateral-velocity request,
zero-centered anterior oscillator, and posterior lag. Change only how the
anterior rectifier shares its actuator: compute the same phase-speed-gated
signed steering command, reserve its absolute magnitude inside the known
joint-acceleration budget, clamp the carrier to the remaining headroom, then
add steering. On a requested stroke steering can use the full budget; on the
opposing stroke the command is shortened rather than being restored to the
same envelope value by downstream clipping. Because steering still vanishes
at observed stroke reversals, this remains rhythmic asymmetry rather than a
parked joint offset. No posterior redirect, clock, route, or world-frame cue
is added.

The falsifiable expectation is an earlier target-directed yaw correction and
a delayed or replaced upper-boundary exit while retaining the alternating 3D
wake and most of the best sample's leftward progress. Reject the allocation if
minimum distance fails to beat `10.062L`, the same upper exit occurs without a
clearer corrective arc, the carrier or caudal wake collapses, or physical
joint limiting remains persistent despite anterior raw commands staying
within the policy budget.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG steering by asymmetric flapping and duty allocation
source_mechanism: target-driven half-cycle amplitude asymmetry superimposed on a continuing propulsive rhythm
transferable_invariant: reserve actuator authority so the requested beat side is stronger and the opposing side is genuinely weakened while state feedback preserves the traveling bend
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, prescribed duty ratios, exact vortex phases, and task-specific routes
policy_translation: body-frame bearing minus normalized lateral velocity sets a bounded request; observed anterior phase speed gates a signed residual whose magnitude is reserved before clamping the anterior carrier to the remaining acceleration headroom
falsification: reject if the alternating carrier or wake collapses, the upper-exit topology persists without better approach, minimum distance does not beat 10.062L, or anterior limiting remains physically persistent
