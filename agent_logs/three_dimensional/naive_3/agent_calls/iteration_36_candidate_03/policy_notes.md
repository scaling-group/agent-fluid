# Phase-balanced posterior-response candidate

## Evidence diagnosis before the policy edit

- All sampled and inherited evaluations use direct uniform initialization in
  still water with `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite
  dynamics, and `horizon` termination at `100T`. I inspected both the
  top-down mid-plane-vorticity and oblique body/Lambda2 rows for all four
  sampled sheets, the assigned parent's posterior-thrust sheet, the inherited
  `1.175L` phase-balanced sheet, and the `1.276L` posterior-phase sheet.
  Every fish self-propels and forms a coherent alternating planar wake with
  compact three-dimensional structures. The remaining failure is a controlled
  broad orbit, not passive advection, wake collapse, collision, domain exit,
  or numerical instability.
- The sampled terminal course hold reaches `1.241/4.157/2.082L`
  minimum/mean/final distance but remains inside `1.25L` for only about
  `0.47T`. The three sampled rear-selector, equilibrium-unbend, and
  fixed-sign-restart descendants reach only `2.366L`, `2.215L`, and
  `2.369L`; their sheets visibly broaden into nearly rigid C-bends, and their
  representative minima have almost stationary joints despite translation
  near `0.677U`.
- The inherited phase-balanced regulator is the strongest closest-approach
  scaffold. It reaches `1.175/4.041/3.243L`, remains inside `1.25L` for
  about `2.35T` and inside `1.5L` for `6.62T`, and preserves mean
  absolute anterior/posterior joint velocity near `0.775/0.360 rad/T` inside
  `2L`. Its minimum is nevertheless tangential and slightly receding: speed
  is `0.683U`, course error is `1.682 rad`, course dot is `-0.111`, and
  yaw is only `-0.061 rad/T`.
- The assigned parent's course-selective posterior-wave attenuation is a
  concrete negative result. Relative to that phase-balanced parent, it
  regresses closest approach from `1.175L` to `1.444L`, never enters
  `1.25L`, shortens residence inside `1.5L` from `6.62T` to `3.12T`,
  and worsens final distance from `3.243L` to `3.330L`; near-target speed
  falls by only about `0.02U`. Reducing posterior oscillatory thrust therefore
  does not remove the tangential attractor and must not be retuned.
- A separate completed posterior phase-response branch is more informative
  than attenuation. Starting from the course hold, it changes the terminal
  trajectory to `1.276/4.085/2.881L` and increases residence inside `1.5L`
  from `2.87T` to `5.69T` while preserving a coherent wake and active
  joints (`0.866/0.367 rad/T` mean absolute velocity inside `2L`). It does
  not beat the course hold's minimum or final distance, so it is not
  independently an improvement; its reusable evidence is that response-gated
  posterior phase changes the terminal orbit without creating the parked
  equilibrium seen in static posterior reallocations.

## Policy hypothesis

Start exactly from the completed `1.175L` phase-balanced policy. Preserve its
bearing curvature, target-behind C-turn, continuous course hold, anterior and
posterior moving equilibria, symmetric two-sided anterior energy regulator,
base posterior lag, braking, wave envelope, and command limit. Add the
completed response-gated posterior phase mechanism: derive target-ray angular
rate and signed target-ray/course error from normalized body-frame target and
velocity, compare a bounded course-closing turn request with measured yaw, and
translate only the unsatisfied response into a joint-state-phase-dependent
posterior lag shift. This keeps anterior energy and static curvature unchanged
while giving the posterior joint a measured steering-response role rather than
removing its thrust.

Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a tighter final return while preserving the coherent first
recovery, active terminal wave, and comparable clamp/load residence. Reject
the combination if the phase action and energy regulator interfere, the first
return moves, either joint parks or saturates, course error does not contract,
the wake/orbit broadens, or closest approach, residence, mean distance, and
final distance fail to improve over the relevant parents.

```text
bookshelf_consulted: true
source_domain: classical elongated-body traveling-wave propulsion and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve a closed-loop rhythmic carrier while slow measured route error modulates posterior wave phase as a separate steering-response channel
transferable_invariant: keep phase-balanced energy about the moving anterior equilibrium and place unsatisfied turn response in bounded posterior phase, without changing the mean bend or suppressing the traveling wave
nontransferable_details: published gains, dimensional frequencies, species-specific amplitude envelopes, full-body joint counts, clocked phase, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target and velocity form course error and target-ray rate; measured yaw supplies turn response, anterior joint state supplies phase, and only the posterior lag receives the bounded residual while the symmetric anterior energy law remains unchanged
falsification: reject if the coherent first return or active rhythm is lost, either joint parks or saturates, course error and closest/near-target/mean/final distance do not improve, or wake and load margins worsen
```

## Evaluation boundary

The candidate's coupled CFD result becomes evidence only after this worker
exits. Frozen completed-state replay and direct controller probes can establish
locality, boundedness, reflection equivariance, parameter ownership, and that
the two feedback roles remain distinct; they cannot establish hydrodynamic
improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed `1.175L` phase-balanced policy and
adds five owned parameters for the response-gated posterior phase mechanism.
It computes a bounded desired yaw rate from target-ray rate plus course error,
compares that request with measured heading rate, and uses measured anterior
joint velocity only as the posterior lag's half-cycle coordinate. The
phase-balanced anterior energy law, anterior/posterior mean curvatures, base
lag, brake, wave envelope, and `+/-28 rad/T^2` command reserve are unchanged.
The policy uses no elapsed time, step count, hidden or mutable state, world
coordinate, target identity, route, randomness, or file access.

Exact Julia replay over all `18182` states of the completed `1.175L` trace
leaves anterior action bit-for-bit identical. Posterior action changes by only
`4.42e-5/0.00244 rad/T^2` mean/maximum beyond `3L` and by
`0.0417/0.172 rad/T^2` inside `1.5L`. At the parent's minimum-distance
state, the candidate action is `(5.853,0.243) rad/T^2`, with only
`0.0384 rad/T^2` posterior change. Frozen anterior/posterior clamp fractions
remain about `0.226/0.103`; every action is finite and bounded, and full-trace
lateral reflection negates both actions with zero observed residual. All
`53` direct parameter references name the `53` fields returned by
`target_policy_params()`. The material-guidance, lightweight Julia contract,
parameter-schema, reflection, frozen-replay, and solver-boundary checks pass.
No formal CFD was run.
