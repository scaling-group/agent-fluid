# Candidate diagnosis and hypothesis

## Inherited and sampled evidence

- The assigned parent and every sampled rollout report direct uniform
  still-water initialization, `U_infinity=(0,0,0)`, and no prewarm. In the
  combined sheets, the fish moves left while shedding an alternating
  top-down vorticity street and a persistent oblique Lambda2 trail. The broad
  approach is therefore useful self-propulsion rather than advection.
- The inherited unrelieved bearing-minus-slip carrier gives the strongest
  approach (`2.960L` minimum), but finishes at `7.786L` after an upper-boundary
  exit. Its path and wake hook upward after about `12T`: reconstructed
  full-quadrant bearing is about `-0.41 rad` at `14T`, `-0.87 rad` at `16T`,
  and beyond `-1 rad` near the closest pass while speed remains about
  `0.8--1.0U`. The existing `12 deg` posterior mean-curvature request is
  already saturated in this interval, so another scalar bearing gain cannot
  supply a different steering action.
- The sampled approach-hold policy has the best scalar score (`-7.749`) but
  reaches only `3.592L`. Its visual wake fades during the close hook, its
  joints settle near an almost straight anterior joint and a `-12 deg`
  posterior bend, and it coasts out at about `0.73U`. The full-quadrant
  C-redirect similarly reaches `2.999L`, freezes near `(-10,-12) deg`, and
  coasts out. These results rule out carrier-wide relief and persistent static
  joint centers as sources of corrective hydrodynamic action.
- Two newer tail-only half-cycle reallocations preserve an active alternating
  wake longer but do not change the failure semantics. The assigned-parent
  variant reaches `2.986L` and finishes at `6.616L`; the close-pass variant
  reaches `3.013L` and finishes at `7.457L`. Both still exit the upper
  boundary. At the assigned-parent minimum (`17.88T`), full bearing is about
  `-1.31 rad` and speed is still `0.765U`: attenuating the counterstroke
  changes posterior motion too late and too weakly to contain the inertial
  pass.
- The combined evidence preserves one useful boundary: keep the unrelieved,
  zero-centered anterior oscillator and an oscillating posterior joint, but
  change the relationship between them once target error grows. Do not add
  carrier amplitude, because raw commands already encounter the actuator
  envelope, and do not infer a route from world coordinates or time.

## Policy hypothesis

Restore the unrelieved carrier and compute target angle from normalized
`target_body_L` so rearward geometry is not folded into the front half-plane.
Retain the evidenced bearing-minus-body-slip mean curvature. Add one new
actuator mechanism: smoothly contract the posterior velocity-lag term only
when the magnitude of full-quadrant bearing leaves the broad-approach
corridor. This keeps the modulation reflection-equivariant and leaves the
initial approach unchanged. Under a large turn request, bringing the
posterior target closer to `mean_curvature - q1` should keep the summed body
curvature nearer the requested sign through the beat while both joints remain
rhythmic. It changes wave shape rather than attenuating a half-cycle or
shifting either joint to a static center.

The next CFD result should falsify the mechanism if the alternating 3D wake or
far-field progress degrades, joint-limit occupancy rises, either joint settles
to a fixed bend, or bearing containment, the `2.960L` closest approach, and
the upper-exit termination class all fail to improve.

A fixed-state replay over the inherited unrelieved trace confirms the intended
scope without predicting a fluid outcome: effective lag stays at `0.8` at
`0T`, `4T`, `8T`, and `12T`, contracts to about `0.71` at `14T`, and reaches
its `0.45` floor by `16T`. On those unchanged states, posterior raw-command
envelope exceedance decreases from about `65.3%` to `61.7%`; the new mechanism
does not obtain authority by amplifying the existing saturated command.

```text
bookshelf_consulted: true
source_domain: classical fish-wave mechanics and robotic-fish CPG steering
source_mechanism: bounded phase-lag or wave-shape modulation superposed on a propulsive traveling bend
transferable_invariant: preserve rhythmic propulsion while changing posterior timing so a target-directed mean bend persists through more of the beat
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, clock phase, exact vortex phase, and task-specific routes
policy_translation: use normalized full-quadrant target_body_L only to gate a reflection-equivariant contraction of the posterior joint-state velocity lag, while bearing minus bounded body slip retains turn direction
falsification: reject if wake coherence or broad-approach progress falls, limit occupancy rises, the joints become static, or closest approach, bearing containment, and termination class do not improve over the unrelieved carrier
```
