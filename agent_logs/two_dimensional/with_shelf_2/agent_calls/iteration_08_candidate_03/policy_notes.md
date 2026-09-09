# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet confirms the common upper-right release above four
  developed, interacting cylinder streets. The released trajectories are
  therefore controller comparisons rather than changes in wake maturity.
- The yaw-gated distributed reference is a finite self-propelled success: its
  keyframes show a continuous diagonal down-left path into the merged wake and
  capture at `51.47`; metrics report `0.748L` final/minimum and `1.82L` mean
  distance, `-11.28/-4.94L` head displacement, and `426/4084` force/moment RMS.
  Three sampled replays are identical, so they establish deterministic
  same-snapshot materialization, not held-out robustness.
- The sampled aligned-posterior-envelope variant preserves that route while
  reaching at `46.80` and reducing mean distance to `1.745L`. Its total command
  energy falls from `51225` to `47931` because the episode is shorter, although
  mean command energy rises from `995` to `1024`, force/moment RMS rises to
  `441/4259`, and both joint rates still reach their hard cap. This is positive
  evidence for modest posterior emphasis when body-frame route alignment is
  already good, but not for an unconditional amplitude increase.
- The assigned parent's propulsive-priority residual allocator is a concrete
  negative result. The sheet shows the fish pass below the target and strike
  the lower second-row cylinder at `58.93`; metrics agree with only `1.87L`
  closest and `4.29L` mean distance. Its slightly lower mean command energy
  (`971`) did not preserve the route and force/moment RMS increased to
  `537/4995`. Splitting propulsion and steering by instantaneous command sign
  changed the successful phase/composition enough to cause collision.
- The available compact evidence has no sign-resolved flow/load event history,
  so it does not justify a signed moment or crossflow residual. The useful
  remaining observation is normalized approach progress: it can decide when
  alignment-conditioned posterior motion is actually contributing to target
  closure without changing the successful steering law.

## Candidate hypothesis

Preserve the complete successful aligned-posterior controller: the
zero-centered anterior oscillator, lagged posterior traveling bend, predicted
body-frame bearing, yaw-moment-magnitude steering gate, distributed half-cycle
residual, and sum-then-soft-limit composition. Add one compact closed-loop gait
mechanism: a bounded closure-efficiency gate on a small additional posterior
envelope. Closure efficiency is the positive windowed target-closing speed
divided by observed body-speed magnitude, so the added posterior motion is
admitted only when the fish is aligned and its recent motion is actually
reducing target distance. The existing aligned emphasis remains the fallback;
the new term continuously vanishes for poor alignment or non-closing motion.

The next CFD rollout falsifies this mechanism if it loses `target_reached`,
returns the parent's collision or either boundary-exit topology, fails to beat
the `46.80` arrival or `1.745L` mean-distance baseline, or increases rate-limit
contact and hydrodynamic load without compensating approach benefit. A
same-snapshot improvement would not establish wake-phase or geometry
robustness.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and reactive posterior-wave propulsion
source_mechanism: retain the rhythmic traveling wave while bounded sensory feedback modulates its posterior envelope
transferable_invariant: additional posterior actuation should remain subordinate to the propulsive rhythm and be admitted only when normalized body-frame observations confirm useful route alignment and target closure
nontransferable_details: published gains, dimensional speeds, linkage geometry, species-specific amplitude envelopes, exact vortex phases, and task-specific routes
policy_translation: preserve the successful two-joint sum-then-limit controller and multiply only a small extra posterior target envelope by predicted-bearing alignment and positive windowed-closing-speed divided by observed body-speed magnitude
falsification: reject if capture, arrival, mean distance, or route topology regresses, or if rate saturation and loads rise without useful target progress
