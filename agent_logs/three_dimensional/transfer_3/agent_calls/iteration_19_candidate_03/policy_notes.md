# Response-reversing posterior phase candidate

## Visual and metric diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract,
  remain finite, and capture. Their top-down sheets show body-led motion with a
  coherent alternating vorticity street, and their oblique sheets show compact
  three-dimensional tail-associated structures that persist through capture.
  With zero imposed flow and local-flow RMS only `0.0178--0.0184U`, neither the
  translation nor the trajectory differences are moving-window advection.
- The strongest finite sample is the response-reversing half-cycle policy
  (`solver_85695f4d40af`): it captures at `18.931T`, scores `-0.15357`, and has
  action RMS `25.22/28.86 rad/T^2`, force/moment RMS `0.01357/0.00707`, and
  anterior/posterior acceleration-limit occupancy `44.8%/76.1%`. Its body and
  wake remain aligned with a direct approach in both views.
- The assigned-parent prefill is an identical half-cycle controller evaluated
  on a later rollout (`solver_6916fe380bcd`). It also captures, at `19.052T`
  and score `-0.16031`, with action RMS `24.85/28.75`, force/moment RMS
  `0.01330/0.00692`, and occupancy `42.6%/75.1%`. The timing spread between
  same-code samples is a warning not to infer a robust gain from one result.
- The sampled response-reversing phase extension (`solver_3ca4e16bfde3`)
  captures at `18.997T` and score `-0.15967`. Its two visual rows retain the
  alternating carrier and direct capture topology. It lowers action RMS to
  `24.55/28.59`, force/moment RMS to `0.01317/0.00685`, and occupancy to
  `41.3%/74.1%`. At `16T` it is vertically closer to the target line than the
  fastest half-cycle sample (`head_y=10.350L` versus `10.514L`) but slightly
  farther in total range (`2.889L` versus `2.834L`), so the evidence supports
  a distinct lower-demand useful trajectory, not proven faster arrival.
- The informative regression is instantaneous slow-curvature allocation
  (`solver_909fc51efdc1`). Although its wake is still coherent and it reduces
  action/load RMS further, it is behind by `16T` (`3.096L`) and captures only
  at `19.239T`, score `-0.17198`. Assigned-parent and inherited logs agree:
  another range gate or memoryless curvature allocator can weaken continuous
  route closure and is not justified by effort reduction alone.

## Policy hypothesis recorded before editing

Preserve the normalized body-frame bearing plus rotation-invariant LOS-rate
request, recoil-conditioned yaw response, continuously recruited anterior and
posterior mean curvature, response-reversing half-cycle scale, and explicit
componentwise acceleration projection. Add the one sampled phase mechanism:
rotate the two posterior traveling-wave coefficients at fixed coefficient norm
by a bounded angle selected from yaw-response error and observed joint phase.
This changes when the posterior bend is produced without increasing the wave
coefficient norm, and reverses continuously when measured yaw outruns demand.

The prior identical phase-policy rollout is evidence for materializing this
candidate, but the new CFD evaluation will occur only after this worker exits.
Treat the candidate as a load-aware trajectory alternative. Falsify it if the
new rollout loses capture, arrives after the `19.239T` allocation regression,
loses the alternating wake, exceeds `76.1%` posterior limit occupancy, or
exceeds force/moment RMS `0.01357/0.00707`. Replication at or before the
`18.931--19.052T` half-cycle band would be required before calling phase
rotation an arrival improvement.

bookshelf_consulted: true
source_domain: sensor-conditioned robotic-fish CPG direction tracking and posterior phase-lag modulation
source_mechanism: encode steering through a bounded phase change of the propulsive rhythm while preserving the carrier
transferable_invariant: preserve traveling-wave magnitude and use observed route error plus measured response to reverse a bounded posterior phase correction
nontransferable_details: published gains, robot linkage geometry, species kinematics, dimensional frequency, clock phase, exact vortex phase, and task-specific routes
policy_translation: rotate the joint-state posterior position and velocity coefficients at fixed norm using normalized body-frame LOS demand, recoil-conditioned yaw error, and observed joint phase before the two-joint acceleration projection
falsification: reject if capture is lost or later than 19.239T, wake coherence degrades, posterior occupancy exceeds 76.1%, or force/moment RMS exceed 0.01357/0.00707

## Validation status

- The configured guidance semantic check and solver boundary check pass.
- Static auditing confirms every direct `params.FIELD` reference is returned by
  `target_policy_params()`, and the solver candidate is byte-identical to the
  evaluated phase-policy sample (SHA-256 `e6ec8938802ac8a1031b53f804018025245fe6e2795bbaaac07450488a1622f7`).
- The required Julia smoke command was invoked by the configured check-runner,
  but this image has no `julia` executable. No CFD was run and no result from
  the new evaluation is claimed.
