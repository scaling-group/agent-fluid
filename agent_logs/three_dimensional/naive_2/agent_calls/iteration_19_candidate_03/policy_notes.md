# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts report direct uniform initialization at
  `U_infinity=(0,0,0)` with no prewarm. The combined sheets were inspected in
  both their top-down mid-plane vorticity and oblique body/Lambda2 rows.
- The exact prefilled policy hash is represented by both
  `solver_d32fb3a02de7` and `solver_16135cb555bf`. Both self-propel along a
  direct targetward path, leave a compact alternating wake, remain stable, and
  capture at `0.749982L/15.9830T` and `0.747234L/15.9940T`. Their peak sampled
  planar force/moment magnitudes are about `0.0342--0.0367/0.0173--0.0185`,
  but each joint is above 95% of the rate envelope for roughly 18% of samples.
- `solver_aa2570fe3d2e`, which has predicted-miss curvature but no
  response-gated posterior pulse, preserves the same visible wake and also
  captures at `0.747725L/16.0105T`. This brackets the posterior pulse as a
  terminal refinement rather than the source of propulsion or route success.
- In the informative failure `solver_ec81137f627b`, proximity-triggered broad
  carrier reduction preserves a wake and leftward propulsion but bends into a
  large wrong-side/upward arc, reaches only `4.64998L`, and exits left at
  `20.0337T`; sampled joint angles touch both hard limits and peak normalized
  planar force/moment rise to about `0.620/0.261`. Thus carrier braking is not
  an acceptable route to rate reserve on this carrier.
- The inherited score log contains near-misses at `0.9631L` and `0.8100L`,
  followed by captures in steps 15 and 16 and renewed left-domain failures in
  steps 17 and 18. A reproduced nominal capture is real but does not justify
  replacing target/course prediction with an unconditioned terminal maneuver.

## Policy hypothesis

Preserve the complete predicted-miss carrier, mean-bend, and half-cycle route
controller. Change only the posterior mid-stroke terminal pulse so it is
recruited while carrier-separated yaw has not yet responded in the requested
direction, then fades continuously as corrective yaw appears. The simpler
no-pulse sampled controller already captures, so response release should keep
the semantic success boundary while avoiding redundant posterior steering in
the high-rate terminal beat. Reject this mechanism if it loses capture,
arrives later than the no-pulse reference, increases joint-rate occupancy or
loads, or produces a visibly less coherent wake.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG turning
source_mechanism: strong geometry-gated redirect is released when measured turning response appears, returning authority to the propulsive rhythm
transferable_invariant: recruit a bounded steering transient only while target error remains and the observed yaw response is not yet corrective
nontransferable_details: species-specific C-start shapes, published CPG gains, dimensional timing, exact vortex phase, and task-specific routes
policy_translation: multiply the normalized body-frame predicted-miss posterior pulse by the complement of the existing bounded carrier-separated corrective-yaw gate; retain the two-joint state-feedback oscillator and all far-field behavior
falsification: reject if capture is lost, arrival is slower than the sampled no-pulse policy, rate occupancy or loads increase, or the compact alternating wake and direct approach are not preserved
