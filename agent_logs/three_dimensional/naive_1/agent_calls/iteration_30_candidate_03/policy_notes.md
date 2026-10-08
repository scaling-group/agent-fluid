# Wake-policy candidate notes

## Evidence diagnosis

All four sampled rollouts satisfy the direct-uniform still-water contract
(`U_infinity=[0,0,0]`) and terminate in capture; there is no sampled
termination failure. I therefore compared the executable-identical phase-lag
parent pair (`solver_4e1a15b275ab`, `solver_bd37a8d7a3f9`) with the best-score
fixed-budget allocation (`solver_c33f31eb9226`) and the fastest line-of-sight
lead variant (`solver_ed8cdbcee113`).

The complete parent sheet shows self-propulsion from rest, an alternating
mid-plane street, and discrete oblique Lambda2 structures through capture.
The best-score allocation preserves the same visible top-down S-route and
attached alternating wake, but its oblique row is blank and cannot establish a
new 3D-wake result. The line-of-sight variant has both views and preserves the
carrier wake while reaching the capture circle earlier. None shows collision,
domain exit, wake collapse, or numerical instability.

The metrics isolate an actuator-allocation crossover. Pure posterior
velocity-quadrature recovery repeats at `23.122009T`, mean distance
`2.133413L`, score `-0.237071`, and mean action norm about `60.062`. Allocating
the same `0.12` budget to whole-carrier amplitude while target error is small
improves `2T` distance from `12.207L` to `12.156L`, `4T` distance from
`11.450L` to `11.300L`, mean distance to `2.127679L`, score to `-0.231273`,
and mean action to about `58.990`. It does not improve capture time and falls
behind the pure phase-lag route by `12T` (`6.203L` versus `6.171L`) and `20T`
(`2.104L` versus `2.029L`). Thus target error is a useful correlate but not a
causal locomotor allocation signal. The line-of-sight lead reaches earlier at
`22.572023T`, but with slightly worse mean distance/score than the allocation
(`2.127978L`, `-0.232481`) and higher mean action (about `60.545`); prior
guidance also shows that independently positive loops need not compose.

## Candidate hypothesis

Keep the inherited carrier, route loop, reactive rudder, terminal relief, and
total posterior recovery share unchanged. Replace the target-error allocation
of recovery with one smooth locomotor-state allocation: at the deepest
normalized through-water axial-speed deficit, apply the share to the whole
lagged carrier for launch authority; as the measured speed approaches the
existing recovery threshold, transfer that same share to posterior
velocity-quadrature lag for the evidenced later route. Reuse the existing
smooth recovery gate as the convex allocation weight, so the two pathways
cannot stack and recovery still vanishes above the established cruise-floor
threshold. This should retain the allocation's early lead while recovering the
phase-lag parent's `12--20T` approach, without extra authority or a hidden
startup clock.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish central-pattern-generator control
source_mechanism: measured locomotor state modulates amplitude and phase allocation while a coupled rhythmic carrier persists
transferable_invariant: redistribute a bounded gait budget between amplitude and traveling-wave phase response using observed locomotor state, without suppressing the carrier
nontransferable_details: published CPG gains, clock phase, robot morphology, species kinematics, dimensional speeds, and task-specific routes
policy_translation: normalized body-minus-local-water axial speed smoothly allocates the fixed posterior recovery share between whole-carrier scaling at deep deficit and joint-velocity phase lag near recovery
falsification: reject if capture is later than 23.122009T, mean distance exceeds 2.127679L, the early lead or later route is lost, or action, saturation, load, top-down wake, or complete oblique-wake bounds regress

