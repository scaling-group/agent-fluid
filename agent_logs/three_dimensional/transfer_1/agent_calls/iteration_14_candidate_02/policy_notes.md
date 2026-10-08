# Candidate diagnosis and hypothesis

The four sampled rollouts satisfy the direct-uniform still-water contract.  The
combined top-down and oblique sheets for the assigned prefill
`solver_7316a9ac5bac` and strongest finite sample `solver_89695d5abf83` show
self-propelled fish, coherent alternating mid-plane vorticity and three-
dimensional Lambda2 structures, and smooth target-signed arcs through capture;
there is no sampled failed rollout or evidence of passive advection.  The
prefill/residual-recovery policy captures at `19.3105 T`, score `-0.21058`,
distance integral `2.09959 L`, mean/max speed `0.665/0.931 L/T`, and peak
force/moment norms about `0.0306/0.0154`.  Posterior steering spillover alone is
an exact behavioral negative control in the sampled pose: despite a different
implementation, `solver_a850e1367983` reproduces the prefill trajectory and
metrics.  The whole-wave gait-angle projection in `solver_89695d5abf83` is the
only sampled semantic improvement: it preserves the visible wake and load
envelope while leading by `0.154/0.150/0.174 L` at `8/12/16 T`, capturing at
`18.9970 T`, and reducing the distance integral to `2.07455 L`.

The remaining evidence-backed mismatch is in the rate channel.  Across the
strongest rollout, measured body yaw rate is dominated by carrier recoil.  Once
the existing anterior correction `0.40*phi_dot1` is applied, its residual is
still anti-correlated with the observed whole-wave tangent rate
`phi_dot1+phi_dot2` (`-0.927` over the rollout, `-0.941` from `2--12 T`, and
`-0.906` after `12 T`).  A least-squares cancellation coefficient remains
`0.224--0.227` across those regimes and would reduce residual RMS from about
`0.89` to `0.30--0.38 rad/T`; the prefill independently gives the same
`0.221--0.225` range.  This candidate therefore starts from the evaluated
whole-wave gait-angle projection and adds only a bounded, normalized posterior
whole-wave rate projection to the existing bearing-trend and turn-rate
feedback.  It does not change the carrier, redirect, scalar gait gains, or
actuator allocation.

Expected test: removing fast posterior carrier recoil should let the existing
slow body-frame route feedback act on target motion rather than tail-beat
phase, advancing the same coherent capture without increasing the sampled
speed, acceleration-saturation, force, or moment envelope.  Falsify the change
if capture regresses, the `8--16 T` distance lead disappears, the target-signed
arc or alternating wake loses coherence, rate feedback amplifies rather than
removes beat-frequency yaw, or speed/limit residence/load rises materially.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and reactive traveling-wave swimming
source_mechanism: separate the fast joint-state phase of the propulsive traveling bend from the slow feedback that modulates direction
transferable_invariant: rhythmic carrier recoil should be factored out of persistent route-error feedback without damping the carrier itself
nontransferable_details: published CPG gains, dimensional cadence, species-specific envelopes, exact vortex phase, full-body kinematics, and task routes
policy_translation: normalize the observed two-joint tangent rate by the policy's own amplitude-frequency scale, clamp it to a unit phase signal, and add one bounded posterior recoil estimate to body-frame bearing-trend and yaw-rate feedback
falsification: reject if the correction loses capture or mid-route closure, changes the coherent traveling wake adversely, has the wrong yaw-cancellation sign, or materially increases speed, saturation, force, or moment
