# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled episodes satisfy the experiment contract: direct uniform
  still-water initialization at `U_infinity=(0,0,0)`, no cylinders, 251
  moving-window shifts, finite dynamics, and capture rather than collision or
  virtual-domain exit.
- The assigned `optimizer_f9467557f4cd` parent log records the fully sampled
  v24 result at `-0.064407450` and a later score-only capture at
  `-0.065176046`. The latter has no policy, trajectory, or two-view evidence,
  so I do not attach a mechanism to it or let it override the sampled
  comparisons below.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the best finite sample, `solver_adfafc9b9f71` (v20, score
  `-0.064027620`, capture at `18.006996T`), and the most informative weaker
  sample, `solver_59258915c93c` (v24, score `-0.064407450`, capture at
  `17.995996T`). Both start without a pre-wake, self-propel toward the target,
  and develop a coherent alternating traveling wake by `4T` that persists
  through the `12T`, `16T`, and capture frames. Neither view shows wake
  collapse, passive advection, a collision precursor, or instability. The
  nearly indistinguishable sheets localize the useful policy difference to
  the terminal state and allocation rather than basic propulsion.
- Metrics agree with that visual diagnosis. Relative to v20, replacing the
  yaw-power selector by target-normal-power suppression of the whole posterior
  wave (v24) shortened center path from `13.2108L` to `13.1921L` and near
  posterior acceleration-ceiling residence from `75.83%` to `72.38%`, but
  worsened mean distance/score from `1.950358L/-0.064028` to
  `1.950652L/-0.064407`, lowered final course alignment from `0.1092` to
  `0.0975`, and increased absolute final yaw from `0.9840` to
  `1.2697 rad/T`. The downstream positive-work governor similarly regressed
  score to `-0.064336`. Using the signal only to select conserved mean-bend
  allocation was effectively score-neutral (`-0.064035`) and shortened the
  path to `13.1972L`, but still reduced final alignment to `0.1036` and raised
  absolute final yaw to `1.1215 rad/T`. Thus three translations of the same
  instantaneous power selector do not establish a terminal-control gain.
- A phase check on the sampled v20 approach (`distance <= 2.10L`) finds that
  target-line-normal force is strongly carrier organized: its correlation is
  `+0.919` with posterior joint rate and `-0.912` with anterior angle. That
  explains why an instantaneous normal-power gate mostly selects alternating
  stroke phases. The missing test is not another scalar threshold; it is
  whether balancing work between those observed half-cycles can damp
  cross-course motion without reducing net posterior drive.

## Policy hypothesis

Preserve v20 exactly outside the established `2.10L` approach and retain its
odd target-to-curvature map, state-feedback carrier, posterior lag, yaw-power
envelope, conserved anterior allocation, cadence, and rate governor. During a
moving, misaligned approach only, form signed target-normal velocity divided
by total speed. Multiply the posterior wave target by a small, bounded
half-cycle factor using the observed posterior joint rate: weaken the phase
whose measured force sign reinforces target-normal velocity and strengthen the
opposite phase by the same authority. For a settled sinusoidal beat the
phase-odd modulation has no added mean bend; under lateral reflection both the
normal velocity and posterior rate change sign, so their product and authority
are invariant.

Falsify the candidate if pre-approach commands differ from v20, either visual
row loses the coherent traveling wake, capture or distance integral regresses
materially, or terminal path/alignment/yaw and non-migrating actuator
residence do not improve together. Also reject the mechanism if the observed
posterior-rate/normal-force polarity fails under a reflected or disturbed
approach.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop CPG modulation, combined with biological terminal-approach separation
source_mechanism: sensor feedback redistributes authority across observed stroke half-cycles while preserving a traveling propulsive rhythm
transferable_invariant: keep the state-feedback traveling wave and bounded mean turn, and use a near-target phase-odd modulation to move posterior effort from a cross-course reinforcing half-cycle to the opposing half-cycle
nontransferable_details: published gains, duty ratios, dimensional frequencies, species envelopes, exact vortex phases, full-body CPG states, and prescribed routes
policy_translation: within the normalized body-frame approach gate, use signed target-line-normal velocity over speed and normalized posterior joint rate to apply a bounded reciprocal scale around one to the lagged posterior wave target; retain the existing two-joint feedback and full far/middle authority
falsification: reject if transit changes, reflection equivariance fails, capture or mean distance worsens materially, the wake loses coherence, or path, final course/yaw, and actuator residence do not improve together

## Non-CFD policy checks

- Replaying the new algebra over the sampled v20 trace leaves the posterior
  half-cycle scale exactly `1.0` for all 2,881 pre-approach states. It is
  nontrivial in 312 of 393 approach states, ranges only from `0.9437` to
  `1.0604`, and averages `0.9980`; this confirms redistribution rather than a
  chronic posterior-amplitude reduction on the evidence used to design it.
- Static checks confirm that all 65 direct `params.FIELD` references are owned
  by the 67-field object returned from `target_policy_params`, the new scale is
  bounded inside its declared reciprocal envelope, prohibited hidden-state and
  case-coordinate inputs are absent, and the candidate is the only solver file
  outside the baseline boundary.
