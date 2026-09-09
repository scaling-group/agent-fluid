# Wake-policy diagnosis and candidate hypothesis

The four sampled evaluations are valid direct-uniform still-water rollouts and
all capture. The combined top-down and oblique sheets show self-propelled
motion, a coherent alternating three-dimensional wake, and the same smooth
late hook into the target rather than passive advection or a wake breakdown.
The response-aware wave handoff (`solver_a47435301f18`) is the best finite
sample at `19.338T`, distance integral `2.07622L`, head path `12.304L`, and
sub-`2L` mean body-lateral speed `0.099U`. It also preserves the sampled load
class (`0.02535/0.01335` peak planar force/yaw moment coefficients). However,
the byte-identical distance-only handoff repeats (`solver_2dfe05597921` and
`solver_b5fc80fd779c`) span `19.354--19.613T`, `2.07892--2.09432L`, and
`12.416--12.554L`, so the response-aware result does not establish a causal
timing improvement outside solver variation. The response-gated posterior
counterturn (`solver_1af6c62469a7`) is shorter-path (`12.052L`) but uses more
anterior command (`19.251 rad/T^2`, `37.07%` above 90% of the smooth bound) and
has a worse distance integral (`2.08911L`), arguing against another mean-bend
residual.

Candidate hypothesis: retain the complete capture scaffold and the prefilled
response-aware posterior allocation, but apply the same measured-response idea
to a different actuator channel. While closing inside the existing approach
region, agreement between the reflection-equivariant body-frame turn request
and recent yaw response will continuously release only the joint-phase half-
cycle steering scale shared by the two joints. Baseline mean curvature,
terminal velocity-course redirect, drive relief, and the state-feedback
traveling wave remain active. This should avoid feeding an already-established
turn, reduce late path/slip and anterior near-bound command residence, and
preserve the early `10/8/6L` progress and capture topology. The mechanism is
falsified if capture is lost, the coherent
wake or early milestones regress, or timing/integral, path, command residence,
joint/rate margin, or force/moment loads fail to improve beyond the broad exact-
handoff repeat envelope.

A read-only signal replay on the response-aware parent trajectory confirms the
new gate is selective but nontrivial: inside `6L` its approximate mean/maximum
weight is `0.083/0.315`, it exceeds `0.10` on about `36%` of approach samples,
and therefore attenuates the half-cycle asymmetry by at most about `20.5%` for
the selected bound. This is an activation audit, not evidence of candidate CFD
performance.

bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG steering
source_mechanism: apply transient asymmetric curvature for redirect, then release it into the propulsive posterior beat when heading response appears
transferable_invariant: measured agreement between a target-relative turn request and yaw response can continuously reduce transient steering-wave asymmetry without removing the traveling bend
nontransferable_details: species-specific C-start shapes, published CPG gains, dimensional timing, exact vortex phase, and task-specific routes
policy_translation: multiply only the existing joint-state half-cycle asymmetry by a bounded release gate from normalized approach distance, positive closing response, and signed turn-request/yaw agreement; preserve mean curvature and posterior propulsion
falsification: reject if the candidate loses capture or early progress, breaks wake coherence, or does not reduce approach path/slip or actuator cost without worse distance integral, timing, margins, or loads beyond exact-policy repeat variation
