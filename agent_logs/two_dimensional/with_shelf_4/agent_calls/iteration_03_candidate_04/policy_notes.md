# Multi-wake target-policy candidate

## Evidence diagnosis recorded before the policy edit

- The shared prewarm sheet establishes a common initial condition: the held
  fish begins above and to the right of four developed interacting streets,
  outside the second-row target neighborhood. The common target-blind seed is
  visibly self-propelled but turns into a steep downward transit, reaches both
  joint speed and acceleration caps, and exits the lower domain at `50.127`
  released units after head displacement `(-3.545,-13.300)L`; its closest
  distance `8.615L` regresses to `12.123L`.
- The static-curvature descendant improves the termination class to a full
  `300`-unit horizon and lowers RMS moment from `541.704` to `270.955`, but its
  sheet shows repeated far-right loops. It advances only `1.187L` upstream,
  reaches no closer than `10.276L`, and ends `10.484L` from the target. Thus a
  bounded gait is useful, while persistent mean curvature is not a supported
  route mechanism for this topology.
- Two sampled half-cycle controllers do reach the target. The prefilled policy
  applies bearing-rate-damped asymmetry to joint 1 and a smaller matching
  asymmetry to the posterior target; it wanders through a long upper-right
  loop and several sharp reversals before capture at `268.488`, with mean
  distance `8.038L`, mean command energy `351.616`, and RMS moment `273.010`.
  The stronger comparator applies bearing-driven asymmetry only to joint 1;
  its sheet shows a shorter descending turn followed by sustained upstream
  translation into the target wake, capture at `179.218`, and mean distance
  `5.041L`. It uses more command effort (`653.202` mean) and sees higher RMS
  relative crossflow/moment (`0.133/338.915`), but stays finite and below the
  joint angle, speed, and acceleration envelopes (`0.397 rad`, `3.246
  rad/time`, `30.402 rad/time^2` maxima for joint 1).
- The assigned parent's inherited second-step log supplies a critical negative
  boundary: applying the same `0.35` half-cycle asymmetry to both the anterior
  oscillator and posterior target moves `+2.343L` downstream and exits after
  `25.811` units with final distance `14.060L`. Together, these results do not
  justify another posterior steering gain. They support isolating route
  asymmetry to the anterior oscillator while retaining an unmodulated lagged
  posterior wave. They also do not support indiscriminate crossflow rejection:
  the largest sampled finite crossflow belongs to the fastest successful
  approach, and no phase-resolved sign calibration is available.

## Policy hypothesis

Use the fastest successful actuator-feasible traveling-bend scaffold as a
deliberately minimal rebaseline: bounded body-frame bearing selects anterior
half-cycle amplitude, joint angle and velocity encode phase, and joint 2 only
tracks the resulting posterior-lagged wave. Removing the prefilled posterior
asymmetry and bearing-rate branch tests whether a single coherent steering
site avoids the slow controller's reversals without reintroducing static
curvature or the inherited equal-tail-asymmetry downstream exit. No flow
phase, cylinder coordinate, target identity, elapsed time, route, or mutable
controller state is used.

Support the candidate if formal evaluation reproduces target capture with a
shorter distance integral and arrival than the prefill while remaining finite
and below actuator caps. Falsify the structural implication if it returns to
the lower/domain exit or far-right loop, loses target capture, persistently
clips acceleration, or improves arrival only through materially worse loads.
The new CFD rollout happens after this worker exits, so the sampled comparator
metrics above—not an unevaluated same-worker claim—are the present evidence.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction control by asymmetric flapping layered on rhythmic propulsion
source_mechanism: target-dependent half-cycle amplitude asymmetry with an anterior steering oscillator and posterior-lagged traveling bend
transferable_invariant: persistent body-frame direction error may strengthen the requested bend-side half-cycle while a sign-changing posterior-lagged wave continues to provide thrust
nontransferable_details: published gains, dimensional frequencies, linkage geometry, species-specific envelopes, clock phase, exact vortex phase, cylinder layout, and source-task routes
policy_translation: map normalized body-frame bearing through a smooth bound, infer beat side from normalized anterior joint angle and velocity, modulate only the anterior phase-plane envelope, and pass that wave to an unmodulated lagged second-joint target
falsification: reject if anterior-only asymmetry loses capture, repeats the lower exit or far-right loop, becomes cap-dominated, or gains arrival speed only with materially worse force or moment loads

## Pre-evaluation audit

A source diff confirms that the executable equations and parameter values are
intentionally identical to the fastest sampled finite controller; only
comments differ. This is an evidence-backed champion rebaseline from the
prefilled slower controller, not a claim that unevaluated gain interpolation
will improve it. A language-independent joint-only integration (not CFD and
not rollout evidence) checked constant bearings `-0.5`, `0`, and `+0.5` rad.
It mirrored the requested half-cycle, kept angles within `23.09/19.64 deg`,
speeds within `192.02/163.69 deg/time`, and raw accelerations within
`1769.61/1444.72 deg/time^2` for joints 1/2, below the `45/260/1800` envelope.
A finite-output grid over joint state and bearings through `+/-pi` also passed,
and every direct `params.FIELD` reference resolves to the returned schema.
These checks establish equation parity, bounded realization, and contract
shape only; the later evaluator owns the new formal rollout.
