# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the held fish at the common upper-right
  release while the four streets develop and merge around the target. The
  released comparisons therefore begin from the same mature wake rather than
  candidate-specific flow initialization.
- The assigned parent's alignment-conditioned posterior emphasis is the only
  sampled mechanism change from the repeated yaw-gated reference. It retains
  the coherent traveling body wake and continuous down-left route, then bends
  into the target circle at `46.80` rather than `51.47`. Metrics confirm the
  semantic success and improve mean distance from `1.820L` to `1.745L`, while
  head displacement remains strong at `-10.97/-4.60L`.
- That improvement has a bounded tradeoff: mean command energy rises from
  `995` to `1024`, force/moment RMS from `426/4084` to `441/4259`, relative
  crossflow RMS from `0.275` to `0.287`, and both joint rates still touch the
  `4.538` hard limit. Posterior angle increases from `0.659` to `0.675` rad,
  consistent with the intended propulsion translation rather than a new
  steering bias, but it does not justify a scalar-only amplitude increase.
- The inherited propulsive-priority allocator is the informative visual
  failure. It travels even farther upstream/downward (`-14.42/-6.79L`) but
  passes below the capture circle, then collides with the lower-left cylinder
  at `58.93`; its `1.872L` closest approach and `537/4995` force/moment RMS
  show that preserving or increasing travel alone is not sufficient. The next
  candidate must retain the parent's target-response and yaw-load gate.

## Candidate hypothesis

Preserve the successful oscillator, predicted-bearing steering, yaw-moment
gate, soft limiter, and alignment-conditioned posterior wave. Add one compact
response mechanism to the posterior emphasis: modulate its envelope smoothly
around the parent's `0.10` startup value with normalized windowed target
closing speed. Confirmed closure can raise the emphasis modestly, while
stalled or reversed closure removes the extra motion without weakening the
base traveling wave. The history window should reject beat-scale distance
noise better than a one-step derivative, and route alignment remains the
primary body-frame gate.

The next CFD rollout falsifies the candidate if it loses `target_reached`,
does not improve the `46.80` arrival or `1.745L` mean-distance baseline,
returns the lower collision/exit topology, or increases joint saturation,
command effort, or hydrodynamic loads without useful route progress. A fixed
wake success would not establish phase, inflow, geometry, or target
robustness.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control
source_mechanism: preserve the rhythmic locomotion generator while observed task response modulates its amplitude envelope
transferable_invariant: strengthen the propulsive envelope only when normalized feedback confirms useful target closure, and relax the residual when progress reverses
nontransferable_details: published gains, dimensional rates, robot linkage geometry, species-specific envelopes, learned routes, and exact vortex phases
policy_translation: multiply the existing body-frame alignment-conditioned posterior emphasis by a bounded smooth function of normalized windowed closing speed, leaving the base two-joint traveling wave and yaw-gated steering unchanged
falsification: reject if capture or useful topology is lost, arrival and mean distance fail to improve, or added posterior motion raises limit residence or loads without compensating closure
