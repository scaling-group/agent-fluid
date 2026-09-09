# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled rollouts satisfy the frozen direct-uniform contract:
`U_infinity=(0,0,0)`, no cylinders, no prewarm, finite moving-window dynamics,
and `termination=capture`. I inspected both the top-down vorticity and oblique
body/Lambda2 rows in their combined sheets, then compared them with the
inherited posterior-wave-preservation failure. The claims below were
cross-checked against `wake_metrics.csv`, `wake_diagnostics.json`, executable
policy diffs, the assigned parent guidance, and inherited optimizer notes.

The four captures form one narrow behavior band rather than four independent
improvements. Three policies are executable replications and the fourth only
couples the existing anterior amplitude relief to the existing yaw-response
gate. They capture at `18.65050--18.75500T`, with mean scored distance
`2.09340--2.09542L` and scores in `[-0.20743, -0.20578]`. Their top-down sheets all
show a coherent alternating street behind a self-propelled fish following the
same broad target-directed curve; the oblique rows retain compact caudal
Lambda2 structures through first crossing. The response-coupled schedule sits
inside repeat variability at `18.66150T` and `2.09362L`, so it is not evidence
for another response-gate compound. Public acceleration remains projected at
`31.416 rad/T^2` but contacts that envelope on about `60.6--61.0%` and
`73.0--73.2%` of anterior/posterior rows; the joint-rate envelope is contacted
on about `10.9--11.2%` and `14.8--15.1%`. Wake coherence and capture are
therefore established, while route class and posterior demand have stagnated.

The inherited posterior-wave-preservation ablation is the informative
failure. It inversely restored the centered anterior-displacement-plus-lag
component in the posterior target while anterior redirect relief was active,
leaving both mean-curvature shares unchanged. Both image rows still show
energetic alternating structures, but the fish turns downward past the target,
reaches only `3.14646L`, and exits left at `28.07753T` with final distance
`9.21649L`. Its heading reaches `1.35362 rad`, posterior angle reaches
`0.64053 rad` versus about `0.55426 rad` in the current captures, and posterior
acceleration contact rises to `74.69%`. Thus extra posterior traveling-wave
authority during redirect can destroy the route without destroying the wake.
The current candidate must preserve displacement-only beat phase, both
target-signed mean-curvature shares, the non-inverting response-release gate,
and final acceleration projection.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirect-to-cruise transitions and sensor-modulated robotic-fish CPG gait allocation
source_mechanism: strong bounded redirect curvature with temporarily de-emphasized posterior propulsion, followed by response-triggered restoration of the traveling beat
transferable_invariant: persistent normalized body-frame misalignment may reallocate authority from posterior rhythmic propulsion toward unchanged target-signed mean curvature, while observed correcting yaw continuously restores the posterior wave
nontransferable_details: published amplitudes, frequencies, CPG gains, species-specific C-start envelopes, full-body waveforms, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: retain the captured joint-state oscillator, displacement-only half-cycle steering, differential mean-curvature shares, posterior lag, and projection; multiply only the zero-mean posterior displacement-plus-lag target by a positive bounded scale derived from absolute lateral target direction cosine and the existing correcting-yaw response gate
falsification: reject if capture or either coherent wake view is lost, arrival and mean distance do not improve beyond the replicated capture band, the route returns to the downward/left exit, posterior angle/rate/acceleration contact does not fall, or planar load peaks materially worsen

## Single-candidate policy hypothesis

Add one redirect-to-cruise gait-allocation mechanism. Define a posterior wave
scale that is one at target alignment, falls mildly while lateral target
misalignment is large and yaw has not responded, and returns toward one as the
existing one-sided correcting-yaw response grows. Apply it only to the
zero-mean `-centered_q1 - tail_lag_gain*qd1/omega` component of the posterior
target; do not scale `tail_bias`. Use the same `15%` relief magnitude already
tested for the anterior envelope, so the edit tests the allocation sign and
location rather than importing a literature gain.

The hypothesis is that the opposite of the failed posterior enhancement will
reduce posterior sweep and yaw overshoot during redirect, then restore caudal
propulsion for cruise without changing route sign or beat phase. It is a new
feedback mechanism, not a scalar-only carrier retune. Formal CFD occurs only
after this worker exits. Accept it only if it retains capture and both coherent
wake rows while improving outside the `18.65050--18.75500T` /
`2.09340--2.09542L` repeat band and reducing posterior demand; otherwise the
negative result should rule out response-gated posterior wave allocation
around this carrier.

## Implementation and non-CFD validation

The candidate adds exactly one parameter-owned mechanism:
`posterior_redirect_relief_fraction=0.15`. Its positive scale is bounded in
`[0.85, 1.0]`, equals one at alignment, and changes only the posterior
zero-mean wave target. The target-signed head/tail biases, displacement-only
phase factor, response gate, anterior envelope, oscillator, posterior lag,
and final acceleration projection remain unchanged.

The workspace guidance-difference check and solver boundary check pass. A
deterministic source comparison also confirms every direct `params.FIELD`
reference is returned by `target_policy_params()`. The configured check-runner
could not execute its lightweight Julia call because this worker environment
has no `julia` executable; no policy assertion failed, and no CFD was run.
