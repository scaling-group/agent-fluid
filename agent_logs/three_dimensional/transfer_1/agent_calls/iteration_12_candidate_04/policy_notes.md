# Saturation-aware posterior steering spillover

## Evidence and visual diagnosis before editing

- All four sampled solver rollouts satisfy the frozen Phase-2 contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and semantic `capture`.  The assigned
  parent's centered gait-frame target projection is the strongest: it captures
  at `20.5315 T`, score `-0.29557888`, and distance integral `2.18697 L`.
  The reproduced v27 common-mode controller captures at `23.6390 T`, score
  `-0.54450554`, and integral `2.44217 L`; the quiescent posterior-start
  alternative captures later at `24.2220 T`, score `-0.52481420`, and integral
  `2.42365 L`.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows from
  release through termination for the assigned parent, the reproduced v27
  control, and the inherited full-frame projection failure.  The two captures
  self-propel from quiescent water and develop coherent alternating posterior
  packets in both views.  The assigned parent bends the same wake into an
  earlier, tighter target-signed arc and leads v27 by `0.168/0.932/1.423/1.771`
  `L` at `4/8/12/16 T`; this is a useful trajectory change, not passive
  advection.  The inherited failure initially follows an even shorter arc and
  reaches `0.8840 L` at `20 T`, but passes just outside the capture circle,
  curls away with a visibly tighter wake/body turn, and exits left at
  `30.9388 T` with final distance `12.1995 L`.
- The numeric diagnostics agree with the images.  The assigned parent has
  mean/max speed `0.628/0.894 L/T`, about `46.6%` any-joint acceleration-limit
  residence, and peak normalized planar force/yaw moment `0.03056/0.01525`.
  The failed uncentered projection reaches `1.456 L/T`, about `62.6%` limit
  residence, and `0.07252/0.03280` peak force/moment.  Its `0.80058 L`
  closest approach followed by complete route reversal shows that projected
  carrier phase must not choose or release the large-error redirect; the
  assigned parent's raw redirect geometry and subtraction of its commanded
  head-joint mean are protected.
- Replaying the assigned policy algebra on its completed trajectory exposes a
  narrower actuator-allocation defect.  The anterior carrier clips a nonzero
  portion of target-derived head steering on `35.9%` of sampled states and
  discards `35.0%` of its absolute requested head-steering magnitude overall
  (`36.7%` far, `30.9%` middle, and `31.6%` near the target).  The maximum
  discarded residual is `4.73 rad/T^2`, and every same-direction discarded
  residual fits within the posterior carrier's remaining componentwise
  acceleration headroom on those states.  Thus the useful gait-frame request
  is still partly erased even though the final outputs remain bounded.

## One-candidate policy hypothesis

Preserve the evaluated v28 gait-frame geometry, raw completion-gated redirect,
state-feedback traveling wave, progress-gated posterior lag, half-cycle
steering, and componentwise acceleration bound.  After allocating the
anterior carrier first, measure only the target-steering residual rejected by
that joint's bound and add the same bounded residual to the posterior steering
command before its existing final projection.  Do not transfer carrier demand
or moment damping.  This is state- and command-dependent actuator allocation,
not a carrier/steering gain retune; when anterior steering is feasible the
candidate is exactly the assigned parent.

The expectation is to retain capture and wake coherence while making the
already useful gait-frame route request effective on saturated anterior
half-cycles, improving early or middle closure without increasing the anterior
command.  Falsify the mechanism if capture is lost or later than `20.5315 T`,
the distance integral exceeds `2.18697 L`, the target-signed arc changes into
the inherited near-miss/reversal topology, posterior or any-joint limit
residence grows without compensating route improvement, or peak speed,
normalized force, yaw moment, or wake disorder materially exceeds the assigned
parent.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated robotic-fish turning
source_mechanism: preserve a posterior traveling wave while applying target-dependent asymmetry through the locomotor cycle
transferable_invariant: route steering should use feasible phase-dependent joint authority without replacing the posterior-lag carrier or demanding unavailable anterior actuation
nontransferable_details: published gains, dimensional cadence, robot linkage leverage, species-specific envelopes, clocked oscillator phase, exact vortex phases, and prescribed routes
policy_translation: detect only the target-steering acceleration rejected after anterior carrier-first projection and spill that bounded residual into available posterior acceleration before the existing componentwise projection
falsification: reject if spillover loses or delays capture, disrupts the coherent alternating wake, reproduces the near-miss/reversal route, or raises posterior saturation, speed, force, or moment without better closure

## Evidence boundary

All numerical and visual claims above come from completed sampled CFD and
inherited optimizer evidence.  This spillover candidate is evaluated only
after worker exit; no same-worker CFD outcome is claimed.
