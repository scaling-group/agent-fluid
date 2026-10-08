# Candidate wake-policy notes

## Evidence diagnosis before policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=0`, no cylinders, no prewarm, and a moving inertial storage
  window. Motion in the sheets is therefore self-propulsion rather than
  imposed-flow advection.
- The strongest finite rollout is the naive seed (`-14.825`). In its top-down
  row, a compact alternating vorticity trail grows behind the tail while the
  fish first moves left and then curls upward; the oblique Lambda2 row confirms
  a coherent three-dimensional posterior wake. Distance improves from
  `12.328L` to `12.078L` at `6.358T`, then regresses to `12.380L` at the upper
  boundary (`8.547T`). Its heading changes from `0.506` to `-0.782 rad`, and
  body-frame bearing changes from `+0.155` to `-1.296 rad`, showing that the
  small correct-sign initial turn becomes an unrecovered overshoot.
- The informative strong-steering failure (`-16.465`) remains visibly
  self-propelled with a curved alternating wake in both rows, but rotates still
  farther to `-2.132 rad` and exits at `13.829L`. Its closest approach is only
  `12.235L` at `3.702T`; peak trace force and moment magnitudes rise to about
  `0.394` and `0.194`, versus `0.026` and `0.013` for the seed. This is a
  high-load curl, not useful target progress.
- The other two target-aware mean-curvature laws also terminate
  `left_domain`. Their minima are `12.226L` and `12.296L`, both worse than the
  seed's `12.078L`. In particular, the prefilled `0.90T`, `18 deg` posterior
  bias law has no raw acceleration or joint-speed exceedance in the recorded
  trace yet still reaches bearing `-1.137 rad` and exits at `13.084L`. Thus
  actuator headroom was necessary but not sufficient, and three different
  static mean-curvature realizations did not arrest yaw after bearing changed
  sign.
- The assigned parent contains only the fresh-lineage contract, while the
  inherited worker notes predicted that target-driven static curvature would
  reverse the seed curl. The completed rollouts now falsify that prediction.
  Another scalar adjustment of curvature magnitude would not test a new
  explanation.

## Policy hypothesis

Keep the evidenced joint-state oscillator and posterior traveling-wave target,
but replace static mean curvature with posterior half-cycle amplitude
asymmetry. A bounded body-frame bearing defines a desired yaw rate; recent yaw
rate closes that loop. The resulting signed request strengthens the posterior
half-cycle that produces the requested yaw and weakens the opposite half-cycle.
Because the steering term is proportional to the instantaneous wave magnitude,
it vanishes at beat crossings and cannot hold the tail at a route-independent
offset. A sub-limit `0.85T`, `14 deg` carrier preserves the coherent wake while
leaving authority for this new steering mechanism.

The candidate should turn only enough to drive bearing toward zero, reverse its
beat imbalance as soon as measured yaw outruns the requested rate, survive
beyond `9.08T`, and improve on `12.078L` without the strong-steering rollout's
load spike. Reject it if the upper-boundary topology persists, bearing remains
large after changing sign, the alternating wake collapses, or joint limits and
force/moment peaks become persistent.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and direction tracking
source_mechanism: sensor-modulated half-cycle amplitude asymmetry superposed on a rhythmic propulsive gait
transferable_invariant: steering authority can come from a bounded imbalance between opposite propulsive half-cycles, while observed turn response reverses that imbalance and the underlying traveling wave remains active
nontransferable_details: published gains, robot and species kinematics, clock-driven phase, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: body-frame bearing sets a bounded desired yaw rate; recent yaw-rate error modulates the positive and negative magnitudes of the lagged posterior target inferred only from joint state
falsification: reject if bearing does not settle toward zero, the same upper-boundary exit recurs, minimum distance does not beat 12.078L, the posterior alternating wake disappears, or load and actuator-limit activity approach the strong static-curvature failure
```

## Non-CFD contract probe

The initial `18 deg`, `0.55` asymmetry draft failed a released-horizon
joint-only envelope check because the Van der Pol scale is not its asymptotic
excursion. The final `14 deg`, `0.45` version was integrated for `100T` under
neutral, initial-turn, overshoot-braking, and both worst-sign bounded requests.
Across those deliberately sustained requests, peak ideal joint magnitude was
`33.93 deg`, speed was `207.25 deg/T`, acceleration was `1606.92 deg/T^2`, and
the policy's internal acceleration clamp was not reached. This is only a
deterministic actuator/headroom check; it is not CFD evidence and makes no
claim about target progress or hydrodynamic loads.
