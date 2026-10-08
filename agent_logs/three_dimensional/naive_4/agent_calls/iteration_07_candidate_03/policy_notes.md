# Redirect allocation with closing-gated wave relief

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled evaluations are finite captures under the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, and inertial moving-window transport. Translation is self-propelled,
  not imposed advection.
- I inspected the combined and view-specific top-down and oblique sheets for
  the strongest actuator-quality sample, `solver_57f7c1352c72`, and the
  informative unallocated redirect, `solver_e44c6b14905f`. Both form a strong
  alternating red/blue mid-plane street and compact three-dimensional Lambda2
  structures, turn down-left, and retain the wake through capture. The current
  sample set contains no semantic failure; its useful failure is the parent
  redirect's actuator-quality cost rather than its route.
- The inherited redirect should remain. The unallocated version captures at
  `0.746L` and `16.291T`, but posterior acceleration occupies the hard limit in
  `60.4%` of samples. Redirect-priority allocation preserves the visible route
  and wake, captures at `0.748L` and `16.258T`, and cuts posterior limit
  residence to `22.5%`. It also reaches `5L`, `2L`, and `1.2L` about
  `0.028T`, `0.039T`, and `0.044T` earlier, respectively. This directly
  satisfies the inherited allocator's falsification test.
- Terminal treatments are distinguishable despite nearly identical images.
  The current full zero-bend hold reduces near-target force and acceleration,
  but captures at `16.269T` with score `-0.066867`. Preserving mean curvature
  while damping the anterior rhythm and attenuating only the posterior wave
  yields the best sampled score, `-0.066121`, and captures at `16.258T`. The
  full hold therefore gives away directional authority that a first-crossing
  task does not require it to remove.
- Inherited logs rule out shared anterior steering bias, two-sided half-cycle
  amplification, short-window yaw-rate feedback, and scalar carrier shrink.
  Those changes either quenched the traveling bend or retained the former
  upper-exit topology. No current evidence supports reintroducing them.

## Policy hypothesis

Produce one candidate that combines two compatible, already separated
state-feedback mechanisms. Preserve the captured anterior carrier, body-frame
target-versus-course redirect, posterior-only mean curvature, and one-sided
opposing-wave relief. First, retain the evidenced mean-first posterior
acceleration allocator: as response-gated redirect demand opens, admit the
joint-state wave only inside reserved posterior headroom or when it unloads
mean tracking. Second, replace the parent's zero-bend terminal hold with the
sampled closing-gated approach relief: proximity plus target-aligned body
velocity adds bounded anterior damping and reduces only posterior wave
amplitude, leaving the mean steering bend intact.

The gates use normalized body-frame target geometry and velocity, contain no
clock, route, or world coordinate, and revert continuously if closing is lost.
The combination should keep capture at no worse than `16.291T`, retain the
coherent wake, keep whole-trajectory posterior limit residence materially
below `60.4%`, and improve on the full hold's score without restoring its
zero-curvature terminal behavior. Falsify it if capture is lost or materially
delayed, the `5L`/`2L` approach milestones regress, posterior limit residence
returns near the unallocated level, or approach relief suppresses the visible
traveling wake before crossing.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion, biological burst redirection, and sensor-modulated robotic-fish terminal control
source_mechanism: preserve a traveling posterior bend in cruise, prioritize observed-error curvature within limited actuation during redirect, and relieve only excess oscillatory drive during reliable final closing
transferable_invariant: separate propulsive wave, directional mean bend, and terminal energy relief so state-dependent actuation limits do not erase the component needed for the current control regime
nontransferable_details: published gains, species-specific body envelopes and C-start shapes, dimensional approach distances, prescribed or vortex phase, morphology-specific torque, and task-specific routes
policy_translation: normalized body-frame target-versus-course error gates mean-first posterior acceleration allocation, while normalized target distance and target-aligned velocity gate bounded anterior damping and posterior-wave attenuation without removing mean curvature
falsification: reject if the coherent wake or capture disappears, arrival exceeds 16.291T materially, posterior hard-limit residence approaches 60.4%, or the closing gate coasts through a near miss instead of releasing

This candidate has no same-worker CFD result. Deterministic checks can establish
schema, boundedness, and symmetry only; closed-loop evaluation must establish
the trajectory and wake claims above.

## Non-CFD verification

- The guidance provenance check passes after removing a duplicated rendering
  of the same assigned-parent marker from the workspace README.
- The prescribed Julia policy-contract and solver-boundary checks pass.
- A deterministic `19,683`-state sweep across joint state, bearing, body-frame
  velocity, and target geometry returns finite bounded actions and exact sign
  reversal under lateral reflection.
