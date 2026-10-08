# Candidate diagnosis and hypothesis

The sampled rollouts all use direct uniform still-water initialization and all
capture, so semantic success is already established.  The top-down sheets for
the prefilled v27 course-preview policy and sampled v34/v35 descendants show
the same self-propelled, target-closing arc: a regular alternating vortex street
develops by `5T`, remains coherent through the redirect, and reaches the target
without visible wake breakup.  The oblique Lambda2 sheets confirm a compact,
three-dimensional alternating wake rather than passive advection or a planar
rendering artifact.  Near `24T` the fish is still swimming and turning through
the capture circle; there is no visual case for replacing the carrier or route
controller.

The trajectory metrics isolate a remaining actuator defect.  The prefilled v27
captures at `24.5795T` but holds the posterior joint at its hard stop for about
`23.63%` of samples and reaches peak normalized planar force/yaw-moment
coefficients `0.269/0.178/0.143`.  The stroke-aware v34 and v35 descendants
remove sampled posterior hard-stop occupancy and reduce those peaks to roughly
`0.024-0.034/0.016`, while preserving capture.  Replicated v34 captures at
`25.0635T`; v35 captures sooner at `24.6730T` and has the best sampled score
`-0.448647`.  However, neither posterior coast guard meets its rate objective:
posterior exact-rate occupancy is `5.837%` in v34 and `5.930%` in v35, versus
`5.818%` in v27.  The v34 linear pressure ramp can still command almost the
full acceleration envelope just inside its rate band, so downstream clipping
remains the effective boundary mechanism.  The inherited dual-joint inward
braking failures show that stronger braking is not an acceptable substitute;
they remove rate occupancy but turn capture into a pass-and-left-exit topology.

Policy hypothesis: start from the evidenced v35 route, steering allocation,
stroke predictor, and braking reserve.  Replace only its posterior rate ramp
with a velocity-headroom tangency rule.  When posterior acceleration is aligned
with posterior velocity inside the existing guard band, cap that aligned part
by `(rate_limit - abs(rate)) * drive_omega`; blend in only already-requested
opposing steering.  This produces a bounded non-braking coast that approaches
the owned rate limit asymptotically in oscillator-scale time, while leaving the
anterior phase anchor, all inward commands, and all commands below the band
unchanged.  Falsify the mechanism if formal evaluation loses capture, changes
the coherent target-closing route, restores posterior hard-stop occupancy,
raises the v34/v35 low-load class, or fails to reduce posterior exact-rate
occupancy below the `5.818%` v27 reference.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and low-dimensional sensor-modulated CPG control
source_mechanism: preserve the anterior rhythm as phase anchor and constrain the posterior follower through observed joint state instead of replacing the traveling wave
transferable_invariant: feasibility shaping should preserve wave direction and posterior lag while acting only on the boundary-directed component evidenced by joint velocity
nontransferable_details: published species kinematics, dimensional beat frequencies, oscillator gains, full-body envelopes, and exact wake phases
policy_translation: use normalized posterior rate headroom and the state-feedback drive omega to cap only velocity-increasing posterior acceleration, retaining opposing target steering
falsification: reject if capture or the coherent route is lost, low loads regress, posterior hard-stop occupancy returns, or posterior exact-rate occupancy is not below 5.818 percent
