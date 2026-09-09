# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet confirms the common held-fish initial condition:
  four developed staggered wakes merge around the target while the fish is
  held above and downstream. This identical flow field is not policy credit.
- The released sheets for bearing gains `1.5`, `1.7`, and `1.9` all show active
  self-propulsion rather than passive advection. Each fish leaves a dense
  tailbeat trail, makes an early turn, traverses diagonally left and down into
  the interacting wake, and reaches the target ring without collision, domain
  exit, or instability. There is no failed current sampled rollout; the
  weakest finite success (`1.5`) and the assigned parent's target-blind seed
  exit provide the available negative boundaries.
- Raising only `steering_gain` from `1.5` to `1.7` improved score from
  `-0.041832` to `0.002860`, shortened arrival from `41.316` to `39.710`, and
  lowered mean distance from `1.9194L` to `1.8738L`. It also reduced relative
  crossflow RMS from `0.2364` to `0.2265` and force/moment RMS from
  `41.98/660.23` to `38.40/618.59`, while retaining the same visible route.
- The new `1.9` sample falsifies a monotonic continuation. Against `1.7`, it
  arrives later at `40.034`, raises mean distance to `1.9013L`, lowers score to
  `-0.024288`, and raises relative-crossflow RMS to `0.2329` and force/moment
  RMS to `41.31/657.28`. Maximum joint angles also rise from `0.507/0.528` to
  `0.523/0.548` rad. Both gains touch the same rate and acceleration envelopes;
  the `1.9` mean command energy is only slightly lower while its total command
  energy is higher. Because gain is the sole policy difference, the evidence
  supports a local optimum near the lower end of the `1.7`--`1.9` bracket, not
  a propulsion, wake-signal, or actuator-limit explanation.

## Candidate hypothesis

Keep the evaluated `0.55`-period, 28-degree oscillator, posterior phase lag,
positive two-joint bearing centering, and 12-degree `tanh` steering bound.
Change only `steering_gain` from the regressed prefill value `1.9` to `1.72`.
This is a conservative one-tenth interpolation into the bracket from the best
sampled value; descriptive three-point fits put the score, mean-distance, and
relative-crossflow minima near `1.72`--`1.73`, but the sparse deterministic
samples do not justify treating that fit as an identified model.

The post-worker CFD result should falsify this bracket candidate if it loses
capture, arrives later than `39.710`, exceeds `1.8738L` mean distance, or raises
crossflow or force/moment loads above the `1.7` comparator. If it does, later
workers should restore the evaluated `1.7` value rather than resume upward gain
steps or add unscaled flow/moment feedback. If it improves navigation while
loads remain finite, refine only inside `1.7`--`1.9` before changing another
controller axis.
