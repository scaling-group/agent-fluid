# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held in the upper-right while four
  staggered vortex streets develop and merge across the target corridor. This
  is a common initial condition, not candidate-specific evidence.
- All four sampled solver evaluations reach the target with exactly the same
  metrics: `34.7105` released time, `1.62283L` mean distance, `46985.9`
  total command energy, `0.240234` RMS relative crossflow, and
  `68.963/1036.40` RMS force/moment. Their sheets show an immediate targetward
  redirect followed by a coherent, self-propelled upstream traverse and direct
  first entry into the `0.75L` capture circle. Head displacement
  `(-10.923,-4.166)L` against mean local flow `(-0.202,-0.172)U` corroborates
  propulsion rather than passive advection. Three sampled files differ only in
  explanatory comments, so the four identical outcomes represent replication,
  not distinct mechanisms.
- No current sampled sheet is a semantic failure. The assigned parent's
  phase-filtered moment credit is the informative negative comparison: its
  five-frame sheet has the same route topology, but arrival regresses to
  `34.8370`, mean distance to `1.63062L`, total energy to `47147.5`, and
  force/moment RMS to `78.707/1184.745`. Inherited logs also report that a
  targetward anterior-phase gate raised load, actuator-local burst release
  regressed every main finite metric, and fast bearing-trend steering exited
  with negative progress. Locomotor phase, local actuator pressure, and a fast
  derivative residual therefore are not reintroduced as route or unloading
  signals.
- The incumbent remains at the joint-speed and `30.0` acceleration envelopes,
  and its substantial moment load is incurred during the visually sharp
  redirect. The established controller credits recent line-of-sight closure,
  but that quantity mixes physical body yaw with translation of the target
  vector and can lag the onset of a useful turn. The policy observation exposes
  normalized `heading_rate`, allowing a direct response signal without a
  hidden clock, wake phase, or coordinate route.

## Candidate policy hypothesis

Preserve the state-feedback traveling-bend carrier, posterior lag, course-slip
correction, raw-bearing mean steering and reserve, base half-cycle asymmetry,
all-phase signed moment credit, and one whole-body speed release. Add one
response-gated burst mechanism: classify measured body yaw as useful only when
its sign agrees with the persistent raw-bearing request, normalize the yaw
accumulated over one carrier period by the existing bearing scale, and combine
that credit with recent bearing closure. The signal can withdraw only the
optional redirect burst; it cannot attenuate propulsion, mean steering, base
asymmetry, or actuator reserve.

Expected evidence is retained capture and redirect/upstream topology with less
redundant burst during the initial turn, reducing total effort or force/moment
without materially regressing the `34.7105` arrival and `1.62283L` mean
distance. Reject the mechanism if capture or upstream propulsion is lost, if
arrival/mean distance regress without a meaningful effort/load benefit, or if
force/moment exceed the assigned phase-gated parent's `78.707/1184.745`.

```text
bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish direction control
source_mechanism: release a strong redirect into rhythmic propulsion when measured heading response appears
transferable_invariant: persistent target error requests the maneuver, while correctly signed physical yaw response may release only surplus maneuver authority
nontransferable_details: published gains, C-start body envelopes, clocked CPG phase, species kinematics, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: normalize body-frame `heading_rate` over the endogenous carrier period by the bearing scale, credit only yaw whose sign agrees with raw bearing, and combine it with bearing-closure credit inside the optional half-cycle burst
falsification: reject if capture or coherent upstream propulsion is lost, or if arrival and route regress without lower effort or load; a changed wake phase is required before any robustness claim
```
