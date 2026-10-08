# Margin-rate joint-speed viability candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled evaluations use direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm, and all terminate in
  capture. The two identical prefill samples are one physical soft-envelope
  result. In its combined sheet, the top-down row develops a coherent
  alternating red/blue wake from release through capture at `16.943T`; the
  oblique row shows compact three-dimensional Lambda2 structures shed behind
  the caudal region. Peak body speed is `1.39290U` while peak local flow is
  only `0.03249U`, so this is self-propelled motion rather than moving-window
  or ambient advection.
- Both later speed-allocation sheets retain essentially the same alternating
  top-down street and compact oblique structures, so their changes did not
  cause wake collapse. They remove the parent's exact `260 deg/T` contacts,
  but neither improves its route. Posterior-to-anterior positive-work
  reallocation captures at `17.060T`, scores `-0.20865`, and has mean distance
  `2.09311L`; anterior-to-posterior carrier reallocation captures at
  `17.053T`, scores `-0.21075`, and has mean distance `2.09541L`. The unguarded
  soft-envelope parent remains better at `16.943T`, `-0.20539`, and
  `2.08985L`. The first reallocation also spends the special acceleration
  reserve up to `31.102 rad/T^2`, while the reverse transfer raises peak force
  slightly above the parent's `0.03609` to `0.03631`.
- The inherited logs provide the necessary baseline: the direct `0.94`
  positive-work speed shell already removed exact contacts, retained capture
  and both wake views, but delayed arrival to `17.115T`. The two sampled
  transfers therefore show that moving rejected work between joints is not a
  supported route-recovery mechanism, even when phase and headroom gates are
  added. The remaining issue is how the speed boundary is enforced, not where
  to inject the rejected work.

## Single-candidate policy hypothesis

Start from the strongest soft-envelope capture. Preserve its full-quadrant
body-frame target/course observation, zero-centered anterior oscillator,
posterior lag and target-steering reserve, high-knee acceleration shoulder,
and posterior kinetic angle-margin projection. Add one normalized
control-barrier mechanism to both joints: when an assembled acceleration would
increase measured joint speed, cap that directional acceleration in proportion
to the remaining speed margin. Existing reversal/braking and all requests
already below the admissible ceiling pass unchanged. Unlike a fixed-width
shell, the condition directly encodes the continuous viability inequality
`d|phi_dot|/dt <= rate * (speed_limit - |phi_dot|)`.

A non-CFD replay on the strongest logged trace gives the proposed rate a
one-step factor of `0.88` at the released maximum solver step. It would alter
`152/136` anterior/posterior samples and remove total acceleration magnitude
`1102/1681 rad/T^2`, versus `199/179` samples and `1336/1871 rad/T^2` for the
inherited `0.94` smooth shell replay. This establishes a selective, lower-work
projection on the observed states; it does not predict the closed-loop CFD
trajectory.

Expected result: retain capture and coherent alternating shedding, eliminate
exact speed-limit occupancy, and recover route performance toward the
`16.943T`, `2.08985L` soft-envelope reference without exceeding its
`0.03609/0.01766` force/moment peaks or `29.846 rad/T^2` command ceiling.
Falsify the mechanism if either hard-speed contact returns, capture or wake
coherence is lost, arrival/mean distance is no better than the inherited
`17.115T/2.09800L` direct guard, or angle, acceleration, force, or moment use
grows.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and bounded residual control
source_mechanism: preserve a low-dimensional rhythmic carrier while applying the smallest state-triggered constraint residual needed for actuator viability
transferable_invariant: constraint feedback should be normalized, directional, inactive for admissible carrier work, and should preserve braking and the coupled traveling bend
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, linkage geometry, exact vortex phases, actuator ratings, and task-specific routes
policy_translation: use each measured joint speed divided by its owned limit; cap only speed-increasing assembled acceleration by a rate times remaining speed margin, after the evidenced soft envelope and before posterior angle protection
falsification: reject if exact speed contact remains, capture or alternating three-dimensional shedding is lost, route metrics fail to beat the direct speed shell, or load and mechanical-envelope use exceed the soft-envelope reference
```
