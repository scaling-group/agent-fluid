# Projected-capture-corridor yaw hold candidate

## Visual and metric diagnosis before the policy edit

- All four sampled solvers are byte-identical policy and combined-keyframe
  repeats. They satisfy the released direct-uniform still-water contract with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite moving-window
  dynamics, and capture at `16.604496T`, `0.743958L`, score `-0.113729`, and
  scored distance integral `1.998146L`. Their exact nominal replication does
  not establish pose, flow, or controller-family robustness.
- I inspected both rows of the combined sampled sheet from release through
  capture and compared them with the inherited LOS-rate control at score
  `-0.118996`. The top-down views show self-propelled targetward translation,
  a coherent alternating vorticity street, and the same shallow final arc;
  the oblique views show compact, finite, tail-connected three-dimensional
  Lambda2 structures. Neither is passive advection, wake breakup, collision,
  boundary exit, or instability. The visually unchanged wake in the weaker
  control makes its higher distance cost a directional-control regression,
  not evidence for changing propulsion.
- The inherited logs supply controlled negative results on the assigned
  parent. Phase-demodulated LOS-rate feedforward, bearing demodulation, and
  yaw-moment residual rejection all retained capture but worsened score and
  distance integral. The two most recent completed terminal mechanisms also
  failed to improve the parent: high-alignment yaw-response release captured
  one step earlier at `16.598995T` but regressed to `-0.114037` and
  `1.998380L`, while closure-deficit posterior redirection captured at
  `16.609995T` and regressed to `-0.114215` and `1.998537L`. Thus neither
  generic terminal release nor extra posterior attenuation should be
  gain-tuned; the missing boundary is whether the current velocity already
  intersects the capture neighborhood.
- Replaying the assigned trace in observation coordinates shows why target
  alignment is too broad a hold trigger. The completed high-alignment gate is
  nonzero for `356/3019` samples. A forward projected-miss corridor of `0.5L`
  below `3L`, using the same phase-demodulated velocity and yaw-release
  authority, is nonzero for only `152/3019` samples. It is silent at the late
  `1.269L` course excursion where projected miss is `0.779L`, but becomes
  strong when the projected path passes close to target, including a peak
  near `0.975L`; at the final parent sample the projected miss is `0.191L`.
  This is offline localization, not a closed-loop CFD prediction.

## Sole policy hypothesis

Preserve the evaluated anterior oscillator, raw body-frame target geometry,
mean-preserving yaw and lateral phase demodulators, raw-course anterior
center, posterior route/crossflow feedback, phase-selective relief, smooth
acceleration bound, and one-sided speed guard. Add one terminal capture hold:
below `3L`, compute the perpendicular miss distance of the current
phase-demodulated body-frame velocity ray from the target. Smoothly release at
most the previously tested `35%` of only the additive posterior yaw-response
term when the ray points targetward and passes through an inner `0.5L`
corridor. Restore full yaw response whenever the ray leaves that corridor.

Unlike the failed alignment-only hold, a fixed angular agreement is not
enough: the same course angle maps to a large miss far away and a small miss
near capture. The new mechanism is bounded, reflection-equivariant,
clock-free, and target-translation invariant. It changes neither propulsive
amplitude nor route sign. Falsify it if capture, pre-`3L` action identity,
distance integral, final crossing depth, connected wake, joint feasibility,
effort, force, moment, or score regresses; also reject it if the hold remains
active when projected miss exceeds its owned corridor or if it cannot improve
on the alignment-only negative control.

bookshelf_consulted: true
source_domain: terminal prey-capture control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve rhythmic propulsion while an observed approach condition selectively releases a fast directional correction
transferable_invariant: separate the productive traveling carrier from terminal steering and release only the correction whose current target-relative response already projects through the capture neighborhood
nontransferable_details: published gains, dimensional speeds, species or robot kinematics, maneuver timing, exact vortex phase, prescribed routes, and source-task capture geometry
policy_translation: use normalized body-frame target and phase-demodulated velocity to form a forward projected-miss corridor, then attenuate only the posterior yaw-response addend while leaving raw route, crossflow, carrier, and actuator guards intact
falsification: reject if nominal capture or the pre-approach route changes, projected interception or distance cost does not improve, the connected wake changes class, or joint contact, feasible effort, force, moment, or score worsens

## Evaluation boundary

No CFD result is claimed for this unevaluated workspace. Later evaluation
must require capture and the same two-view wake class first, then compare
arrival, scored and observed distance integrals, crossing depth, projected
miss, hold duty, joint contact, near-limit residence, mean action, and peak
force/moment against both the exact `-0.113729` parent and the completed
alignment-only hold. A changed pose, flow, success radius, observation filter,
or carrier family may require a different corridor and is a direct
falsification test rather than evidence for copying this nominal geometry.
