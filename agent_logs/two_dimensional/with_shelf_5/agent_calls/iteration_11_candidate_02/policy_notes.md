# Wake-policy candidate notes

## Evidence diagnosis

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets; it is the common initial condition,
  not evidence attributable to a policy.
- The three byte-identical unprojected samples all capture at `43.9505` with
  mean distance `2.1391L`.  Their released sheets show the same useful
  topology: a large early target-directed redirect, sustained self-propelled
  diagonal travel across the wakes, and a nearly straight final approach.
  Mean body velocity `(-0.2471,-0.1020)` differs materially from mean local
  flow `(-0.1342,-0.1556)`, so the route is not passive advection alone.
- That carrier still reaches both joint-rate and joint-acceleration caps and
  has RMS crossflow/force/moment `0.2111/49.44/701.26`.  The sampled
  velocity-derived half-cycle phase lead preserves the visible route and
  capture (`43.9780`) but worsens those loads to `0.2136/53.18/736.58`, so
  phase advance is a negative result rather than a reason for further scalar
  tuning.
- No current sampled solver has a semantic failure termination.  The most
  informative failure contrast is therefore the inherited common seed: it has
  no visible recovery turn, leaves the lower boundary after `50.127`, moves
  `(-3.545,-13.300)L`, and differs from local-flow advection by only about
  `0.038U`.  That contrast rules out weakening the useful carrier or adding
  target-blind drive; the sampled phase lead supplies the mechanism-level
  negative comparison for the already successful carrier.
- Inherited rollout logs contain three numerically identical evaluations of a
  direction-aware posterior rate-envelope projection.  Relative to the
  unprojected carrier it retains direct capture at `44.0220` and changes mean
  distance by only `+0.0027L`, while reducing RMS crossflow/force/moment to
  `0.2102/44.86/663.89`.  The assigned guidance notes that both maxima still
  reach the hard caps, so the mechanism is distributed load relief, not cap
  avoidance.

## Candidate hypothesis

Use exactly one added controller mechanism: a smooth, direction-aware
posterior rate-envelope projection.  Preserve the demonstrated oscillator,
distance envelope, target-bearing curvature, joint-angle half-cycle gate, and
posterior lag.  Only when absolute body-frame bearing is small and posterior
joint rate is already near its soft envelope, remove the component of the raw
posterior acceleration that would push the rate farther outward.  Never remove
acceleration that reverses the posterior joint, and leave large-error redirect
fully authoritative.

This should reproduce the inherited projection's direct trajectory while
lowering distributed crossflow, force, and moment relative to the unprojected
sample.  Falsify the hypothesis if formal CFD loses target capture, materially
delays the direct route, increases mean distance beyond the evidenced small
tradeoff, weakens reversal, or fails to reduce load metrics.  Because the new
CFD evaluation occurs after this worker exits, these are expectations rather
than claims about this candidate.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation
source_mechanism: sensor-gated residual modulation of a rhythmic carrier
transferable_invariant: preserve the propulsive rhythm and apply only the smallest state-triggered correction that suppresses harmful motion
nontransferable_details: published gains, dimensional joint-rate envelopes, species-specific kinematics, exact vortex phases, and source-task routes
policy_translation: gate a direction-aware posterior outward-acceleration projection with body-frame bearing and posterior joint rate while preserving reversal and the two-joint carrier
falsification: reject if direct capture topology or reversal is lost, arrival is materially delayed, or repeated CFD does not lower crossflow and loads

## Pre-evaluation verification

- The required guidance semantic check passes after removing a duplicate
  assigned-parent marker from the rendered workspace `README.md`; the marker
  repair does not change policy or evidence content.
- The solver editable-boundary check passes.  Exactly one 2D target-policy
  candidate exists, it is non-empty, and every direct `params.FIELD` reference
  is present in `target_policy_params()`.
- The candidate SHA-256 is
  `1edf13974ccf694f26683c51d8bcdf6df1ff054af65d4063525fc57b4b4eab74`,
  byte-identical to the inherited policy whose three logged evaluations all
  captured at `44.0220` with RMS force/moment `44.86/663.89`.  That inherited
  result motivates materializing the candidate; it is not a claim that this
  worker ran CFD.
- The prescribed Julia include/assertion could not start because no Julia
  runtime is installed on `PATH`; the available HPC module exposes only a
  `juliaup` launcher, whose attempt to fetch a runtime channel is blocked by
  the execution environment's network connection.  No formal CFD was run,
  per the workspace contract.
