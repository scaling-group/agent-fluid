# Bidirectionally arbitrated adverse-yaw work allocation

## Evidence-led visual diagnosis recorded before the policy edit

- Every sampled rollout and the assigned parent report direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot. All terminate in capture, so the informative weaker
  comparison is a slower viable controller rather than a failure termination.
- I inspected the combined keyframe sheets for the byte-identical best samples
  `solver_db2418f56ce7` / `solver_cf5406a979f8`, the prefilled
  `solver_9c72bd94b27c`, and the assigned parent `solver_493935b907b9` from
  release through capture. Their top-down rows show a translating fish and a
  coherent alternating red/blue street; their oblique rows retain compact
  three-dimensional caudal Lambda2 structures through the terminal approach.
  There is no standing wiggle, held-joint coast, wake collapse, collision, or
  boundary exit. Peak fish speed near `1.37--1.39U` versus sampled local flow
  below `0.033U` confirms self-propulsion rather than ambient or moving-window
  advection.
- The repeated prefilled bidirectional allocator captures at `16.98841T`, with
  score `-0.20476427`, mean distance `2.08931L`, posterior angle magnitude
  `0.57000 rad`, and force/yaw-moment peaks about `0.03634/0.01804`. Its narrow
  positive-power speed guards keep both joints below the exact `260 deg/T`
  stops while preserving the alternating wake.
- The assigned parent's joint-angle counter-yaw selector improves only
  modestly to `16.96515T` and mean distance `2.08904L`. In contrast, the
  target-signed measured-yaw residual is reproduced by two byte-identical
  policies and rollouts: both capture at `16.93205T`, improve score to
  `-0.20004481` and mean distance to `2.08513L`, and remain below both speed
  stops. Its bounded tradeoff is posterior angle `0.59921 rad` and peak
  force/yaw moment about `0.03693/0.01835`.
- The sampled receiver-isolated continuation regresses to `16.96004T` and
  mean distance `2.08869L`; its posterior excursion and force are slightly
  lower than the best sample, while yaw-moment peak is slightly higher. Thus
  the extra receiver-speed gate trades away route quality without a consistent
  mechanical-envelope benefit. The reusable distinction is the signed product
  of target turn request and measured yaw response, not a global moment
  threshold or a joint-angle proxy.

## Single-candidate policy hypothesis

Start from the reproduced best target-signed adverse-yaw allocator. Preserve
its body-frame velocity-course feedback, zero-centered anterior oscillator,
posterior traveling lag, terminal steering reserve, soft acceleration
shoulder, high-onset positive-power speed guards, base bidirectional transfer,
and posterior stopping-risk projection. Keep the evidenced posterior-donor
residual that adds work to an anterior receiver only when its command agrees
with target-relative turn intent and opposes measured yaw moment.

Apply the same signed adverse-yaw arbitration to the other direction without
adding carrier work: when anterior positive work is blocked by its speed shell,
smoothly withhold a bounded part of the otherwise reclaimed posterior carrier
work only if that carrier direction opposes the body-frame turn request while
the measured yaw moment is already adverse. The ordinary carrier, steering
term, low-speed motion, helpful-yaw half-cycles, and existing receiver
headroom gates remain unchanged. A recorded-state audit of the best trace
finds 26 such late states, beginning after about `14.38T`; the largest withheld
reallocation is about `0.443 rad/T^2`, so this is an active terminal
course-correction mechanism rather than scalar carrier tuning or a dormant
gate.

Expected result: preserve capture, alternating three-dimensional shedding, and
zero exact speed contact while improving or matching the reproduced
`16.93205T` arrival and `2.08513L` mean distance; the selective withholding
should not exceed the sampled `0.5993 rad`, `0.0370` force, or `0.0184`
yaw-moment envelope. Falsify the hypothesis if capture or wake coherence is
lost, either speed stop returns, the route regresses toward the gated or
joint-angle samples, the new channel is behaviorally inactive, or reduced
reclaimed work lowers propulsion without a compensating course/load benefit.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and reactive two-joint swimming
source_mechanism: preserve a traveling propulsive rhythm while state feedback allocates corrective work to turn-useful portions of the cycle and avoids reinforcing an adverse yaw response
transferable_invariant: separate body-frame target intent from signed measured yaw response, then modify only bounded phase-local residual work while leaving the underlying traveling carrier intact
nontransferable_details: published gains, dimensional beat frequencies, species-specific kinematics, duty ratios, full-body oscillator networks, exact vortex phases, and task-specific routes
policy_translation: retain the sampled target-aligned posterior-to-anterior residual; during an existing anterior speed-guard donor event, smoothly reduce only target-opposing posterior reallocation when normalized turn request and signed yaw moment identify adverse yaw
falsification: reject if capture or alternating shedding is lost, a speed stop returns, the late residual is inactive, route metrics regress, or propulsion and load costs exceed any course benefit
```
