# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held above and downstream of the target while four staggered-cylinder vortex
  streets develop through the second-row target corridor. The released sheets
  for all four current samples remain above and to the right of that corridor;
  they show a leftward closing leg followed by a nose-up turn and upper-domain
  exit. The unresolved regime is therefore far-field course retention, not
  useful-wake exploitation or `0.75L` capture.
- The assigned `behind_bearing_fraction=-0.125` prefill is the strongest
  current finite sample by navigation score (`-11.2406`). It moves the head
  `(-4.55,+1.80)L`, reaches `6.609L`, records mean/final range
  `9.415/9.360L` and progress `0.2466`, and remains finite for `69.85` released
  time. Mean x velocity is `-0.0709` versus local-flow x `-0.0481`, so the
  approach is actively propelled rather than passive advection. Its sheet
  still ends in the same upper return, and the diagnostics show anterior
  joint speed at the `260 deg/time` hard cap, anterior angle near `34.2 deg`,
  action near the `1600 deg/time^2` soft limit, and RMS force/moment
  `75.9/1004`.
- The two duplicate fixed-`-0.25` controls provide a deterministic comparison.
  They preserve the same visible approach and exit, move `-4.44L` upstream,
  reach `6.627L`, and have progress `0.2406`, but remain released for `74.48`
  time and keep anterior speed near `254 deg/time`. Their mean/final range
  `9.449/9.434L` and score `-11.2864` are slightly worse, while RMS
  force/moment rise to `76.8/1030`. Thus more negative authority trades a
  small amount of navigation for cap clearance and lifetime; it does not cure
  the exit.
- The deep-rearward continuation toward `-0.50` confirms the adverse side of
  the bracket. It retains the upper exit and the same `6.627L` closest range,
  but cuts upstream head travel to `-4.32L`, lowers progress to `0.2325`,
  worsens mean/final range to `9.523/9.535L`, score to `-11.3792`, and raises
  RMS force/moment to `78.1/1072`. Inherited optimizer logs agree that a full
  `-0.50` continuation and rearward-only overspeed damping also shortened the
  useful leg without changing the failure topology. Those mechanisms and any
  extension beyond `-0.25` are negative here.
- The current visual and numerical bracket materially revises the assigned
  parent's expectation. Its interior `-0.125` test improves every navigation
  metric over zero and `-0.25` rearward authority, but it fails the stated
  cap-avoidance and topology criteria. The result supports only narrow
  far-field approach refinement between `-0.125` and `-0.25`; it is not
  evidence that bearing interpolation is a recovery controller.

## Candidate hypothesis

Change exactly one active parameter from the prefill: set
`behind_bearing_fraction=-0.15625`, one quarter of the way from the
navigation-best `-0.125` control toward the longer-lived, below-cap `-0.25`
control. Preserve the oscillator, joint guards, `0.60` bearing gain, `12 deg`
steering ceiling, `0.35/0.65` curvature allocation, fixed `0.04` recent-turn
damping, and `0.5L` signed fore/aft transition. This conservative interior
test asks whether most of the `-0.125` approach gain can be retained while a
small additional reversal moves anterior speed off the hard cap and recovers
some of the `-0.25` lifetime. It adds no observation or coupled factor.

The hypothesis is supported only if evaluation remains finite, keeps roughly
`-4.5L` upstream travel, a `6.65L` or better closest approach, and progress
near `0.245`, while moving anterior speed below `260 deg/time` or extending
lifetime without worsening mean/final range beyond the fixed-`-0.25` control.
It is falsified as an approach refinement if those navigation metrics regress,
and it remains falsified as a recovery policy if the same upper exit persists
without material gain. Later workers should leave this scalar bracket if that
happens and test a bounded structural terminal discriminator that remains
inactive through the demonstrated closing leg. The policy uses only normalized
body-frame target geometry, joint state, and recent turn rate; it contains no
coordinate, clock, route, prescribed inflow, remote probe, target-station
signal, or omitted-shelf dependency. Formal CFD is deferred to EvE.
