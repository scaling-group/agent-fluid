# Joint-speed kinetic-headroom candidate

## Visual and rollout diagnosis before the edit

- All four sampled solver rollouts satisfy the direct-uniform still-water
  contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and terminate in
  capture. Three reproduce the unguarded inertial line-of-sight response at
  `0.749769L` and `27.6045T`; the prefilled two-joint stopping-margin guard
  captures at `0.749992L` and `27.7695T`. Their top-down rows show controlled
  leftward translation followed by a late downward rotation through the target,
  while their oblique body/Lambda2 rows retain an organized, body-attached 3D
  alternating wake. The fish advances with that wake through 260--264 lossless
  moving-window shifts, so the visible route is self-propulsion rather than
  storage-window advection.
- The inherited terminal-traveling-bend failure is the informative visual
  contrast. Its top-down row follows the same broad corridor but passes above
  the target, reaches only `0.875770L` at `27.269T`, and continues to a
  left-domain exit at `39.925T`; its oblique row still shows a coherent 3D
  wake. The sampled line-of-sight response therefore contributes a real late
  route correction rather than merely a stronger wake or a moving-window
  artifact, and that target-line mechanism should not be replaced by another
  terminal waveform or release threshold.
- The evaluated prefill guard supplies a positive safety result beyond scalar
  score. Relative to the repeated unguarded capture, it removes exact `45 deg`
  angle contact (peak `43.86 deg` rather than `45 deg`) and reduces peak planar
  force/yaw moment from `0.03397/0.01548` to `0.02212/0.01041`, while retaining
  capture, essentially unchanged mean distance (`2.61546L` versus `2.61565L`),
  and peak speed (`0.68458L/T` versus `0.68487L/T`). The assigned parent's
  posterior-only stopping governor independently captures at `0.749430L`, has
  no angle contact, and similarly low peaks (`0.02154/0.00992`), supporting the
  reusable principle that predictive envelope feedback can preserve the
  target-line carrier.
- Neither guard resolves velocity saturation. The prefilled guard still has
  1,144 of 5,049 trace samples with at least one joint at the `260 deg/T` cap
  and 1,700 samples with at least one command at the `30 rad/T^2` clamp. That
  persistent cap residence, despite angle and load improvement, identifies
  missing kinetic-headroom regulation rather than missing target-turn gain.

## Policy hypothesis

Preserve the evaluated traveling-bend carrier, posterior follower, body-frame
target/course selector, same-sign redirect, terminal miss veto, inertial
line-of-sight positive-response-deficit branch, and two-joint stopping-angle
guard exactly. Add one symmetric speed-envelope barrier after the angle guard.
For each joint, normalize observed angular-speed magnitude between a soft speed
boundary and the physical speed limit. When the current command would increase
that magnitude, smoothly blend its outward component toward bounded inward
braking as speed headroom vanishes; leave inward commands and all commands below
the soft boundary unchanged. Absolute speed defines the gate and signed speed
defines braking direction, so the mechanism is reflection-equivariant, owns no
clock or route state, and cannot add energy to a near-limit joint.

The falsifiable expectation is repeat capture with the same coherent wake and
late target-directed route, no angle contact, and materially less joint-speed
cap residence without increased acceleration-clamp residence, peak planar
force, or yaw moment. Reject the barrier if capture is lost, the route changes
before near-limit velocity events, the carrier loses propulsion, speed-cap
residence is not reduced, braking chatter appears at the soft boundary, or
command/load exposure rises. The current worker does not claim these unevaluated
CFD outcomes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG and bounded residual control
source_mechanism: preserve a productive rhythmic carrier while measured actuator state gates the smallest residual needed to keep the carrier inside its usable envelope
transferable_invariant: constrain rhythmic energy only where observed phase speed is exhausting finite authority, leaving the traveling-wave and task response intact elsewhere
nontransferable_details: published CPG gains, linkage inertia, species-specific speed envelopes, dimensional beat timing, exact vortex phases, world coordinates, and task-specific routes
policy_translation: normalized absolute joint speed between parameter-owned soft and hard limits smoothly gates only the outward acceleration component toward signed inward braking for each of the two joints
falsification: reject if capture or the late line-of-sight turn is lost, the coherent wake weakens, speed-cap residence does not fall, or acceleration-limit, force, moment, or angle-boundary exposure increases

## Non-CFD implementation audit

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were then run
  directly and separately. The initial guidance check exposed two identical
  assigned-parent markers in the rendered workspace `README.md`; removing only
  the duplicate resolved parent identity. The guidance semantic-delta check,
  finite Julia policy contract, and solver editable-boundary check all pass.
- All `42` directly referenced parameter fields are owned by
  `target_policy_params()`, and exactly one non-empty candidate policy exists
  under `solver/`. A synthetic state below the `240 deg/T` soft speed boundary
  gives byte-identical actions to the evaluated prefill. A synthetic
  `255 deg/T` outward joint-1 state changes its acceleration from `+7.544` to
  `-3.884 rad/T^2`; reflecting every lateral target, velocity, rate, angle, and
  angular-speed signal negates both outputs with zero numerical error.
- Applying only the new final speed-barrier algebra to the sampled guarded trace
  changes `1,026` joint-1 and `390` joint-2 recorded actions (`1,020/382` by
  more than `0.1 rad/T^2`). It changes no below-soft-limit or already-inward
  command and never increases outward joint power. Material activation spans
  `1.061--24.409T` and remains at least `2.224L` from the target, confirming
  that this is a carrier-envelope intervention rather than an unevidenced
  terminal pulse. This frozen-state audit establishes locality, direction,
  symmetry, boundedness, and schema coverage only; it cannot predict the
  counterfactual joint trajectory, wake, saturation residence, or capture.
