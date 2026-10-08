# Candidate diagnosis and policy hypothesis

## Evidence read before the policy edit

- The four assigned solver rollouts are valid direct-uniform still-water
  evaluations: `U_infinity=(0,0,0)`, no cylinders, no prewarm, and moving-
  window shift counts of 269--271. I inspected the combined sheets from
  release through capture in both the top-down vorticity and oblique 3D
  body/Lambda2 rows for the prefilled curvature-reallocation parent
  (`solver_a1253ad45bc8`) and the only distinct higher-scoring sample
  (`solver_d5c9dea468e1`). The fish are self-propelled, not advected: both
  develop a coherent alternating posterior wake while following the same
  compact target-directed arc, and neither view shows an instability before
  capture.
- The closure-previewed sample is a small but consistent positive result over
  the parent. Score improves from `-0.53064634` to `-0.53006032`, capture
  advances from `25.26152T` to `25.11302T`, and mean distance falls from
  `2.431797L` to `2.430636L`. Its wake sheets are almost visually
  indistinguishable from the parent, which agrees with the fact that the edit
  only schedules the already-validated terminal carrier-to-curvature
  reallocation and does not create a new steering direction.
- The time series localizes the benefit. At the first `4L` crossing, the
  parent's head joint is about `-43.04 deg` and its head command is at the
  `30.543 rad/T^2` policy cap. Across the inside-`4L` interval, parent head-
  command and head-rate envelope incidence are about `0.487%` and `0.780%`.
  The closure preview begins the same reallocation shortly before that
  crossing; the evaluated child has no inside-`4L` command or rate cap hits,
  reaches `2.4L` about `0.066T` sooner and `1L` about `0.138T` sooner, and
  slightly lowers the observed force/yaw-moment coefficient maxima from about
  `0.01593/0.00834` to `0.01548/0.00800`.
- I also inspected the inherited broad approach-hold capture
  (`solver_e7a7bd0d3fe2`) as the informative scheduling failure. Its
  top-down row visibly loops around the target and its oblique row shows long
  low-wake portions before eventual capture at `51.645T`; mean distance is
  `3.15077L` and score is `-1.19739`. This rules out extending drive relief
  over a broad near-target regime merely because closure is positive.
- The recession-release factor in the closure-previewed controller remains a
  robustness hypothesis, not an evaluated recovery success: the sampled
  nominal approach stays above its full-support closing threshold. Its safe
  role is only to suppress terminal hold on loss of closure; it must not be
  interpreted as a velocity-course steering signal.

## Policy hypothesis

Promote the evaluated closure-previewed reallocation as this single candidate,
without adding another curvature residual or a broader approach mode. Positive
normalized closing speed projects range less than one declared control period
ahead, so the existing body-frame geometry-gated two-joint curvature
equilibrium receives actuator excursion before the physical `4L` crossing.
Loss of closure continuously restores the posterior-lag carrier. Target
geometry still owns activation and turn sign, and the far wake and trajectory
remain those of the captured parent.

Expected evidence is replication of the compact coherent approach, no inside-
`4L` command/rate clipping, and capture no later than the `25.2615T` parent.
Falsify the selection if the far trajectory changes, capture is lost or
delayed, terminal loads or saturation rise, or a low-drive orbit like the
broad approach-hold counterexample appears. The release branch is separately
unproven unless a future coupled rollout actually loses closure and recovers.

bookshelf_consulted: true
source_domain: biological burst-redirect turning and sensor-modulated robotic-fish rhythmic control
source_mechanism: response-conditioned scheduling of actuator reallocation from a posterior-lag carrier into bounded target-directed mean curvature
transferable_invariant: when propulsion and steering share limited joints, persistent body-frame target geometry should own the bend while normalized range and observed closure schedule when joint excursion transfers from rhythm to that bend
nontransferable_details: published gains, dimensional cadence, species-specific C-start kinematics, full-body waveforms, exact vortex phases, and prescribed target routes
policy_translation: bounded positive `window_closing_speed_L` previews normalized distance by less than `control_period`; existing body-frame bearing and target-vector angles continue to gate and sign the two-joint equilibrium, while nonpositive closure restores the state-feedback carrier
falsification: reject if the outer wake changes, capture is delayed or lost, transition clipping or loads return, or recession still produces a low-drive orbit despite releasing the hold
