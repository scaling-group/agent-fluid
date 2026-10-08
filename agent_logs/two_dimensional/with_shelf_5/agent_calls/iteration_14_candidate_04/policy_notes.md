# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes. It is the common initial
condition, not candidate-specific evidence. The strongest three sampled
policies are byte-identical. Their released sheets show one decisive
correct-sign redirect followed by a coherent posterior traveling bend and a
compact upstream-left traverse to the `0.75L` target boundary. They reproduce
capture at `43.9505`, mean distance `2.1391L`, and RMS relative crossflow,
lateral force, and yaw moment of `0.2111`, `49.44`, and `701.26`. Mean fish
velocity `(-0.2471,-0.1020)` differs materially from mean local flow
`(-0.1342,-0.1556)`, especially upstream, so the approach is active swimming
rather than the advection-dominated motion of the documented seed failure.
Both joint-rate and acceleration envelopes are nevertheless reached.

No sampled solver has a semantic-failure keyframe. The available failure-class
boundary is therefore the inherited target-blind seed, which left the lower
domain after `50.127` with no recovery turn and little velocity relative to
local flow. The most informative visual negative in the assigned parent is
the completed alignment-conditioned amplitude transition. It preserves a
roughly direct six-frame route and still captures, but delays arrival to
`44.8525`, raises mean distance to `2.1708L` and command energy to `54872.1`,
and increases RMS crossflow/force/moment to `0.2188/69.92/948.62`. Its late
sheet also shows larger, more distorted body-shed structures than the carrier.
Alignment is therefore not by itself permission to weaken the oscillator
envelope: changing the amplitude inside the nonlinear Van der Pol drive can
increase, rather than relieve, actuation and fluid loads.

The inherited direction-aware posterior rate projection is the positive
contrast. It removes only outward acceleration near the posterior rate
envelope after alignment, preserves every reversal, and retained the compact
capture at `44.0220` with RMS crossflow/force/moment
`0.2102/44.86/663.89`. Terminal localization erased that effect, selecting
transit rather than range as the useful regime. A nonpreferred-half-cycle
selector recovered only part of the benefit (`44.0605`, `46.71/677.72`), and
the sampled phase-lead variant worsened loads (`53.18/736.58`). The evidence
supports direction-aware envelope projection but not another phase, distance,
moment, or amplitude modulation.

## Policy hypothesis before the edit

Preserve the evaluated oscillator, normalized body-frame bearing curvature,
target-favored half-cycle steering, posterior lag, and smooth approach taper.
Generalize the evidenced alignment-gated outward-rate projection from the
posterior joint to both joints using the same normalized rate envelope and
gate. Large bearing demand leaves both raw accelerations exactly unchanged.
After alignment and only near a rate limit, remove from each joint only the
acceleration component that reinforces its current rate; all acceleration
that reverses either joint remains exactly available.

This is one bilateral actuator-envelope mechanism, not a gain retune. It tests
the unresolved observation that both joints hit their rate and acceleration
caps even after posterior-only load shaping. Expected evidence is the same
direct target capture, posterior load benefit at least comparable to the
evaluated projection, and reduced anterior cap/load evidence without the
nonlinear load amplification of amplitude scaling. Falsify it if the direct
route or capture is lost, arrival is materially slower than the posterior-only
`44.0220` result, reversal authority changes, or force, moment, effort, and
anterior saturation do not improve enough to justify the added projection.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve the traveling-bend carrier and its posterior thrust while sensor feedback relieves redundant actuator drive after direction alignment
transferable_invariant: retain full bounded target-directed rhythm at large body-frame error and every joint reversal, while removing only acceleration that reinforces an already near-envelope joint rate after alignment
nontransferable_details: published gains and dimensional envelopes, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: use bounded body-frame bearing demand as the alignment observation, each normalized joint rate as its own envelope state, and project only the same-sign outward component of the two raw joint accelerations
falsification: reject if capture or compact route topology degrades, arrival materially exceeds the posterior-only result, reversal changes, or load, effort, and anterior saturation evidence do not improve

## Pre-evaluation verification

The required semantic-guidance check and solver editable-boundary check pass.
The rendered workspace README initially repeated the same copied-parent marker;
removing only that duplicate metadata entry allowed the checker to resolve the
unchanged assigned parent. Static schema comparison found all `15` direct
`params.FIELD` references among the `15` fields returned by
`target_policy_params()`. A deterministic algebraic sweep of `72,900` states
spanning range, both bearing signs, both joint limits, rates below and above
the guard, and both rate limits returned finite actions and gates in `[0,1]`.
It confirmed exact inactivity at large bearing demand, exact preservation of
every reversal acceleration, no amplification or sign reversal of outward
acceleration, and zero action at the zero state. The prescribed Julia include
check could not start because this workspace image has no `julia` executable;
this is a verification limitation, not a passed runtime assertion. No formal
CFD was run.
