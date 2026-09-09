# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled L64 rollouts used direct uniform still-water initialization
  with `U_infinity=(0,0,0)` and captured from the same upper-right pose. The
  top-down mid-plane sheets show monotone left/down target approach followed by
  a bounded final nose-in turn; the oblique Lambda2 sheets show a coherent,
  alternating three-dimensional wake from release through capture. Neither
  view supports passive advection, wake collapse, collision, or instability.
- The unmodified LOS-led scaffold is the strongest finite sample: capture at
  `19.706T`, mean distance `2.10594L`, score `-0.21598`, mean absolute commands
  `(18.20,17.02) rad/T^2`, and near-command-bound residence `(35.25%,32.74%)`.
  Its matched repeat captured at `19.888T`; this brackets small rollout
  variation without a new trajectory topology.
- Releasing both anterior and posterior redirect after measured yaw response
  remained stable but regressed to `19.850T` and `-0.22093`. Gating LOS history
  by a second instantaneous coherence estimate regressed to `19.987T` and
  `-0.22648`, while raising mean commands to `(18.85,17.62) rad/T^2` and
  near-bound residence to `(36.08%,33.13%)`. Inherited optimizer evidence also
  reports that phase-scaling the posterior redirect captured later at
  `20.168T`/`-0.24199`. These are concrete evidence against further filtering,
  whole-channel response release, or posterior phase gating.
- Every current capture retains zero near-joint-angle-limit residence but
  reaches the joint-velocity limit and spends about one third of the rollout
  near the smooth acceleration bound. The remaining useful test is therefore
  a localized response allocation that does not weaken posterior propulsion or
  the supported distance/closing approach hold.

## Policy hypothesis

Preserve the assigned parent's signed body-frame target map, closing-conditioned
carrier relief, half-cycle route allocation, and continuous posterior LOS-led
curvature. Add one response-gated burst/release mechanism only to the transient
anterior redirect bias: full anterior bias is available until measured yaw has
the calibrated sign of response, then it releases smoothly, while posterior
curvature remains unchanged. This isolates whether redundant anterior C-bend
authority causes late-turn effort without repeating the known regression from
releasing the whole redirect.

Expected evidence: retain capture and the coherent two-view wake, remain within
the approximately `0.025/0.013` peak planar-force/yaw-moment class, and improve
arrival or command residence relative to the `19.706--19.888T` LOS-led repeat
band. Falsify the mechanism if capture is lost, arrival or distance integral
regresses beyond that band, posterior wake coherence weakens, or command/joint
headroom or loads worsen.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-feedback robotic-fish direction tracking
source_mechanism: strong bounded curvature followed by observation-gated release into posterior beating
transferable_invariant: release transient steering only after measured directional response while preserving the propulsive traveling wave
nontransferable_details: species kinematics, published gains, dimensional timing, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame LOS/course geometry and recent yaw response to release only anterior redirect bias under the two-joint state-feedback contract
falsification: reject if capture timing or distance integral regresses, wake coherence or posterior thrust weakens, or load and actuator-limit residence increase
