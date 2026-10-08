# Candidate wake-policy notes

## Evidence read before the edit

- All four sampled evaluations use direct uniform initialization with
  `U_infinity=[0,0,0]`; all capture from `12.327720L`. The three
  response-released artifacts are policy-byte-identical and reproduce score
  `-0.5283387731`, capture at `25.118523T`, mean distance `2.429293780L`, and
  final distance `0.746410191L`. The only distinct policy is the
  departure-phase allocator: it captures one integration step earlier at
  `25.113022T` but is slightly weaker at score `-0.5283756345`, mean distance
  `2.429298361L`, and final distance `0.746516585L`.
- The response-released top-down row shows self-propelled progress rather than
  advection: an alternating red/blue wake grows behind the moving fish from
  release through the broad target-directed arc, then the oscillatory wake
  weakens as the terminal curvature equilibrium forms before capture. Its
  oblique row confirms a coherent three-dimensional Lambda2 chain at `8T` and
  `16T`, followed by a compact, low-activity approach at `24T`; the fish turns
  toward and enters the capture sphere rather than passing or exiting.
- The distinct phase-selective sheet supports the same outer-wake and path
  diagnosis in its top-down row, but its oblique panels after frame 000 are
  black. That is incomplete visual evidence, not a flow or controller
  failure, so no comparative 3D-vortex claim is based on those panels.
- Diagnostics agree with the visual comparison. Neither policy reaches the
  candidate acceleration cap inside `4L`. The response-released policy's
  inside-`4L` lateral-force/yaw-moment maxima are about
  `0.015475/0.007995`, versus `0.014256/0.007571` for the phase-selective
  policy. At `24T`, the reproduced response policy has settled joint angles
  near `(-0.116,-0.217) rad`, tiny actions, and target-directed yaw near
  `-0.257 rad/T`; by capture the aligned yaw response has grown to about
  `0.313 rad/T`. The joint-equilibrium error is already below `0.01` of drive
  amplitude through most of that interval.
- The assigned parent correctly treats the phase-versus-response score gap as
  a near-tie rather than robust superiority. The sampled optimizer guidance
  and inherited scores sharpen the boundary: coordinated two-joint release is
  exactly reproduced in three artifacts; posterior-only release regressed to
  `-0.530288`, and stacking the phase allocator with coordinated release
  regressed to `-0.530990`. A further joint-phase gate or direct velocity-course
  law is therefore contradicted. The untested residual named by the inherited
  evidence is actual body response while preserving the paired handoff.

## Policy hypothesis written before editing

Keep the outer carrier, closure preview, target-relative shared curvature, and
coordinated two-joint carrier recovery unchanged. Replace tracking-error-only
release with a response-confirmed handoff: joint settling makes recovery
eligible, but the carrier is recovered only in proportion to measured yaw in
the bounded redirect direction. This distinguishes a formed joint bend from a
hydrodynamically effective body turn. It should retain full curvature authority
during the early terminal blend, then recover the same paired traveling wave
after target-directed yaw appears. The hoped-for result is the earlier/lower-
load transition of the phase-selective rollout without giving up the
response-released rollout's mean/final-distance edge.

Falsify this candidate if it changes motion before the terminal transition,
loses capture, delays or stalls the compact approach, restores command caps or
joint-stop dwell inside `4L`, raises terminal force/moment peaks, or merely
reproduces the parent because the new body-response condition is effectively
always one. Formal CFD is intentionally deferred to the downstream evaluator.

bookshelf_consulted: true
source_domain: biological C-start turning and sensor-modulated robotic-fish CPG control
source_mechanism: hold bounded turning curvature until measured heading response appears, then release into a propulsive rhythm
transferable_invariant: actuator-state settling alone does not prove a turn; require target-directed body response before handing authority back to rhythmic propulsion
nontransferable_details: species-specific C-start shapes, full-body degrees of freedom, published oscillator gains, dimensional rates, exact wake phase, and task routes
policy_translation: use normalized body-frame target geometry for redirect sign, joint error normalized by drive amplitude for bend settling, and recent yaw response for a continuous paired two-joint carrier handoff
falsification: reject if pre-terminal motion changes, capture or distance quality regresses, terminal saturation or loads grow, or the response condition is dormant
