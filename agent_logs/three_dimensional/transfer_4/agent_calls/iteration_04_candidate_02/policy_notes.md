# Wake-policy candidate notes

## Evidence diagnosis before editing

All four sampled rollouts satisfy the Phase-2 evidence contract: direct
uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
prewarm, and combined sheets containing both top-down mid-plane vorticity and
oblique body/Lambda2 views. No sampled rollout is a failure in this workspace;
all capture at about `23.35T`. I therefore compared the best-score capture
with the least-score capture and used the assigned parent's documented domain
exits only as inherited trajectory evidence, not as unseen visual evidence.

The top-down sheets for the rate-governed `solver_3e8ee72bb918` and base
signed-curvature `solver_bfe9ef100c67` both show self-propulsion: the body
translates left while shedding a regular alternating wake, then follows a
broad downward turn whose distance closes continuously into the target. The
oblique rows show compact alternating three-dimensional caudal structures
through termination rather than passive advection, wake collapse, or a
near-target C-bend. The views are nearly indistinguishable at their coarse
keyframe cadence, so the improvement must be established from histories, not
from a visually dramatic vortex.

The prefilled alignment-cadence controller `solver_fb3dd7355a7f` captures at
`23.3585T`, scores `-0.51527750`, and has mean distance `2.41260L`. Its raw
acceleration requests exceed the fixed envelope in about `70.0%/52.1%` of
anterior/posterior samples, and the corresponding joint rates occupy at least
`99.9%` of the rate envelope in about `9.09%/1.62%` of samples. Adding only an
explicit symmetric acceleration clamp in `solver_ee4561476853` produces the
same trajectory and score because the episode already applies that clamp.

In contrast, `solver_3e8ee72bb918` adds a smooth, reflection-equivariant rate
governor that attenuates only acceleration aligned with the observed joint
rate near the envelope and preserves opposing acceleration for reversal. It
keeps peak joint rates below the `260 deg/T` limit (`259.39/259.20 deg/T`) and
reduces `99.9%`-envelope residence to zero for both joints. It still captures
with the same coherent wake and unchanged peak planar force and yaw-moment
coefficients (`0.03672/0.01832`). Its score and mean distance improve to
`-0.51274776` and `2.40949L`; the tradeoff is a slightly lower peak speed
(`0.7428` versus `0.7515 L/T`) and an arrival `0.0055T` later. This is direct
CFD evidence that selective state-dependent withdrawal is useful here, while
raw clipping incidence alone is not evidence for a generic steering reserve.

## One candidate hypothesis

Adopt the evaluated rate-governed controller as the single candidate. Preserve
the captured alignment-conditioned cadence, normalized body-frame target and
turn-rate guidance, bounded odd posterior mean-curvature map, half-cycle
steering, and joint-state traveling-wave carrier. Add only the demonstrated
per-joint envelope governor: first bound requested acceleration by a
policy-owned copy of the physical limit, then use normalized `abs(phi_dot)` to
smoothly withdraw same-direction acceleration above a near-limit onset. Leave
decelerating/reversing authority untouched. This is one actuator-feedback
mechanism, not scalar gain tuning, a hidden phase, or a route branch.

Expected result: reproduce the sampled governor's capture topology, coherent
wake, lower distance integral, and zero measured near-rate-limit residence.
Falsify its reusable value if a repeat or held-out geometry loses capture,
materially worsens arrival or mean distance, restores rate-envelope residence,
raises force/moment loads, or disrupts the reflected target-to-curvature
response. The new rollout occurs after this worker exits, so no additional CFD
outcome is claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and actuator-aware efficient undulatory swimming
source_mechanism: preserve a traveling propulsive oscillator while observed joint state continuously limits unavailable speed-increasing effort
transferable_invariant: near an actuator-rate boundary, withdraw only acceleration that increases the current signed joint speed while retaining full reversal authority and the posterior traveling wave
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, exact Strouhal values, open-loop phase, exact vortex phases, and task-specific routes
policy_translation: normalize each observed joint rate by policy-owned limits and smoothly attenuate only same-direction acceleration inside the existing two-joint state-feedback carrier
falsification: reject if rate-limit residence returns, capture or integrated distance degrades materially, load histories worsen, or the alternating wake and reflected steering response are not preserved
