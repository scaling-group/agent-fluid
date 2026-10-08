# Wake-policy candidate notes

## Evidence diagnosis before editing

All four sampled evaluations satisfy the Phase-2 flow contract: direct uniform
still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no prewarm
snapshot, and complete combined keyframe sheets. No sampled rollout is a
semantic failure; I therefore compared the strongest finite capture
`solver_3e8ee72bb918` with the lower-scoring captured prefill
`solver_fb3dd7355a7f`, the matching policy-clamped rollout
`solver_ee4561476853`, and the base signed-curvature capture
`solver_bfe9ef100c67`, while using the inherited optimizer logs for the earlier
route failures.

- In both the top-down vorticity and oblique body/Lambda2 rows, the prefill and
  strongest sample self-propel along essentially the same broad, continuously
  closing turn. Both retain an organized alternating three-dimensional caudal
  wake through capture; neither shows passive advection, wake collapse, a
  terminal overshoot, or an out-of-plane instability. This supports preserving
  the signed-curvature guidance, course-aligned terminal cadence, and
  joint-state traveling-wave carrier.
- The assigned-parent and inherited notes establish why that route should not
  be redesigned: same-sign odd posterior mean curvature converted the original
  lower-boundary miss into capture, while one-sided redirect and generic
  steering-reserve mechanisms produced upper- or lower-boundary exits with
  much larger loads. The later cadence gate improved score only modestly and
  did not shorten arrival, so another cadence scalar is not an evidence-backed
  mechanism.
- The prefill captures at `23.3585T`, score `-0.51527750`, mean score-distance
  `2.412601L`, and final distance `0.746966L`, but observed joint rates occupy
  at least `99.9%` of the fixed rate limit in `9.09%/1.62%` of samples and peak
  at `260/260 deg/T`. Merely adding the fixed symmetric acceleration clamp is
  a demonstrated applied-motion no-op: `solver_ee4561476853` and the unclamped
  prefill have identical trajectory, force, termination, and score.
- The state-aware rate governor in `solver_3e8ee72bb918` is the strongest
  sampled result. It preserves capture and the visible wake, improves score to
  `-0.51274776` and mean score-distance to `2.409486L`, reduces peak speed from
  `0.7515` to `0.7428 L/T`, reduces peak joint angles from `27.61/37.19` to
  `27.48/36.75 deg`, and eliminates sampled `99.9%` rate-limit residence while
  keeping peak planar force/moment at or below the prefill scale. It arrives
  one `0.0055T` step later and crosses at `0.749951L`, so the evidence supports
  actuator-feasibility and integrated-distance improvements, not faster or
  deeper capture.

## Candidate hypothesis

Adopt exactly the sampled rate-envelope governor on the captured prefill. Keep
the existing normalized body-frame target guidance, odd bounded mean
curvature, half-cycle steering, terminal cadence gate, and state-feedback
traveling wave unchanged. Clamp each requested joint acceleration to the
policy-owned fixed envelope, then use normalized observed joint-rate magnitude
to smoothly withdraw only acceleration that would increase the same signed
joint speed above a `0.96`-limit onset. Opposing acceleration remains fully
available for phase reversal and steering recovery.

The next rollout should preserve the demonstrated capture topology and compact
alternating wake while reproducing lower rate-envelope residence and no worse
integrated distance or load scale. Falsify the transfer if capture is lost,
the trajectory or wake changes materially, rate-limit residence returns, or
arrival/distance/load metrics worsen beyond the small sampled tradeoff. Do not
claim held-out robustness or energetic efficiency from this one fixed-case
comparison.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and actuator-aware undulatory control
source_mechanism: preserve a traveling propulsive rhythm while measured joint state continuously gates effort near a response boundary
transferable_invariant: unavailable speed-increasing effort should vanish smoothly near a normalized actuator limit while opposing reversal authority remains intact
nontransferable_details: published CPG gains, dimensional beat frequencies, species-specific envelopes, exact Strouhal values, clock phase, vortex phase, and task routes
policy_translation: normalize each observed joint rate by policy-owned limits and smoothly attenuate only same-direction acceleration under the existing two-joint state-feedback oscillator
falsification: reject if capture, integrated distance, loads, or wake coherence degrade materially, or if measured rate-limit residence is not reduced
