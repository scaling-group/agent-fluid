# Candidate diagnosis and policy hypothesis

All four sampled evaluations report direct uniform initialization with
`U_infinity=(0,0,0)`, so their displacement is self-propulsion rather than
background advection. I inspected the combined top-down vorticity and oblique
Lambda2/body sheets for the strongest rollout (`solver_adc862529891`), the
assigned prefill (`solver_19f251537923`), and the early-turn failure
(`solver_2bf5e06dbda4`). The strongest rollout retains a coherent alternating
posterior wake and advances strongly in world -x, reaching `5.658L`, but it
does not bend its trajectory downward toward the target: center y rises from
`14.00L` to the upper exit at `15.20L` by `16.77T`. The inherited prefill also
has a coherent propulsive wake, but arcs too far downward: it reaches `6.138L`
at `16.51T`, regresses to `10.460L`, and exits the lower boundary at `26.15T`.
Thus the carrier is useful while both steering topologies fail through
unbraked lateral motion of opposite sign.

The strongest trace makes the missing separation measurable. Target bearing
changes from `+0.155 rad` initially to `-0.193 rad` at `6T`, yet body-frame
lateral velocity later reaches `+0.442 U` at `10T` and `+0.628 U` at `12T`
while the fish continues toward the upper boundary. Its instantaneous yaw
rate is dominated by the carrier: raw yaw-rate RMS is `2.250 rad/T`; the
sampled one-joint correction `heading_rate + 0.47*phi_dot1` leaves
`1.054 rad/T`, whereas the evidence-fitted two-joint projection
`heading_rate + 0.82*phi_dot1 + 0.12*phi_dot2` leaves `0.281 rad/T`. This is
consistent across the other sampled traces in sign, and it explains why the
one-joint residual repeatedly mistakes beat recoil for a slow route response.
The two-joint compensated candidate must retain the sampled `0.55T`,
`28 degree` state-feedback traveling-bend carrier, use target bearing minus a
speed-gated body-slip angle as the slow route error, and apply the resulting
yaw-rate residual only through bounded posterior mean curvature.

Expected evidence: compared with `solver_adc862529891`, bearing reversal and
positive body slip should produce an earlier positive-yaw brake, lower center
y below `14L`, extend survival beyond `16.77T`, and improve minimum distance
below `5.658L` without destroying the coherent wake. Falsify the hypothesis if
the same upper-exit topology remains, if correction reverses into the
prefill's lower-exit topology, or if propulsion/wake coherence collapses.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction control and tail-beat averaging
source_mechanism: sensor-feedback modulation of a propulsive rhythm through bounded mean-curvature or offset steering
transferable_invariant: keep rhythmic propulsion state-driven while a slower observed direction error modulates bounded mean curvature
nontransferable_details: published gains, clock-driven CPG phase, species-specific envelopes, dimensional rates, exact wake phase, and task routes
policy_translation: preserve the two-joint state-feedback carrier; form normalized body-frame bearing and speed-gated slip error, remove both joints' evidenced recoil from measured yaw, and command bounded posterior mean curvature
falsification: reject if lateral correction does not reverse the upper-going path, produces the inherited lower exit, or degrades the coherent self-propelled wake
