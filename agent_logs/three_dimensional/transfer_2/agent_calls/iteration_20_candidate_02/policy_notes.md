# Candidate diagnosis and hypothesis

All four sampled episodes satisfy the direct-uniform still-water contract
(`U_infinity=(0,0,0)`, no prewarm) and capture at about `0.747L`. In both the
top-down vorticity and oblique Lambda2 rows, each policy self-propels from rest,
forms a coherent alternating wake, holds a mostly direct middle approach, and
makes a pronounced final hook into the capture circle. There is no visible new
wake topology that would justify another phase or terminal-gate scalar edit.

The amplitude-to-lag handoff sample is the strongest finite example: it reaches
`10/8/6L` at `6.897/9.674/12.293T`, captures at `19.354T`, and has the best
distance integral/score (`2.07892L/-0.18968`). The weakest sampled repeat is a
byte-identical response-gated posterior-curvature policy, which captures at
`19.591T` with `2.09637L/-0.20651`. The handoff's benefit is not a cleaner
terminal turn: its recorded path is longer (`12.829L`) and its mean absolute yaw
below `2L` is higher (`0.431 rad/T`) than the response-gated samples
(`12.591--12.693L`, `0.285--0.382 rad/T`). Its evidence-backed advantage is
earlier progress and a lower integral while preserving capture, wake coherence,
and the existing low load envelope.

Policy hypothesis: preserve the supported target-vector, yaw-rate braking,
distance/closing relief, course redirect, and half-cycle steering scaffold.
Use joint-state phase to allocate posterior carrier-amplitude asymmetry while
far, then hand it continuously to posterior lag modulation by normalized
body-frame target distance before the terminal region. This tests one
regime-specific posterior-wave mechanism and avoids stacking the inherited
response-gated curvature or another slip/terminal residual.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and sensor-modulated robotic-fish CPG wave shaping
source_mechanism: posterior emphasis and phase lag create a traveling propulsive bend, while closed-loop modulation allocates gait shape by observed task regime
transferable_invariant: preserve a posteriorly emphasized traveling bend and change its bounded wave-shape allocation continuously from propulsion to approach feedback
nontransferable_details: published gains, dimensional frequencies, species envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: infer phase from normalized joint velocity, use body-frame distance to hand posterior carrier asymmetry to posterior lag, and retain the two-joint bounded state-feedback contract
falsification: reject if repeat or held-out evidence loses capture or coherent propulsion, fails to improve timing or distance integral beyond run variation, or worsens terminal yaw, path, command headroom, joint margins, or force/moment loads
