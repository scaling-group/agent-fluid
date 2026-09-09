# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, so none of the visible motion is imposed advection
  or a prewarm artifact.
- No inherited optimizer log was present in this rendered workspace before
  these notes; the inherited durable record is the assigned parent guidance.
- The assigned parent `solver_8cbc18979df7` is the strongest useful finite
  trajectory: its top-down row shows an alternating, spatially organized wake
  and its oblique row shows persistent three-dimensional Lambda2 structures
  behind a self-propelled fish. It improves the minimum distance to `1.733L`
  and survives to `52.48T`, versus `2.579L`/`29.47T` for the aligned-curvature
  sample and `5.357L` or `7.531L` for the two upper-exit samples. It remains a
  left-domain failure, not a capture.
- The parent's approach allocation materially changes actuator behavior:
  accelerations exceed `0.9*31` for about `21%/23%` of samples, versus roughly
  `52%/55%` for aligned curvature. At its closest pass (`t=22.809T`) the joint
  rates are only `(-0.067,0.050)` and commands `(0.09,0.53)`, yet center speed
  is still `0.764U`. The target is already aft/right in the body frame while
  the fish coasts left/down. Thus the remaining error is not lack of command
  release at the instant of closest approach; the body momentum needed to
  influence the steering request earlier.
- The other combined sheets corroborate the boundary. `solver_ae0c621b2f7d`
  retains a coherent propulsive wake but passes above and exits left at high
  speed (`0.826U` at `2.579L`) with frequent limiting. The opposing-sign and
  bearing-release variants also make organized wakes but turn into upper exits
  with minima `5.357L` and `7.531L`. Wake coherence alone is therefore useful
  propulsion evidence, not capture evidence.

## One candidate hypothesis

Preserve the parent's traveling-bend carrier, aligned mean bend, and
closing-gated approach drive relief. A dry replay first screened a literal
velocity-preview target vector and rejected it: at the parent's first `4L`
crossing it changed target angle by only `0.061 rad`, and by `3L` both the
original and preview angles were already at the same `1.2 rad` clamp. Passing
that preview through the saturated route command would not be a material new
mechanism.

Instead, compare the target direction with the realized body-velocity
direction while near and closing. Send this bounded motion-direction residual
through its own aligned head-bias and posterior-curvature shares, outside the
saturated line-of-sight command. This is state feedback on normalized body
motion, not a new route or clock. It should request additional redirect when
the body is still translating across the desired path even though ordinary
target steering is saturated, and should vanish when speed or closing goes to
zero. Falsify it if it stalls far-field progress, repeats the `1.7--2.6L` fast
pass/left exit, increases actuator-limit residence, or breaks the organized
wake.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish CPG direction tracking and path following
source_mechanism: preserve a rhythmic carrier while measured motion error modulates its bounded steering offset
transferable_invariant: route feedback should account for realized body motion, not only instantaneous line-of-sight geometry, while leaving joint state as gait phase
nontransferable_details: published CPG gains, oscillator frequencies, robot-specific offsets, species kinematics, exact wake phase, and source-task routes
policy_translation: near-target closing gates a bounded difference between target direction and normalized body-velocity direction; separate aligned head and tail shares keep this residual active when the line-of-sight request saturates
falsification: reject if the motion residual disrupts propulsion, raises saturation, stalls approach, or preserves the same fast near-miss and left-exit topology
