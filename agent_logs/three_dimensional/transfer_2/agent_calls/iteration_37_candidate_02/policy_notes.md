# Steering-aware predictive carrier-guard candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  moving-window transport, stable dynamics, and `capture`. There is no failed
  termination in the current sample, so the informative negative is a
  mechanism regression rather than a semantic failure.
- I inspected both rows of the combined keyframe sheets from release through
  capture for highest-scoring `solver_674e84ea2575` and lowest-scoring
  `solver_f997a0c1ad0f`. Both fish self-propel from quiescent water: alternating
  top-down vorticity and compact oblique Lambda2 structures form behind the
  bending body and remain coherent through capture. Neither fish is advected,
  collides, exits, flails without progress, or develops an out-of-plane or
  numerical failure. The prefill carries a visibly broader late hook; the
  strongest sample straightens earlier while retaining the same productive
  wake class.
- Metrics establish the useful change. Relative to the approach-restored
  carrier sample `solver_1d05d22ea1fe`, the state-derived positive-work preview
  in `solver_674e84ea2575` advances capture from `15.939T` to `15.851T`, lowers
  distance integral from `1.82008L` to `1.81025L`, shortens head path from
  `13.107L` to `12.995L`, and lowers mean command norm from `23.82` to
  `23.22 rad/T^2`. Anterior/posterior residence above 90% of the rate envelope
  falls from `17.70/8.25%` to `17.18/6.52%`, and above 99% from `12.18/1.31%`
  to `9.16/0.00%`. All `10--6L` milestones are earlier and the coherent wake is
  retained.
- The boundary is load. Peak planar force/yaw moment rise from
  `0.03477/0.01715` to `0.03846/0.01908`. Both peaks occur together at
  `4.054T`, while still `11.46L` from the target, with the posterior joint at
  about `246 deg/T` and both requested accelerations doing positive work. This
  is an early strong-turn stroke, not a terminal hook or a flow-initialization
  artifact. The current preview projects only carrier acceleration, so a
  steering residual that also pushes a joint outward can make rate contact
  more imminent than the guard senses.
- The assigned parent and inherited step-35/36 notes reject same-sign-yaw
  redirect release, half-cycle response gates, hard distance-only carrier
  handoffs, and scalar threshold tuning: they preserve capture but fail to
  improve timing/path/rate tradeoffs beyond repeat variation. The parent also
  records that instantaneous force/moment relief produced negligible load
  benefit and slower capture. The current candidate therefore preserves the
  full redirect and does not add load feedback.

## One-candidate policy hypothesis

Start from the sampled predictive positive-work guard, retaining corrected
body-frame target geometry, distance/closing drive relief, full velocity-course
redirect, phase steering, posterior allocation, carrier/steering decomposition,
response-conditioned reversal release, soft bounds, and the public two-joint
contract. Change only the short phase-space preview: project each joint's rate
from the full pre-limit acceleration demand (`raw_head_accel` and `tail_drive`),
not the carrier component alone. Continue to withdraw only positive carrier
work; leave target-conditioned steering and negative-work reversal outside the
scaled component. Thus steering keeps priority, but its outward contribution
causes propulsive work to yield earlier before the combined demand reaches the
rate envelope.

Expected evidence is retained capture, early milestones, coherent wakes, and
the sampled `12.995L` short-path/low-rate-residence class, with peak planar
force and yaw moment moving back toward the approach-restored sample. Falsify
if capture timing or distance integral leaves repeat variation without a
material load/rate benefit, if the broader late hook returns, or if path,
command, joint margin, terminal course, finite action, or either wake view
regresses. The new CFD evaluation occurs only after this worker exits and is
not evidence claimed here.

bookshelf_consulted: true
source_domain: Lighthill-style reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posteriorly lagged traveling wave while bounded observed-state feedback modulates rhythmic drive around maneuver demand
transferable_invariant: anticipate actuator-envelope contact from the combined state and outward acceleration demand, then withdraw positive rhythmic work while preserving reversal and target-conditioned steering
nontransferable_details: published gains, species-specific body waves, dimensional cadence, clocked CPG phase, exact vortex phase, and task-specific coordinates or routes
policy_translation: use normalized joint rate and bounded full pre-limit joint demand to preview rate contact; apply the resulting common guard only to positive carrier work under the existing body-frame two-joint feedback contract
falsification: reject if load and rate residence do not improve while capture, timing/integral, short path, joint margin, terminal course, finite action, and coherent top-down and oblique wakes remain in the sampled useful class
