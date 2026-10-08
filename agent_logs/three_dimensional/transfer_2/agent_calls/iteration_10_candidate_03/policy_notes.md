# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts report direct uniform still-water initialization,
  `U_infinity=[0,0,0]`, no prewarm snapshot, and no numerical instability.
- In both the top-down vorticity row and oblique Lambda2 row, the assigned
  steering-priority parent (`solver_0c4c66457a74`) self-propels with a coherent
  alternating wake along the useful early diagonal. It stays on that diagonal
  too long, reaches only `1.07599L` at `25.98T`, executes a sharp upward pivot,
  and leaves the upper boundary at `37.82T`. The two terminal-only siblings
  preserve the same late turn and upper exit (`1.14825L` and `1.09231L` minima),
  so carrier unloading or recapture priority after the miss does not repair
  the missing route-scale correction.
- The sampled course-preview policy (`solver_6e00d384ddf6`) visibly bends the
  trajectory toward the target before the hard terminal pivot while retaining
  a coherent, self-propelled three-dimensional wake. Metrics confirm capture
  at `24.58T`, `0.74697L`, mean distance `2.36044L`, and no instability. Its
  peak normalized lateral force/yaw moment are `0.17844/0.14257`, well below
  the parent's exceptional `0.44113/0.21110`, so the altered path is not merely
  a dramatic high-load vortex event.
- The inherited optimizer note isolates the causal timing on the completed
  parent trace: the course branch is exactly dormant outside `6.5L`, first
  activates at `13.442T`, grows from `0.051` to `0.423` over representative
  `14--18T` samples, and releases when closing reverses. The subsequent sampled
  CFD capture is consistent with that pre-passage prediction, rather than with
  either terminal-only sibling hypothesis.
- The successful policy is not a general low-effort solution: at least one raw
  acceleration exceeds the `1800 deg/T^2` envelope on `72.84%` of samples, a
  joint is at `45 deg` on `23.38%`, and a joint rate is at `260 deg/T` on
  `15.15%`. Its capture margin is only about `0.003L`, so combining an untested
  terminal unload with it would risk erasing the only observed success.

## Policy hypothesis

Replace the assigned parent with the evaluated course-preview structural
delta exactly: use the normalized body-frame cross product between measured
translational course and target direction, gate it by speed, closing state,
posterior release, and a `6.5L`-to-`3.5L` range blend, then add it only through
unused signed sector-request headroom. This is mirror-equivariant, introduces
no clock or memorized route, remains dormant on the established far approach,
and keeps the existing steering-priority bound. Reusing the evaluated policy
without a second speculative terminal mechanism isolates the evidence-backed
cause of the new capture.

Falsification: reject this transfer if formal reevaluation does not capture,
changes the far diagonal before the range gate, loses coherent propulsion, or
returns to the parent's exceptional lateral-force/yaw-moment class. Treat its
high raw-command and joint-limit exposure as an explicit future optimization
target, but require later load relief to preserve semantic capture before it
is called an improvement.

## Bookshelf protocol

This is a later iteration, and inherited evidence contains a new controller
mechanism plus a new semantic success in the immediately preceding completed
iteration. Therefore the three-consecutive-stagnant-iterations consultation
trigger is not met. The shelf was nevertheless consulted because the inherited
optimizer note gives the validated course-preview mechanism shelf provenance;
the transfer below records that provenance without treating it as authority.

bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: use observed route error to modulate bounded steering within a propulsive rhythm, then release corrective authority as measured course aligns
transferable_invariant: separate target-relative translational course error from oscillating body heading, prioritize bounded reorientation only while the predicted route misses, and return authority continuously on alignment
nontransferable_details: species-specific C-start shape, published gains, dimensional cadence, motor timing, full-body gait, exact vortex phase, turning radius, and task-specific routes
policy_translation: form a signed normalized cross product between body-frame velocity and target direction, gate it by normalized distance and positive closing progress, and blend it through unused headroom in the two-joint steering-priority request without time or stored mode
falsification: reject if the far approach changes, capture is lost, alignment fails to release the branch, wake coherence degrades, or exceptional lateral-force and yaw-moment loads return

## Pre-evaluation checks

- The candidate is byte-for-byte equivalent to the sampled successful policy;
  it remains non-empty and is the only candidate target-policy file in
  `solver/`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed no-CFD checks were
  therefore run directly and separately. The rendered README duplicated the
  same assigned-parent marker; removing only that duplicate repaired parent
  selection. The material-guidance check, finite two-joint Julia public
  contract, and solver editable-boundary audit all pass. Formal CFD remains
  deferred to EvE.
