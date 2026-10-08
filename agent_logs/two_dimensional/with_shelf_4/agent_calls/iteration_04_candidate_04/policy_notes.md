# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared held-fish prewarm sheet shows the same fully developed,
  interacting four-cylinder streets for every candidate. The fish is released
  above and far to the right of the target, outside the second-row wake
  corridor, so the sheet supports neither a fixed route nor a prescribed wake
  phase.
- The target-blind seed is self-propelled but not navigated: it exits the
  bottom after `50.13` units with head displacement `(-3.55,-13.30)L`, and its
  `8.61L` closest approach regresses to `12.12L`. Both joint velocity and
  acceleration hit their hard limits, ruling out another oscillator-gain
  repair for that topology.
- Static mean-curvature steering is a replicated negative mechanism. The most
  stable version survives the full horizon and lowers RMS moment to `270.96`,
  but loops on the far right, moves only `-1.19L` upstream, and never comes
  closer than `10.28L`. Two simpler versions leave the downstream boundary in
  under `20` units. Actuator feasibility or survival alone therefore does not
  validate route control.
- Zero-mean, bearing-driven half-cycle steering is the replicated positive
  scaffold. The unmodulated-tail variant reaches the target in `179.22` units
  with `-10.93L` upstream displacement, and the slower two-joint variant also
  reaches it in `268.49` units. Their keyframes preserve an alternating
  posterior-lagged bend throughout broad targetward arcs into the wakes.
- The best sampled policy adds a small, direct normalized yaw-moment residual
  to the faster half-cycle controller. Relative to the otherwise identical
  no-residual success, it improves arrival from `179.22` to `149.57`, mean
  distance from `5.04L` to `4.38L`, RMS moment from `338.91` to `314.99`, and
  RMS force from `18.42` to `16.22`, while retaining `-10.92L` upstream
  displacement. Its cost is higher mean command energy (`681.91` versus
  `653.20`) and peak anterior acceleration closer to the cap (`30.92` versus
  `30.40 rad/time^2`). This supports preserving the small direct residual and
  its gait rather than reopening scalar gait tuning.
- The assigned parent's later combination is a concrete negative result. It
  changes the successful direct residual to a slower `0.76` period, raises the
  residual gain, and gates it by `1 - abs(route_turn)`. The rollout makes a
  compact upper-right loop, exits the top boundary after `126.43` units, moves
  only `-1.12L` upstream, and regresses from `8.61L` minimum to `12.05L` final
  distance. RMS moment remains a superficially moderate `317.27`, and joint
  maxima stay within the hard envelope, so neither load reduction nor an
  actuator audit catches the lost route. Because three controller changes were
  bundled, this evidence cannot isolate the gate, gain, or period; later work
  should not treat route-headroom gating as validated and should make causal
  extensions from the direct-residual success one mechanism at a time.

## Candidate hypothesis

Keep the best sampled controller's state-feedback oscillator, zero-mean
half-cycle steering, posterior lag, gait parameters, and small direct
`moment_z_L2` residual unchanged. Add only bounded damping from the observed
body-frame `bearing_window_rate` inside the persistent bearing request. A
positive bearing rate strengthens a same-sign correction when alignment is
worsening; an opposite-sign rate releases part of the turn while bearing is
converging. The term is smoothly saturated and cannot enlarge the final
half-cycle request beyond the existing `[-1,1]` bound.

This should retain the demonstrated wake-crossing route and arrival while
reducing the visible bearing zigzags and avoiding the parent's upper-right
loop. Falsify it if capture is lost or materially delayed, upstream
translation falls, command or load metrics rise, the alternating posterior
wave is suppressed, or any bottom/top/downstream exit topology returns. The
new formal CFD result occurs only after this worker exits, so these are tests,
not claimed outcomes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-adaptive swimming
source_mechanism: damp the slow target-relative direction loop with observed direction-rate feedback while retaining a smaller fast load residual on the rhythmic steering primitive
transferable_invariant: persistent body-frame target geometry owns route steering, its observed convergence rate may release or restore turn authority, and fast yaw load remains a separately bounded correction
nontransferable_details: published gains, dimensional beat settings, robot linkage and species kinematics, exact vortex phase, cylinder layout, recurrent-network state, and source-task routes
policy_translation: preserve the sampled joint-state half-cycle oscillator and direct normalized moment residual, then add one smoothly bounded `bearing_window_rate` term inside the body-frame bearing request before the existing turn and amplitude bounds
falsification: reject if rate damping weakens necessary far-field correction, loses or slows capture, raises load or cap contact, destroys posterior lag, or reproduces the sampled loop or boundary exits

## Pre-evaluation contract and actuator audit

The lightweight Julia contract call passes with finite two-joint output and the
parameter schema contains both new rate-feedback fields. A joint-only
semi-implicit stress calculation (not CFD or rollout evidence) over smooth
coupled bearing, bearing-rate, and moment inputs kept angles near
`23.6/20.1 deg` and speeds near `193/166 deg/time`; its worst raw anterior acceleration
was about `1803 deg/time^2`, essentially at the `1800` hard envelope. The final
turn request retains the successful prefill's same `[-1,1]` bound, but the
sampled prefill already reached `1772 deg/time^2` in CFD, so actuator-cap
contact remains an explicit falsification condition rather than a claimed
safety margin. Hydrodynamic route, load reduction, and target capture remain
for the later formal evaluation.
