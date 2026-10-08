# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The current shared-prewarm sheet shows the fish held high and downstream of
  the four staggered cylinders while their developed streets overlap through
  the target corridor. The sampled sheets are the same certified initial
  condition, so this structure does not rank candidates.
- The four current rollouts reduce to two policies, each reproduced exactly.
  Both are self-propelled, wake-assisted successes: their mean upstream head
  velocities exceed the magnitude of mean local-flow x, and neither collides,
  exits, becomes unstable, or saturates the `31.2` policy guard. Their sheets
  show the same broad release turn, several productive wake-band crossings,
  and an almost horizontal final target entry rather than passive advection.
- The prefilled `0.08` sign-gated body-frame lateral counter-drift policy is
  the useful route anchor. It captures at `224.488`, with `6.31061L` mean
  distance, `0.01602` controller-relative upstream transport, `17.943` RMS
  lateral force, `361.014` RMS moment, and `157453.9` total command energy.
- Reducing only the counter-drift lookahead to `0.07` is the direct current
  negative contrast. Its sheet retains capture and the central-wake approach,
  and mean distance improves by only `0.00597L` while score rises by `0.0201`.
  However, capture is delayed by `20.961` to `245.449`, upstream margin falls
  to `0.01284`, RMS force/moment rise to `18.399/363.454`, and total command
  energy rises to `169649.0`. Maximum lateral offset and anterior acceleration
  remain fixed at `4.293L/31.055`, isolating a steering-timing trade rather
  than propulsion, saturation, or excursion-envelope change.
- Inherited logs bound the other side: an otherwise matched `0.10` correction
  captured at `263.346`, worsened mean distance to `6.974L`, and produced a
  visible late lower-corridor excursion. The inherited alignment-gated
  heading-rate policy is the weakest visual success (`265.298`, `7.822L`
  mean distance, negative upstream margin). Every available current or
  inherited keyframe sheet terminates in target capture, so there is no hard-
  failure sheet to inspect; the inherited logs report that sign-asymmetric
  bearing-rate steering missed the horizon. These results argue against
  another constant gain, rotational correction, or bearing-rate decomposition.

## Single candidate hypothesis

Preserve the demonstrated `20.25 deg`, `0.67`-period propulsion shell,
posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lookahead, `0.10` lateral-velocity clamp, and `31.2` acceleration
guard. Keep the existing target-away lateral-translation gate, but make its
lookahead a bounded rolling-progress blend between the two current sampled
points. Use `0.08` when normalized window closing speed is negative
(stalled/receding), `0.07` during strong positive closing, and a smooth
midpoint at zero. A `0.02L/time` transition scale is commensurate with the
sampled `0.01284--0.01602` controller-relative upstream transport margins.
The correction remains exactly zero for stationary or targetward lateral
translation and never exceeds the already demonstrated `0.008 rad` addition
before the steering nonlinearity.

This is a distinct rolling-window corridor-retention test: it retains the
faster `0.08` recovery exactly when distance progress is being lost, while
backing off toward the marginally better-integral `0.07` setting only after
the route is closing. It uses normalized body-frame feedback and no global
coordinate, route, clock, prescribed inflow, or remote wake probe. Falsify it
on lost or later-than-`224.488` capture, mean distance above `6.31061L`,
upstream margin below `0.01602`, material crossflow/force/moment or effort
growth, guard contact, larger lateral excursion, or visible switching. No
same-worker CFD result is claimed; a held-out wake phase remains necessary
before treating this blend as transferable.
