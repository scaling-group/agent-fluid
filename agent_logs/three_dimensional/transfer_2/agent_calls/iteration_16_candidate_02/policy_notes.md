# Anterior useful-stroke counterturn candidate

## Evidence diagnosis before the policy edit

- All four sampled episodes satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite moving-
  window transport, stable dynamics, and capture at `0.7473--0.7495L`.
- I inspected the top-down vorticity and oblique body/Lambda2 rows for the
  strongest sampled capture (`solver_7ac67a265211`), the slowest controlled
  repeat (`solver_17ed583a64e1`), and the distinct response-gated candidate
  (`solver_37425e4b74e2`). All are genuinely self-propelled from still water,
  form a coherent alternating planar wake with compact three-dimensional tail
  structures, approach broadly monotonically, and finish with the same upward
  hook. None shows passive advection, wake collapse, collision, exit, or
  instability; the slower runs are informative within-class failures.
- The assigned parent's phase-aligned posterior-lag policy now has three byte-
  identical completed repeats spanning `19.409--19.635T`, mean distance
  `2.09210--2.10246L`, and score `-0.20288-- -0.21272`. This `0.225T` spread
  is larger than its earlier apparent advantage and falsifies treating the
  single `19.635T` result as evidence of a repeat-resolved gain.
- Strengthening that posterior phase allocation while observed yaw opposed
  the requested turn captured at `19.486T`, mean distance `2.09523L`, and
  score `-0.20571`, squarely inside the identical-parent spread. Its peak
  lateral force/yaw moment (`0.02297/0.01312`) and smooth-command maxima
  (`30.36/30.79 rad/T^2`) also remain in the same class, while both visual rows
  retain the same hook. This is a concrete negative result for further scalar
  tuning or response gating of posterior lag on this release.
- The stable carrier and capture scaffold should remain, but the persistent
  terminal hook warrants testing a different actuator path. The posterior
  response gate did not create prompt enough sign reversal; a phase-selective
  anterior action can change the turn-producing half-cycle directly without
  adding static curvature or perturbing the posterior traveling-wave lag.

## One-candidate hypothesis

Restore fixed posterior lag while preserving the evaluated oscillator,
fore/aft-aware target map, range/closing drive relief, velocity-course
redirect, LOS-rate lead, and ordinary half-cycle steering. Add one bounded
response mechanism: when the normalized body-frame turn request and recent yaw
have opposite signs, apply extra anterior steering acceleration only on the
joint-velocity half-cycle aligned with the requested turn, then release it
smoothly as yaw aligns. This translates a corrective burst/duty-asymmetry
invariant into observable joint phase and response disagreement; it uses no
clock, coordinates, route memory, vortex phase, or new mean bend.

Expected signature: preserve capture, coherent wakes, and the approximate
`0.023/0.013` force/moment class while reducing the late hook or producing a
repeat-resolved improvement beyond the `0.225T` identical-policy band without
raising command or rate-limit residence. Falsify it if capture or coherence is
lost; timing and integral remain inside the parent spread without an effort or
load benefit; the hook, terminal lateral motion, joint limits, command
residence, force, or moment regress.

bookshelf_consulted: true
source_domain: biological C-start response control and robotic-fish half-cycle or duty-ratio turning
source_mechanism: concentrate a bounded corrective bend on the stroke that produces the requested turn, then release it when the measured response aligns
transferable_invariant: derive corrective-stroke authority from normalized joint phase, body-frame turn demand, and sign disagreement with measured yaw
nontransferable_details: published gains, dimensional burst duration, clock phase, species-specific kinematics, full-body waveforms, exact vortex phase, and task-specific coordinates or routes
policy_translation: keep the posterior traveling-wave lag fixed and add a softly bounded anterior acceleration only on the requested useful half-cycle while recent yaw opposes the turn command
falsification: reject if it does not improve beyond identical-policy variation without an effort or load benefit, or if capture, terminal topology, wake coherence, load class, joint margin, rate residence, or command headroom regresses
