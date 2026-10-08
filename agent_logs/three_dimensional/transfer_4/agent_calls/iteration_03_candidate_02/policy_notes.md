# Wake-policy candidate notes

## Evidence diagnosis before editing

All four sampled rollouts satisfy the experiment contract: direct uniform
still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no prewarm,
and both top-down mid-plane and oblique Lambda2 views. The combined sheets show
that the policies are self-propelled rather than advected. Both the captured
and failed runs retain coherent alternating caudal structures, so the decisive
difference is planar course control rather than wake formation.

The assigned parent `solver_fb3dd7355a7f` preserves the bounded odd
target-request-to-curvature map and captures at `23.3585T`, reaching
`0.74697L` with mean distance `2.41260L`. Its top-down row shows a broad,
continuously closing turn into the target, while the oblique row retains an
organized three-dimensional wake through termination. In contrast, the
transferred seed `solver_e496f399e09f` generates a similarly coherent wake but
turns past the target: after reaching `4.77995L` at `17.853T`, it continues
toward the lower boundary and exits at `27.4945T` and `9.70888L`. This supports
preserving the parent's signed-curvature steering and traveling-wave topology.

The remaining evidence concerns actuator feasibility. The base signed-
curvature capture `solver_bfe9ef100c67` and the policy-clamped variant
`solver_a327d01ebd51` have identical trajectories, termination, score
(`-0.51790998`), and force histories because the episode already applies the
same symmetric acceleration clamp. Thus another output clamp alone is a
demonstrated semantic no-op. The assigned parent's alignment-conditioned
terminal cadence produces a small score/final-radius improvement to
`-0.51527750` and `0.74697L`, but requested acceleration still exceeds the
episode envelope in about `70.0%/52.1%` of anterior/posterior samples, and
joint rates occupy at least `99.9%` of the rate limit in about `9.1%/1.6%` of
samples. The inherited optimizer notes also report that large route redirects
and generic steering-reserve allocation lost capture, so this candidate does
not add another course branch or retune target gains.

## Candidate hypothesis

Preserve the assigned parent's target guidance, odd posterior mean curvature,
half-cycle steering, alignment-conditioned terminal cadence, and joint-state
traveling-wave carrier. Add one reflection-equivariant actuator-envelope
governor at the two-joint output. It first expresses the already fixed
acceleration and rate envelopes as policy parameters, then uses normalized
`abs(phi_dot)` to continuously withdraw only acceleration that would increase
the same signed joint speed above a near-limit onset. Opposing acceleration is
left untouched so the oscillator can reverse promptly; target steering is not
reinterpreted or assigned a world-frame route.

On an offline replay of the assigned-parent states, an onset at `0.96` of the
rate envelope changes the already-clamped command in about `10.7%` of anterior
and `3.0%` of posterior samples; at the exact rate limit it makes a speed-
increasing command zero. This replay is only a scope check, not new CFD
evidence. The intended test is whether removing futile acceleration demand
reduces rate-envelope residence while retaining the captured trajectory and
coherent wake. Falsify the mechanism if capture is lost, arrival or integrated
distance worsens materially, rate-envelope occupancy is not reduced, or the
slower phase evolution degrades wake coherence or target steering.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and actuator-aware efficient undulatory swimming
source_mechanism: preserve a traveling propulsive oscillator while observed joint state continuously modulates gait effort near a physical response boundary
transferable_invariant: a rhythmic traveling bend should stop requesting unavailable speed-increasing action near an actuator limit while retaining full reversal authority
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, exact Strouhal values, open-loop phase, exact vortex phases, and task routes
policy_translation: normalize each observed joint rate by policy-owned limits and smoothly attenuate only same-direction acceleration near the limit under the existing two-joint state-feedback carrier
falsification: reject if rate-limit residence does not fall, capture or distance score degrades materially, or the alternating propulsive wake and reflected steering response are not preserved
