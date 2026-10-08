# Response-released smooth-envelope candidate

## Evidence diagnosis

- All four sampled rollouts are contract-valid direct-uniform still-water
  episodes with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Two
  samples are duplicate evaluations of the same base C-bend policy, so they
  are not treated as independent controller evidence.
- Both keyframe rows show self-propulsion rather than advection. The base
  C-bend, response-released C-bend, and smooth-envelope C-bend each retain a
  compact alternating top-down wake and a coherent three-dimensional Lambda2
  train through capture. The base policy follows the broadest, slowest arc and
  captures at `25.388T` with mean distance `2.557L`.
- Response-triggered redirect release is a small positive mechanism result on
  the same carrier: it preserves capture and wake coherence, reaches every
  `10/8/6/4/2L` threshold earlier, captures at `25.152T`, and lowers mean
  distance to `2.522L`. It also lowers posterior raw-acceleration cap contact
  from `34.0%` to `29.7%`, although the unprojected policy still exceeds the
  acceleration envelope on at least one joint for `82.0%` of samples.
- The assigned-prefill smooth-envelope policy is the strongest sampled result.
  It captures at `23.997T`, `1.391T` earlier than the base C-bend, lowers mean
  distance to `2.438L`, shortens center path length from `13.247L` to
  `12.949L`, and eliminates exact acceleration-limit contact while retaining
  the visible propulsive wake. Its `11.9/4.5%` anterior/posterior joint-speed
  cap exposure and `2.922 rad/T` peak yaw show that the remaining test should
  concern redirect release, not more cadence or larger turn gains.
- The assigned-parent logs also contain a concrete contrary case: replacing
  the carrier with a polarity-inverted response-gated bend curled upward,
  lost the alternating wake, parked the tail near its angle limit, and exited
  at `7.99T`. The response gate is therefore useful only as a bounded release
  of the validated same-sign C-bend; it is not evidence for changing bend
  polarity or suppressing the traveling-wave carrier.

## One candidate hypothesis

Retain the evaluated smooth output projection and the complete successful
C-bend/traveling-wave controller. Add only the independently positive
response-release gate from the captured comparator: full geometry-gated
posture redirect remains active while observed recent yaw is absent or opposes
the bounded target turn rate; correct-sign yaw continuously releases at most
28% of redirect load back to the posteriorly lagged propulsive wave. This is a
small compatible combination of two mechanisms already separated by sampled
rollouts, with no clock, route, mutable state, or scalar-only gain tuning.

Falsification: reject the combination if capture is lost, arrival or mean
distance regresses materially from the smooth-envelope parent, the visible
alternating/Lambda2 wake collapses, either boundary-exit curl returns, or joint
speed, yaw, force, or moment histories worsen despite bounded acceleration.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological C-start redirect and closed-loop robotic-fish CPG modulation
source_mechanism: large direction error invokes bounded curvature, then measured correct-sign yaw releases steering posture into posteriorly lagged propulsion
transferable_invariant: steering posture should yield continuously to the propulsive carrier only after observed yaw follows the body-frame turn request
nontransferable_details: species kinematics, published gains and frequencies, dimensional maneuver timing, exact vortex phase, full-body shapes, and task-specific routes
policy_translation: multiply the normalized body-frame geometry redirect by a bounded gate formed from target turn rate times observed recent yaw, retain a nonzero redirect floor, and preserve the two-joint oscillator plus smooth acceleration projection
falsification: loss of capture, coherent wake, or target-directed arc, increased speed/load saturation, or recurrence of either sampled boundary-exit topology invalidates the transfer
```

## Worker-side verification boundary

- The semantic guidance check and solver boundary check pass. The deterministic
  schema audit finds 60 returned fields and 58 direct `params.FIELD`
  references, with no missing fields; the candidate contains no clock, route,
  random, cylinder, mutable-global, or file-I/O dependency.
- With fixed parameters, `positive_turn_response >= 0` makes the new response
  gate lie in `[0.72,1]`, and the retained fourth-order projection keeps every
  finite output strictly inside `1800 deg/T^2`. These are algebraic contract
  checks, not a fluid-dynamic counterfactual.
- The configured check-runner was invoked but its pinned model is unavailable
  for this account. Its exact checks were run directly; only the Julia loader
  smoke test could not execute because `julia` is absent. No CFD was run, and
  the candidate's hydrodynamic outcome remains for EvE after exit.
