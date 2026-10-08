# Approach-scheduled crossflow-pose candidate

## Evidence and visual diagnosis before editing

- All four sampled solver rollouts satisfy the frozen direct-uniform contract:
  still water with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
  dynamics, and `capture`.  Their executable differences are comments or a
  version label, and their rendered evidence is identical.  They reproduce the
  geometry-released v34 route at `18.403006 T`, score `-0.140449`, observed
  distance integral `1.418099 L`, total distance integral `2.027810 L`, and
  final distance `0.747223 L`.
- I inspected the combined sheets for the reproduced v34 policy and the
  inherited crossflow-pose experiment from release through capture, including
  both the top-down mid-plane vorticity row and the oblique body/Lambda2 row.
  Both are visibly self-propelled along the same smooth target-directed arc:
  compact startup structures become a coherent alternating posterior wake,
  while oblique structures remain localized around the moving fish and its
  recent trail.  Neither sheet shows passive advection, wake collapse,
  collision, domain exit, or instability.  The sampled set contains no
  semantic failure; the inherited crossflow policy is the informative
  performance/envelope failure, while the earlier wrong-sign whole-wave-rate
  `left_domain` result remains the sign-safety boundary recorded by the parent.
- The inherited unscheduled crossflow-pose policy is a mixed result.  It
  captures sooner (`18.325987 T`) and improves observed distance integral
  slightly (`1.417990 L`); it trails v34 by `0.0150/0.0187 L` at `8/12 T` but
  leads by `0.0104/0.0421/0.0653 L` at `16/17/18 T`.  Its shallower discrete
  capture crossing (`0.748005 L`) raises total distance integral to
  `2.028916 L` and lowers score to `-0.141865`.  It also raises maximum speed
  from `0.9476` to `0.9631 L/T` and any-joint acceleration-limit residence from
  `42.14%` to `43.55%`; peak normalized force is unchanged at `0.03068`, and
  peak yaw moment changes only from `0.01587` to `0.01580`.  Thus the
  crossflow-weighted pose signal has a useful late-route effect, but applying
  it throughout the route is not an evidenced global improvement.
- On the completed v34 trace, a normalized distance gate that is zero at and
  beyond `4 L`, ramps continuously, and is full by the existing `2.1 L`
  approach boundary leaves the first `77.5%` of states exactly on the evaluated
  controller.  It activates at about `14.27 T`, is full at about `16.62 T`, and
  bounds the reconstructed pose correction below `1.70 deg`.  This frozen-state
  audit establishes scope and boundedness only, not a closed-loop outcome.

## One-candidate policy hypothesis

Preserve the reproduced v34 state-feedback traveling wave, posterior lag, raw
large-error redirect, mean-preserving whole-wave pose rejection, head-only
route-rate correction, raw half-cycle steering, closing-response cadence,
bearing-divergence recovery, carrier-first head-to-tail spillover, and physical
bounds.  Add the previously sampled crossflow-weighted observed-joint-phase
correction only in the middle/near regime: it is zero beyond `4 L`, ramps to
full authority by `2.1 L`, and affects only the proportional route-pose
projection.  It remains excluded from redirect selection, derivative feedback,
carrier dynamics, and direct actuator commands.

The structural hypothesis is that the global experiment's late lead came from
rejecting a carrier-coherent fluid/body pose residual after the broad redirect
was established, whereas early application spent extra acceleration authority
and perturbed useful route formation.  Regime selection by normalized target
distance should preserve v34 exactly through the early and middle route, then
test the evidenced late benefit without indiscriminately cancelling the
alternating self-wake.  Falsify this candidate if capture is lost or materially
later than `18.403 T`, total integral exceeds `2.027810 L`, the `16--18 T` lead
does not appear, the coherent two-view wake changes qualitatively, or maximum
speed, acceleration-limit residence, normalized force, or yaw moment exceeds
the v34 `0.9476/42.14%/0.03068/0.01587` envelope without compensating closure.

```text
bookshelf_consulted: true
source_domain: wake-interaction studies, sensor-modulated robotic-fish control, and terminal capture control
source_mechanism: separate slow target-route formation from bounded fast crossflow rejection, and introduce disturbance correction only in the regime where route evidence shows it helps
transferable_invariant: preserve the traveling carrier and broad body-frame redirect; apply the smallest normalized fluid-side pose correction only where accumulated lateral error makes it useful, rather than cancelling all alternating crossflow
nontransferable_details: published gains, species-specific kinematics, exact vortex phase, cylinder-wake synchronization, dimensional distances or cadence, and prescribed routes
policy_translation: weight de-meaned anterior joint phase by normalized body-frame local-crossflow magnitude only inside a continuous normalized-distance gate, and add the bounded result solely to proportional whole-wave pose rejection
falsification: reject if early route identity is not preserved, late closure or capture regresses, the alternating wake weakens, or speed, saturation, normalized force, or yaw moment rises without compensating progress
```

## Evidence boundary

All rollout claims above come from completed sampled CFD, the assigned parent,
and inherited optimizer logs.  The new scheduled candidate is evaluated only
after this worker exits, so no same-worker improvement is claimed.

## No-CFD implementation audit

- The lightweight contract state returns two finite accelerations, and all
  `62` direct `params.FIELD` references are declared among the `64` fields
  returned by `target_policy_params()`.
- A deterministic state grid spanning target distance, bearing, crossflow,
  joint pose, and joint rate remains finite and inside the declared
  acceleration envelope.  Every tested state at or beyond `4 L` is bit-exact
  with the reproduced v34 policy, while in-gate nonzero-crossflow states expose
  an active candidate path.
- The guidance semantic check and solver editable-boundary check pass.  No CFD
  rollout was run; closed-loop benefit remains the next evaluation's question.
