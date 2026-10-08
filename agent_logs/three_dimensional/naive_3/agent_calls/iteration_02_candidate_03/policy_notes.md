# Multi-wake target-policy candidate notes

## Inherited evidence diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, zero cylinders, no prewarm, and moving-window
  transport. Their motion and wakes are therefore self-generated rather than
  ambient advection.
- The strongest finite example, `solver_7afa3aa3b5d0`, preserves a coherent
  alternating wake in both the top-down vorticity and oblique Lambda2 rows.
  Its posterior-only mean-curvature loop produces sustained leftward travel:
  minimum/final distance is `9.141L`, center x reaches `16.396L`, and survival
  extends to `13.129T`. This is materially more useful than the other sampled
  paths even though it does not capture the target.
- That example still has the same terminal steering topology as the assigned
  parent `solver_f222e3379ba1` and the other posterior-only candidate. Its
  body-frame bearing starts at `+0.155 rad`, first crosses zero at about
  `3.73T`, and ultimately diverges to `-1.330 rad`; center y rises to
  `15.201L`, causing an upper `left_domain` exit. The parent similarly ends at
  bearing `-1.163 rad`, center y `15.200L`, and `left_domain` at `9.191T`.
  Thus bearing/yaw-trend release did not actually reverse the accumulated turn.
- The informative failure `solver_54567b011e84` biases both joint centers.
  Its visual sheets show little translation or organized shed wake through
  the early and middle frames, followed by a broad energetic hook. Trace data
  agree: joint amplitudes collapse to only `8.0/11.0 deg`, minimum progress is
  `0.036L`, final distance regresses to `13.403L`, and it exits at
  `10.747T`. Distributing static curvature into the anterior oscillator is
  therefore harmful in this carrier.
- The productive posterior-only examples retain large joint motion and strong
  alternating wakes, but the strongest also requests acceleration beyond the
  nominal envelope on about `78%` of trace samples and touches a joint-rate
  limit on about `9.5%`. The next intervention should not increase oscillator
  gains or add an unbounded acceleration residual. Local crossflow remains
  small (`<=0.0161U`) in every zero-cylinder rollout, so wake-cancellation
  feedback is not supported by this evidence.

## Policy hypothesis

Preserve the strongest example's anterior Van der Pol carrier, cadence, and
posterior phase-lag scaffold, but remove its static posterior mean-curvature
offset. Translate target error into bounded posterior half-cycle amplitude
asymmetry: infer the current posterior-wave side from the phase-lag target,
then strengthen the half-cycle bending toward the requested curvature and
weaken the opposite half-cycle. Bearing plus its short observed trend remains
only the body-frame turn request; the new actuator mapping is rhythmic rather
than a held bend.

This should retain the coherent propulsive wake while giving a reversed
bearing command a cycle-by-cycle way to reverse the yaw response. Falsify the
candidate if bearing again diverges after its first zero crossing, the same
upper-boundary exit persists without materially better distance/survival, the
leftward carrier degrades, or posterior angle/rate/load saturation increases.

bookshelf_consulted: true
source_domain: robotic-fish CPG steering by asymmetric flapping and biological tail-beat turning
source_mechanism: sensory-error modulation of opposite propulsive half-cycle amplitudes
transferable_invariant: preserve the rhythmic traveling-bend carrier while a signed body-frame direction error redistributes effort between opposite bend half-cycles
nontransferable_details: published gains, clock-driven phase, species-specific envelopes, dimensional cadence, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: use bounded bearing plus bearing-window trend as the turn request, infer posterior beat side from the state-derived lag target, and oppositely scale its two half-cycles inside the damped second-joint tracker
falsification: reject if target-bearing reversal still fails to reverse the accumulated turn, if the coherent wake or leftward progress collapses, or if posterior saturation and loads grow
