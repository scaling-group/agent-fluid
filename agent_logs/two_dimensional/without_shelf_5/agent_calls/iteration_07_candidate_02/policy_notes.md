# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held at the upper-right release pose while four staggered vortex streets
  develop and merge around the target. It cannot distinguish controller
  quality.
- All four sampled solver candidates are byte-identical gain-`1.7` policies
  and produce identical released dynamics. Their sheets show active
  self-propulsion, not passive advection: the fish makes an early left-down
  heading correction, leaves a dense alternating tail trail, enters the
  developed wake corridor, and crosses the `0.75L` target ring without
  collision, domain exit, or instability. Capture occurs at `39.710`, with
  mean/final distance `1.874/0.749L`, relative-crossflow RMS `0.2265`,
  force/moment RMS `38.40/618.59`, and power proxy `4092.5`.
- The inherited gain-`1.725` sheet is the most informative finite negative
  comparator because no sampled rollout is a semantic failure. It retains the
  same route topology and capture, but arrives at `40.832`, raises mean
  distance to `1.915L`, relative-crossflow RMS to `0.2364`, force/moment RMS
  to `42.50/674.61`, power to `4263.5`, and maximum joint angles to
  `0.526/0.556` rad. Gain `1.9` also regresses. These outcomes rule out another
  tiny bearing-gain interpolation, not bounded positive bearing steering.
- At the gain-`1.7` anchor the posterior maximum joint angle (`0.528` rad)
  exceeds the anterior maximum (`0.507` rad) by `0.0212` rad, while both joints
  touch the same rate and acceleration caps. The corresponding posterior-minus-
  anterior gaps remain positive at gains `1.725` (`0.0297` rad) and `1.9`
  (`0.0243` rad), where loads are worse. This supports testing distribution of
  the already successful steering command separately from its gain or gait.
- The inherited mixed-feedback controller is only an outer safety boundary:
  simultaneous propulsion, steering-sign, velocity, and moment changes became
  unstable at `2.807`. This candidate therefore adds no observation, damping,
  or flow/moment term and does not weaken the evaluated propulsion oscillator.

## Candidate hypothesis

Preserve the exact measured `steering_gain=1.7`, `0.55`-period 28-degree gait,
posterior phase lag, positive bearing sign, and 12-degree `tanh` steering bound.
Change only `anterior_steering_fraction` from `0.40` to `0.45`. The controller
still centers the total posterior tangent on the same `steering_angle`; the
change only transfers at most `0.6` degree of a saturated steering bias from
joint 2 to joint 1. That transfer is approximately half the measured
`1.22`-degree peak-angle gap at gain `1.7`, so it may reduce posterior excursion
and moment load without changing the successful target mapping or route.

The later CFD rollout should falsify this unvalidated redistribution if it
loses capture, arrives later than `39.710`, raises mean distance above
`1.874L`, raises force/moment RMS above `38.40/618.59`, or merely moves the
larger excursion/load to joint 1. A regression should restore fraction `0.40`;
an improvement must include preserved capture plus lower load or effort, not a
visually similar path or scalar score alone.
