# Candidate diagnosis and hypothesis

The two repeated assigned-policy evaluations (`solver_b3cc38ade37a` and
`solver_7e2b89182e53`) byte-match the prefilled policy and visual sheet. Both
direct-uniform, zero-inflow runs capture at `0.748598L` and `25.5090T`. Their
top-down rows show self-propulsion with a coherent alternating vortex street,
useful upstream translation, and a late target-side hook; the oblique rows
confirm that the wake stays three-dimensional and organized through capture,
rather than showing passive advection or a moving-window artifact.

The informative weak sample (`solver_2f617353199f`) retains the same visual
topology but adds posterior coupling to the upstream anterior duty mechanism.
It is worse at `8/16/24T` (`10.3260/5.9085/1.5132L` versus
`10.3083/5.8980/1.4748L`), captures `0.099T` later, and raises mean distance
from `2.45777L` to `2.46195L`; its similar peak planar force and yaw moment
(`0.02023/0.01043`) do not reveal a compensating load benefit. The simpler
`solver_ab218bebf730` is identical to the assigned policy through `16T`, then
reaches `1.45439L` at `24T` and captures `0.1485T` earlier without the sampled
middle sideslip/force additions. Its score is only `0.00055` lower and both
visual rows remain in the same shallow-hook family. All four summaries confirm
uniform direct initialization with `U_infinity=(0,0,0)`, capture termination,
and no instability. Across the traces, joint angle, speed, and policy command
peak near `0.771rad`, `4.518rad/T`, and `29.87rad/T^2`, below their hard
limits; added authority is therefore not justified merely by nominal command
headroom.

The candidate will preserve the coherent carrier, redirect, target-line
response, upstream anterior duty asymmetry, posterior vectoring, the prefilled
middle residuals, and all viability guards so this rollout isolates one new
mechanism. It will introduce a response-released duty mechanism: smoothly extend
anterior half-cycle dwell from the far-course handoff into the middle-distance
band only when the body-frame course request and inertial target-line request
agree, closing translation is observable, and the existing yaw-response
deficit remains positive. Agreement and response gates keep target geometry in
charge of side; the mechanism passes through in conflict, adequate-response,
redirect, near-capture, and weak-translation states. The hypothesis is that a
response-gated extension will create useful route separation between `16T`
and `24T` without the failed posterior duty coupling or an instantaneous force
command.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and asymmetric flapping, combined with response-released burst turning
source_mechanism: sensor feedback modulates rhythmic duty asymmetry and releases steering once the requested turn response appears
transferable_invariant: preserve the propulsive rhythm, let normalized target geometry own steering side, and condition extra rhythmic asymmetry on measured response rather than elapsed phase or fixed duration
nontransferable_details: published gains, clock-driven oscillator phases, robot-specific linkage kinematics, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: extend the existing body-frame course-side anterior duty asymmetry only across the middle handoff when course and inertial target-line sides agree and the normalized yaw-response deficit is positive; preserve the posterior carrier and withdraw before capture
falsification: reject if capture is lost, the `16--24T` route does not separate usefully, arrival or mean distance worsens, the coherent two-view wake degrades, or angle/rate/acceleration contacts or a new force/moment regime appear

## Non-CFD frozen-trace audit

Reconstructing the new gates on the duplicated prefill trace shows that the
branch is inactive outside its intended handoff and is materially exercised:
it exceeds `0.01` on 197 sampled rows from about `16.79T` to `20.10T`
(`5.44L` to `3.61L`), peaks at `0.579`, and contributes at most
`3.38rad/T^2` before the inherited coordinated soft envelope and angle/rate
guards. This audit checks reachability and locality only; it is not CFD evidence
and does not predict the new trajectory or claim improvement.
