# Phase 2 wake-policy candidate notes

## Evidence diagnosis before policy editing

- All four sampled rollouts satisfy the frozen flow contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and `capture` termination. There is therefore no sampled failure
  sheet; I compared the best finite capture with the weakest-score capture and
  used the inherited `1.01--1.22L` left-exit repeats as the failure boundary.
- In both rows of all four combined keyframe sheets, the fish self-propels from
  the quiescent field on essentially the same direct down-left route. A compact
  alternating mid-plane wake forms by `4--6T`, while the oblique views retain
  localized three-dimensional posterior structures through capture. The weak
  and strong scores show no advection, wake breakup, broad loop, boundary
  contact, or numerical instability. This supports preserving the oscillator,
  posterior lag, and far-field steering rather than changing carrier gains.
- The unified response-plus-miss prefill remains the strongest sample: it
  captured at `15.5008T`, scored `-0.02109`, and had distance integral
  `1.90236L`. The assigned parent's carrier-insensitive terminal observation
  also captured, but at `15.7735T` and `-0.02195`; it ended at heading
  `0.706rad` with velocity `(-1.016,-0.691)U`, versus `0.259rad` and nearly
  horizontal `(-1.286,-0.014)U` for the prefill. Active yaw arrest and
  geometry-qualified release likewise captured at `15.8061T` and `16.0270T`
  without a new route or wake class. All four reached the acceleration cap,
  retained roughly `17--18%` per-joint near-rate occupancy, and stayed in the
  same compact force/moment class. Thus replacing raw terminal pursuit with a
  common-rotation-invariant request did not reduce terminal phase spread or
  improve arrival, score, reserve, or loads; another observation blend or
  release/pulse refinement is not supported.
- Capture still occurs at substantial translational speed and at widely
  different beat phases. The inherited identical-controller left exits show
  that threshold crossing is not guaranteed even when the direct route and
  compact wake survive. The remaining shelf-compatible test is a true
  approach hold: reduce excess rhythmic drive only after proximity, reliable
  closing motion, and a centered predicted course agree, while immediately
  retaining full propulsion for a non-closing or off-center intercept.

## Single candidate hypothesis

Start from the strongest sampled unified response-and-geometry controller.
Preserve its far-field pursuit/course blend, constant-course predictor,
carrier-separated response gate, shared half-cycle handoff, terminal mean
bend and posterior pulse, oscillator frequency, posterior lag, and all
established steering gains. Add one continuous terminal amplitude-envelope
mechanism. A distance-only proximity gate is multiplied by normalized closing
speed, closing alignment, and the complement of bounded predicted-miss
magnitude. That consensus smoothly lowers only the anterior oscillator's
limit-cycle amplitude toward a bounded nonzero share; it does not remove the
restoring carrier or posterior traveling wave. Any loss of closing alignment
or increase in predicted miss restores the full carrier without a timer,
stage, route, or world coordinate.

The hypothesis is that a phase-preserving approach hold will keep the direct
capture route and compact wake while reducing terminal speed and joint-rate
occupancy enough to widen the `0.75L` crossing margin. Support requires
capture, or at minimum a closer pass with a better termination class than the
inherited `1.01--1.22L` left exits, together with no material loss of
far-field progress, wake coherence, or force/moment quality. Falsify it on a
miss, slower score without a margin/reserve improvement, early translation
loss, wake decoherence, persistent joint pinning, or failure to change
terminal speed and limit occupancy.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal capture scheduling
source_mechanism: preserve an autonomous propulsive rhythm while feedback continuously reduces excess drive during a centered closing approach
transferable_invariant: approach relief should require agreement among proximity, closing motion, and small target-relative course miss, and full propulsion should return when that agreement is lost
nontransferable_details: published CPG gains, robot linkage geometry, species-specific amplitude envelopes, dimensional frequency, clock phase, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target and velocity geometry plus distance to gate a bounded nonzero limit-cycle amplitude for the anterior oscillator while retaining the two-joint state-feedback carrier and posterior lag
falsification: reject if capture margin and termination do not improve together, or if arrival, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance degrades

## Dry validation boundary

The prescribed guidance-materiality, Julia policy-contract/schema, and solver
editable-boundary checks pass. A deterministic `72,900`-state grid over
normalized target geometry and velocity plus both joint angles, joint rates,
and yaw response produced finite commands strictly inside the smooth
`30 rad/T^2` envelope with exact left/right reflection (maximum error `0.0`).
Against the strongest sampled prefill, a constructed centered closing approach
changed the command by `0.03645 rad/T^2`, while a near-target receding state
changed it by exactly `0.0`; the new envelope is active and its closing-motion
fallback is algebraically intact. These checks do not predict CFD outcome.
Formal evaluation remains deferred to EvE after this worker exits.
