# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes. It is byte-identical across the
sampled solvers, so it anchors the disturbance field rather than distinguishing
policy behavior.

The three byte-identical strongest sampled policies immediately redirect
toward the target, sustain a coherent posterior traveling bend, and follow a
compact upstream-left diagonal before entering the second-row wake corridor.
They reproducibly cross the `0.75L` target boundary after `43.9505`, with
`2.1391L` mean distance. Mean velocity `(-0.2471,-0.1020)` differs materially
from mean local flow `(-0.1342,-0.1556)`, especially in the upstream component,
so the visible closure is active swimming rather than passive advection. The
same rollouts touch both joint-rate and acceleration envelopes, however, with
RMS relative crossflow, lateral force, and yaw moment of `0.2111`, `49.44`, and
`701.26`.

No current sampled solver is a semantic failure. The most informative sampled
contrast adds joint-rate phase lead to the target-favored posterior half-cycle.
Its sheet retains essentially the same route and reaches after `43.9780`, but
RMS crossflow rises to `0.2136`, force to `53.18`, moment to `736.58`, and both
rate and acceleration envelopes remain touched. Moving the half-cycle in local
oscillator phase therefore has no evidenced load or capture benefit.

The inherited logs supply the failure boundaries and the useful structural
contrast. A raw normalized yaw-moment residual still captured but delayed
arrival to `45.1935`, raised mean distance to `2.1965L`, and increased RMS
force/moment to `71.51/957.29`; its instantaneous sign is not calibrated for
disturbance rejection on this carrier. The earlier target-blind seed and an
excess-static-curvature variant were instead advection-dominated domain exits,
so weakening the traveling wave or adding average curvature is also excluded.
In contrast, the assigned parent's alignment-gated posterior outward-rate
projection preserved the direct topology and reached after `44.0220`, only
`0.0715` later and `0.0027L` worse in mean distance, while reducing RMS
crossflow to `0.2102`, force to `44.86`, and moment to `663.89`. Continued cap
contact limits the claim to distributed load shaping, not peak-rate avoidance.

## Policy hypothesis before the edit

Preserve the current anterior oscillator, bounded body-frame bearing
curvature, target-favored posterior half-cycle, posterior lag, and smooth
distance-conditioned amplitude envelope. Add one terminal load-shaping
mechanism: reuse the evidenced direction-aware posterior outward-rate
projection, but multiply it by the complement of the existing smooth approach
blend. The projection is therefore exactly inactive outside the normalized
`2.5L` approach neighborhood and during large bearing error. Inside that
neighborhood, it removes only acceleration that would push an already
near-envelope posterior rate farther outward; every reversal acceleration
remains unchanged.

This tests whether the parent's small arrival penalty came from applying load
relief throughout the aligned traverse. Expected evidence is the sampled
carrier's early redirect and direct `43.95`-class capture, with terminal
force/moment or mean command between the unguarded carrier and the globally
guarded parent. Falsify the mechanism if capture is lost or materially delayed,
the compact route changes before the approach neighborhood, reversal weakens,
or load/effort remain indistinguishable from the unguarded carrier. Continued
rate-cap contact alone is not evidence for threshold tuning.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and terminal closed-loop robotic-fish target capture
source_mechanism: preserve the posterior traveling wave for transit, then reduce excess actuator drive near capture without removing steering or reversal authority
transferable_invariant: retain bounded target-directed propulsion at large normalized range and direction error, while a smooth near-target gate may remove only acceleration that reinforces an already near-envelope posterior rate
nontransferable_details: published gains and rate envelopes, dimensional timing, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, capture route, and the task's absolute target coordinates
policy_translation: derive transit-to-approach blend from normalized distance, alignment from bounded body-frame bearing, and outward motion from normalized posterior rate; project only the jointly gated outward component of posterior acceleration
falsification: reject if the early route changes, direct capture is delayed or lost, reversal authority weakens, or the inherited load reduction disappears completely when localized to approach
