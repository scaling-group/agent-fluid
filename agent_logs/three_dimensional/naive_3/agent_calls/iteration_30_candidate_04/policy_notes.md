# Target-signed adverse-yaw work-allocation candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertially
  still fluid inserted by the moving window. All capture at `16.988T`, so
  there is no failed termination in the sampled set; the informative negative
  contrast is a controller edit that produces no behavioral change.
- I inspected both the top-down vorticity row and oblique body/Lambda2 row of
  the combined sheets from release through capture. The fish advances toward
  the target while leaving a coherent alternating red/blue street, and compact
  three-dimensional structures remain behind the caudal region through the
  terminal turn. There is no standing wiggle, collision, domain exit, wake
  collapse, or terminal coast. Metrics confirm self-propulsion rather than
  ambient or moving-window advection: peak body speed is `1.374U`, while peak
  sampled local flow is only `0.0313U`.
- Three samples use the prefilled bidirectional phase-local allocator. The
  fourth adds a smooth `0.016--0.018 L^2` yaw-moment magnitude gate to both
  transfer directions, but all four trajectory files, keyframe sheets, and
  3,089-step diagnostic traces are byte-identical. Thus the magnitude gate
  never changes an active transfer on this route. Whole-trace peak yaw moment
  (`0.01804`) is not a valid threshold for a discretionary mechanism whose
  active states have a different load distribution.
- The repeatable trajectory remains a strong finite reference: capture,
  score `-0.204764`, mean distance `2.08931L`, joint-speed maxima
  `4.51886/4.52374 rad/T` below the `4.53786 rad/T` stops, posterior angle
  `0.5700 rad`, and force/yaw-moment peaks `0.03634/0.01804`. It also exposes
  the next discriminating signal. Replay of the observed joint states shows
  that posterior-to-anterior reclaimed-work opportunities occur while the
  receiving anterior acceleration is already target-signed and opposes the
  measured yaw moment in almost every case; their mean moment magnitude is
  about `0.0104`. In contrast, the largest carrier moments have the same sign
  as the requested turn. An absolute-load brake would therefore suppress
  useful target-directed carrier response, whereas an adverse-load product
  can distinguish corrective from helpful yaw.

## Single-candidate policy hypothesis

Preserve the captured zero-centered anterior oscillator, posterior traveling
lag, body-frame velocity-course steering, terminal posterior acceleration
reserve, soft acceleration envelope, high-onset positive-work speed guards,
bidirectional phase-local work transfer, and posterior stopping-risk
projection. Change only the posterior-to-anterior transfer semantics: retain
its established base fraction, then add a bounded extra fraction when the
existing anterior receiver command agrees with the body-frame turn request
and opposes the measured yaw moment. A smooth normalized adverse-yaw product
sets the extra fraction. Receiver speed and the existing `0.99` acceleration
ceiling remain hard prerequisites, so the residual cannot bypass either
mechanical guard or create an independently driven anterior beat.

This is a target-signed half-cycle allocation mechanism, not a carrier-gain or
moment-threshold retune. It should hasten only the corrective anterior reversal
that the sampled bidirectional composition already found useful, while leaving
helpful target-aligned yaw and every low-speed carrier state unchanged.
Falsify it if capture or alternating three-dimensional shedding is lost,
either joint touches `260 deg/T`, score falls below `-0.204764`, mean distance
exceeds `2.08931L`, arrival exceeds `16.988T`, the anterior acceleration
reserve becomes persistently saturated, posterior angle exceeds `0.5701 rad`,
or force/yaw moment materially exceeds `0.03634/0.01804`.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and wake-disturbance rejection
source_mechanism: use state feedback to strengthen only the target-correcting half-cycle while separating persistent route error from an opposing measured yaw load
transferable_invariant: preserve the coupled traveling rhythm and allocate bounded corrective work only when body-frame target intent and measured yaw response identify the same adverse half-cycle
nontransferable_details: published gains, dimensional beat frequency, species-specific kinematics, duty ratios, full-body oscillator networks, exact vortex phase, and task-specific routes
policy_translation: multiply normalized body-frame turn request by normalized yaw moment to detect adverse yaw; within the existing posterior-donor event, receiver-speed gate, and sublimit acceleration reserve, add a bounded fraction only to an anterior command already aligned with the requested turn
falsification: reject if the residual loses capture or coherent alternating shedding, restores a speed stop, fails to improve the repeatable route, persistently occupies the anterior acceleration reserve, or raises force, moment, or posterior-angle peaks beyond the sampled bidirectional envelope
```

## Non-CFD activation check after the edit

An exact policy-level replay on the 3,089 recorded states compared this
candidate with the sampled bidirectional parent. The new residual changes 16
outputs, only on joint 1, with maximum acceleration difference
`0.427 rad/T^2`; all other recorded-state outputs are unchanged. This confirms
that the signed overlap is selective but not behaviorally inert like the
sampled absolute-moment gate. The replay does not evolve the fluid or body and
therefore is not evidence of a score, route, load, or capture improvement.
