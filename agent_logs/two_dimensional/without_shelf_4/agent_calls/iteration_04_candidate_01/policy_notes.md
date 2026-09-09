# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet shows the common held fish high and to the right of
  the target, with four mature, interacting vortex streets already developed.
  It is an initial-condition control, not evidence for any candidate.
- The finite `solver_b01c34e7ecd0` sheet shows a broad transient route after
  release, followed by leftward alignment and sustained travel through the
  wake corridor into the target from the right. It reaches the `0.75L` radius
  at `266.255`, with final/minimum distance `0.749L`, head displacement
  `(-11.031,-4.702)L`, and no collision, exit, or instability. Mean head
  velocity `(-0.04144,-0.01765)` is close to mean local flow
  `(-0.03889,-0.02029)`, while mean relative flow is only
  `(0.00254,-0.00264)`: the useful transport is wake-assisted rather than a
  claim of large velocity relative to the surrounding water. The controller
  keeps maximum joint angles near `20.0/25.0 deg`, rates near
  `187.7/141.3 deg/time`, and accelerations near `1757.3/1325.9
  deg/time^2`; its `30.8 rad/time^2` software guard is not reached.
- The prefilled `solver_7e71cb4e69e1` does enter the wake and move diagonally
  upstream, but the last keyframe shows an upward turn away from the target.
  Its `3.246L` minimum becomes a `3.610L` final miss. Despite nearly the same
  mean command effort as the success (`669.34` versus `667.60`), it obtains
  only `-8.121L` head-x travel, weaker mean upstream velocity (`-0.02730`),
  and less negative mean local flow (`-0.02266`). Its simultaneous changes to
  `21 deg`, period `0.69`, and bearing scale `0.38` prevent attributing the miss
  to amplitude alone; the observed failure is late corridor loss/rebound, not
  inadequate actuator effort.
- `solver_f5cca4991f3d` is the cleanest local control: it has the same `0.67`
  period, `0.65/0.80` posterior lag/damping, and `0.30` bearing scale as the
  finite example but a `19 deg` shell. It eventually points upstream and
  survives the horizon, yet reaches only `-5.846L` head-x displacement and
  finishes at its `5.812L` minimum. Raising only the shell to `20 deg` (plus an
  inactive guard) more than doubles upstream displacement and reaches the
  target. By contrast, the `0.78/0.72` posterior-lag variant
  `solver_fb70be292389` visibly loops near the release corridor, has only
  `+0.058L` head-x displacement, and ends `11.719L` away, so extra posterior
  lag is not a supported repair.

## Candidate hypothesis

Replace the prefilled softened `21 deg`, `0.69` controller with the complete
sampled finite bundle: a `20 deg`, `0.67` phase shell, `0.65/0.80` posterior
lag/damping, bounded negative posterior bearing/rate correction with `0.30`
bearing scale, and a `30.8 rad/time^2` local acceleration guard. This is one
candidate and changes no route, coordinates, time signal, morphology, or
episode code. Under the certified common prewarm it should reproduce the
demonstrated wake-assisted corridor capture without the prefill's late rebound.
Falsify the hypothesis if the candidate misses the target under the same fixed
prewarm, if the local guard becomes active, or if the final keyframes again
show approach followed by increasing distance; in that case later work should
test corridor-retention feedback rather than increase posterior lag or raw
effort.
