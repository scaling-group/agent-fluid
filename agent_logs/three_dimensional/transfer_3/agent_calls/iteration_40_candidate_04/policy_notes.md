# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations satisfy the experiment contract: direct uniform
  initialization, `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
  dynamics, and capture. The two exact actuator-consistent samples capture at
  `18.6725T` and `18.7330T`, with scores `-0.13219` and `-0.13142` and mean
  distances `2.02018L` and `2.01959L`.
- The combined keyframes for all four samples show body motion preceding a
  coherent alternating top-down vortex street. The oblique row retains compact
  body-attached and shed Lambda2 structures from `4T` through capture. This is
  self-propulsion, not still-water advection. No sampled rollout is a semantic
  failure; the most informative adverse mechanism sample is the assigned
  parent's moment-residual variant because it is the slowest capture
  (`18.7440T`), has the largest mean distance (`2.02198L`), and raises sampled
  force/moment RMS to `0.01343/0.00699` without a visibly different useful wake
  or trajectory.
- The one-sided joint-rate anti-windup sample preserves the same visual route
  and captures at `18.7000T`. Relative to the two exact actuator-consistent
  samples, posterior returned-action RMS falls from `28.72--28.77` to
  `28.24 rad/T^2` and acceleration-limit occupancy falls from
  `75.19--75.46%` to `73.91%`. Its `0.01333/0.00694` force/moment RMS and
  `18.7000T` arrival remain inside baseline spread, so the evidence supports a
  feasible-command improvement but not a speed or hydrodynamic-load claim.
- The inherited logs available in this workspace are represented by the
  curated parent experience; there is no separate inherited optimizer log
  under `logs/`. That record already rejects further instantaneous
  moment/residual allocation and scalar tuning, while explicitly requiring a
  repeat of the one-sided rate-boundary projection.

## Policy hypothesis

Replace the unreplicated stress-gated moment residual with the sampled
actuator-consistent phase route plus one-sided joint-rate anti-windup. At the
observed hard rate boundary, return zero only for acceleration that points
farther outward, retain full reverse braking, and reconstruct the persistent
same-side phase witness from the raw posterior demand when the previous
feasible action is zero. This isolates a hard-feasibility mechanism: it should
retain capture and the coherent carrier while replicating posterior returned
action below `28.72 rad/T^2` or acceleration occupancy below `75.19%`.
Falsify it if capture leaves the inherited `18.6725--19.0520T` band, mean
distance exceeds `2.02129L`, the alternating wake weakens, or the effort
reduction does not replicate. In that case restore the plain
actuator-consistent projection rather than tuning the rate threshold.

bookshelf_consulted: true
source_domain: robotic-fish CPG control and classical traveling-wave propulsion
source_mechanism: preserve a low-dimensional propulsive rhythm while sensor feedback modulates only a bounded residual
transferable_invariant: constraint feedback should remove infeasible outward work without interrupting the lagged traveling bend or reverse braking
nontransferable_details: published CPG gains, species kinematics, dimensional beat settings, prescribed phases, and task routes
policy_translation: retain the normalized body-frame LOS C-bend and joint-state posterior phase path; apply a reflection-equivariant one-sided projection only at the observed normalized joint-rate boundary
falsification: reject the projection if it loses capture or wake coherence, delays arrival outside the inherited band, or fails to replicate lower returned-action RMS or acceleration-limit occupancy
