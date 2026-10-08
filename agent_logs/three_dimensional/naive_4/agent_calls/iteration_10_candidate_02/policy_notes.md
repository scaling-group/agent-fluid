# Candidate diagnosis and hypothesis

All four sampled evaluations satisfy the direct-uniform still-water contract
(`U_infinity=0`, no prewarm) and terminate in capture. In both the top-down
mid-plane and oblique Lambda2 rows, they are visibly self-propelled: the body
develops a traveling bend and sheds a coherent alternating wake that persists
through the turn and approach. No sheet shows passive advection, a wake
collapse, an upper-boundary excursion, or three-dimensional instability. The
useful failure comparison is therefore the weakest control ablation rather
than a termination failure.

The prefilled bounded bearing-rate lead and the response-gated terminal wave
unload do not change the transit: both share the closing-continuity policy's
`5L`, `2L`, and `1.2L` crossings at `12.177T`, `15.026T`, and `15.796T`, and
all three capture at `16.225T`. They only perturb the final crossing geometry,
with scores `-0.065510` and `-0.064416` versus `-0.063208`; posterior
acceleration-limit residence also remains essentially `21.3%`. The combined
keyframes agree that their wakes and approach topology are nearly
indistinguishable, so neither terminal-only change supplies evidence for a
better controller mechanism.

The carrier-phase-residual sample is materially different. It retains the
same coherent two-view wake but begins a different useful trajectory before
the terminal regime, reaching `5L`, `2L`, and `1.2L` at `12.106T`, `14.905T`,
and `15.637T`, then capturing at `16.044T` with the best sampled score
`-0.058311`. Its posterior limit residence is `22.7%`, close to the other
allocated variants, while maximum planar force and moment remain comparable
(`0.0311` and `0.0194` in the reported normalized coefficients). This supports
selecting the phase-residual architecture over stacking another approach
modifier. The new rollout is still unevaluated; the candidate hypothesis is
that replaying this mechanism from the sampled winner will reproduce its
earlier useful route and capture without sacrificing the alternating 3D wake.

bookshelf_consulted: true
source_domain: robotic-fish CPG feedback and wake-disturbance control
source_mechanism: separate joint-encoded rhythmic phase from slower route feedback before modulating a high-authority command
transferable_invariant: fast beat-correlated lateral response should not be treated as persistent target-course error
nontransferable_details: published CPG gains, species envelopes, dimensional beat settings, exact vortex phase, and task-specific routes
policy_translation: partially residualize target-versus-course error with normalized anterior joint angle and velocity only when selecting redirect duty; retain the raw body-frame response for turn sign and magnitude and preserve the evidenced carrier
falsification: reject if the formal rollout loses capture or coherent wake, delays the 5L/2L/1.2L milestones, materially raises load or limit residence, or fails to reproduce a meaningfully earlier useful trajectory than the terminal-only variants
