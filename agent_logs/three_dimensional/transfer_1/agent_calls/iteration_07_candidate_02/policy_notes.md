# Evidence-selected posterior-thrust candidate

## Evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the frozen rollout contract: direct
  uniform initialization in still water (`U_infinity=(0,0,0)`), no cylinders,
  no prewarm, finite dynamics, and semantic `capture`.  The best finite sample
  is `solver_15789e4ed8e8`, the progress-gated posterior-thrust controller,
  with score `-0.69471683`, mean distance `2.5975 L`, and capture at
  `26.0425 T`.  The most informative weaker contrast is the prefilled aligned
  speed-recovery sample `solver_e01f6ab5020f`, which scores `-0.70419268`, has
  mean distance `2.6074 L`, and captures at `26.5430 T`.  The unmodified
  completion-gated control samples capture at `26.4110 T` with mean distance
  `2.6134 L`.  There is no semantic failure among the current samples, so the
  weaker captures are used as controls rather than mislabeled failures.
- In both inspected combined sheets, the top-down row shows self-propelled
  motion along a continuous closing arc.  Alternating red/blue vorticity is
  established by `8 T`, remains coherent through the broad redirect, and
  follows the fish into the capture disk.  The oblique row confirms compact
  alternating Lambda2 structures shed behind the posterior body at `8`, `16`,
  `24`, and termination.  Lateral oscillation is therefore organized around
  net progress rather than a reciprocal standing wiggle, and neither sheet
  shows wake collapse or instability before capture.
- Metrics support the visual comparison.  Relative to aligned speed recovery,
  posterior thrust arrives `0.5005 T` earlier, lowers mean distance by
  `0.00993 L`, and raises mean speed from `0.4992` to `0.5081 L/T`.  Its peak
  lateral-force and yaw-moment coefficients (`0.02974` and `0.01484`) do not
  exceed the weaker sample (`0.03193` and `0.01593`).  Relative to the plain
  completion-gated controller it arrives `0.3685 T` earlier and lowers mean
  distance by `0.01589 L`, again without increasing those two peaks.  With
  zero ambient velocity and local flow small compared with body speed, this
  gain is propulsion rather than advection.
- The posterior-thrust sample already projects both commands to the declared
  `1800 deg/T^2` envelope; its higher `0.7170 L/T` peak speed and frequent
  command projection make another global amplitude/frequency increase poorly
  isolated.  The inherited outward joint-speed guard is also a negative
  control: it delayed the plain captured trajectory by `0.4015 T` and worsened
  mean distance without a force/moment benefit.  Preserve the feasibility
  projection, but do not add that guard or stack the weaker cadence residual.

## Policy hypothesis

Promote the completed best sample as the single candidate.  Preserve its
completion-gated target redirect, half-cycle steering, acceleration projection,
and state-feedback oscillator.  When normalized measured closure is poor,
increase only the posterior lag that converts observed head-joint velocity into
a traveling bend; continuously release that residual as closure establishes,
the target approaches, or steering load increases.  This is one tested
controller mechanism, not scalar-only carrier tuning.

The evidence predicts reproduction of the sampled `capture` topology with a
coherent two-view wake and improvement over the prefilled speed-recovery
candidate.  Falsify the transfer if capture is lost or materially delayed,
mean distance regresses beyond the weaker samples, early closing fails to
improve, or joint-limit residence, wake coherence, force, or moment becomes
materially worse.  The completed evidence is for this direct-uniform still-
water initialization; held-out target poses, inflow, and actuator envelopes
remain unproven.

bookshelf_consulted: true
source_domain: Lighthill-style reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: emphasize posterior traveling-wave action while measured task response releases an auxiliary propulsive command
transferable_invariant: poor normalized closure can gate a bounded posterior-only thrust residual while established closure and large steering demand recover the proven base gait
nontransferable_details: published gains, dimensional frequencies, species-specific amplitude envelopes, clocked CPG phases, exact vortex phases, and prescribed routes
policy_translation: scale only the posterior joint's observed-head-velocity lag by normalized closing deficit, distance authority, and inverse body-frame turn load; retain the target-relative two-joint state-feedback carrier
falsification: reject if capture time or mean distance regresses, early closure does not improve, or terminal steering, wake coherence, actuator-limit residence, force, or moment materially worsens

## Scope

The numerical comparisons above are completed sampled CFD evidence.  This
worker runs no formal CFD and claims no new same-worker outcome; post-exit
evaluation must verify that the promoted candidate reproduces the sampled
result.
