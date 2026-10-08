# Wake-policy candidate notes

## Inherited and sampled evidence

- All four sampled evaluations satisfy the frozen rollout contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders, and no prewarm.
  Their translation and wakes are policy-generated rather than ambient
  advection.
- The bearing-minus-body-slip carrier remains the strongest semantic result.
  Both rows of its combined sheet show a coherent alternating mid-plane wake
  and persistent three-dimensional Lambda2 structures through the approach.
  It self-propels from `12.328L` to a `2.960L` closest approach at `17.70T`,
  but the head is still about `2.87L` above the target, body-frame bearing is
  about `-0.97 rad`, and speed remains about `0.82U`. It then passes the target
  in x, hooks upward, and exits at center `y=15.200L` and distance `7.786L`.
- The three sampled approach-allocation variants falsify the inherited claim
  that distance-only carrier relief frees enough posterior authority for
  capture. Posterior-only relief, joint-carrier damping, and joint-amplitude
  scheduling reach only `3.162L`, `3.592L`, and `3.032L`, respectively; all
  retain the same upper-boundary termination. The nominally best score
  (`-7.749`) comes from lower mean/final distance, not capture or a better
  termination class, and it worsens closest approach relative to `2.960L`.
- Visually, all three approach variants preserve the alternating wake during
  broad travel, then weaken or skew it as the body turns upward between about
  `17T` and `21T`. Their metrics agree: the trajectories remain roughly
  identical through `12T`, enter large negative bearing with a saturated
  posterior mean-curvature request, and never convert attenuation into the
  missing downward redirect. More distance-threshold or carrier-floor tuning
  is therefore not supported.
- The observation mapping folds rearward targets into the forward half-plane:
  `state.bearing` divides by `abs(target_body_L[1])`. That representation is
  adequate during the broad approach but discards whether the target has
  passed behind the head. The full normalized `target_body_L` vector is
  available and can supply a signed full-quadrant error without world
  coordinates or route memory.
- Inherited logs also rule out another persistent anterior recentering: that
  earlier variant limited head oscillation to roughly `8 deg` and worsened
  final distance to `13.403L`. Any anterior mean bend should therefore be
  geometry-gated, bounded, and released back to the demonstrated zero-centered
  carrier rather than applied throughout the run.

## Policy hypothesis

Preserve the sampled bearing/slip traveling carrier while full-quadrant target
error is modest. When the normalized body-frame target vector reports a large
angular error, smoothly enter one response-gated redirect: reduce rhythmic
amplitude to a nonzero floor and distribute a same-sign mean bend across the
anterior joint and the existing posterior curvature channel. This forms a
temporary C-like body curve instead of asking an already saturated posterior
offset to reverse yaw while full carrier momentum persists. Because the gate
depends only on current full-quadrant angular error, successful reorientation
continuously releases the anterior mean and restores the carrier; there is no
clock, mutable mode, or memorized route.

The candidate should reproduce the coherent far-field wake and progress of the
bearing/slip carrier, activate only near the observed large-error approach,
and turn toward the target before or after the first pass rather than decay
into the common upper hook. Falsify it if broad propulsion changes materially,
the redirect suppresses the wake without producing angular recovery, raw
actuator demand worsens, or it repeats the upper exit without beating `2.960L`
or producing a meaningfully different recoverable trajectory.

bookshelf_consulted: true
source_domain: biological C-start redirection combined with sensor-modulated robotic-fish direction tracking
source_mechanism: large observed directional error evokes a bounded distributed body bend, then measured geometric recovery releases the swimmer into its propulsive rhythm
transferable_invariant: preserve the traveling carrier at small error, but temporarily trade rhythmic authority for a two-joint same-sign reorientation bend when full body-frame target angle is large, releasing continuously as alignment returns
nontransferable_details: species-specific C-start kinematics, published gains, dimensional thresholds, clock phase, exact vortex timing, and task-specific routes
policy_translation: compute signed full-quadrant error from normalized `target_body_L`; use its bounded magnitude to shift the anterior oscillator center and reduce its amplitude while the existing bearing-minus-slip posterior turn channel remains active
falsification: reject if far-field wake or progress changes, large error does not recover before the same upper exit, the controller stalls outside capture, or joint angle/rate/acceleration occupancy worsens materially
