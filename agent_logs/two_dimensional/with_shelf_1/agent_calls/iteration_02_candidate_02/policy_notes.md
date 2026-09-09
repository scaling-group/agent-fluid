# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent guidance was the copied
  `optimizer_b423f88c46cc` experience; no inherited optimizer note files were
  present, so the reusable update below is grounded in that parent and the four
  sampled solver rollouts rather than inventing unavailable history.
- The common prewarm sheet shows a developed, interacting four-cylinder wake
  already reaching the held fish; it is a shared initial condition, not a
  policy outcome.
- The prefilled target-blind traveling-bend seed initially moves left but turns
  steeply downward, passes below the useful wake corridor, and exits the lower
  domain after `50.127` released time. Its head displacement is
  `(-3.545,-13.300)L`, minimum distance is only `8.615L`, and both joint speed
  and acceleration touch their hard limits. This is coherent propulsion with
  no directional control, not evidence for more oscillator gain.
- The strongest sampled policy adds a bounded, positive bearing-to-acceleration
  residual to both joints. Its keyframes show a broad target-directed turn,
  sustained leftward traversal through the wake, and a final curved entry into
  the target. It reaches the `0.75L` capture boundary in `62.304` time with
  head displacement `(-10.922,-4.153)L`, mean/minimum distance
  `2.460/0.750L`, RMS relative crossflow `0.222`, RMS lateral force `27.3`, and
  RMS yaw moment `526`.
- The opposite-sign, centered-curvature variant moves rightward and exits in
  `13.915` time (`+2.751L` head x displacement, negative progress), so the
  body-axis sign must be taken from rollout evidence rather than inferred from
  a geometric convention. A slower/smaller centered-bias variant lasts longer
  but becomes unstable after `121.517` time with RMS relative crossflow
  `1.138`, force `1.67e4`, and moment `2.90e5`; it does not justify adding wake
  rejection to the proven route controller.

## Policy hypothesis

Retain the prefilled state-feedback oscillator and posterior lag unchanged,
and add only the sampled successful bounded bearing residual: positive
body-frame bearing requests positive joint acceleration, with a smaller
same-sign posterior share. This should preserve the demonstrated propulsive
carrier while supplying the missing target-directed mean curvature. The prior
rollout predicts target capture rather than the seed's lower-domain exit.

The hypothesis is falsified if evaluation loses leftward progress, repeats the
steep lower exit, collapses the traveling bend, becomes unstable, or misses the
target. The sampled success touched joint speed and acceleration limits, so it
establishes navigation but not actuator headroom or wake-phase robustness;
later changes should preserve semantic success before reducing effort.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical fish mean-curvature turning
source_mechanism: sensor-modulated tail-beat bias superposed on a rhythmic propulsive carrier
transferable_invariant: persistent body-frame target error can request a bounded mean bend without replacing the traveling wave
nontransferable_details: published gains, dimensional beat settings, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: map normalized body-frame bearing through tanh to a bounded same-sign acceleration residual on the two joints, with a smaller posterior share
falsification: reject if propulsion collapses, the empirically correct turn sign is lost, saturation becomes unstable, or target capture is not retained
