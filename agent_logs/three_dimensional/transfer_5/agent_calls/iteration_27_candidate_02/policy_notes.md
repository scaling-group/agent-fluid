# Joint-rate feasibility candidate

## Evidence diagnosis before editing

- I read the assigned-parent guidance, the four sampled solver evaluations, and
  the inherited optimizer notes and completed evaluations before proposing the
  controller. Every rollout used direct uniform still water at
  `U_infinity=(0,0,0)`, with no cylinders or prewarm, remained finite, and
  terminated in capture. The sampled set reduces to v33 at `23.84252T` and
  three exact replicas of the v37 split observer at `23.83702T`; the replicas
  have identical trajectories and visual sheets.
- I inspected the combined top-down mid-plane-vorticity and oblique 3D
  body/Lambda2 rows for sampled v33, the repeated v37 winner, the assigned
  parent's completed child, and the worst inherited half-cycle child. They all
  show self-propelled motion from an initially empty field, an ordered
  alternating wake, compact three-dimensional structures, a smooth
  target-directed arc, and capture without advection, wake breakup, boundary
  contact, or instability. No sampled rollout is a termination failure; the
  informative failures are the completed controller regressions, whose visual
  differences are below sheet resolution and therefore require metric and
  actuator-history comparison.
- Relative to v33, v37 improved score/mean/final distance from
  `-0.535091/2.433543L/0.746165L` to
  `-0.535013/2.433468L/0.746096L`, captured one control step earlier, and
  narrowly reduced inside-`3L` mean target-cross-track speed and peak moment
  from `0.239236U/0.013730` to `0.238678U/0.013581`. It retained a mixed yaw
  boundary: mean absolute yaw fell slightly to `1.679385 rad/T`, while peak yaw
  rose to `3.193864 rad/T`.
- Three completed descendants kept the same `23.83702T` capture class but did
  not improve the v37 distance result. Replacing the phase-response magnitude
  with the course-response magnitude regressed score/mean/final distance to
  `-0.535212/2.433604L/0.746410L`; adding displacement-rate quadrature to the
  half-cycle selector regressed them to
  `-0.535561/2.433904L/0.746654L`; and relieving the anterior oscillator
  envelope on the selected half-cycle regressed them to
  `-0.535880/2.434158L/0.746981L`. The first reduced inside-`3L` mean/peak yaw
  to `1.665740/3.170166 rad/T` but raised peak moment to `0.0141`; the latter
  two modestly reduced some cross-track or peak-yaw measures without recovering
  distance. This rejects another phase selector, correction-magnitude blend,
  or half-cycle envelope edit as the next useful axis.
- The repeated v37 trajectory has no joint-angle contact, and its smooth
  acceleration projection stays below `31.386 rad/T^2`, but `728` joint
  samples sit at the `260 deg/T` velocity cap. In `703` of those samples
  (`96.6%`), the recorded command accelerates in the same direction as the
  capped velocity. This is a distinct feasibility defect: the environment is
  repeatedly discarding outward command after the final acceleration
  projection. It is not evidence for changing cadence, posterior lag, or
  adding global joint-velocity damping, all of which would reshape the useful
  traveling wave.

## Single candidate hypothesis

Start from the evaluated v37 split observer and preserve its normalized
body-frame target feedback, response-released C-bend, anterior-only continuous
course observer, distributed phase classifier, posterior traveling-wave
target, terminal actuator allocation, cadence, and component-wise smooth
acceleration projection. Add one final state-feedback feasibility layer: in a
narrow band immediately below the known joint-rate envelope, smoothly remove
only acceleration that points farther outward; pass every inward/restorative
command unchanged. At the hard-rate boundary the projected outward component
is zero, matching the component the environment would otherwise discard.

The hypothesis is that unilateral rate-aware projection will reduce cap
residence and wasted command without acting like global damping or changing
the nominal gait away from the boundary. It should preserve the coherent wake
and v37-scale capture/progress while improving actuator feasibility and, if
the clipped impulses feed terminal yaw/load, their histories. Falsify it if
capture is lost or delayed, mean/final distance regresses materially, cap
exposure is not reduced, the alternating wake changes, restorative reversal is
slowed, or yaw/moment/load behavior worsens.

bookshelf_consulted: true
source_domain: actuator-constrained robotic-fish CPG control and efficient undulatory propulsion
source_mechanism: preserve the observed traveling-wave oscillator while enforcing its kinematic envelope through state feedback
transferable_invariant: remove only the command component that drives an observed joint farther outward near its rate boundary, while retaining inward reversal and the posterior-lagged carrier
nontransferable_details: published CPG gains, hardware torque-speed curves, species-specific envelopes, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: apply a bounded unilateral projection to each smoothly acceleration-limited command using only normalized joint velocity and parameter-owned rate-envelope values; leave target feedback and both oscillator targets unchanged
falsification: reject if CFD loses v37-scale capture or distance progress, fails to reduce joint-rate-cap residence, disrupts the coherent wake, slows reversal, or worsens yaw, moment, and command feasibility

## Non-CFD validation

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account and failed before inspecting the
  workspace. I therefore ran its prescribed checks directly.
- The guidance-materiality check passes: these notes exist and
  `guidance/control_experience.md` has an evidence-backed semantic change from
  the assigned parent. The repository-boundary check passes with exactly one
  nonempty candidate file in `solver/`.
- The prescribed Julia contract command cannot start because no Julia
  executable is installed. The deterministic static schema audit finds all
  `72` direct `params.FIELD` references among `74` returned fields, with no
  undeclared reference. Static guards find no explicit time/step input,
  randomness, file I/O, cylinder observation, mutable global state, or
  memorized route. The unchanged v37 core has completed CFD evidence; the new
  unilateral projection is deliberately left for post-worker evaluation.
- On the recorded v37 trace, the projection would affect `831/8668` joint
  commands; `703` are outward commands already at the hard rate boundary.
  This only checks scope and directionality and is not a rollout or evidence
  of improved dynamics. Candidate SHA-256:
  `378a457d6c8b4517f3a75d60e910a888d9ce53535dcfa1350da7c7f1a7f6c06a`.
