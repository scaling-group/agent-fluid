# Slow-route-consistent crossflow-pose candidate

## Rollout evidence and visual diagnosis before editing

- All four sampled solver examples satisfy the frozen Phase-2 contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `capture` termination.  Three
  geometry-released bearing-divergence policies reproduce capture at
  `18.403006 T`, score `-0.140449`, total distance integral `2.027810 L`, and
  observed distance integral `1.418099 L`.  The response-released sibling is
  a small regression at `18.414005 T`, `-0.141536`, `2.028719 L`, and
  `1.418269 L` without a speed, force, or moment benefit.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows from
  direct release through capture for the strongest sampled geometry-only
  controller and the response-released sibling.  Both are visibly
  self-propelled along the same smooth target-directed arc: compact startup
  structures develop into a coherent alternating mid-plane street and
  organized three-dimensional posterior structures.  Neither sheet shows
  passive advection, wake collapse, collision, domain exit, a prewarm
  artifact, or numerical instability.  The sampled set contains no failed
  termination; the inherited whole-wave route-rate projection remains the
  informative failure boundary because it kept an organized wake but turned
  upward and exited at `8.4755 T` with roughly tenfold force and moment peaks.
- The assigned-parent rollout and inherited logs isolate a small fluid-side
  opportunity.  Full-route, carrier-phase-anchored crossflow pose rejection
  captures at `18.325987 T` and improves the observed integral to
  `1.417990 L`, but trails geometry-only by `0.0150/0.0187 L` at `8/12 T` and
  raises maximum speed and acceleration-limit residence from
  `0.9476 L/T` and `42.14%` to `0.9631 L/T` and `43.55%`.  A distance-only
  terminal gate removes that cost and produces the best observed integral,
  `1.417769 L`, at the geometry-only `0.9476 L/T`, `42.03%`,
  `0.03068/0.01587` peak normalized force/moment envelope, but delays capture
  to `18.386505 T`.  Both combined visual sheets retain the same coherent
  wake and target-signed route, so the trade is in when sensing correction is
  admitted, not in propulsion or wake formation.
- Frozen reconstruction on the repeated geometry-only trace shows that the
  full crossflow residual points toward the slow, whole-wave-de-gaited target
  bearing on only about `39%` of carrier states near `8 T`, versus about
  `68%` near `16 T` and `61%` near `18 T`.  This supports a response-semantic
  selector instead of another fixed distance threshold; it is an offline
  localization result, not a closed-loop claim.

## One-candidate policy hypothesis

Preserve the sampled geometry-released controller's state-feedback traveling
wave, posterior lag, raw large-error redirect, mean-preserving whole-wave pose
projection, head-only route-rate correction, raw half-cycle steering,
response-released cadence, bearing-divergence recovery, approach scheduling,
head-to-tail rejected-steering allocation, and componentwise bounds.  Add one
sensor-fusion mechanism: form the completed crossflow-times-observed-carrier-
phase pose residual, but admit it only when its sign contracts the slow
whole-wave-de-gaited body-frame target bearing.  A correction pointing away
from that bearing yields continuously.  The term remains in proportional pose
sensing only and cannot alter redirect selection, route rates, carrier
dynamics, or direct actuator residuals.

The candidate should preserve geometry-only middle-route closure while
retaining more of the full-route controller's useful late correction than the
distance-only gate.  Falsify the mechanism if capture is lost or not earlier
than `18.3865 T`, observed distance integral exceeds `1.41777 L`, the coherent
target-directed wake changes qualitatively, or maximum speed, acceleration-
limit residence, normalized force, or yaw moment materially exceeds the
completed full-crossflow envelope `0.9631/43.55%/0.03068/0.01580` without
compensating progress.  Formal CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish control
source_mechanism: separate slow target geometry from fast carrier-coherent flow signatures and admit only a bounded task-consistent correction
transferable_invariant: a phase-anchored fast flow cue may refine locomotor pose sensing when it agrees with slower body-frame task geometry, and should yield when it would become an opposing route bias
nontransferable_details: published gains, species kinematics, exact vortex or tail-beat phase, cylinder-wake synchronization, clocked CPG timing, full-body envelopes, dimensional distances, and prescribed routes
policy_translation: use normalized local body-frame crossflow magnitude to weight observed de-meaned anterior joint phase, then apply that odd residual only when it contracts the whole-wave-de-gaited body-frame target bearing under the two-joint state-feedback contract
falsification: reject if capture or middle-to-late closure regresses, the alternating wake weakens, or speed, saturation, normalized force, or yaw moment exceeds the completed crossflow envelope without compensating progress
```

## Evidence boundary

All numerical and visual outcome claims above come from completed sampled CFD,
the assigned parent, and inherited optimizer logs.  No same-worker CFD result
is claimed.

## No-CFD implementation audit

- The candidate policy has SHA-256
  `907efa19a3dd3bdd05a23d71f825addb121a7cfc19461fab4d0a5795c8be31d5`.
  All `61` directly referenced parameter names are present among the `63`
  fields returned by `target_policy_params()`.
- Reconstructing the candidate algebra over all `3346` states of a completed
  geometry-only trace produces finite commands within the unchanged
  componentwise acceleration limit.  The selector is active on `56.4%` of
  those frozen states and bounds its realized pose correction to `1.49 deg`
  under the inherited `2 deg` limit.  Its isolated bearing/crossflow mapping
  is sign-symmetric under reflection.  These checks establish targeting and
  contract safety only; they are not a closed-loop result.
