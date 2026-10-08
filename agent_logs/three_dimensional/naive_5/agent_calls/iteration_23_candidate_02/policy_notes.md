# Coupled kinetic-headroom candidate

## Visual and metric diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and capture. They reduce to
  two trajectory-identical pairs: the selective speed-guard controller
  captures at `0.749366L/27.5770T`, while the assigned parent's promoted
  common acceleration envelope captures at `0.749242L/26.2955T`. Duplicate
  executions establish deterministic fixed-pose behavior, not geometric or
  held-out robustness.
- In both unique combined keyframe sheets, the top-down row shows genuine
  translation from rest, an organized alternating wake, and a late
  target-directed hook into the capture circle. The oblique body/Lambda2 row
  retains connected three-dimensional vortical structures along the same
  route. The wake trails the moving body while the storage window follows it,
  so neither success is imposed-flow advection or a moving-window artifact.
  There is no current non-capture sheet; the speed-guard pair is the
  informative control-envelope comparison, and inherited logs supply the
  failed terminal-waveform and stronger scalar-governor contrasts.
- The assigned parent's common command envelope is a real improvement: it
  removes all `1686/10028` exact acceleration-clamp samples, keeps zero angle
  and exact speed contacts, advances capture by `1.2815T`, lowers the distance
  integral from `2.61279L` to `2.51998L`, and lowers peak planar force/yaw
  moment from `0.02218/0.01034` to `0.01883/0.00979`. At capture it is also
  still closing through the circle instead of approaching tangentially.
- Zero exact rate contact does not mean useful kinetic headroom. In the
  promoted trace, `1704/9562` joint samples are at or above `250 deg/T`,
  `1430/9562` are at or above `255 deg/T`, and `449` of the over-`250 deg/T`
  samples still receive speed-increasing acceleration. Its two-joint RMS rate
  exceeds `240 deg/T` for 310 steps, 161 with positive net joint work. The
  inherited stronger per-joint rate brake left 34 exact contacts and raised
  clamp/load exposure, so this evidence does not support another scalar brake
  increase.

## Policy hypothesis

Preserve the evaluated traveling-bend carrier, target/course selector,
redirect and release logic, line-of-sight response residual, common
acceleration envelope, and downstream angle/speed viability guards. Add one
reflection-equivariant kinetic-headroom modulation between the common command
envelope and the state-safety guards. Normalize the Euclidean two-joint rate
by `sqrt(2)` times the existing joint-speed limit. Above a soft normalized
rate band, use the positive cosine alignment between the joint-rate vector and
the two-joint acceleration vector as a bounded net-energy-injection gate.
Smoothly scale the complete two-joint command by one common factor. Therefore
speed-reducing or power-neutral commands pass unchanged, the instantaneous
anterior/posterior command ratio is retained, and the individual angle and
speed guards remain downstream with full braking authority.

The falsifiable expectation is repeat capture and coherent wakes with fewer
near-limit rate samples and no increase in hard clipping, angle/rate contact,
arrival time, distance integral, or force/moment peaks. Reject the mechanism
if shared modulation suppresses the late target-line response, loses capture
or propulsion, changes commands below the kinetic soft band, weakens inward
braking, or merely trades rate residence for larger loads or a slower route.
The candidate's CFD evaluation occurs after this worker exits and is not used
as evidence here.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: coordinated anterior-to-posterior motion sustains reactive propulsion while observed actuator state can modulate energy supplied to the rhythmic carrier
transferable_invariant: near a joint-kinetic envelope, reduce only net energy-injecting actuation through a shared modulation that preserves the instantaneous two-joint command relationship; do not disturb decelerating commands
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, full-body waveforms, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: compute normalized two-joint RMS rate and positive rate-command alignment from joint state; above a soft band, smoothly apply one common scale before the unchanged body-frame state-safety guards
falsification: reject if coherent propulsion or capture is lost, sub-band or net-decelerating commands change, state-safety braking is weakened, near-limit residence fails to fall, or arrival, distance integral, force, moment, or clipping worsens

## Non-CFD implementation audit

- The required checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account. Running its three prescribed commands
  directly and separately passes the material-guidance/schema check, the
  finite two-joint Julia contract, and the solver editable-boundary check.
- A deterministic 2,250-state grid confirms finite bounded commands, exact
  lateral reflection equivariance, and exact equality with the sampled parent
  below the kinetic soft band. The new mechanism changes 38 high-rate grid
  states and leaves the final `30 rad/T^2` numerical bound intact. This checks
  contract and mechanism invariants only; no CFD or physical outcome is
  claimed.
