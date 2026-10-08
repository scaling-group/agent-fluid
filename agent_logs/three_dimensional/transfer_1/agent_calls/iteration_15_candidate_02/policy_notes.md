# Candidate diagnosis and hypothesis

The four sampled rollouts use direct uniform still-water initialization and all
capture.  The best finite example, `solver_89695d5abf83`, is the whole-wave
gait-projection controller: it captures at `18.9970 T`, score `-0.18597`, and
distance integral `2.07455 L`, versus `19.3105 T`, `-0.21058`, and
`2.09959 L` for the assigned posterior-spillover prefill
`solver_a850e1367983`.  The combined keyframe sheets show self-propelled
motion, a continuous target-signed arc, and a coherent alternating vorticity
wake in the top-down row together with a compact, repeating three-dimensional
Lambda2 train in the oblique row.  The weaker prefill retains the same visible
wake topology but closes later, so the evidence favors preserving its
traveling-wave carrier and improving route-state estimation rather than adding
drive.  No sampled failure has keyframes; the inherited failure summaries
(`solver_8462522d3a63` and `solver_b375bf7d11ca`) report immediate
`left_domain` exits above `12.2 L`, so they are scalar warnings against an
unbounded or sign-fragile feedback change, not visual evidence.

The centered-half-cycle negative control `solver_86374a6bd3ab` keeps capture
and the coherent two-view wake, but moving mean removal from the sensing layer
into the actuator's bend-side classifier regresses the best controller to
`19.0355 T`, score `-0.20185`, and integral `2.08993 L`.  Phase separation
therefore stays confined to observations in this candidate.

After the existing anterior rate projection, residual yaw rate is strongly
anti-correlated with whole-wave tangent rate `phi_dot1 + phi_dot2`: correlation
is `-0.927` with slope about `-0.226` in the best rollout, and the same sign and
scale occur in every sampled capture.  Adding a bounded
`0.225 * (phi_dot1 + phi_dot2)` estimate offline reduces that residual's RMS by
`62--64%`; the proposed `1.2 rad/T` cap engages in only `0.2--0.6%` of samples.
The policy hypothesis is that applying this projection to both the observed
yaw rate and body-frame bearing trend will keep beat-frequency recoil out of
route feedback, improving middle/late closure without changing the carrier,
raw large-angle redirect geometry, mean curvature, or physical actuator
limits.  Reject the mechanism if capture, early closing, wake coherence, speed,
joint-limit residence, force, or moment regresses, even if offline residual RMS
falls.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish CPG control and wake-disturbance rejection
source_mechanism: separate persistent route error from fast oscillatory carrier-correlated motion before closing the direction loop
transferable_invariant: reject self-generated beat-frequency recoil from slow target feedback using bounded observed body and joint state
nontransferable_details: published gains, species kinematics, clock phase, exact vortex phase, and source-task routes
policy_translation: preserve raw body-frame redirect geometry; add a capped whole-wave joint-rate estimate to yaw rate and bearing trend after the established anterior projection
falsification: reject if another pose loses capture or early closure, the alternating wake decoheres, mean turn changes sign, or speed, saturation, force, or moment rises without compensating progress
