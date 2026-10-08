# Candidate wake-policy notes

## Evidence diagnosis before policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract
  (`U_infinity=[0,0,0]`, no prewarm) and capture between `26.2405T` and
  `26.3615T`, with final distances `0.748338--0.748829L`.
- The top-down rows show self-propelled motion with a coherent alternating wake
  from release through a common late upward hook. The oblique Lambda2 rows show
  that the three-dimensional wake remains organized during the approach; there
  is no visible loss of propulsion, wake breakup, collision, or domain exit.
- The best scalar sample, `solver_8e7135ef9173`, uses translational
  line-of-sight rotation to qualify steering side and captures at `0.748338L`
  and `26.2460T`. The assigned parent captures at `0.748792L` and `26.3615T`.
  Their largest sampled centerline separation is only `0.0566L`, so this is a
  finite fixed-pose improvement, not a new trajectory class.
- Every sample has zero angle, rate, and acceleration contacts. Peak planar
  force is identical at `0.018834`, peak yaw moment is `0.009789--0.009903`,
  and the `8T/16T` distances are identical to shown precision. The remaining
  opportunity is therefore route-observer semantics during the middle/late
  approach, not more propulsion, terminal amplitude, or actuator relief.
- Inherited guidance reports that the folded bearing-plus-turn estimate has
  gait-frequency sign changes and about `3.18 rad/T` RMS in the `4.5--1.75L`
  band, while normalized translational line-of-sight rotation keeps one sign
  and has about `0.144 rad/T` RMS. Side qualification produced the best sampled
  result without a semantic clearance improvement; carrier relief and
  alternative residual arbitration did not improve the topology.

## Policy hypothesis

Start from the best sampled translation-consistent policy. Preserve its
state-feedback oscillator, posterior traveling-bend target, same-sign redirect,
capture-gated posterior modulation, command-ratio governor, and joint viability
guards. Add one bounded observer-allocation mechanism: when translation is
observable, the target is inside the evidenced `4.5--3.0L` handover, and the
history and translational line-of-sight observers request the same turn side,
blend desired yaw-response magnitude from the gait-contaminated history
estimate toward the normalized translational estimate. Startup, far travel,
observer disagreement, adequate measured yaw response, and non-closing states
remain pass-through. This should reduce tail-beat-frequency over-request without
weakening the coherent carrier or changing the calibrated steering side.

Falsify the mechanism if formal CFD loses capture or wake coherence, raises
limit/load exposure, produces persistent under-response, or remains in the
same shallow late-hook topology without a meaningful clearance, arrival, or
trajectory improvement. In that case later workers should not scalar-tune the
observer blend; they should seek a separately observed route-response variable.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG steering with sensor feedback
source_mechanism: use route feedback to modulate a rhythmic steering command while preserving the propulsive oscillator
transferable_invariant: persistent observed route response should qualify steering demand, while joint-state phase preserves the traveling carrier
nontransferable_details: published CPG gains, oscillator networks, robot morphology, species kinematics, dimensional frequencies, and task routes
policy_translation: blend normalized body-frame translational and history line-of-sight response magnitudes only in reliable agreeing states, then apply the result through the existing anterior half-cycle residual
falsification: reject if capture, coherent wake, or limit-free operation is lost, or if the trajectory remains milliscale-equivalent without better clearance or arrival
