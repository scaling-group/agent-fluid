# Aligned phase-substitution candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled solver rollouts and the assigned-parent rollout satisfy the
  frozen contract: direct uniform `U_infinity=(0,0,0)` initialization, no
  cylinders or prewarm, finite dynamics, and capture. Their combined sheets
  show body-led motion from release, coherent alternating mid-plane vortices,
  and compact oblique Lambda2 structures following the swimmer through the
  target-directed approach. There is no passive advection, wake collapse,
  terminal loop, collision, boundary exit, or instability. The assigned
  parent preserves the same visual wake topology, with local-flow RMS only
  `0.01798U`.
- The strongest sampled route is the actuator-consistent phase gate. It
  captures at `18.67250T`, scores `-0.13362`, and has mean distance
  `2.02129L`, but stacks amplitude asymmetry with phase recruitment and reaches
  `76.41%` posterior acceleration-limit occupancy plus `0.01350/0.00703`
  force/moment RMS. The prefilled demand-lead parent is slower at `18.78799T`,
  score `-0.14000`, and mean distance `2.02833L`, with `75.67%` occupancy and
  `0.01333/0.00694` loads. The current-demand phase gate is the lower-load
  comparator at `18.79899T`, `74.20%`, and `0.01315/0.00684`.
- The inherited assigned-parent `complementary_tail_phase_v1` result closes the
  missing ablation. Fading amplitude by the complement of phase-gate
  activation still captures at `18.74950T` and reduces posterior occupancy to
  `74.48%` and loads to `0.01336/0.00696`. It therefore recovers most of the
  broader phase gate's effort relief while remaining `0.0385T` faster than the
  demand-lead prefill. However, it is `0.0770T` slower than the fully stacked
  actuator-consistent route and worsens mean distance to `2.02989L`. Gate
  activation alone therefore does not establish that phase modulation has
  replaced the amplitude steering contribution on that joint-state sample.

## Policy hypothesis recorded before editing

Start from the fastest sampled actuator-consistent controller, preserving its
normalized body-frame bearing and LOS-rate guidance, recoil-conditioned yaw
response, distributed C-bend, coherent carrier, same-side actuator-stress
gate, coefficient-norm-preserving posterior phase rotation, and componentwise
physical projection.

Change only the amplitude-to-phase handoff. Compute the signed posterior
joint-target displacement contributed by phase rotation and the signed
displacement contributed by the stacked half-cycle asymmetry. Release the
amplitude increment only by the normalized fraction that the phase increment
supplies in the same direction. Opposed phase motion or a zero-leverage phase
state retains the evaluated stacked route; aligned phase motion substitutes
amplitude continuously without a new gain. This should avoid the assigned
parent's gate-level over-release while retaining effort relief where phase is
an actual replacement actuator.

Support requires capture no later than the assigned parent (`18.7495T`) while
reducing posterior occupancy or force/moment load below the fully stacked
sample (`76.41%`, `0.01350/0.00703`). Falsify the allocation if capture is
lost, arrival exceeds the replicated half-cycle bound (`18.931T`), the
alternating wake weakens, or neither timing nor effort improves on the assigned
parent. The evidence is limited to direct still water near `0.018U` local-flow
RMS and does not establish disturbance robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG phase-lag and asymmetric-flapping steering
source_mechanism: sensory feedback transfers bounded steering authority between rhythmic amplitude asymmetry and posterior phase while retaining the traveling carrier
transferable_invariant: release one steering mode only to the extent that the recruited mode supplies an aligned joint-space response, while preserving the propulsive rhythm
nontransferable_details: published gains, clock phase, robot linkage geometry, species kinematics, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame LOS response, observed two-joint phase, same-side normalized actuator stress, and aligned posterior target increments to allocate between half-cycle amplitude and phase
falsification: reject if capture is later than 18.7495T without load relief, wake coherence degrades, or arrival exceeds 18.931T
