# Course-resolved carrier-release candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes satisfy the frozen rollout contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture`. No failed
  termination is present, so the informative negative is a controller-
  mechanism regression rather than a semantic failure.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  from release through capture for the highest-scoring
  `solver_1d05d22ea1fe` and lowest-scoring `solver_8d0068c45885`. Both fish
  self-propel from blank quiescent water on a shallow target-directed arc.
  Compact alternating caudal vortices in the top-down row and discrete 3D
  Lambda2 structures in the oblique row remain coherent; neither rollout is
  advected, collides, exits, flails without progress, or becomes unstable.
  The lower-score half-cycle gate has the same useful wake topology but a
  slightly longer terminal curve, so propulsion and lateral oscillation
  should be retained rather than retuned or cancelled.
- Metrics resolve the visually subtle differences. The two byte-identical
  all-distance response-release repeats capture at `16.071--16.088T`, with
  distance integrals `1.82203--1.82366L`, paths `13.129--13.166L`, and
  anterior greater-than-90%-rate residence `17.50--17.52%`. Restoring common
  carrier coupling over the sampled `6--4L` approach captured at `15.939T`,
  reduced integral/path to `1.82008L/13.107L`, and kept peak planar force/yaw
  moment at `0.03477/0.01715`, but raised anterior rate residence to `17.70%`.
  Gating half-cycle asymmetry from target bearing and same-sign yaw captured
  at `16.022T/1.82375L/13.144L` and left anterior rate residence at `17.71%`;
  it therefore did not selectively relieve the carrier-driven rate cost.
- The assigned parent guidance and inherited step-35 note sharpen the
  boundary. A prior same-sign-yaw redirect residual produced a longer
  `13.363L` hook, `16.247T` capture, and higher command without material load
  or rate benefit; same-sign yaw is response onset, not proof that body-frame
  course demand is resolved. Conversely, inherited repeat evidence puts the
  hard approach handoff at `15.939--16.170T`, overlapping the all-distance
  repeat class. This rejects both another response-gain tune and a claim that
  range alone is the portable mechanism.

## One-candidate policy hypothesis

Preserve the prefilled corrected-sign target geometry, distance/closing drive
relief, full velocity-course redirect, joint-phase steering, posterior wave
allocation, carrier/steering decomposition, soft bounds, and public two-joint
contract. Change only the negative-work reversal release. Require the existing
same-sign normalized yaw response to coincide with resolution of the bounded,
speed-authorized velocity-course redirect magnitude. A large unresolved
body-frame course demand keeps the common carrier subordinated to steering;
an aligned or too-slow-to-define course permits phase-coherent reversal without
using a clock, fixed range stage, world coordinate, or memorized route.

Expected signature: retain capture, early progress, the coherent two-view wake,
and the short-path class while avoiding unnecessary approach carrier priority
on aligned segments. Falsify if timing/integral leaves the combined sampled
repeat envelope without a material path or rate-residence benefit, the
`13.363L` hook reappears, capture is lost, or command, joint margin, terminal
yaw/slip, force/moment, finite action, or either wake view deteriorates. The
new CFD result occurs only after this worker exits and is not evidence claimed
here.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: strong bounded curvature yields to phase-coupled propulsion only when observed directional response actually resolves the steering demand
transferable_invariant: response onset is not response completion; release a direction-priority maneuver only when same-sign response coincides with reduced normalized body-frame directional error
nontransferable_details: species-specific maneuver stages and kinematics, published gains and duty ratios, dimensional cadence, clocked CPG phase, full-body waveforms, exact vortex phases, and task-specific coordinates or routes
policy_translation: preserve target steering and the two-joint traveling carrier; multiply same-sign-yaw negative-work reversal release by the complement of speed-authorized bounded velocity-course redirect magnitude
falsification: reject if capture, timing/integral, short path, joint margin, actuator residence, loads, terminal course, finite action, or coherent top-down and oblique wakes leave the sampled useful envelope
