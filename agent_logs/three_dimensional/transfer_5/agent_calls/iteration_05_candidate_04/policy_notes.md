# Wake-policy diagnosis and hypothesis

## Sampled evidence

- All four sampled rollouts report direct uniform still-water initialization,
  `U_infinity=(0,0,0)`, no cylinders, and capture. The three v21 source files
  differ only in comments/version and have byte-identical combined sheets plus
  the exact same `4341`-step trajectory. The sampled population therefore
  supplies one evaluated v21 behavior, not three independent mechanisms.
- In both top-down and oblique rows, v21 and v22 are self-propelled rather than
  advected: a coherent alternating wake is established by `4T`, remains
  connected to the posterior body through the curved approach, and reaches the
  capture circle without wake breakup or a boundary encounter. No failed
  rollout sheet is present in this workspace. The informative failure evidence
  is consequently limited to inherited diagnostics: the transferred carrier's
  coherent-wake lower exit and the two early upper exits produced by replacing
  it with opposite-sign static posture.
- Evaluated v21 captures at `23.8755T` with mean distance `2.435715L`, peak yaw
  rate `2.9489 rad/T`, posterior `>=95%` speed-limit exposure `9.376%`, and peak
  lateral-load/yaw-moment coefficients `0.02400/0.01409`. Its joint angles do
  not spend samples within 95% of the angle limits, so the remaining constraint
  is dynamic rather than a locked static bend.
- The sampled v22 terminal excess-yaw amplitude relief is a concrete weak
  negative result. It retains capture and changes mean distance by only
  `-0.000225L`, but arrives one integration step later (`23.8810T`), leaves peak
  yaw and posterior speed exposure effectively unchanged (`2.9486 rad/T` and
  `9.351%`), and raises peak heave load from `4.349` to `5.448`. Reducing the
  whole oscillator amplitude from an instantaneous yaw gate is therefore not
  supported as the next mechanism.
- Raw yaw is dominated by carrier phase: evaluated v21 has correlation
  `corr(heading_rate, phi_dot1)=-0.9438` over the rollout and `-0.9541` for
  `distance<3L`. As an offline signal diagnostic only, removing the fitted
  carrier component `-0.50*phi_dot1` reduces near-target mean absolute yaw rate
  from `1.566` to `0.495 rad/T` and its peak from `2.949` to `1.039 rad/T`.
  Near-target bearing is likewise correlated with anterior angle (`-0.693`,
  fitted slope `-0.543`); adding `0.50*phi1` reduces its RMS from `0.279` to
  `0.206 rad` before accounting for the existing redirect center. This supports
  separating fast beat yaw from route-level excess yaw before adding damping;
  it is not a claim about the unevaluated candidate.

## Candidate hypothesis

Retain the evaluated v21 traveling-wave oscillator, geometry-gated same-sign
C-bend, response-triggered redirect release, half-cycle steering, and smooth
physical-command projection. Add one terminal feedback path: estimate route
yaw and target bearing in a redirect-centered joint-state carrier frame,
compare its magnitude with a target rate derived from compensated body-frame
target geometry (excluding the fast bearing-trend term), and convert only
excess route yaw into a proximity-gated counter-curvature offset at both
oscillator centers. Unlike
v22, this does not reduce carrier amplitude; unlike the failed static-posture
controllers, it is a small residual around the existing carrier and vanishes
outside the terminal band. Back-projecting the new observation algebra onto
the v21 trace (without evolving dynamics) gives mean/max absolute brake gates
of `0.281/0.905` inside `3L`, activation above `0.05` for `74.7%` of that band,
and maximum added head/tail offsets of `3.62/9.05 deg`. The candidate is thus a
material but bounded test; those figures are not rollout predictions.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and fish turning by bounded mean-curvature bias
source_mechanism: retain rhythmic propulsion while sensory heading response modulates a low-dimensional posture offset
transferable_invariant: separate beat-synchronous motion from route error, then apply a bounded response residual without replacing the propulsive wave
nontransferable_details: published CPG gains, clock phase, species envelopes, exact body-wave kinematics, and task-specific trajectories
policy_translation: use normalized body-frame target geometry, heading rate, and redirect-centered anterior joint angle/velocity to form a carrier-rejected target and yaw residual; map only near-target excess residual yaw to small same-sign head and tail curvature offsets
falsification: reject if capture is lost, arrival or mean distance materially worsens, the alternating wake degrades, posterior speed-limit exposure does not fall, or yaw/load histories exceed v21 without a compensating semantic gain
