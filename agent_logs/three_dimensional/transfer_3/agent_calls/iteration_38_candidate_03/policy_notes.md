# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent preserves the normalized LOS-rate C-bend, the traveling
  two-joint carrier, persistent same-side posterior phase recruitment, and a
  stress-gated yaw-moment residual. Its durable guidance already rejects
  scalar-only gain changes and further instantaneous fluid-response allocation.
- All four sampled solver results use direct uniform still-water initialization
  (`U_infinity=0`, no prewarm), remain finite, and capture. Three exact
  actuator-consistent policy copies capture at `18.6725--18.7330T`, score
  `-0.13362-- -0.13142`, and mean distance `2.01959--2.02129L`. The assigned
  parent residual captures at `18.7440T`, score `-0.13364`, and mean distance
  `2.02198L`; it does not separate from the baseline's run-to-run spread.
- Inherited optimizer logs also contain only captures but a much wider score
  range (`-0.13320` to `-0.16366` in the assigned parent, and
  `-0.14324-- -0.15464` in the other sampled parents). A small single-rollout
  score delta is therefore not evidence for another allocator.

## Visual diagnosis

The best finite actuator-consistent sheet (`solver_0f8ee73693ab`) and the
assigned-parent residual sheet (`solver_bdf6dd947707`) show the same useful
topology in both visual rows. From release through `18T`, the body follows a
smooth target-closing arc and leaves a regular alternating mid-plane vortex
street. The oblique Lambda2 row confirms body-attached three-dimensional wake
formation and a coherent downstream chain rather than passive advection. No
collision, wake collapse, loop, or late route reversal precedes capture. The
parent residual does not create a visibly distinct route or wake.

The quantitative distinction is an actuator-feasibility defect shared by all
four traces. The anterior/posterior joints sit at the `260 deg/T` speed limit
for `2.85--3.00%` / `7.02--7.36%` of samples. At essentially every one of those
samples (`2.82--3.00%` / `7.02--7.33%` of the whole rollout), returned
acceleration still points outward; reverse braking at the boundary is only
`0--0.03%`. Posterior speed saturation overlaps acceleration clipping for
`2.26--2.39%` of the rollout. Yet all sheets retain coherent wakes and all
captures lie in the same timing band, so changing carrier gains, route gains,
or fluid-response allocation is not supported.

## Policy hypothesis

Start from the replicated actuator-consistent policy, remove the unreplicated
yaw-moment residual, and add a one-sided joint-rate feasibility projection.
When an observed joint is at its normalized hard speed boundary, suppress only
acceleration that would drive farther outward; preserve all inward braking.
For the posterior phase gate, treat continued same-side raw demand at that
boundary as the persistence witness so the projected zero returned on the
previous step cannot silently disable the established phase actuator. This is
one anti-windup mechanism, not a carrier or route gain change.

Expected result: outward command occupancy at the speed limit should approach
zero while the alternating wake, route, capture, and reverse braking remain
unchanged. Falsify the candidate if it loses capture, leaves the sampled
`18.6725--19.0520T` arrival band, exceeds `2.02129L` mean distance or
`0.01350/0.00703` force/moment RMS, alters wake phase, or fails to reduce
redundant outward action.

## Bookshelf transfer record

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation under bounded actuation
source_mechanism: preserve a traveling rhythmic carrier while observed state gates a small feedback modulation
transferable_invariant: constraint feedback should remove only an infeasible command component without erasing the propulsive wave or useful reverse response
nontransferable_details: published CPG gains, species kinematics, dimensional beat frequencies, exact vortex phases, and task routes
policy_translation: use normalized joint rate versus its owned hard limit to project only outward acceleration; preserve the LOS C-bend, posterior lag, phase recruitment, and braking
falsification: reject if capture or coherent wake is lost, braking changes, arrival leaves the sampled band, or outward-at-limit action is not reduced
```
