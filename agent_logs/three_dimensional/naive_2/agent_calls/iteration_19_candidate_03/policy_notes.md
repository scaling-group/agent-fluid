# Evaluated one-sided speed-guard candidate

## Visual and metric diagnosis before the edit

- All four sampled solvers satisfy the released evidence contract: direct
  uniform still-water initialization with `U_infinity=[0,0,0]`, no cylinders,
  no prewarm, finite dynamics, and capture. The assigned prefill and its exact
  repeat capture at `16.631994T` with score `-0.118307`; the raw-coordinate
  yaw-demodulation control captures at `16.637493T` with score `-0.119674`.
  The distinct one-sided speed-guard rollout is best at `16.609995T`,
  `0.745621L`, and score `-0.115560`.
- I inspected both rows of the combined keyframe sheets for the speed-guard
  result, the assigned prefill, and the weaker raw-coordinate control. The
  top-down rows show self-propelled targetward translation and a coherent
  alternating wake from release through capture; the oblique rows show finite,
  tail-connected three-dimensional Lambda2 structures. Their shallow capture
  arcs and wake class are nearly identical. No sampled rollout is a semantic
  failure, so the weaker controlled capture is the informative comparator.
- The diagnostics agree with the visual preservation. Relative to the assigned
  prefill, the one-sided guard lowers scored distance integral from
  `2.001992L` to `1.999656L`, observed distance integral from `1.378485L` to
  `1.377882L`, peak joint magnitudes from `0.547719/0.555689 rad` to
  `0.541097/0.549208 rad`, mean absolute requested acceleration from
  `22.7698/25.4341` to `21.7384/22.6911 rad/T^2`, and peak planar force/moment
  from `0.036777/0.018272` to `0.035828/0.017759`. At the same 99%-speed
  threshold, outward-command residence falls from `9.66%/14.42%` to
  `1.85%/1.39%`; overall near-speed residence remains comparable
  (`27.42%` versus `27.28%`), consistent with removing infeasible outward
  acceleration rather than weakening the carrier.
- The inherited optimizer logs provide the control boundary. The exact
  tangent-cone projection that activates only at the declared speed limit
  reproduced the assigned prefill bit-for-bit, so waiting for exact equality
  is an ineffective intervention under the released integration order. The
  phase-confidence startup gate delayed capture and worsened score, while
  broader wave relief and added terminal mean curvature previously damaged
  approach. The completed final-1% smooth guard is therefore evidence for a
  narrow actuator-feasibility mechanism, not permission to reduce carrier
  gains or expand terminal steering.

## Single policy hypothesis

Promote the completed one-sided speed guard as this workspace's sole policy
candidate. Preserve the assigned mean-preserving yaw-demodulated carrier,
route feedback, phase-selective posterior relief, and every evaluated gain.
After the existing smooth acceleration bound, normalize each measured joint
speed by the parameter-owned hard-speed envelope and smoothly remove only the
acceleration component pointing farther outward over the final 1% of that
envelope. Inward and reversal acceleration remains unchanged.

This state-feedback projection is clock-free, route-free, and acts identically
on both joints. The completed rollout supports retained capture and wake
topology with a small but consistent improvement in arrival, distance cost,
joint excursion, requested effort, force, and moment. Falsify reuse if capture
or the connected alternating wake is lost, the target-crossing arc changes
materially, reversal is delayed, joint contact appears, or any of arrival,
distance integral, outward-at-limit residence, joint excursion, force, or
moment regresses beyond the narrow completed advantage. Do not widen the guard
without a controlled rollout because doing so would become carrier attenuation.

bookshelf_consulted: true
source_domain: bounded low-dimensional robotic-fish CPG control and traveling-wave reactive propulsion
source_mechanism: preserve a useful rhythmic propulsive carrier while applying a separate state-feedback correction compatible with actuator feasibility
transferable_invariant: remove only the command component that points farther outward as normalized joint speed reaches its constraint, while preserving interior and reversal motion
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, waveform envelopes, exact vortex phases, maneuver timing, and task-specific routes
policy_translation: retain the body-frame two-joint carrier and steering policy, then use parameter-owned joint-speed limits to smoothly project only outward acceleration over the final one-percent speed band
falsification: reject if capture, arrival, distance cost, targetward arc, connected wake, reversal timing, joint contact, force, moment, or feasible command effort worsens

## Evaluation boundary

This candidate is the promotion of a completed sampled rollout, not a claim of
held-out robustness. A later evaluation should first require capture and the
same target-crossing/wake class, then compare arrival, scored and observed
distance integral, outward acceleration conditional on joint speed, mean/RMS
action, reversal timing, joint contact, peak force/moment, and both wake views.
Changed pose, inflow, morphology, or actuator integration remains outside the
current evidence.
