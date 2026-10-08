# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. This is the certified common initial
  condition; it does not show candidate-specific wake selection or wake-phase
  robustness.
- All four assigned solver samples reproduce the ungated posterior-half-cycle
  controller at exactly `32.472` release time, `1.64761L` mean distance, and
  score `0.224538`. Their sheets show immediate targetward redirection, a
  sustained posterior-traveling body wake, cylinder clearance, and one compact
  diagonal crossing of the `0.75L` capture circle. Mean fish velocity
  `(-0.334,-0.140)` versus mean local flow `(-0.197,-0.189)` and head motion
  `(-10.912,-4.332)L` confirm self-propulsion rather than passive advection.
  The identical outcomes establish fixed-snapshot reproducibility only.
- The fast branch is load-intensive: both joints touch the `260 deg/time`
  velocity and `1800 deg/time^2` acceleration limits, posterior excursion
  reaches `0.5834 rad`, and lateral-force/yaw-moment RMS are `68.70/931.60`.
  The assigned parent's direction-selective headroom branch preserves the same
  visible route and repeatedly captures at `32.7305` with `1.64927L` mean
  distance while reducing posterior excursion to `0.5684 rad` and force/moment
  RMS to `56.29/800.58`. Nearly unchanged relative crossflow (`0.2451` versus
  `0.2431`) shows that the load reduction is not simple wake avoidance.
- The inherited completed records at steps 9, 10, and 11 repeat that same
  headroom result without a new mechanism or semantic improvement. This
  plateau triggers the required bookshelf consultation. It also means another
  replay of the same gate would add no evidence about held-out wake phase.
- No failed released sheet is present in the sampled workspace. The most
  informative adverse contrasts therefore remain inherited: a blanket
  physical-limit gate kept the route but delayed capture to `33.9405` and
  scored `0.181716`; an extra response-triggered burst delayed capture to
  `32.824` while increasing loads; unrestricted bearing-rate recentering erased
  the traveling bend and exited downstream. Those results rule out blanket
  damping, more posterior authority, and target-rate feedback at the oscillator
  centers.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG residual modulation interpreted through posterior reactive propulsion and transient target capture
source_mechanism: use slow goal-progress feedback to arbitrate an optional actuator-state residual while retaining a persistent lagged propulsive rhythm
transferable_invariant: preserve the traveling base gait and mean target curvature, restore bounded steering residual authority during turning or lost progress, and permit residual withdrawal only during coherent targetward motion
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator ratings, source-task routes, and fixed approach distances
policy_translation: normalize history-window target closure by the magnitude of the body-frame target-vector window rate, smoothly use that trajectory efficiency to supervise the evidenced direction-selective posterior headroom gate, and keep the resulting residual between the evaluated ungated and gated branches
falsification: reject if direct capture or the compact diagonal topology is lost, arrival or mean distance is worse than the completed headroom branch, loads return to the ungated branch without recovering its navigation result, or a held-out wake exposes switching or propulsion loss

## Candidate hypothesis

Produce exactly one candidate by combining the completed direction-selective
posterior headroom gate with one slow trajectory-efficiency supervisor. Preserve
the filtered body-frame bearing, bounded `12 deg` total-curvature request,
`40/60 -> 35/65` allocation, anterior state-feedback oscillator, posterior lag
and damping, and maximum `8%` target-helping half-cycle residual.

The supervisor computes nonnegative history-window closing speed divided by the
magnitude of the history-window target-vector rate. A smooth dimensionless
ratio near one means target-vector motion is mostly useful closure, so observed
posterior speed/acceleration pressure may withdraw the optional residual. A
ratio near zero means the fish is still redirecting, moving laterally, stalled,
or receding, so the residual returns continuously to the successful ungated
value. Early padded history also recovers the ungated branch. The mechanism
does not add a burst, read elapsed time, alter oscillator centers, or suppress
the unit-gain traveling wave. Downstream CFD must determine whether this bounded
interpolation retains the fast branch's arrival while preserving part of the
headroom branch's load reduction; no same-worker improvement is claimed.
