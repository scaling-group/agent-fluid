# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts report direct uniform initialization in still water
  with `U_infinity=[0,0,0]`, no prewarm snapshot, and `capture` termination.
  There is therefore no sampled semantic-failure keyframe sheet in this
  generation. The informative contrast is the v33 parent capture
  (`solver_2546ece173ab`) against the split-observer capture represented by
  `solver_8ae803ceeb4c`; the other two split-observer sheets and CFD trajectories
  are exact repeats.
- In both combined sheets, the top-down row shows self-propelled target progress
  with a coherent alternating vortex street rather than passive advection or
  wake collapse. The oblique Lambda2 row confirms a persistent three-dimensional
  chain of alternating structures through the terminal approach. The visible
  route remains smooth and target-bound; the remaining defect is carrier-scale
  yaw and lateral sweep at the capture sphere, not missing thrust or wrong-sign
  broad steering.
- The split observer improved v33's arrival/mean/final distance from
  `23.8425T / 2.433543L / 0.746165L` to
  `23.8370T / 2.433468L / 0.746096L`. Inside `3L`, mean absolute yaw and mean
  absolute target-cross-track speed fell from `1.67999 rad/T / 0.23924U` to
  `1.67938 rad/T / 0.23868U`, and peak moment fell from `0.013730` to
  `0.013581`; peak yaw rose slightly from `3.18484` to `3.19386 rad/T`.
  Recorded command and joint envelopes were effectively unchanged.
- The inherited step-26 evidence rules out two nearby edits: displacement-rate
  phase anticipation regressed score/mean/final distance to
  `-0.535561 / 2.433904L / 0.746654L` and raised peak moment, while one-sided
  `12%` anterior envelope relief reduced peak yaw/cross-track speed but
  regressed progress and raised peak moment. Later score-only child logs also
  remain below the repeated split baseline, but lack policy and wake/load
  evidence, so they do not identify another mechanism to copy.

## Policy hypothesis

Use the repeated split-observer behavior as the base. Preserve its anterior-only
continuous course response, distributed phase classification, phase-selected
anterior counter-curvature, posterior traveling-wave target, cadence, and smooth
command projection. Add one new mechanism: inside the existing terminal
proximity/speed/yaw gate, use normalized observed tail tangent side to transfer a
small amount of the anterior oscillator's amplitude-squared budget from the
undesired-yaw-supporting half-cycle to the opposing half-cycle. This is distinct
from the failed one-sided relief because the paired boost is intended to retain
cycle-scale propulsive authority. It is also distinct from failed phase
anticipation because it uses the already evaluated displacement-side phase and
does not advance it.

Expected result: preserve the coherent capture topology and split-baseline
progress while reducing its terminal peak-yaw defect without increasing peak
moment or actuator exposure. Reject the mechanism if capture is lost, arrival
or mean/final distance regresses beyond repeat-scale variation, the alternating
wake weakens, peak yaw/moment rises, or joint/command limits worsen.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated rhythmic control
source_mechanism: observed-phase half-cycle amplitude asymmetry around a propulsive carrier
transferable_invariant: redirect bounded cycle effort between observed half-cycles while retaining the traveling wave and target-feedback carrier
nontransferable_details: published gains, duty ratios, species kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: use signed split-observer excess yaw and normalized two-joint tangent displacement to shift the anterior oscillator amplitude-squared budget oppositely across the two half-cycles; retain the posterior target and all body-frame route feedback
falsification: reject if CFD loses capture or coherent propulsion, regresses split-baseline arrival or distance metrics, raises peak yaw or moment, or worsens joint and projected-command feasibility

## Lightweight verification

- The material-guidance check, policy contract/finite-action assertion, and
  editable-file boundary check pass. The new transfer also passes a direct
  algebraic invariant check: opposite signed excess-yaw inputs move anterior
  amplitude-squared equally above and below the unchanged baseline while
  keeping both joint commands finite.
- No CFD was run; this candidate's hydrodynamic outcome remains evidence for a
  later worker.
