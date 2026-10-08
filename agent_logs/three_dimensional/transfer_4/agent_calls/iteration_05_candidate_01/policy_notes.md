# Candidate diagnosis and hypothesis

## Inherited evidence

- All sampled evaluations report direct uniform quiescent initialization,
  `U_infinity=[0,0,0]`, no cylinders, and capture. Three samples are exact
  repeats of the prefilled signed-curvature rate-governor policy: capture at
  `23.3640T`, score `-0.51275`, center path `13.3177L`, and distance integral
  `183.4076 L*T`. The distinct course-cadence sample captures at `23.3585T`
  with score `-0.51528`, path `13.4189L`, and distance integral
  `183.9437 L*T`.
- In both distinct top-down sheets, an alternating vortex street grows only
  after release and follows sustained target progress (`12.3L` initially,
  about `10.5L` at `9T`, `7.4L` at `14T`, and `4.8L` at `18T`). The fish turns
  continuously into the capture circle near `23.36T`; there is no visible
  passive advection or prewarm wake. Both oblique Lambda2 sheets show compact
  three-dimensional alternating structures shed from the posterior body and
  retained through the terminal turn, rather than a wake collapse or a
  planar-only artifact.
- The selective rate governor is therefore worth preserving. Relative to the
  distinct sample without it, it removes exact `260 deg/T` contacts, reduces
  peak angles from `27.61/37.19 deg` to `27.48/36.75 deg`, shortens the path,
  lowers the distance integral, and improves score despite arriving only
  `0.0055T` later. Its intervention remains late: `15.68%/3.58%` of samples
  are still above 96% of the joint-rate envelope, while the two acceleration
  ceilings remain active for `69.61%/50.68%` of samples.
- The assigned parent also records the informative failure boundary unavailable
  as a sampled failure sheet here: old asymmetric request-to-curvature mapping
  and later route/allocation variants missed on opposite sides and terminated
  at a boundary. Thus the bounded odd curvature map is held fixed; acceleration
  saturation, not steering polarity, is the remaining tested deficiency.

## Policy hypothesis

Add one upstream mechanism: compute a smooth pressure from the maximum observed
joint-rate fraction and continuously ease the state-feedback carrier frequency
before either joint reaches the envelope. Retain the late sign-aware governor
as a safety layer and leave target geometry, odd mean curvature, half-cycle
steering, approach scheduling, and full reversal authority unchanged. This is
state-conditioned rhythm modulation, not a global cadence-gain edit or another
output clamp.

Falsification: the next CFD evaluation should retain capture and the coherent
top-down/oblique wake while reducing acceleration-ceiling residence and
joint-rate-envelope residence, without increasing path or distance integral.
Reject the mechanism if capture is lost, arrival degrades materially beyond the
current approximately `23.36T`, either limit residence increases, or the
posterior alternating wake visibly weakens.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation under sensor feedback
source_mechanism: modulate a rhythmic carrier from measured state while retaining a low-dimensional propulsive pattern
transferable_invariant: actuator-state feedback should relieve an approaching envelope upstream while preserving the propulsive traveling bend
nontransferable_details: published oscillator gains, dimensional frequencies, species envelopes, prescribed phases, and task routes
policy_translation: use the maximum normalized observed joint rate to apply smooth bounded relief to the state-feedback carrier frequency; preserve the two-joint posterior lag and odd body-frame target-curvature map
falsification: reject if matched CFD loses capture, increases path or distance integral, increases rate or acceleration limit residence, or disrupts the coherent three-dimensional alternating wake
