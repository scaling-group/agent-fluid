# Candidate diagnosis and hypothesis

## Prior evidence

All four sampled evaluations satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no prewarm, no cylinders, and finite capture. Their
combined sheets show body-led motion rather than advection: the top-down row
develops a coherent alternating reverse-street-like wake from release through
capture, while the oblique row shows a persistent three-dimensional Lambda2
chain attached to the swimming trajectory. There is no visible wake collapse,
collision, boundary approach, or isolated crossflow event immediately before
termination. The four policies therefore differ in route/actuator allocation,
not in the existence of propulsion.

The assigned parent, helpful-moment relief of half-cycle amplitude, is the best
sampled finite result: capture at `18.6560T`, score `-0.13321`, mean distance
`2.02115L`, acceleration-limit occupancy `41.19%/75.97%`, force/moment RMS
`0.01328/0.00691`, and local-flow RMS `0.01808U`. The actuator-consistent phase
baseline captures at `18.6725T` with `42.68%/76.41%` occupancy and
`0.01350/0.00703` loads. Requiring phase recruitment plus sign-coherent stress
before moment relief slows capture to `18.7440T`; regressing out instantaneous
joint-phase moment lowers occupancy/load to `41.73%/74.40%` and
`0.01309/0.00682`, but also slows capture to `18.7165T` and worsens mean
distance to `2.02337L`. These deltas are inside inherited same-hash timing
spread and do not justify another raw-moment allocator or scalar gain edit.

The remaining observable mismatch is semantic. The inertial route in both
visual rows is smooth, yet reconstructed instantaneous body-frame bearing on
the parent swings from about `+0.99` rad at `4T` to `-1.01` rad at `10T` and
back across zero, repeatedly saturating the slow bearing command. The policy
already treats `heading_rate + 0.82*phi_dot1 + 0.12*phi_dot2` as its slow yaw
response. Applying the integral counterpart to bearing changes representative
samples from `0.317` to `0.113` rad at `8T`, `-0.304` to `-0.007` rad at `12T`,
and `0.195` to `0.016` rad at `18T`, consistent with removing beat recoil rather
than weakening the target route.

## Policy hypothesis

Use `bearing + yaw_recoil_q1_gain*phi1 + yaw_recoil_q2_gain*phi2`, wrapped to a
signed angle, as the slow bearing and anterior redirect observation. Preserve
the rotation-invariant LOS rate, recoil-conditioned yaw-rate response,
response-reversing posterior phase recruitment, helpful-moment residual,
traveling-bend carrier, limits, and every evaluated scalar. This should reduce
carrier-phase steering chatter and unnecessary anterior saturation while
retaining the broad capture trajectory. It is falsified if evaluation loses
capture, arrives outside the inherited `18.656--19.008T` variation band,
weakens either wake row, exceeds `76.41%` posterior occupancy or
`0.01350/0.00703` force/moment RMS, or shows no material reduction in
beat-side route-command oscillation. A lower scalar alone does not establish
the mechanism; the conditioned bearing must change the command/trajectory or
load history as predicted.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and wake-interaction control
source_mechanism: separate slow persistent route error from fast gait- or wake-induced oscillation before modulating the rhythmic actuator
transferable_invariant: demodulate rhythmic body recoil from the route observation while preserving the propulsive carrier and a separately observed physical response
nontransferable_details: published gains, species-specific joint envelopes, clock-driven oscillator phases, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target geometry and observed joint angle to form a reflection-equivariant slow bearing; retain LOS-rate and two-joint state feedback for physical response and actuation
falsification: reject if capture or wake coherence is lost, arrival leaves the replicated timing band, loads exceed the sampled baseline, or bearing-command oscillation is not reduced
