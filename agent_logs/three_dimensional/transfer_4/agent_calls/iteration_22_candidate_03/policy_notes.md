# Moment-calibrated terminal posterior half-cycle

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance and inherited optimizer log, all four
  sampled policies, scores, observations, metrics, diagnostics, and
  trajectories, and the top-down vorticity and oblique Lambda2 rows of the
  sampled-best and assigned-parent combined keyframe sheets. Every rollout is
  a stable self-propelled capture from direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, and no cylinders. Both visual views retain
  a coherent alternating wake and compact three-dimensional posterior
  structures from release through capture; there is no passive advection,
  wake breakup, collision, or out-of-plane instability. The remaining defect
  is terminal yaw allocation within an otherwise useful traveling wake.
- The sampled symmetric posterior-wave envelope remains the score leader. It
  improves score/mean distance from the reproduced unrelieved trajectory's
  `-0.06459894/1.95082256L` to `-0.06454455/1.95080137L`, shortens path from
  `13.23303L` to `13.21113L`, raises final course alignment from `0.06785` to
  `0.18179`, and lowers mean absolute yaw below `2.10L` from `1.99704` to
  `1.88833 rad/T`. Its cost is lower near speed (`0.88656U` versus `0.90122U`)
  and capture at `18.02349T` rather than `18.01250T`.
- The assigned parent's direction-selective retry recovered near speed to
  `0.89975U` and captured earlier at `18.00150T`, while retaining essentially
  the sampled envelope's posterior near-approach acceleration-ceiling
  residence (`72.45%` versus `72.48%`). It nevertheless regressed score/mean
  distance to `-0.06535790/1.95141313L`, raised near mean absolute yaw to
  `1.98867 rad/T`, and collapsed final course alignment to `0.04282`; its
  `13.21995L` path also remained longer than the sampled envelope's. The two
  visual rows remain coherent and nearly indistinguishable at sheet scale, so
  this is a selector failure rather than a wake-class failure.
- The failed selector treated the raw lagged posterior target as if its sign
  were the sign of induced yaw. The measured 3D histories show the inverse:
  inside `2.10L`, the raw target has correlation `-0.934` with yaw moment and
  the two signs oppose in `89.90%` of the sampled-envelope trajectory. The
  relation is stable in the unrelieved sample (`-0.936`, `89.59%`) and assigned
  parent (`-0.936`, `89.80%`), and remains above `|0.926|` across the realized
  cadence range. Thus the parent's negative-product test preferentially
  attenuated phases whose measured moment supports the requested yaw-rate
  correction, while preserving the yaw-reinforcing phases.

## Single policy hypothesis

Preserve the assigned parent's odd body-frame curvature map, state-feedback
carrier, cadence, posterior lag and emphasis, mean steering, reserve-work
guard, terminal distance/alignment/yaw window, and reversal-preserving rate
governor. Change only the terminal half-cycle polarity: because measured yaw
moment is opposite the raw lagged target, attenuate a half-cycle when the raw
posterior target has the *same* sign as the bounded yaw-rate correction, and
preserve it when their signs oppose. This uses the measured 3D actuation-to-yaw
polarity rather than treating curvature sign as yaw sign; both signed factors
reverse under reflection, so the scalar authority remains reflection-invariant.

Expected evidence is exact preservation of the assigned parent outside
`2.10L`, retention of its recovered near speed and early capture, and recovery
of the sampled symmetric envelope's lower terminal yaw, path, alignment, and
mean distance. Falsify the mechanism if pre-approach motion changes, the
moment-to-target polarity changes under the edited trajectory, capture or
score regresses, terminal alignment/yaw/path fail to improve, limit residence
migrates without benefit, reflection fails, or either coherent wake view
deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish half-cycle turning and terminal capture staging, combined with posterior reactive propulsion
source_mechanism: infer beat side from joint state and modulate only the half-cycle whose measured yaw effect opposes the requested terminal correction
transferable_invariant: preserve the propulsive traveling wave while using measured actuation-to-body-response polarity to withdraw only yaw-reinforcing posterior work during a poorly aligned approach
nontransferable_details: published gains, dimensional cadence, species-specific duty ratios and envelopes, exact vortex phase, full-body kinematics, world coordinates, capture radius, and task-specific routes
policy_translation: combine the existing normalized distance/alignment/yaw window with the product of bounded body-frame yaw-rate correction and the raw lagged posterior target, using the empirically measured inverse target-to-moment polarity to envelope only the posterior oscillatory target
falsification: reject if pre-approach motion changes, terminal speed and arrival are not retained together with lower yaw and better alignment, the target-to-moment polarity is not stable, capture or mean distance is lost, reflection fails, or either visual wake degrades

## Lightweight validation

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable to this account. I ran its three
  immutable commands directly and did not run CFD. The material-guidance check
  passes, and the repository boundary check passes with only the allowed active
  target-policy file changed under `solver/`.
- No Julia executable is installed, so the check-runner's load probe cannot run
  in this shell. The deterministic schema guard passes: all `62` distinct
  direct `params.FIELD` references resolve among the `64` unique fields returned
  by `target_policy_params`; parentheses and brackets balance; and the candidate
  remains non-empty.
- Focused selector probes give authority exactly `1.0` outside the terminal
  window, when raw target and yaw-rate correction oppose, and at zero
  correction. A same-sign probe gives `0.77356288`, while reflecting both signed
  inputs gives the identical authority. The executable change from the assigned
  parent is the evidence-calibrated product polarity; these are contract and
  mechanism checks, not new rollout evidence.
