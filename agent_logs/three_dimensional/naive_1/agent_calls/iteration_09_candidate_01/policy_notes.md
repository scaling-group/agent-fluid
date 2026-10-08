# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four assigned solver examples and the two inherited step-8 evaluations
  satisfy the direct-uniform experiment contract: still water with
  `U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot, and no numerical
  instability. Their top-down sheets show persistent alternating red/blue
  caudal wakes, while the oblique sheets retain discrete three-dimensional
  Lambda2 structures through approach and exit. The motion is self-propelled;
  neither advection nor wake collapse explains the failure.
- The assigned prefill's anterior-only `8 deg` center and symmetric posterior
  relief reaches `4.233L` and exits through the lower boundary at `31.87T`.
  An anterior phase-selective residual improves this to `4.018L`, posterior
  half-stroke redistribution to `3.909L`, and their whole-body combination to
  the sampled-best `3.691L`. All retain the same visible lower-going path. At
  `20T` the combined policy is still `3.736L` away with folded/full target
  error about `1.362 rad`; it has preserved propulsion but not produced enough
  target-side yaw before passing below the target.
- The inherited rear-aware continuations are a concrete negative result.
  Gating the combined half-cycle mechanism with the full head-relative target
  angle (`solver_84cf58b005c4`) and also using that angle for turn sign
  (`solver_aa8ea60de395`) both reproduce the `3.691L` minimum exactly, retain
  the coherent wake, and still exit low. Their final distances worsen slightly
  to `9.328--9.329L`, versus `9.294L` for the folded-angle parent. At `32T`
  their full errors remain about `2.42` and `2.39 rad`: keeping the same
  phase-selective authority active behind the head corrects observation
  semantics but does not create route recovery.
- The sampled traces also bound the new hypothesis. The whole-body
  half-cycle policy already uses about `13.7/5.5%` anterior/posterior rate-cap
  occupancy, while inherited logs show that direct recent-yaw unloading can
  extinguish joint motion and the visible wake. Further relief, asymmetry, or
  redirect-gain tuning would repeat a falsified mechanism. The next test must
  change how the anterior actuator allocates its angle/rate envelope while
  retaining the evidence-positive anterior/tail mean separation.

## One candidate hypothesis

Test one target-gated anterior burst-curvature mechanism. Retain the cruise
oscillator, slip-aware `8 deg` anterior center, zero-mean posterior lag, and
the sampled posterior relief. When the full normalized body-frame target angle
enters the already sampled large-error band, continuously move the anterior
center toward a stronger bounded target-signed posture and compress its
oscillatory amplitude. This reallocates the anterior angle/rate envelope from
a wide beat to mean yaw authority instead of adding another clipped
phase-selective acceleration. The posterior continues to follow only the
centered anterior carrier, with reduced authority during the burst, so the
failed opposite tail mean and shared-curvature modes are not reintroduced.
True alignment continuously restores the full propulsive carrier.

The expected semantic change is an earlier, sustained target-side heading
change while the target is still ahead, with the alternating cruise wake
preserved before and after the redirect. Reject the mechanism if minimum
distance does not beat `3.691L`, full target error fails to decrease before
the miss, the same lower exit remains without a meaningful recovery turn, the
anterior joint spends more time at its angle/rate limits, or the posterior
wake collapses as it did under direct yaw unloading.

bookshelf_consulted: true
source_domain: biological burst redirection and closed-loop robotic-fish direction tracking
source_mechanism: large persistent heading error temporarily reallocates a rhythmic gait toward strong bounded curvature, then observed alignment releases the maneuver back to propulsion
transferable_invariant: when a coherent propulsive rhythm exhausts its steering authority, body-frame target error may smoothly trade oscillation envelope for bounded turn posture without a clock, while preserving a lagged posterior carrier for recovery
nontransferable_details: species-specific C-start shape, published gains, dimensional beat frequency, robot linkage geometry, prescribed burst duration, exact vortex phase, and task-specific routes
policy_translation: the full normalized head-relative target angle gates interpolation from the slip-aware cruise center to a stronger target-signed anterior center and simultaneously compresses the centered carrier; the posterior tracks only that zero-mean carrier under the inherited smooth relief
falsification: reject if the 3.691L approach or coherent wake is lost, target error does not fall before the miss, the lower exit persists without recovery, joint-limit occupancy worsens, or carrier compression causes inertial coasting
