# Replicated posterior steering-recovery promotion

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and semantic `capture`.  The assigned
  v28 parent is reproduced twice at `20.5315 T`, score `-0.29557888`, and
  distance integral `2.18697 L`.  Two independently expressed v29 posterior
  recovery allocators also reproduce exactly at `19.3105 T`, score
  `-0.21057567`, and integral `2.09959 L`; identical trajectories from distinct
  policy hashes show that the improvement belongs to the shared allocation
  semantics rather than packaging.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows from
  release through termination for the assigned parent and the replicated best
  candidate.  Both fish visibly self-propel from quiescent water: compact
  startup structures become coherent alternating posterior packets, and both
  routes bend continuously toward the target.  Posterior recovery preserves
  that wake topology while advancing the same target-signed arc by
  `0.050/0.195/0.517/0.994 L` at `4/8/12/16 T` and entering the capture circle
  before the parent's final visual interval.  There is no semantic failure
  among the four current sampled sheets; the inherited informative failure is
  the uncentered full-frame projection that passed outside the circle at
  `0.8006 L`, reversed its route, and exited left, so raw redirect geometry and
  redirect-mean subtraction remain protected.
- Numeric diagnostics agree with the images.  Recovery increases mean/max
  speed from `0.628/0.894` to `0.665/0.931 L/T`, but reduces head/tail/any-joint
  acceleration-limit residence from `35.92/10.37/46.29%` to
  `34.18/8.20/42.35%`; mean absolute and RMS command also fall from
  `24.899/26.276` to `24.680/26.081 rad/T^2`.  Peak normalized planar force is
  unchanged at `0.03056`, and peak yaw moment changes only from `0.01525` to
  `0.01541`.  The faster capture therefore accompanies less limit residence,
  not a larger carrier or persistent bang-bang action.

## One-candidate policy hypothesis

Promote the evaluated v29 allocation semantics without changing any carrier,
guidance, redirect, or steering gain.  Project both rhythmic carrier commands
first, apply the head target residual, measure only the signed residual rejected
by the head's physical acceleration bound, and offer that unmet residual to the
posterior target command before its own final projection.  Opposite-sign head
steering can still unload a saturated carrier, and the posterior joint cannot
exceed the shared componentwise envelope.  This is one state- and
command-dependent allocation mechanism; it adds no clock, route memory,
world-frame cue, or scalar-only gait tuning.

The expectation is to reproduce the sampled `19.3105 T` capture and coherent
wake while retaining the lower saturation/effort envelope.  Falsify the
promotion under another rollout or pose if capture is lost or later than the
assigned parent's `20.5315 T`, the distance integral exceeds `2.18697 L`, the
continuous target-signed arc or alternating 3D wake degrades, or posterior
saturation, speed, normalized force, or yaw moment rises without compensating
closure.

bookshelf_consulted: true
source_domain: residual control over robotic-fish CPG locomotion and elongated-body posterior propulsion
source_mechanism: preserve the rhythmic traveling-wave carrier while target-derived residual control uses available posterior actuation
transferable_invariant: route steering should remain separate from the carrier and move only its unrealized bounded component to an actuator with available authority
nontransferable_details: published gains, clocked CPG phase, robot or species geometry, dimensional cadence, linkage leverage, exact vortex phases, and prescribed routes
policy_translation: retain normalized body-frame v28 guidance and its state-feedback posterior-lag carrier, then transfer only head steering rejected after carrier-first acceleration projection into posterior residual headroom before the same physical bound
falsification: reject if the allocator loses or delays capture, worsens the distance integral, disrupts the target-signed coherent wake, or raises saturation, speed, force, or moment without better closure

## Evidence boundary

All performance and visual claims above come from completed sampled CFD and
inherited optimizer logs.  The promoted file receives formal evaluation after
worker exit; no same-worker CFD outcome is claimed.
