# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the common held-fish initial condition: four
developed staggered-cylinder wakes overlap the target corridor and reach the
upper-right release pose. It is not candidate-specific evidence.

The three byte-identical strong samples visibly establish an immediate
correct-sign redirect, retain a coherent posterior traveling bend, and swim a
compact upstream-left diagonal into the merged wake and target. All capture
after `43.9505` released time with `2.1391L` mean distance, about `5.308e4`
total command energy, and RMS lateral force/moment `49.44/701.26`. Their mean
velocity `(-0.247,-0.102)` versus mean local flow `(-0.134,-0.156)` confirms
substantial self-propelled upstream closure. Both joints reach the rate and
acceleration caps, so the remaining limitation is cap-dominated actuation, not
missing route authority.

The evaluated prefill removes the evidence-neutral approach taper and adds a
posterior rate guard that subtracts only acceleration pushing an already
near-envelope posterior rate farther outward. Its sheet preserves the same
compact diagonal topology and capture, delayed only to `44.2420`; mean distance
changes to `2.1450L` and total command energy falls slightly to `5.296e4`.
More importantly, posterior peak rate falls below the cap (`4.5223` versus
`4.5379 rad/time`), while RMS force/moment fall to `43.46/649.26`, reductions
of about `12.1%/7.4%`. Anterior rate and both acceleration caps remain reached.
This is positive evidence that selective high-rate posterior compliance can
reduce loads without destroying the fast half-cycle-steering route.

The most informative inherited failure exits right after `16.7914`, never
forms a targetward traveling bend, has `-0.147` progress, and moves only
`0.0154U` upstream relative to local flow. It bounds the edit away from more
static curvature or global carrier relief. The assigned-parent response-gated
amplification is a sharper negative result: adding up to `20%` posterior boost
when bearing worsens creates a visibly larger correction loop, delays capture
to `56.5400`, worsens mean distance to `2.5747L`, raises total command energy to
`7.021e4`, and raises RMS force/moment to `52.73/705.07`. Bearing-error growth
is therefore not evidence for adding more steering authority on this fast
topology.

## Policy hypothesis before the edit

Preserve the evaluated prefill's `0.55`-period, `28 deg` anterior oscillator,
bounded `8 deg` bearing bias, posterior lag, state-phased half-cycle steering,
and outward-only posterior rate guard. Replace the guard's fixed onset with a
smooth function of the magnitude of normalized body-frame relative crossflow.
In quiet flow the guard starts closer to the hard rate envelope, retaining
reversal authority; during large relative crossflow it starts modestly earlier,
allowing the wake to move the tail rather than spending acceleration against an
already fast outward motion. The slow target-bearing curvature and the sign of
the traveling bend are unchanged.

At zero crossflow the onset is `0.98` of the parameter-owned rate envelope. At
the prefill's `0.210U` RMS relative crossflow it is approximately `0.942`, and
it is bounded below by `0.93`. This is a new observation-conditioned compliance
mechanism, not a scalar-only retune. The current worker does not run formal CFD;
the hypothesis is falsified if target capture is lost or materially delayed,
the compact diagonal/traveling bend changes adversely, or force, moment, and
episode effort do not improve relative to the evaluated prefill's small arrival
cost. Because only crossflow magnitude is used, the candidate does not claim
sign-calibrated vortex rejection or phase locking.

bookshelf_consulted: true
source_domain: Karman-wake fish interaction and adaptive robotic-fish swimming
source_mechanism: preserve useful wake-induced motion by adding bounded flow-conditioned compliance rather than cancelling every lateral disturbance
transferable_invariant: separate persistent body-frame target steering from fast wake response, and reduce only actuation that opposes a strong observed disturbance without removing the propulsive traveling bend
nontransferable_details: reduced-muscle-activity values, species kinematics, published controller gains, dimensional frequencies, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: keep bearing-driven mean curvature and joint-state half-cycle steering; use absolute normalized body-frame relative crossflow to advance only the outward posterior high-rate guard within parameter-owned bounds
falsification: reject if the fast compact capture is delayed or lost, the traveling bend collapses, or force, moment, and effort fail to improve over the evaluated fixed-guard prefill

## Pre-evaluation verification

The prescribed guidance-semantic and solver editable-boundary checks pass.
The lightweight Julia contract assertion passes with the workspace-accessible
runtime, and a deterministic `3,375`-state sweep across bearing, both joint
states, both rate signs, and relative crossflow returns finite two-joint actions
with a guard-onset range of `0.9300--0.9800`. Zero bearing and zero joint state
remain a zero-action equilibrium even under nonzero crossflow magnitude. Every
direct `params.FIELD` reference is returned by `target_policy_params()`. No CFD
rollout was run; performance of this candidate remains post-worker evidence.
