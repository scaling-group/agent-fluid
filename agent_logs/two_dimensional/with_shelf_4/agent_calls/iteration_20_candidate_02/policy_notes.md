# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the held fish above and downstream of four
  already-developed, interacting vortex streets; it is a common initial
  condition, not candidate-specific evidence.
- No sampled solver terminates in failure. The most informative comparison is
  therefore the strongest finite rollout (`solver_156008611089`) against the
  three repeated independent-guard materializations, represented by
  `solver_8254a7bac4e5`.
- Both released sheets show self-propelled alternating bends, an initial
  targetward redirect, and upstream travel through the merged wake into the
  capture circle. The shared-guard sheet retains that topology but shows a
  shallower late redirect and terminates at its frame 14 sample rather than
  the independent guard's frame 15 sample. The metrics confirm that this is
  useful motion rather than a visual wake artifact.
- Replacing separate joint lag-power guards with one total signed lag-power
  guard advances capture from `123.018` to `118.024`, reduces mean distance
  from `3.594L` to `3.560L`, total command energy from `95084` to `89079`, and
  RMS crossflow/force/moment from `0.14287/17.03/334.45` to
  `0.13833/16.74/329.67`. Maximum bends and posterior acceleration also fall
  slightly while anterior acceleration retains the same peak. This is a
  one-mechanism policy difference; the common wake snapshot means it is not
  yet evidence of robustness to another wake phase.

## Policy hypothesis

Materialize the sampled shared guard as this workspace's single candidate.
Treat the anterior and posterior history deltas as one coupled traveling-wave
response: sum their normalized signed lag power, then use one smooth weight for
both joints. This permits energy-removing lag in one joint to balance lag in
the other while bypassing the whole delayed command when its net effect keeps
injecting kinetic energy. Preserve the evidenced bearing/progress route owner,
direct bounded moment residual, zero-mean half-cycle steering, raw oscillator,
and posterior lag. Reject the mechanism later if it loses capture or the
alternating wave, or fails to improve arrival, distance, and effort/load
together over the independent guard under a matched snapshot.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and robotic-fish coupled CPG control
source_mechanism: coherent anterior-to-posterior phase coupling in a lagged propulsive wave
transferable_invariant: judge response energy over the coupled traveling-wave actuator because propulsion depends on inter-joint phase coherence
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: normalize total signed history-lag power by the gait's body-state scale and apply one smooth weight to both joint acceleration deltas
falsification: reject if capture or alternating upstream propulsion is lost, or if matched evidence does not beat the independent guards on arrival, distance, and effort/load together
