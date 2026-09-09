# Carrier-separated predicted-miss reproducibility candidate

## Visual and metric diagnosis before editing

All four sampled solver rollouts and the assigned parent's completed rollout
satisfy the frozen experiment contract: direct uniform initialization in still
water with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and
capture termination. I inspected every combined keyframe sheet from release
through capture in both required views. The top-down rows show genuine direct
down-left self-propulsion and coherent alternating mid-plane wakes; the oblique
body/Lambda2 rows show compact body-connected three-dimensional vortex trains.
No view shows passive advection, wake breakup, boundary interaction, or
instability. The productive carrier and broad route should remain unchanged;
terminal course discrimination and repeatability are the active questions.

The sampled policies expose an actuator-quality spread inside the same visual
capture class. Tail-only cubic allocation is fastest and score-best at
`15.1403T/-0.01094`, but crosses with `0.651L` head-relative constant-course
miss, `0/1.269%` anterior/posterior `>40 deg` dwell, and `0.04041/0.01902`
peak normalized planar force/moment. Directional reserve improves those to
`15.3385T/-0.01502`, `0.461L`, `0/0.681%`, and `0.03959/0.01889`; dual
absolute reserve gives `15.2957T/-0.01484`, `0.556L`, `0/0.898%`, and
`0.03872/0.01876`. The absolute-reserve spillover sample captures at
`15.2745T/-0.01525` but exchanges exposure into `0.648/1.044%` dwell and
retains a `0.632L` miss.

The assigned parent's carrier-separated miss is the first completed result to
improve the directional benchmark's margin, both-joint reserve, and load class
together: capture at `15.3668T/-0.01589`, `0.305L` miss, `0/0.358%` dwell,
and `0.03856/0.01846` peak loads. Its visual wake and route remain in the same
useful compact class. The arrival is only `0.028T` outside the inherited fast
window and is outweighed by the distinct margin/reserve improvement. However,
inherited identical-controller repeats have previously changed terminal miss
by several tenths of a body length, so this one centered result does not yet
establish robustness. Adding another terminal actuator at the same time would
confound whether carrier separation itself survives a replicate.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow target-directed correction from fast alternating carrier motion while preserving the autonomous traveling wave
transferable_invariant: terminal route feedback should act on motion residual to the productive carrier rather than reject coherent beat-scale sway as persistent course error
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, robot linkage geometry, exact vortex phases, task coordinates, routes, waypoints, and the fitted coefficients outside this carrier
policy_translation: reproduce the evaluated parent by subtracting its normalized two-joint-rate sway proxy only from near-target predicted-miss velocity while retaining raw body-frame velocity for broad course, closing, and timing and retaining the response-plus-miss handoff, directional phase-space reserve, and two-joint carrier
falsification: reject robustness if the replicate loses capture or compact-wake routing, exceeds `0.461L` terminal miss, exceeds `0/0.681%` joint dwell, exceeds about `0.040/0.019` peak normalized loads, or incurs materially slower arrival without a stronger margin

## Single candidate hypothesis

Replace the prefilled older absolute-reserve allocator with an exact semantic
replicate of the evaluated assigned-parent controller. Its one observation
mechanism normalizes both joint rates by the owned carrier rate and subtracts
the evidenced two-joint lateral-sway proxy only from the velocity used for
near-target closest-approach miss. Raw normalized body-frame velocity still
controls far-field course, closing alignment, and prediction timing. The
autonomous oscillator, posterior lag, common response-plus-miss handoff,
posterior pulse, directional phase-space reserve, and smooth acceleration
envelope are preserved exactly. This is a deliberate reproducibility test,
not scalar gain tuning and not a claim that the parent's downstream CFD is the
current candidate's result.

Support requires another capture on the direct compact-wake route with terminal
miss at or below the `0.461L` directional benchmark, zero anterior dwell,
posterior dwell at or below `0.681%`, peak normalized planar force/moment no
worse than about `0.040/0.019`, and arrival near the `15.14--15.37T` class.
Stronger support is a repeat near the parent's `0.305L`, `0/0.358%`, and
`0.03856/0.01846` result. Falsify on lost capture, a return to the sampled
`0.556--0.651L` miss class, worse joint/load quality, changed far-field route,
nonfinite commands, or loss of reflection equivariance. If it falsifies,
later workers should refit or remove the carrier proxy under a changed carrier
instead of stacking a new terminal actuator on an unreplicated observation.

## Dry validation boundary

The prescribed guidance-materiality/parameter-schema check, lightweight Julia
policy contract, and solver editable-boundary check pass without running CFD.
The candidate SHA-256 is
`99b6a937cdee9ff7d6b1b4d91ea4a2a7c2263ebceb37fe00b9fee4645d7f9e9e`,
exactly matching the evaluated assigned-parent controller as required for a
semantic replicate. That identity establishes implementation fidelity only;
the parent's capture, wake, terminal margin, joint history, loads, and arrival
remain prior evidence, not results of this unevaluated candidate.
