# Step 34 target-policy diagnosis

## Evidence read before the edit

- All four sampled solver runs satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and capture at
  `0.7480--0.7495L` after `18.199--18.749T`. Their top-down rows retain an
  alternating signed-vorticity street and their oblique rows retain bilateral
  Lambda2 structures through capture. The fish is self-propelled and still
  undulating at termination; neither advection nor terminal wake collapse
  explains the successful passes.
- The strongest sampled finite run is the exact speed-reserve capture at
  `0.74939L`, `18.6010T`, and score `-0.15140`. The prefilled fixed
  unsafe-terminal anterior-transfer policy also captures, but later at
  `18.7495T`; inherited evidence reports no clipping, speed-residence, load,
  or repeat-reliability advantage for fixed spatial transfer, so that
  mechanism is removed rather than scalar-tuned.
- The assigned parent's exact speed-reserve rollback is the informative
  active-wake failure. Its top-down and oblique sheets remain organized, but
  the trajectory passes below the target at `1.4107L`, turns down, and exits
  at `32.703T` with final distance `10.5484L`. This extends the inherited
  exact-policy record from `4/6` to `4/7`; unchanged replay is not a robust
  answer even though propulsion survives.
- The sampled-optimizer progress-loss redirect is a distinct informative
  failure. It reaches `1.2402L`, then its persistent two-joint mean-curvature
  replacement entrains the joints into a slowly varying bend: after about
  `20T` joint speeds and actions decay, the `24T` and `31.23T` sheets show no
  substantial new alternating wake, while inertial speed remains about
  `0.79--0.81L/T`. It coasts down the same lower branch and exits at final
  distance `10.1095L`. Algebraically retaining the oscillator is therefore
  insufficient when an unreleased curvature servo cancels its realized beat.

## Candidate hypothesis

Restore the evaluated intercept-guarded speed-reserve carrier and allocation.
Add one response-released recovery-bend mechanism that is exactly inactive
while terminal distance is still closing faster than `0.10L/T`. If a pass
stalls or opens, blend the ordinary steering residual into a bounded
target-signed mean-curvature redirect, but multiply that redirect by the
complement of the existing phase-compensated correct-turn response. A
correct-sign yaw response therefore releases immediately back to the intact
traveling carrier instead of holding the quasi-static curvature until distance
closure resumes.

This tests a clock-free C-start invariant rather than a scalar gain change:
geometry and progress trigger the bend, observed response releases it, and the
posteriorly lagged carrier remains the cruise/recovery gait. It should be
baseline-equivalent on every sampled capture trace, whose sub-`4L` closing
speed stays above `0.20L/T`, while permitting a missed first pass to turn and
make a propelled second approach. Falsify it if a sampled-class first pass is
lost, the same lower exit remains, the recovery gate chatters without useful
redirection, the terminal wake again collapses, or actuator/load metrics leave
the repeat-backed envelope. One threshold capture is compatibility evidence,
not robustness.

```text
bookshelf_consulted: true
source_domain: biological C-start reorientation and sensor-modulated robotic-fish turning
source_mechanism: gate a nonsteady curvature redirect by task error and release it when the desired body response appears
transferable_invariant: a recovery bend should be triggered and released by normalized geometry and measured response while the posterior traveling wave remains the propulsive gait
nontransferable_details: species-specific C-start shape, published gains, dimensional duration, robot morphology, exact vortex phases, and task-specific routes
policy_translation: below the existing terminal range, blend baseline steering into bounded two-joint curvature only after normalized closing progress is lost, then use phase-compensated yaw response to restore the unchanged carrier before it is entrained
falsification: reject if first-pass capture is perturbed, a miss still follows the lower branch, the active top-down or oblique wake collapses, or actuator and load metrics leave the baseline envelope
```
