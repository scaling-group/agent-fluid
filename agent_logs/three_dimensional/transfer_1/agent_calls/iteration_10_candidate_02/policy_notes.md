# Whole-wave phase-neutral yaw candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  semantic `capture`.  Three independently evaluated v26 artifacts produce
  the same trajectory at `23.9305 T`, score `-0.551781`, and distance integral
  `2.45000 L`; this is strong evidence that combining joint-state yaw-phase
  rejection with carrier-first steering allocation is a real improvement, not
  packaging noise.  The weaker projection-only parent captures at `25.9545 T`,
  score `-0.647789`, and integral `2.55008 L`.
- I inspected both rows of the combined keyframe sheets for the reproduced
  v26 capture and the projection-only parent.  Both are self-propelled from
  quiescent water: compact startup structures become a coherent alternating
  posterior vorticity sheet and three-dimensional Lambda2 packets, and the
  wake bends continuously with the target-signed route.  V26 turns more
  aggressively after roughly `12 T` and reaches the capture disk about `2 T`
  sooner; the larger separated terminal packets agree with its higher speed
  and command activity, not with passive advection or wake collapse.
- Trajectory diagnostics support the visual comparison.  V26 improves distance
  from `8.4209/6.0297/3.3829 L` at `12/16/20 T` to capture at `23.9305 T`,
  whereas the parent is at `8.6331/6.5369/4.3294 L` and captures at
  `25.9545 T`.  The cost is higher mean/max speed (`0.546/0.784` versus
  `0.510/0.667 L/T`) and any-joint acceleration-limit residence (`45.62%`
  versus `33.95%`), while peak planar force/yaw moment remain unchanged near
  `0.02974/0.01484`.  Thus the next test should preserve phase-neutral route
  feedback but make its phase estimate less noisy, not add propulsion gain.
- V26 estimates gait recoil from head-joint rate alone.  On the completed v26
  trace, subtracting a one-period moving mean leaves beat-frequency yaw whose
  least-squares relation to both observed joint rates is stable across route
  segments: head coefficients are about `0.56--0.60` and posterior coefficients
  about `0.20--0.23`.  Replaying only the observation calculation on that fixed
  trace, the existing `0.40*phi_dot[1]` correction leaves `0.403 rad/T` RMS
  beat-frequency content; a two-joint `0.55/0.21` recoil estimate leaves about
  `0.139 rad/T`.  This is an offline signal diagnostic, not a claim about the
  unevaluated closed-loop candidate.  It also resolves the misleading final
  instant: raw yaw is `-1.068 rad/T`, head-only correction reports about
  `-0.030`, while the whole-wave estimate reports `+0.201`, consistent in sign
  with the positive `0.608 rad/T` mean turn over the final carrier period.
- The inherited response-only redirect failure still bounds the change: an
  apparently correct instantaneous yaw response can release curvature too
  early and miss above-left.  The completion gate, posterior lag, target
  geometry, and carrier-first allocation therefore remain unchanged.

## One-candidate policy hypothesis

Replace only the head-rate recoil estimate in v26 with a bounded two-joint
traveling-wave recoil estimate.  Both observed joint velocities contribute to
the fast carrier component; the corrected rate enters the existing target
turn-rate loop and completion-gated redirect, while all propulsion, curvature,
approach, and envelope-allocation mechanisms are retained.  This is a
state-feedback phase observer, not a new clock, fixed route, wake-phase target,
or scalar carrier increase.

Expected evidence is the same coherent wake and semantic capture, with less
half-cycle countersteering, equal or earlier arrival than `23.9305 T`, lower
distance integral, and acceleration-limit residence moving below `45.62%`
without increasing the sampled `0.784 L/T` speed or load envelope.  Falsify the
mechanism if capture is lost or delayed, the target-signed arc weakens, the
response-only near-miss topology returns, the alternating wake degrades, or
saturation, speed, force, or moment materially increases.  Formal CFD occurs
after this worker exits; no same-worker result is claimed.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and whole-wave locomotor state feedback
source_mechanism: separate fast gait-synchronous body motion from persistent target-route response using observed oscillator state
transferable_invariant: target guidance should respond to route-scale yaw after accounting for the full observed traveling bend rather than treating one joint as the entire carrier phase
nontransferable_details: published oscillator gains, robot geometry, dimensional cadence, species-specific kinematics, exact vortex phases, prescribed duty ratios, and task-specific routes
policy_translation: estimate carrier recoil from both bounded observed joint velocities, use the corrected yaw only in normalized body-frame target feedback and redirect release, and preserve carrier-first residual projection
falsification: reject if capture or distance integral regresses, the target-signed route or coherent wake is lost, or speed, acceleration-limit residence, force, or moment exceeds the reproduced v26 envelope
