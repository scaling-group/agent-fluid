# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled runs satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no prewarm and no cylinders) and end with the same
  powered `left_domain`/lower-boundary topology. Their minimum distances are
  `2.385L`, `2.443L`, `2.536L`, and `2.541L`; none captures.
- The combined top-down and oblique sheets for the best finite example
  (`2.385L`, measured-yaw half-cycle brake) and the inherited posterior
  S-bend failure (`2.536L`) show nearly the same continuous alternating wake,
  sustained body translation, broad correct-sign approach, and late downward
  departure. The oblique Lambda2 row remains coherent through approach and
  exit. This is self-propulsion with inadequate terminal redirection, not
  passive advection, wake collapse, collision, or instability.
- Metrics and diagnostics agree with the images. The best brake reaches its
  minimum at `17.869T` with about `1.379 rad` full body-frame direction error
  and `2.185 rad/T` error-growing yaw, then powers away to `9.190L` at
  `31.207T`. Its peak normalized force/moment magnitudes (`0.0285/0.0148`)
  are comparable to the alignment carrier (`0.0287/0.0148`), while anterior
  and posterior commands are already clamped for about `0.747/0.356` of the
  trace. More scalar drive or a larger generic equilibrium bend is therefore
  poorly supported.
- Reconstructing the best brake's own continuous gate from its trace gives
  397 samples inside `3.2L` with gate weight above `0.1`. In 288 of those
  samples (about 72%), the posterior traveling-wave target has the same sign
  as the full-direction error. The measured-yaw selector is useful, but the
  selected brake throws away authority precisely when a corrective posterior
  action is needed. The sampled gait-yaw residual and inherited
  bearing-response S-bend changed signals or equilibrium allocation and
  worsened minimum distance to `2.541L` and `2.536L`, respectively.

## Policy hypothesis

Preserve the best sampled brake's cruise carrier and exact body-frame
approach/lateral/measured-yaw selector. Replace braking with a target-directed
posterior half-cycle counterstroke: on the selected error-growing response,
remove a bounded fraction of the instantaneous posterior traveling-wave
target and put that same magnitude on the corrective side. If the wave was
already corrective, the reallocation algebra leaves it unchanged. This tests
new actuator semantics without new route knowledge, clock phase, scalar drive
tuning, or an always-on posterior equilibrium bias.

Expected evidence is a meaningfully smaller minimum than `2.385L`, ideally
capture or a different finite trajectory/termination class, without degrading
far-field progress or the coherent 3D wake. Falsify the mechanism if it keeps
the same lower exit and minimum, causes a short-wake curl, raises posterior
limit/load residence, or worsens the broad approach.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and biological mean/asymmetric tail-beat steering
source_mechanism: feedback-selected half-cycle amplitude asymmetry that adds a bounded corrective stroke while retaining the traveling bend
transferable_invariant: persistent target geometry chooses turn direction while measured error-growing response chooses which posterior half-cycle to reshape
nontransferable_details: published gains, duty ratios, oscillator clocks, species kinematics, exact vortex phases, and source-task routes
policy_translation: use normalized body-frame target direction, distance, measured yaw, and joint-state traveling-wave target to reallocate only selected posterior authority into the corrective sign
falsification: reject if minimum is not better than 2.385L, the powered lower exit is unchanged, wake coherence or far-field progress is lost, or posterior saturation/load residence increases materially
