# Reproduced intercept-supported posture candidate

## Evidence and visual diagnosis before candidate selection

- All four current samples are finite captures from direct-uniform still water
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. They reproduce the
  same trajectory, combined two-view keyframe sheet, capture at `19.684490 T`,
  score `-0.261384287`, mean/final distance
  `2.151092787 L`/`0.748302400 L`, path length `12.951133 L`, and no joint-angle
  stop dwell. Three policies are byte-identical `v40` controllers. The fourth
  contains a signed course/yaw selector but is behaviorally identical, so that
  selector is dormant rather than evidence for a second mechanism.
- In the sampled top-down row, the fish self-propels from quiescent water on a
  compact target-directed arc and sheds a coherent alternating wake through
  capture. The oblique row contains finite, localized Lambda2 structures; it
  shows no passive advection, volume-filling instability, or wake collapse.
- The assigned-parent evidence is weaker despite the same broad topology:
  retaining extra carrier during outward terminal posture response captures at
  `19.711988 T`, scores `-0.261822240`, and lengthens the path to
  `12.984927 L`. Adding posture in the opposite response direction also
  regresses, as does adding posture while coupled posture-error energy is
  decreasing (`-0.261772172`). The flat `v40` handoff is therefore the only
  terminal allocation that survives the completed comparisons.
- The newest inherited outer course-supported mean-curvature redirect is an
  independently active failure, not a dormant comparison. Although it changes
  only 220 reconstructed startup commands and is absent below `9.858 L`, it
  delays capture to `23.375013 T`, regresses score/mean distance to
  `-0.401182121`/`2.298002624 L`, and lengthens the path to `13.529185 L`.
  Its top-down sheet initially retains alternating shedding but then develops
  longer paired bands and a pronounced late turn near the target; its oblique
  structures remain finite. The metrics therefore identify stable
  mis-steering, not numerical instability or loss of self-propulsion.
- The inherited phase-lag governor is the most informative failure: it bends
  the alternating wake into long curved paired bands around a large loop,
  increases path length and window shifts to `31.012702 L` and `607`, and
  captures only at `46.145020 T` with score `-0.915605503`. This confirms that
  the fixed posterior lag is a route-defining part of the current traveling
  bend, not an isolated saturation knob.

## Candidate hypothesis

Retain the evaluated `v40_intercept_supported_terminal_posture` policy exactly
as the single candidate. It preserves the state-feedback traveling bend,
fixed posterior lag, geometry/course-agreed outer residual allocation,
center-intercept corridor, closure preview, and the small flat terminal
posture handoff. Do not add another response selector, startup curvature bias,
phase-lag governor, or scalar gain change: every currently evaluated active
alternative at those loci regresses, while the only sampled nominal addition
is dormant.

The expected result is reproduction of the compact self-propelled path,
coherent alternating top-down wake, localized finite oblique structures,
capture near `19.684490 T`, and absence of joint-stop dwell. Falsify this
selection on material non-reproduction, slower or lost capture, worse distance
integral, changed outer topology, renewed stop dwell, load growth, instability,
or degradation of either wake view. The new CFD rollout occurs only after this
worker exits and is not evidence in this note.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, robotic-fish closed-loop direction control, and continuous terminal approach-hold control
source_mechanism: preserve an established posterior-lagged traveling bend for propulsion and hand off continuously toward a bounded mean-bend posture only when observed approach state supports it
transferable_invariant: when the propulsive wave and steering share two joints, preserve their evidenced phase relationship and keep any gait-to-posture allocation small, continuous, target-relative, and supported by normalized range, closure, and body-frame intercept observations
nontransferable_details: published gains and frequencies, species-specific kinematics, full-body envelopes, dimensional Strouhal targets, exact beat or vortex phase, target coordinates, capture radius, and task-specific routes
policy_translation: retain the reproduced body-frame v40 law and reject the evaluated startup curvature, posterior-lag, and terminal response additions rather than using the shelf to justify another scalar retune
falsification: reject on failed reproduction, delayed or lost capture, worse distance integral, changed compact route, joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Pre-evaluation identity audit

The retained solver policy has SHA-256
`624f4cec48f1a4c8d2eada4f72269efd16c22d4785955a09cd208447208cd659`,
matching three current evaluated `v40` samples. This establishes candidate
identity and evidence provenance; it is not a new CFD result.
