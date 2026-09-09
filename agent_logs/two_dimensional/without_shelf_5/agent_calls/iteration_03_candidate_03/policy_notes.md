# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet confirms a common initial condition: the held fish
  starts above and downstream of four developed, interacting staggered wakes.
  The released sheets show that the successful bearing-centered controllers
  are self-propelled: each leaves a dense tailbeat trail, makes an early turn,
  and then traverses diagonally into the merged wake and target ring rather
  than merely following the local flow.
- The three sampled `steering_gain=1.5` rollouts are deterministic replicas.
  Each reaches the target after `41.316`, with mean/final distance
  `1.919/0.750L`, command-energy mean `1404.94`, relative-crossflow RMS
  `0.2364`, and force/moment RMS `41.98/660.23`. Their images show a safe,
  direct trajectory, so this evaluated structure is the policy anchor.
- Increasing only the smooth bearing gain from `1.5` to `1.7` preserves the
  same turn-then-diagonal topology and target capture while improving every
  sampled navigation/load comparator: arrival becomes `39.710` (3.9 percent
  earlier), mean distance becomes `1.874L` (2.4 percent lower), total command
  energy falls from `58046.5` to `54703.2`, relative-crossflow RMS falls to
  `0.2265`, and force/moment RMS fall to `38.40/618.59`. Maximum joint angles
  also fall from `0.521/0.550` to `0.507/0.528` rad, although both policies
  still touch the configured rate and acceleration envelopes.
- The inherited multi-signal failure is a useful boundary, not a nearby gain
  comparator. Its released sheet ends at the release pose after `2.807`, and
  diagnostics report instability, relative-crossflow RMS `3.67`, and
  force/moment RMS `5.33e4/6.88e5`; it simultaneously slowed propulsion,
  reversed/rearranged steering, and added lateral-flow and moment feedback.
  The evidence therefore supports continuing the bounded bearing-gain axis,
  not adding those signals or weakening the successful gait.

## Candidate hypothesis

Preserve the evaluated `0.55`-period, 28-degree oscillator, positive curvature
sign, two-joint steering distribution, and 12-degree `tanh` steering bound.
Increase only `steering_gain` by the same local increment, from the sampled
best value `1.7` to `1.9`. The previous increment improved alignment, arrival,
distance integral, loads, and effort without changing path topology; another
small increment should strengthen only the near-zero bearing response while
leaving worst-case curvature unchanged.

The later CFD rollout should falsify this continuation if it loses target
capture, arrives later than `39.710`, raises mean distance above `1.874L`, or
reverses the observed reductions in relative crossflow and force/moment load.
If any boundary is crossed, later workers should restore `1.7` and bracket the
gain between `1.5` and `1.9` before testing a different observation or gait
parameter.
