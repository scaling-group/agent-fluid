# Candidate diagnosis and hypothesis

The four sampled rollouts are valid direct-uniform still-water evaluations
(`U_infinity=(0,0,0)`), and all terminate by capture near `23.35T`.  In both
the best-score and lower-score combined sheets, the fish is self-propelled: a
compact alternating mid-plane wake appears by `4T`, lengthens coherently
through the nearly straight transit, and remains organized through the late
target turn.  The oblique Lambda2 row agrees that vortices originate at the
moving tail rather than from background advection.  No sampled rollout is a
semantic failure; the least favorable sampled result is therefore useful as a
lower-efficiency comparison rather than as a miss.

The sampled acceleration-clamped cadence controller and the corresponding
unclamped cadence controller are trajectory-identical and score `-0.5152775`,
confirming that duplicating the episode's independent acceleration clamp is
not a controller improvement.  By contrast, the rate-governed variant keeps
capture, improves score to `-0.5127478`, shortens center path length from
`13.4189L` to `13.3177L`, reduces maximum joint angles from `27.61/37.19 deg`
to `27.48/36.75 deg`, and reduces RMS yaw rate from `1.5749` to
`1.5537 rad/T`.  It nevertheless leaves the anterior joint above 96% of the
rate limit for `15.68%` of samples and at the logged acceleration ceiling for
`69.61%` of samples.  The evidence supports retaining the selective
speed-increasing acceleration governor but moving a small part of the response
upstream into the rhythmic carrier.

Policy hypothesis: use normalized maximum joint-rate utilization to withdraw
only the *extra* progress/capture cadence boost before the state-feedback
oscillator is evaluated.  The baseline cadence, odd body-frame
target-to-curvature map, half-cycle steering, and full deceleration/reversal
authority remain unchanged.  This should avoid commanding an accelerated beat
when either joint lacks rate headroom, preserve the visible traveling wake,
and reduce path/yaw waste without turning terminal drive off.  Falsify the
candidate if it loses capture, increases arrival time or distance integral
enough to erase the rate-governor gain, increases rate-limit residence, or
breaks the coherent alternating wake.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and classical traveling-wave propulsion
source_mechanism: sensor feedback modulates rhythmic cadence while posterior lag preserves a directed traveling bend
transferable_invariant: change carrier cadence from observed actuator headroom while retaining the joint-state phase relation and target-directed mean curvature
nontransferable_details: published CPG gains, dimensional frequencies, species envelopes, full-body waveforms, and prescribed vortex phase
policy_translation: smoothly suppress only the above-baseline frequency boost as max(abs(phi_dot))/joint_rate_limit approaches one; keep body-frame guidance and two-joint state feedback
falsification: reject if capture, distance integral, path length, joint-rate residence, or top-down and oblique wake coherence worsen relative to the sampled rate-governed controller
