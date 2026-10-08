# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the common held-fish initial condition: four
developed staggered-cylinder wakes overlap before reaching the upper-right
release pose and the target corridor. It is common environmental evidence, not
a policy distinction.

The three strongest sampled rollouts are byte-identical copies of the prefill.
Their released sheets show an immediate correct-sign redirect, a coherent
posterior traveling bend, and a compact upstream-left diagonal into the merged
wake and target. They reach the `0.75L` boundary after `43.9505`, with `2.1391L`
mean distance, `5.3083e4` total command energy, and RMS lateral force/moment of
`49.44/701.26`. Mean fish velocity `(-0.2471,-0.1020)` versus mean local flow
`(-0.1342,-0.1556)` confirms controlled upstream swimming rather than passive
advection. Both joint rates and accelerations still touch their configured
caps.

There is no failed current sample, so the most informative contrast is the
posterior-rate-guard success. Its keyframe sheet retains the same useful route
topology and traveling bend, with only a subtle posterior-wake difference near
capture. Suppressing outward posterior acceleration above `95%` of the rate
envelope lowers RMS force/moment to `43.46/649.26`, power proxy from `3944.0` to
`3848.5`, and total command energy by only `0.23%`. It also delays capture to
`44.2420`, worsens mean distance to `2.1450L`, and still touches the acceleration
cap while reducing maximum posterior rate by only `0.34%`. The assigned-parent
guidance reports that removing the approach taper alone retained the exact
`43.9505` arrival, so taper removal does not explain the rate-guard regression.
This is evidence that global near-cap relief withdraws some useful posterior
authority; it is not a free efficiency improvement.

The inherited response-gated recovery candidate has no post-worker CFD result
in the current evidence. It remains an unevaluated hypothesis and is not used
as evidence for this edit.

## Policy hypothesis before the edit

Preserve the evaluated carrier, bearing bias, posterior lag, approach taper,
and target-favored half-cycle boost exactly. Add one phase-selective compliance
mechanism: when posterior velocity is near its envelope and the requested
acceleration would push it farther outward, suppress that outward component
only on the target-disfavored joint-state half-cycle. The same centered joint
state used by `preferred_half` supplies a compact smoothstep phase gate that is
exactly zero throughout the target-favored half-cycle, and absolute bounded
bearing demand makes the relief vanish at zero turn request. Thus the stroke
carrying the proven redirect retains full authority, while the complementary
stroke tests the load benefit suggested by the global guard.

Expected evidence is the same direct `43.9505`-class route and target capture,
with lower RMS force/moment or power than the prefill and without the global
guard's distance-integral regression. Falsify the mechanism if capture is
delayed or lost, mean distance worsens, the traveling bend or early redirect
changes adversely, or saturation and loads remain effectively unchanged.
Formal CFD remains post-worker evidence.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric CPG turning and elongated-body reactive propulsion
source_mechanism: allocate posterior effort by observed beat phase while preserving the stroke that carries target-directed curvature and reactive thrust
transferable_invariant: cap-directed posterior relief should preserve the target-favored half-cycle and act only on its complementary joint-state phase, with phase inferred from body-frame turn demand and centered joint state
nontransferable_details: published gains and duty ratios, species-specific kinematics, dimensional frequency and rate envelopes, clock phase, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: retain normalized bearing-to-curvature feedback and the evaluated posterior half-cycle boost; multiply only outward near-envelope posterior acceleration by a smooth target-disfavored phase gate that vanishes with turn demand
falsification: reject if the direct diagonal capture is delayed or lost, the traveling bend degrades, mean distance worsens, or force, moment, power, and cap contact do not improve relative to the prefill

## Pre-evaluation verification

The compliance gate is exactly zero at zero bearing, below `95%` of the
posterior rate envelope, and throughout every state with
`turn_request * head_wave >= 0`, so the complete target-favored half-cycle
matches the prefill. The gate remains in `[0,1]` and can attenuate but never
reverse an outward posterior action. A deterministic sweep of `21,875` states
spanning approach distance, both bearing signs, both joint limits, and both
rate-envelope signs returned finite actions, exercised the guard in `4,500`
states, found zero favored-half guard activations, and preserved the exact
zero-action equilibrium.

Static schema comparison confirms every direct `params.FIELD` reference is
returned by `target_policy_params()`. The prescribed guidance semantic check
and solver editable-boundary check pass. The Julia include/assertion could not
run because this environment has no `julia` executable. No formal CFD was run;
candidate performance remains a falsifiable post-worker hypothesis.
