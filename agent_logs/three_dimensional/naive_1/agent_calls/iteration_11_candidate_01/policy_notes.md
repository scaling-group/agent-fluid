# Candidate diagnosis and hypothesis

## Prior evidence

- All four sampled rollouts use direct uniform still-water initialization with
  `U_infinity=0`; there is no prewarm artifact. In both the top-down
  vorticity row and the oblique Lambda2 row, the assigned parent
  (`solver_c039fddba4d9`) is visibly self-propelled and maintains an
  alternating three-dimensional posterior wake. Its failure is directional,
  not a lack of propulsion: it curves below the target, reaches only
  `4.233L`, and exits the lower boundary at `31.87T` with `9.176L` final
  distance.
- The live one-sided-envelope failure (`solver_237089f89ff4`) and late
  same-sign posterior C-bend (`solver_94750f47d14e`) preserve similar coherent
  wakes but retain the same below-target topology, reaching `3.712L` and
  `3.692L` before lower exit. The C-bend's angle-only gate first exceeds
  `0.01` at about `19.84T`, `3.734L`, after the route is already committed; it
  changes late yaw but does not prevent the miss.
- The strong finite example (`solver_1a1f00e33399`) preserves the alternating
  top-down wake and compact oblique vortex train, then visibly turns onto the
  target rather than continuing to the lower boundary. It captures at
  `24.34T` and `0.7496L`, with mean score distance `2.224L`. Its
  distance-and-full-error-gated opposite-sign posterior rudder begins before
  the miss (gate above `0.01` at about `10.15T`, `7.712L`, and above `0.5` at
  `12.28T`, `6.552L`). The recorded peak normalized force/moment
  (`0.0316/0.0164`) and anterior/posterior rate-cap occupancy
  (`14.0/6.9%`) remain near the inherited envelope, although the final
  first-crossing occurs with substantial yaw; this establishes capture for
  the fixed case, not robust terminal alignment.

## Policy hypothesis

Use the sampled successful architecture as an evidence-replication candidate:
retain slip-aware anterior curvature, the live state-feedback carrier, and
full-angle half-cycle redistribution, then add the tested bounded posterior
reactive-rudder offset scheduled only by normalized head-relative body-frame
target geometry and distance. Reproducing the sampled values is deliberate:
the semantic change from the parent is the early, distinct posterior load
pathway, while further scalar tuning would confound the only completed capture
evidence. The expected result is a coherent propulsive wake followed by
target-side yaw early enough for first-crossing capture.

Falsify the transfer if it fails to capture, loses the alternating wake before
the `8L` recruitment region, repeats a lower-boundary exit, or materially
exceeds the sampled `14.0/6.9%` joint-rate occupancy or `0.032/0.0165`
force/moment envelope. Treat high-error/high-yaw first crossing as fixed-case
success only; held-out target poses would still need evidence.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical fish mean-curvature turning
source_mechanism: bounded asymmetric flapping or joint offset superposed on a continuing propulsive rhythm
transferable_invariant: preserve the traveling carrier while target geometry recruits a distinct bounded posterior mean-load pathway early enough to create yaw
nontransferable_details: published gains, duty ratios, species-specific envelopes, clock phase, exact vortex phase, and task-specific routes
policy_translation: use head-relative target distance and full body-frame angle to gate an opposite-sign posterior rudder target while joint angle and rate retain oscillator phase
falsification: reject on loss of wake, failure to capture or earlier target-side yaw, repeated lower exit, or materially larger saturation and load peaks
