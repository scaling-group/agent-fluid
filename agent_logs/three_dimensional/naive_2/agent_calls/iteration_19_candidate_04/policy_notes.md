# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations use direct uniform still-water initialization
  with `U_infinity=[0,0,0]` and terminate in capture. There is no sampled
  failure sheet in this workspace, so the assigned-parent capture is compared
  with the slowest finite capture and with the inherited upper-exit failures
  summarized in `guidance/control_experience.md`; the absence of a current
  failed rollout limits causal claims.
- The assigned parent (`solver_a2617fc44329`) captures at `16.6100T`, reaches
  `0.7456L`, and scores `-0.115560`. Its combined keyframe sheet shows
  self-propelled target approach rather than background advection: the
  top-down row develops a persistent alternating red/blue street behind the
  fish, and the oblique row shows tail-connected three-dimensional Lambda2
  structures through the final target crossing. No wake collapse or terminal
  instability is visible.
- The slower raw-`q1` demodulation capture (`solver_a46c8c6241a4`) has the same
  visible route and wake topology but arrives at `16.6375T`, scores
  `-0.119674`, and has slightly larger peak planar force/moment
  (`0.03687/0.01856` versus `0.03583/0.01776`). The two identical
  mean-preserving, unguarded samples arrive at `16.6320T` and score
  `-0.118307`; their duplicated policy and image hashes count as repeatability,
  not independent mechanism evidence.
- On the logged mean-preserving trace without the speed guard, at least one
  joint is above `0.99` of the `260 deg/T` speed limit while acceleration still
  points outward on `24.07%` of steps. The completed 99%-onset parent reduces
  that reconstructed fraction to `3.25%`, retains capture, trims maximum joint
  excursions from `0.5477/0.5557` to `0.5411/0.5492 rad`, and slightly lowers
  peak load. Acceleration-limit residence remains high (`73.91%` within 5% of
  the limit), so adding carrier strength or curvature is not supported.

## Bookshelf protocol

The fish-control shelf and its primitive/source references were reviewed after
the rollout evidence. This is a later iteration, and the inherited record does
not show three consecutive completed iterations without either a new mechanism
or a semantic improvement: joint-phase demodulation produced capture,
mean-preserving demodulation improved the capture, and speed-feasibility
projection preserved it with a better score. Therefore the structured
later-iteration consultation trigger is not active. No bookshelf primitive or
source family is used to justify the scalar guard-width refinement below.

```text
bookshelf_consulted: true
source_domain: none; protocol audit only
source_mechanism: none adopted for this edit
transferable_invariant: not applicable
nontransferable_details: published gains, kinematics, phases, and routes remain excluded
policy_translation: direct rollout evidence alone motivates a narrower actuator-feasibility test
falsification: do not attribute the result to the shelf; compare capture, route, wake, loads, and constraint residence with the completed 99%-onset parent
```

## Single candidate hypothesis

Preserve the complete successful route controller, mean-preserving yaw
demodulation, traveling-wave carrier, and one-sided nature of the speed guard.
Change only the normalized guard onset from `0.99` to `0.98`. This tests whether
removing outward acceleration a little earlier in the infeasible approach to a
hard speed clamp can further reduce clamp-driven joint excursion and load
without delaying inward beat reversal or changing the target-crossing arc.

Falsify the candidate if it loses capture; arrives later than the `16.6100T`
parent; changes the alternating/tail-connected wake topology; increases peak
force, moment, angle contact, speed-limit residence, or acceleration-limit
residence; or turns this local feasibility projection into broad wave relief.
Because this candidate's CFD runs only after worker exit, none of these outcomes
is claimed here.
