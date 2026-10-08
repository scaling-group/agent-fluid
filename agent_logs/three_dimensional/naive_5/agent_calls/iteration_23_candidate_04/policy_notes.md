# Course-response closure candidate

## Visual and metric diagnosis before editing

- The four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. The two direction-preserving common-envelope policies reproduce
  capture exactly at `0.749242L` and `26.2955T`; their executable files differ
  only in indentation. The two speed-guard predecessors likewise reproduce
  `0.749366L` and `27.5770T`. The inherited optimizer logs add a third exact
  common-envelope execution. These repeats establish fixed-condition
  determinism, not initial-pose or target-location robustness.
- In the best and lower-scoring combined sheets, the top-down vorticity row
  shows genuine self-propulsion from rest, an alternating coherent wake, and a
  late correct-sign hook into the capture circle. The oblique body/Lambda2 row
  shows a connected three-dimensional wake along the same useful route. The
  wake trails the body through `252--255` storage-window shifts, so the motion
  is neither imposed-flow advection nor a window artifact. The lower-scoring
  sample is informative as a command-coordination failure rather than a
  termination failure: both variants capture, but its independent hard
  clipping distorts the two-joint command relationship.
- The common envelope removes all `1686/10028` exact acceleration-clamp
  samples, retains zero angle and speed contacts, advances the distances at
  `8/16/24T` from about `10.71/6.71/2.44L` to `10.46/6.23/1.90L`, and lowers
  peak planar force/yaw moment from `0.02218/0.01034` to
  `0.01883/0.00979`. It is therefore retained with the predictive angle and
  selective speed guards downstream. Inherited failures already reject
  stronger scalar rate braking, terminal damping or recoil, deeper terminal
  curvature, and a beat-scale binary intercept hold.
- A route-level response deficit remains before the `1.75L` approach
  neighborhood. On the completed common-envelope trace, whenever translation
  is observable and the blended body-frame course request has magnitude above
  `0.25`, its phase-rejected yaw response has the wrong sign for `1255/3547`
  samples and is below half of a conservative `0.10*abs(turn_side)` normalized
  yaw request for `2004/3547` samples. The longest under-response intervals are
  about `0.7--0.8T`, not one-step noise, while the head remains in the high
  corridor until the late turn. The speed-guard predecessor shows the same
  topology (`1395` wrong-sign and `2361/3777` under-responsive samples), so the
  defect is not created by common command compression.

## Policy hypothesis

Preserve the evaluated traveling-bend carrier, posterior lag and allocation,
body-frame target/course selector, large-error redirect, terminal miss veto,
inertial line-of-sight response residual, common acceleration envelope, and
angle/speed viability guards. Add one far/middle-route response closure through
the already calibrated anterior half-cycle channel. The desired yaw magnitude
is a bounded function of the blended body-frame turn request. Compare it with
the phase-rejected measured yaw response and add authority only for the
positive deficit. Gate the addition by observable translation and positive
closing, remove it continuously inside the existing `1.75L` approach region,
and suppress it while the established large-error redirect is active.

This is a feedback-structure test, not a scalar selector increase: adequate
yaw is never cancelled or amplified, the posterior traveling bend is not
rewritten, and the terminal capture funnel is unchanged. The falsifiable
expectation is earlier downward course alignment and lower arrival/distance
cost with the same coherent wake, capture, zero limit contacts and hard
clipping, and comparable or lower force/moment peaks. Reject the mechanism if
it restores the early curl, changes the terminal funnel, over-turns, loses
capture or propulsion, creates actuator contact/clipping, or raises load
exposure. The new CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and reactive traveling-wave propulsion
source_mechanism: measured directional error modulates a coupled rhythmic carrier while the anterior-to-posterior wave remains the propulsion scaffold
transferable_invariant: add bounded steering only when observed body response falls short of a normalized target-geometry request, leaving adequate response and the productive traveling bend intact
nontransferable_details: published gains, dimensional frequencies, species-specific body envelopes, exact vortex phases, full-body waveforms, Strouhal targets, and task-specific routes
policy_translation: compare the blended normalized body-frame course request with phase-rejected yaw response; apply only its positive deficit through the anterior state-inferred half-cycle channel outside the terminal region and established redirect
falsification: reject if course alignment or arrival does not improve, the far route over-turns, the terminal path changes, or capture, wake coherence, actuator viability, clipping, force, or yaw-moment exposure worsens

## Non-CFD implementation audit

- The mandated checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this ChatGPT account and failed before executing. Its
  three configured commands were run directly: the guidance semantic-delta
  check, finite two-action Julia contract, complete parameter-schema check
  (`45` direct references), and solver repository boundary check pass. Exactly
  one non-empty main candidate exists under `solver/`; no CFD was run.
- On a representative far-route state with a wrong-sign phase-rejected yaw
  response, the parent command `(-5.8069,3.9663)` becomes
  `(-6.2267,3.9663) rad/T^2`: only the calibrated anterior steering channel
  changes. A state inside the fully active approach gate and a state with
  adequate yaw response both match the assigned parent exactly.
- Reflecting target lateral position, bearing and rate, body lateral velocity,
  yaw response, and both joint states negates both candidate accelerations to
  better than `1e-12`. This checks boundedness, pass-through boundaries, and
  reflection equivariance only; it is not evidence for the unevaluated CFD
  trajectory.
