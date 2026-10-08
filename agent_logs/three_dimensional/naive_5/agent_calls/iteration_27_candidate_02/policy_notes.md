# Response-gated turn-priority carrier envelope

## Evidence diagnosis before editing

- All four sampled solver rollouts satisfy the frozen experiment contract:
  direct uniform still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm snapshot, stable moving-window transport, and `capture`
  termination. Three byte-identical posterior-offset descendants capture at
  `0.748829L` and `26.2955T`; the coordinated-envelope control captures at
  `0.749242L` and the same time.
- The combined sheets for the posterior-offset descendant, the coordinated-
  envelope control, and the assigned parent's posterior half-cycle policy
  were inspected in both views. Their top-down rows show genuine
  self-propulsion, an organized alternating vortex train, and the same smooth
  left/down hook into the target disk. Their oblique rows retain a compact,
  connected three-dimensional wake through capture. No view shows passive
  advection, wake breakup, boundary interaction, or moving-window-induced
  rotation.
- The sampled posterior-offset edit moves the centerline by at most
  `0.000591L` relative to the coordinated-envelope control and changes neither
  the joint/load extrema nor visible topology. The assigned parent's genuinely
  beat-side-odd posterior redistribution is a stronger negative test: it
  changes 327 action rows by as much as `1.46513 rad/T^2`, yet moves the
  centerline by only `0.001492L`, captures at `0.749146L` and `26.3010T`, and
  retains exactly the control's maximum joint angle, rate, acceleration, peak
  planar force, and peak yaw moment (`0.772361`, `4.512809`, `29.725850`,
  `0.018834`, and `0.009789` in recorded normalized units). Its two-view sheet
  is visually unchanged. This is not a semantic improvement and does not
  support tuning either posterior terminal expression.
- At the best sampled terminal state, speed is about `0.648L/T`, with roughly
  `0.610L/T` transverse to the target line and only `0.219L/T` closing. The
  reconstructed target-line response deficit is still active, but prior
  anterior, posterior, recoil, damping, phase, and deeper-curvature terminal
  edits all preserve the same shallow crossing. The unresolved control issue
  is therefore excess propulsive translation while corrective steering is
  under-responding, not lack of another terminal waveform scalar.

## Policy hypothesis

Preserve the capture-proven traveling-bend carrier, large-error redirect,
line-of-sight response closure, coordinated acceleration projection, and
joint viability guards. Add one continuous turn-priority mode: when normalized
body-frame course misalignment is large, the target is within a middle-
approach neighborhood, closing remains positive, and the measured inertial
target-line turn is still under-responding, reduce only the carrier's energy
injection by lowering its effective limit-cycle amplitude and phase pump.
Keep half-cycle steering, redirect, and navigation authority unscaled. The
posterior joint continues to follow the observed anterior traveling bend, so
the mechanism trades thrust for turning time without introducing a clock,
route, world direction, or independent terminal pulse.

The new evaluation should activate earlier than the rejected `1.65L` terminal
edits, preserve the far wake, reduce transverse terminal speed, and create a
route change larger than the inherited milliscale cluster or a materially
deeper capture. Reject it if capture is lost, the far carrier changes, the
three-dimensional wake collapses, arrival slows without added clearance, or
angle/rate/acceleration contact or peak loads return.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG control and terminal capture scheduling
source_mechanism: observation-gated carrier-amplitude relief while corrective steering retains authority
transferable_invariant: when a productive rhythm is closing on a target but transverse course error remains large and turn response is deficient, temporarily trade propulsive energy for steering time without weakening the steering channel or changing the far carrier
nontransferable_details: published amplitudes and gains, dimensional beat frequencies, robot or species kinematics, clock phase, exact vortex phase, task-specific coordinates, and prescribed routes
policy_translation: use normalized target distance, body-frame velocity/target cross product, positive closing speed, and reconstructed inertial line-of-sight response to lower the state-feedback oscillator's effective amplitude and phase pump; leave the two-joint redirect and steering residuals at full authority and retain the existing feasibility projections
falsification: reject if the edit loses capture, changes commands outside the bounded response gate, repeats only the sub-0.002L route cluster, disrupts the coherent two-view wake, slows arrival without deeper clearance, or restores actuator contact or materially higher loads

## Non-CFD implementation audit

- A deterministic grid of 3,456 finite body-frame states gives exact lateral
  reflection equivariance. Relative to the evaluated coordinated-envelope
  control, all states at or beyond the `3L` outer gate pass through exactly;
  252 near, closing, course-misaligned, under-responsive states activate the
  mechanism, with a maximum two-joint command-component change of
  `2.18756 rad/T^2` and no output beyond the policy acceleration envelope.
- A representative high-transverse terminal state returns finite bounded
  accelerations. These are schema, symmetry, gating, and mechanism checks—not
  CFD evidence or a performance claim.
- The required checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were then
  run directly and separately: the reusable-guidance/schema check, finite
  two-joint Julia contract, and solver editable-boundary check all pass. The
  duplicate assigned-parent marker in the rendered workspace `README.md` was
  reduced to one so the first check could identify the parent unambiguously.
