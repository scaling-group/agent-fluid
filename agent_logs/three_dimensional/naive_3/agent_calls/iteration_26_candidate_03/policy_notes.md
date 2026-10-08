# High-onset phase-consistent speed-allocation candidate

## Evidence-led visual diagnosis recorded before the policy edit

- Every sampled rollout and inherited speed-guard rollout used direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, zero cylinders, and no
  prewarm. The combined sheets for the strongest soft-envelope capture and the
  guarded contrasts were read from release through capture in both views. The
  top-down rows retain a coherent alternating red/blue street, and the oblique
  rows retain compact alternating three-dimensional Lambda2 structures behind
  the caudal region. There is no visible standing wiggle, collision, exit, or
  wake collapse before capture.
- Metrics agree that the motion is self-propelled rather than moving-window or
  ambient advection. The unguarded soft-envelope policy reaches `1.393U` while
  sampled peak local flow is only `0.0325U`; it captures at `16.943T` with mean
  distance `2.090L` and force/yaw-moment peaks `0.03609/0.01766`. Its remaining
  defect is exact `260 deg/T` occupancy at the two joints for `3.73/3.54%` of
  the trace.
- The inherited `0.90` positive-power guard removes that occupancy but delays
  capture to `17.330T` with mean distance `2.102L`. The sampled `0.94` guard is
  the strongest mechanically viable continuation: it also has zero exact
  occupancy, reaches only `258.92/259.20 deg/T`, captures at `17.115T`, and has
  mean distance `2.098L`, while preserving the alternating wake. This shows
  that narrowing the intervention recovers most of the route cost.
- The sampled `0.90` anterior-to-posterior carrier reallocation also keeps zero
  occupancy and improves its like-onset guarded reference from `17.330T` to
  `17.275T`, but it remains slower than the `0.94` no-transfer guard. Its
  `2.098L` mean distance, `257.11/257.75 deg/T` joint-speed peaks, and
  `0.03583/0.01758` load peaks rule out instability or a destroyed wake; the
  result supports a small conditional transfer, not a broader or stronger
  redistribution.

## Single-candidate policy hypothesis

Start from the sampled `0.94` phase-local speed governor, preserving the
body-frame target/course feedback, zero-centered anterior oscillator,
posterior lag, terminal steering reserve, high-knee acceleration envelope, and
posterior angle stopping-risk projection. Add only the previously isolated
one-way carrier-work reallocation: when the high-onset guard removes
speed-increasing anterior acceleration, transfer a bounded fraction into the
existing posterior carrier direction if the assembled posterior command agrees
and has acceleration headroom. Apply the posterior speed governor and angle
projection afterward, so transfer cannot bypass either mechanical constraint.

This is the missing combination in the completed evidence: the `0.94` guard
establishes the best viable route and the same transfer gave a small improvement
over the otherwise identical `0.90` guard. Expected behavior is zero exact
speed-limit occupancy with a coherent alternating wake and capture earlier than
`17.115T`. Falsify the candidate if it loses capture, touches either speed
limit, fails to improve arrival or mean distance over the `0.94` guard, exceeds
the soft baseline's `0.0361/0.0177` force/moment peaks, worsens posterior angle
clearance, or changes the useful traveling wake into standing or one-sided
motion.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and elongated-body reactive propulsion
source_mechanism: retain a feedback-modulated rhythm while posterior wave kinematics carry most reactive thrust
transferable_invariant: preserve the traveling-bend phase and redirect only bounded unavailable anterior work into an already compatible posterior carrier stroke
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized joint speed and positive joint power to guard both commands at the evidenced high onset; conditionally allocate guarded anterior acceleration into the signed posterior carrier within soft acceleration, posterior speed, and angle viability constraints
falsification: reject if speed contact returns, capture or alternating three-dimensional shedding is lost, the 0.94-guard arrival and mean-distance references are not improved, or force, moment, and posterior-angle peaks exceed the soft-envelope references
```
