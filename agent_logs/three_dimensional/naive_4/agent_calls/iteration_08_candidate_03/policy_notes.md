# Response-normalized terminal-hold candidate

## Pre-edit visual and quantitative diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and capture
  at `0.745-0.748L` after `16.258-16.269T`.
- I inspected both rows of the combined sheets for the strongest sampled score,
  `solver_a5dc27216aa2`, and the weakest terminal-hold score,
  `solver_3b1e268859f6`. In the top-down mid-plane row, both establish a strong
  alternating red/blue wake by `4T` and carry it along the same stable
  down-left target-directed transit. In the oblique Lambda2 row, compact
  three-dimensional structures remain attached to the traveling tail wave
  through the `12T` and capture frames. Quiescent release, sustained body
  translation, and a wake trailing the tail establish self-propulsion rather
  than advection. Neither example shows wake collapse, virtual-boundary exit,
  or instability.
- The sampled difference is terminal control quality, not route topology. The
  assigned mean-bend hold (`solver_60f446303562`) and the zero-bend hold both
  capture at `16.269T`, but retaining bounded mean steering improves score from
  `-0.066867` to `-0.066497` while keeping terminal force and moment near zero.
  Selective approach damping retains more of the wave, captures one control
  step earlier at `16.258T`, and has the best sampled score (`-0.066121`), but
  carries larger terminal load. Thus preserving the mean bend is supported;
  entering a strong fixed-distance hold early is not supported as translational
  braking.
- The traces explain the scheduling mismatch. At the parent's `1.2L` hold
  onset the fish is still closing near `1.0L/T`, so only about `0.45T` remains
  before the `0.75L` capture surface. A fixed distance gate is already half
  open there even though crossing is not yet immediate. All sampled terminal
  modes still end near `1U`; their demonstrated role is joint/wake unloading,
  not body stopping.
- Inherited evaluation of the allocator-plus-approach stack is a concrete
  non-additivity result. It captures earlier at `16.225T`, but worsens score to
  `-0.067754` versus either isolated mechanism (`-0.066284` allocation and
  `-0.066121` approach relief). This candidate therefore does not stack the
  allocator onto the assigned parent.

## Policy hypothesis recorded before the edit

Preserve the assigned parent's anterior carrier, target-versus-course redirect,
posterior mean bend, attenuation-only opposing-lobe relief, hold dynamics, and
hard envelopes. Replace only the fixed-distance half of the terminal gate with
a response-normalized time-to-capture signal: divide the remaining normalized
distance beyond the parameter-owned capture surface by positive measured
closing speed. Blend into the existing mean-bend hold only when this time is
short and closing is reliable; release continuously if closing is lost.

This is a state-feedback regime change rather than a scalar gain edit. On the
sampled parent trajectory it should leave more of the proven carrier active at
`1.2L`, become strong shortly before crossing, retain the parent's mean steering
and low terminal load, and capture no later than `16.269T`. Falsify it if the
pre-approach path or coherent wake changes, capture is lost or delayed, the
terminal force/acceleration rises toward the ungated redirect, or a near miss
keeps the hold engaged after closing ceases.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal capture scheduling
source_mechanism: preserve broad propulsion and mean steering until observed proximity and closing response make capture imminent, then continuously relieve the rhythmic drive
transferable_invariant: separate the slow target-directed mean bend from the oscillatory carrier and schedule drive relief by normalized observed response rather than elapsed time or a fixed route
nontransferable_details: published CPG gains, species-specific capture maneuvers, dimensional speeds, exact tail or vortex phase, task coordinates, and prescribed routes
policy_translation: use normalized target distance, measured closing speed, joint state, and the existing body-frame target-versus-course mean bend; a smooth time-to-capture gate blends from the proven carrier to the mean-bend hold
falsification: reject if early transit changes, capture is lost or later than 16.269T, terminal unloading disappears, or the gate fails to release when closing progress is lost

## Non-CFD verification

- Counterfactual evaluation on the assigned parent's recorded distance history
  makes the intended scheduling change explicit. At the first samples below
  `1.2L`, `1.0L`, and `0.8L`, the old/new hold weights are approximately
  `0.508/0.003`, `0.937/0.888`, and `0.995/0.998`. The new mechanism therefore
  preserves the parent transit through the former onset but still converges to
  its mean-bend hold before the sampled crossing. This replay is a gate check,
  not a claim about the unevaluated closed-loop trajectory.
- Every direct `params.FIELD` reference resolves to a returned parameter. A
  `19,683`-state deterministic sweep across joint state, target bearing,
  body-frame velocity, distance, and closing speed returned finite bounded
  actions and exact lateral-reflection equivariance; non-finite optional
  observations also fall back to finite actions.
- The documented guidance/materiality check, Julia policy-contract check, and
  solver edit-boundary check pass. The configured check-runner agent itself
  was unavailable because its fixed model is unsupported in this account, so
  its three commands were executed separately as the prescribed fallback.
- No same-worker CFD was run. Capture time, wake preservation, load relief, and
  score remain falsifiable claims for the downstream evaluation.
