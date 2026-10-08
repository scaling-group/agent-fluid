# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

All four sampled solver examples and the inherited step-39 progress-qualified
rollout are finite `capture` episodes from the required direct-uniform still-
water initialization: `U_infinity=[0,0,0]`, no cylinders, and no prewarm. I
inspected the combined keyframe sheets from release through termination,
including both the top-down mid-plane-vorticity row and the oblique body/
Lambda2 row. The strongest broad route-handoff sample and the informative
progress-qualified failure are visually indistinguishable at the available
cadence: each fish self-propels on the same smooth left-and-down approach, forms
a compact alternating wake by the early frames, and carries coherent paired
three-dimensional structures around the final arc. Neither shows passive
advection, wake collapse, out-of-plane instability, collision, or an exit
precursor. Controller discrimination therefore has to come from progress,
motion, load, and joint histories rather than a claimed wake-topology change.

The full course observer captures at `23.441015T` with score and scoring
mean/final distance `-0.501691/2.399184/0.746948L`. The assigned-parent broad
handoff withdraws only that observer's main-request contribution over the
existing `3.0L -> 0.75L` terminal window. Two independent policy texts produce
bit-identical CFD at `23.441015T`, `-0.501134`, and
`2.398743/0.746369L`, so this remains the strongest sampled distance anchor
with the same coherent wake and `6/3/2/1L` crossing samples. Its trade is
lateral/load rather than feasibility: inside `3L`, mean absolute yaw and
mean/peak target-line cross-track speed are `1.68837 rad/T` and
`0.22619/0.58481U`, and peak absolute moment is `0.014319`, versus
`1.68733 rad/T`, `0.22592/0.58297U`, and `0.013886` for the full observer.
The parent remains below the angle cap; its joint-speed and projected-command
histories are effectively unchanged from the full observer (about `9.97%` and
`21.62%` of joint samples lie within one percent of those respective caps).

The inherited progress-qualified broad handoff is the decisive negative
comparison. Multiplying the same terminal handoff by normalized positive
radial progress retains the capture sample and slightly lowers inside-`3L`
mean/peak yaw and peak moment relative to the broad handoff, but regresses
score and mean/final distance to `-0.501734/2.399219/0.746987L`; peak moment
also remains above the full observer at `0.014167`. Offline replay shows why
the observation has little discriminatory power here: its progress release
averages about `0.92` inside `3L` on all three trajectories. Radial translation
quality therefore cannot decide when the slow lateral route correction is
needed. Another radial qualifier, threshold change, or scalar strengthening is
not supported.

## One-candidate hypothesis

Preserve the assigned parent's carrier, broad distance-based route handoff,
terminal desired-yaw observer, cadence handoff, anterior phase-selected
correction, posterior lag, and smooth component-wise command projection. Add
one continuous lateral-divergence guard to the main-request handoff. Form a
carrier-rejected target-angle demand from the normalized body-frame target
vector and anterior joint angle; compare its sign with the existing normalized
carrier-rejected target-line course residual. When their product is positive,
the swimmer is translating in the direction that grows the target-line error,
so proportionally restore the slow route term. When the error is converging or
the signals disagree, keep the evidenced broad handoff unchanged. The guard
uses the existing centerline scale and bounded state feedback, introduces no
new gain, clock, memory, world coordinate, flow proxy, or actuator layer, and
is identically inactive outside the existing terminal window.

This is a phase-space qualification, not another radial-progress gate: it asks
whether lateral error is currently diverging, not whether overall distance is
closing. Falsify it if pre-`3L` motion changes, capture or wake coherence is
lost, the assigned parent's score/mean/final-distance benefit is given back,
terminal cross-track/yaw/moment do not improve together, or angle, speed, or
projected-command exposure worsens. Because the new CFD result is unavailable
until after this worker exits, this file records only the prior evidence and a
testable prediction.

A counterfactual signal replay on the assigned-parent history confirms that
the mechanism is bounded and localized, not a textual no-op: inside `3L` the
divergence guard averages `0.084`, exceeds `0.25` for `9.3%` of samples, and
restores about `0.050` mean route authority after proximity weighting; below
`1L` its mean is about `0.309`. This replay does not predict the changed
closed-loop trajectory and is used only to verify observation scale and
falsifiability.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG path following and terminal approach control
source_mechanism: sensor feedback modulates a slow route command around a preserved traveling-wave carrier, while near-target yaw and slip observations arbitrate route versus stabilization authority
transferable_invariant: keep propulsion and slow route correction separate, and yield the route layer only while normalized lateral error is converging rather than merely while radial progress is positive
nontransferable_details: published gains, dimensional cadence, robot morphology, species-specific kinematics, duty ratios, exact oscillator or vortex phase, capture radius, and prescribed routes
policy_translation: within the existing body-frame terminal-proximity window, continuously restore only the main-request course residual when carrier-rejected target angle and normalized target-line course residual have the same divergence sign; preserve both joint-carrier dynamics and terminal actuation
falsification: reject if CFD changes the pre-terminal route, loses capture or coherent wake, gives back the replicated broad-handoff distance benefit, fails to improve terminal lateral/yaw/load balance, or worsens actuator feasibility

Formal CFD is intentionally deferred to the post-worker evaluator.

## Validation status

The prescribed guidance/material-change check and solver boundary check pass.
A deterministic schema audit finds `73` returned parameter fields, `71` unique
direct `params.FIELD` references, and no undeclared reference; each public
policy function is defined exactly once. The configured check-runner was
invoked, but its pinned `gpt-5.4-mini` model is unavailable for this account,
so its three commands were run directly. The Julia contract smoke could not
launch because Julia is not installed in the workspace image. No formal CFD
was run.
