# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three independently
  materialized, executable-equivalent copies of the assigned-parent
  course-plus-posterior-recovery controller reproduce exactly the same
  `23.331013T` capture, `0.749672L` crossing, score-metric mean distance
  `2.135772L`, and score `-0.239045`. This is deterministic fixed-pose
  evidence, not held-out robustness.
- The strongest combined sheet shows self-propelled motion along the inherited
  S-shaped approach. An alternating red/blue mid-plane street forms behind the
  caudal region by `4T` and stays attached through capture; the oblique row
  shows discrete three-dimensional Lambda2 structures from `4T` through the
  terminal frame. The matched course-only sheet has the same coherent
  top-down and oblique wake class and no collision, exit, or visible wake
  collapse. Thus the score difference is a locomotor-allocation result, not a
  new route or wake regime.
- Relative to the course-only comparison, adding a `0.12` whole-carrier
  posterior recovery share advances capture from `23.369514T` to
  `23.331013T` and lowers mean distance from `2.152884L` to `2.135772L`.
  Distance is already lower at `2T/4T` (`12.156/11.297L` versus
  `12.199/11.440L`) and remains lower thereafter. The measured recovery gate
  is confined to startup: its mean is about `0.945/0.246` during `0--2T` and
  `2--4T`, then is effectively zero after `6T`. This establishes compatibility
  between through-water course feedback and bounded early posterior recovery.
- The gain is not free. Compared with the course-only rollout, mean action
  rises from `58.179` to `59.044`, peak normalized force from `0.029468` to
  `0.030861`, peak normalized moment from `0.015365` to `0.016213`, and exact
  anterior/posterior rate-cap occupancy from about `11.16/6.10%` to
  `11.34/6.27%`. Action is especially higher during `0--2T` (`67.15` versus
  `61.20`). The inherited adverse-yaw-moment composition also warns that an
  independently useful posterior feedback path need not add cleanly, so the
  next test should reallocate the evidenced recovery rather than stack another
  residual or increase its scalar gain.

## One candidate hypothesis

Preserve the assigned-parent course observation, anterior oscillator recovery,
target geometry, anterior redirect, phase-selective carrier, reactive-rudder
sign, and terminal relief. Replace only the posterior recovery allocation:
instead of multiplying the entire lagged carrier by up to `1.12`, add the same
bounded `0.12` share to the velocity-quadrature tail-lag coefficient during
the existing through-water speed-deficit gate. At mid-stroke this reinforces
the direction and delay of the traveling bend; at stroke reversal, where
anterior velocity vanishes, it adds no posterior excursion. This is a
state-qualified phase-lag mechanism, not a new gain on the existing amplitude
path, and it remains normalized, body-frame, memoryless feedback.

Falsify the translation if capture is lost or later than `23.331013T`, scored
mean distance exceeds `2.135772L`, or the early distance lead disappears.
Also reject it if the established S-route or alternating two-view wake changes
adversely, mean action materially exceeds `59.044`, anterior/posterior rate-cap
occupancy leaves the approximately `11.34/6.27%` class, or peak normalized
force/moment materially exceed `0.030861/0.016213`. A fixed-pose still-water
win would establish phase-lag allocation compatibility only, not robustness to
changed poses, hydrodynamics, or imposed wakes.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a traveling lateral bend with posterior delay and recruit locomotor authority from measured feedback without replacing the slow route loop
transferable_invariant: during measured through-water slowdown, posterior recovery can reinforce the velocity-quadrature delay of a joint-state carrier while leaving stroke-reversal excursion and target-relative steering unchanged
nontransferable_details: published gains, dimensional frequencies and speeds, distributed-body envelopes, species-specific kinematics, robot calibration, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: keep the evidenced smooth speed-deficit gate but move its bounded posterior share from whole-carrier amplitude to the tail-lag coefficient multiplying normalized anterior joint velocity
falsification: reject if capture is later than 23.331013T or lost, mean distance exceeds 2.135772L, the early lead disappears, or route, complete two-view wake, action, saturation, force, or moment envelopes worsen
