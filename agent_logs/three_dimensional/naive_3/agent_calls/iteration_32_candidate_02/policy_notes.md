# Acceleration-headroom-isolated adverse-yaw allocation

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and inertially
  quiescent cells inserted by the moving window. All terminate in capture, so
  the informative contrast is route quality and mechanical cost rather than a
  failure termination.
- I inspected the combined sheets for the assigned bidirectional parent and
  the strongest target-signed descendant from release through capture. In both
  top-down rows the fish advances while shedding a coherent alternating
  red/blue street; both oblique rows retain compact three-dimensional caudal
  Lambda2 structures through the terminal turn. Neither shows passive drift,
  a held-joint coast, boundary exit, collision, or wake collapse. Diagnostics
  support that visual interpretation: peak fish speed is `1.374U` for the
  parent and `1.391U` for the signed descendant, whereas peak local flow stays
  below `0.033U`.
- The assigned parent captures at `16.988T`, score `-0.204764`, and mean
  distance `2.08931L`, with sublimit joint speeds and posterior angle
  `0.5700 rad`. The target-signed adverse-yaw residual is the only sampled
  controller with a materially distinct beneficial route: it captures at
  `16.932T`, score `-0.200045`, and mean distance `2.08513L`, while preserving
  the same alternating wake and sublimit speeds. Its bounded cost is posterior
  angle `0.5992 rad` and force/yaw-moment peaks `0.03693/0.01835`, versus
  `0.03634/0.01804` for the parent.
- The other distinct descendant isolates the signed residual behind a
  plateaued `0.75--0.90` receiver-speed gate. It still improves on the parent
  (`16.960T`, `-0.204089`, `2.08869L`) but gives back most of the ungated
  signed residual's route benefit and reaches `0.59395 rad` posterior angle
  with `0.03668/0.01838` force/moment peaks. Its implementation replaces the
  signed residual's already-evidenced all-speed receiver taper with greater
  low-speed authority; therefore it does not establish that earlier speed
  withdrawal is useful. Preserve the best sample's receiver-speed semantics.

## Single-candidate policy hypothesis

Start from the completed target-signed adverse-yaw sample. Preserve its
zero-centered anterior oscillator, lagged posterior wave, body-frame
target/velocity-course feedback, terminal posterior acceleration reserve,
smooth acceleration shoulder, high-onset positive-power speed guards, base
bidirectional transfer, existing receiver-speed taper, and posterior kinetic
angle projection. Separate the signed corrective increment from the base
posterior-to-anterior transfer so base carrier work has priority. Multiply only
the corrective increment by a C1 gate formed from its remaining anterior
acceleration headroom, normalized by the already-owned sublimit reserve between
the routine soft ceiling and the reallocation ceiling. Full authority remains
when that reserve is available; the increment withdraws continuously as the
receiver consumes the last reserve. No carrier gain, actuator limit, speed
threshold, or nominal bend changes.

This is one viability-aware residual-allocation mechanism. It should retain the
signed-load route benefit without letting the discretionary correction occupy
the receiver's last acceleration reserve. Falsify it if it is inactive on the
recorded parent states, loses capture or alternating three-dimensional
shedding, touches an actuator boundary, fails to improve the `2.08931L` parent
route, or exceeds `0.5993 rad`, `0.0370` force, or `0.0184` yaw moment without
a meaningful arrival benefit.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-disturbance residual control
source_mechanism: preserve the coupled propulsive rhythm while feedback adds bounded corrective work only during an observed adverse yaw response
transferable_invariant: keep route intent separate from measured response and withdraw a discretionary phase-local residual as its receiving actuator loses normalized headroom
nontransferable_details: published gains, dimensional beat frequency, species-specific kinematics, duty ratios, full-body oscillator networks, exact vortex phases, and task-specific routes
policy_translation: use body-frame target/course turn request and normalized yaw moment to identify the adverse posterior-donor half-cycle, retain the sampled receiver-speed taper, and smoothly remove only the extra anterior work as remaining sublimit acceleration reserve vanishes
falsification: reject if the residual is replay-inactive, loses capture or coherent shedding, restores an actuator contact, fails to preserve the signed-load route improvement, or increases posterior angle and hydrodynamic loads beyond the sampled envelope
```

## Non-CFD activation check after the edit

Policy-level replay on reconstructed normalized observations from the assigned
parent's 3,089 recorded states changes 16 anterior outputs relative to the
assigned bidirectional policy and changes no posterior outputs. Relative to the
completed signed-load policy, the acceleration-headroom gate changes those same
16 anterior outputs on the parent trace; on the signed policy's own 3,079-state
trace it changes 25 anterior outputs. The largest candidate-to-signed
difference is `0.299 rad/T^2`. This establishes that the residual remains active
and that its new withdrawal is selective rather than a no-op. The replay does
not evolve the body or fluid and is not evidence of capture, score, route, or
load improvement.
