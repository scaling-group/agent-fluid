# Multi-Wake Target-Policy Candidate Notes

## Evidence read before the policy edit

- The assigned parent guidance preserves the naive oscillator's traveling-bend
  scaffold but identifies target-blind propulsion as an architecture failure.
  The current prefill (`solver_ad1db499142c`) already adds bearing feedback,
  yet its released sheet shows only a small downward-right displacement followed
  by a downstream-boundary exit: it moves `(+2.195,-1.302)L`, never gets closer than
  `12.424L`, and terminates after `18.683` released time units. Its low joint
  excursions (`0.249/0.191 rad`) and low mean command energy (`187.66`) agree
  with loss of useful propulsion, not a wake-induced failure near the target.
- The shared prewarm sheet shows the held fish above four fully developed,
  interacting vortex streets; this is common initial-condition evidence. In
  the best released sheet (`solver_96495c5b1e65`), the fish executes an early
  targetward turn, sustains a visible posterior traveling bend while crossing
  the developed wake, and reaches the target on a compact diagonal route. Its
  metrics confirm capture at `39.737` time units, `0.940` progress, and
  `1.934L` mean distance despite `0.227` RMS relative crossflow.
- The second distributed-curvature sibling (`solver_cf905c92f9f7`) also
  reaches the target, at `42.856` time units and `2.119L` mean distance. This
  repeated semantic success is stronger evidence than either scalar score
  alone. Both successful policies retain the seed's `0.55` period, `28 deg`
  anterior rhythm, and posterior lag while sharing a bounded mean bend across
  both joints.
- Two failures bound the transfer. The target-blind seed visibly curls into a
  lower-domain exit after moving `(-3.545,-13.300)L`. The inherited optimizer
  log for `solver_021464f63996` records that reducing the rhythm to a `0.9`
  period and `20 deg` amplitude produced only `17.02` mean command energy,
  moved the head `(+2.185,-0.917)L`, and exited after `16.984` time units.
  Therefore actuator headroom obtained by weakening the propulsive scaffold is
  not a supported route to control in this initial condition.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological mean-curvature turning and robotic-fish closed-loop CPG direction tracking
source_mechanism: distribute a sensor-driven average body bend across an otherwise propulsive traveling rhythm
transferable_invariant: persistent body-frame direction error should request a bounded total curvature shared coherently by anterior and posterior joints while posterior phase lag preserves thrust
nontransferable_details: published gains, dimensional frequencies, robot geometry, species envelopes, duty ratios, exact vortex phase, and source-task routes
policy_translation: map normalized body-frame `state.bearing` to one bounded total-curvature request, split that budget between the two joint attractors, and retain the evidenced state-only oscillator and velocity-derived posterior lag
falsification: reject the translation if a later rollout loses target capture, turns with the wrong sign, collapses the traveling bend, returns to either domain-exit topology, or adds persistent saturation and load without faster or more robust progress

## Candidate hypothesis

This candidate makes one architecture correction to the failed prefill:
steering authority is a single `12 deg` total-curvature budget with `45%`
assigned to the anterior oscillator center and `55%` to the posterior center,
rather than a full anterior bias plus an additional tail share. The target
bearing is the only route signal, smoothly saturated on a `20 deg` scale. The
propulsive period, amplitude, state-feedback drive, damping, and posterior lag
remain unchanged because the two successful sampled rollouts support them and
the inherited slower-gait result contradicts weakening them for headroom.

The expected downstream evidence is repetition of the successful diagonal
target-entry topology, with capture rather than early domain exit. This worker
does not claim a new CFD result. Later evaluation should compare termination,
arrival time, distance integral, joint/acceleration saturation, command effort,
and force/moment loads against both sampled successes and the failed prefill.
