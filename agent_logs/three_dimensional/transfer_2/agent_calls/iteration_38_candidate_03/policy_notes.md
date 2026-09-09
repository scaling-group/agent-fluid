# Candidate diagnosis and hypothesis

## Evidence read before editing

All four sampled episodes are valid direct-uniform still-water releases
(`U_infinity=[0,0,0]`, no prewarm and no cylinders), and all terminate in
capture. The combined sheets show self-propulsion rather than advection: from
release onward the top-down row develops a coherent alternating signed wake,
while the oblique row shows paired three-dimensional Lambda2 structures shed
behind a body that turns and advances toward the target. Neither the best
finite example nor the slower prefill shows a disturbance event, wake breakup,
collision, or instability before capture. Both straighten and shed less
vorticity during final drive relief; the difference is trajectory and actuator
allocation, not a missing terminal wake-cancellation response.

The strongest scalar sample, `solver_6dada5e7a98a`, uses a steering-aware
predictive common carrier guard and captures at `15.604T` with distance
integral `1.79354L`, head path `13.137L`, peak planar force/yaw moment
coefficients `0.04226/0.02076`, and anterior/posterior greater-than-99%-rate
residence `9.38/0.00%`. The prefilled response-release policy
`solver_0e3ccca5bc77` is slower at `16.088T/1.82203L`, with path `13.129L`,
peaks `0.03575/0.01781`, and greater-than-99% residence `11.93/1.44%`.
The joint-selective predictive sample `solver_7d26cc24fc23` captures at
`15.730T/1.80572L` but shortens path to `12.848L`, limits peaks to
`0.03558/0.01724`, and leaves posterior greater-than-99%-rate residence at
zero while anterior residence remains `8.71%`. Thus the evidence supports its
per-joint positive-work guard as the base, while exposing unused posterior
rate margin whenever the anterior joint is the bottleneck.

No optimizer note was inherited in this workspace. The assigned parent
guidance also records three or more completed capture-preserving terminal
variants without a new success class or a repeat-robust semantic improvement;
it specifically rejects another corridor, slip, instantaneous-load, or
same-sign-yaw gate and asks for unresolved body-frame directional demand to
govern later carrier allocation. That triggers the required bookshelf
consultation.

## Policy hypothesis

Use the shortest-path joint-selective predictive guard, but add one bounded
course-resolved posterior-margin transfer. Only when (a) the anterior carrier
is doing positive work near its projected rate envelope, (b) the posterior
projected rate remains below guard onset, and (c) the actual body-frame
velocity course has resolved the target redirect, restore a small amount of
posterior outward carrier work. Keep reversal, mean curvature, approach
relief, and all target steering unchanged. This should use posterior actuator
headroom to recover some of the common guard's early progress without
recreating its longer path and higher loads.

Falsify the mechanism if capture is lost; timing or distance integral fails to
improve beyond the sampled `15.60--15.73T` / `1.7935--1.8057L` class; head path
rises materially above `12.85L`; posterior greater-than-99%-rate residence
becomes nonzero or its greater-than-90% residence rises materially above
`5.77%`; anterior rate cost does not fall; peak force/moment exceeds the
joint-selective sample's `0.03558/0.01724` without a clear timing benefit; or
either visual row loses the coherent alternating traveling-wake class.

bookshelf_consulted: true
source_domain: slender-body reactive propulsion and sensor-modulated robotic-fish CPG turning
source_mechanism: posterior emphasis plus observed-response release from redirect into the propulsive beat
transferable_invariant: allocate rhythmic work posteriorly only when steering demand is fulfilled and that actuator has state-measured margin
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body waveforms, exact vortex phase, and task routes
policy_translation: normalized body-frame velocity-course resolution gates a bounded transfer from anterior positive-work pressure into posterior carrier work, with each joint's projected rate enforcing the margin
falsification: reject if timing and integral do not improve while short path, zero posterior hard-rate residence, low loads, capture, and coherent two-view wake are retained
