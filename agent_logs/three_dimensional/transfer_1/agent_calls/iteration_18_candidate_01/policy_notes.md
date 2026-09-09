# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled evaluations use direct uniform still-water initialization
  with `U_infinity=(0,0,0)` and terminate in capture. The strongest finite
  comparator is `solver_6b0e320e2f55` (`-0.15140`, `18.6010T`); the assigned
  prefill `solver_29faa601686c` is the informative mechanism comparator
  (`-0.16296`, `18.6065T`). The other two exact-byte speed-reserve repeats
  capture at `18.2050--18.3205T`.
- Both combined keyframe sheets were inspected in both views. In the top-down
  row, each fish generates a continuous alternating red/blue wake, turns
  broadly toward the target, and continues laying down vortices through the
  terminal approach; there is no visual carrier collapse or passive coast.
  In the oblique row, compact alternating Lambda2 structures remain attached
  to the posterior wave and trail in a coherent three-dimensional chain to
  capture. The visible routes and wake topology are closely matched, so the
  score difference is not evidence for a new propulsion regime.
- The three exact `567de354...` speed-reserve samples capture at
  `0.7466--0.7494L`, with action clamp fractions about
  `68.5--68.7%/70.6--71.0%` and speed-limit residence about
  `10.4--10.6%/11.3--11.6%`. The `034c915d...` prefill capture has essentially
  the same `68.8%/71.0%` clamping and `10.5%/11.5%` speed residence, while its
  mean distance is worse (`2.0503L` versus `2.0387--2.0456L`). Thus neither
  more carrier suppression nor replay of the prefill is supported.
- Inherited optimizer evidence also shows that replacing the terminal error
  with signed projected miss was unreliable and that carrier-signed
  half-cycle redistribution retained an active wake but missed below. The
  reusable baseline is therefore the achieved-course/intercept controller
  with sparse outward-carrier reserve and phase-independent additive steering.

## Candidate hypothesis

Restore the three-repeat intercept-guarded speed-reserve policy, then add one
small terminal mechanism: when projected geometry already indicates an
approaching pass inside the capture corridor and the phase-compensated yaw
response is already in the requested direction, apply a bounded mean-curvature
brake opposite the route request. The brake is smoothly normalized by the
existing response and intercept gates. It cannot act in the far field, cannot
replace the propulsive carrier, and cannot act while projected miss says full
correction is still needed. This tests whether excess correct-sign yaw at the
last pass can be damped without the previously harmful carrier-phase
redistribution.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop turning and terminal approach control
source_mechanism: sensor-gated mean-curvature modulation with near-target yaw damping
transferable_invariant: add a bounded feedback bend only after the observed turn response and approach geometry indicate that braking, rather than more route authority, is needed
nontransferable_details: published gains, robot or species kinematics, clock-driven CPG phase, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target/velocity projection, the joint-state-compensated yaw response, and the existing two-joint steering shares to gate a small response-opposing acceleration while preserving the traveling-bend carrier
falsification: reject if capture is lost, arrival or distance integral worsens beyond the sampled repeat spread, the coherent top-down or oblique wake weakens, clipping or loads rise, or the same below-target exit topology returns

The current candidate has no same-worker CFD evidence. Its evaluation must be
judged against the three exact-byte captures and their secondary-metric spread.
A dry replay of only the new gate on those recorded baseline trajectories
activates the brake on `3.9--7.7%` of rows, first at `2.53--2.71L`, and never
exceeds `2.36 rad/T^2` against its `2.40` bound. This confirms that the edit is
inactive in the far field and materially exercised near the pass; it does not
predict the coupled CFD outcome.
