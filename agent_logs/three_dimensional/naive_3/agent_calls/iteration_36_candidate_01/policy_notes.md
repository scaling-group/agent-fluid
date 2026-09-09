# Terminal energy-plus-phase-response candidate

## Evidence diagnosis before the policy edit

- All sampled and inherited evaluations used direct uniform initialization in
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I
  inspected the combined top-down vorticity and oblique body/Lambda2 sheets for
  all four sampled policies and the inherited terminal-energy, direct-response,
  and posterior-phase policies. Their alternating planar and compact 3D wakes,
  finite body motion, and `100T` horizon terminations establish self-propelled
  controlled orbits rather than advection, wake collapse, collision, exit, or
  instability.
- The sampled `1.241L` terminal course hold is still the strongest complete
  return scaffold: it reaches `1.241/4.158/2.082L` minimum/mean/final distance
  and visibly makes the tightest late target-side loop. The assigned parent's
  joint-state C-bend release regresses to `2.215/3.859/3.416L`; its broad loop
  parks near a common bend, so another equilibrium release is unsupported.
  The fixed-sign restart and rear selector similarly reach only `2.369L` and
  `2.366L`.
- Inherited completed runs close several tempting repairs. Direct anterior
  target-ray-rate acceleration reaches only `2.201/3.887/3.584L`; useful-side
  activity asymmetry reaches `2.362/3.876/3.511L`; and a posterior
  response-phase mechanism alone reaches `1.276/4.085/2.881L`, just outside the
  course hold's `1.241L` pass and with a worse final distance. These results do
  not support another direct kick, static bend, scalar drive edit, asymmetric
  half-cycle, or stand-alone lag-response retune.
- Phase-balanced anterior activity feedback is mixed but supplies the best new
  semantic evidence: one completed variant reaches `1.175L`, remains inside
  `1.25L` for about `2.35T`, preserves active near-target joint motion, and
  lowers clamp/load residence, while independent variants reach only `1.615L`
  and `1.366L`. At the `1.175L` minimum the fish is still tangential and
  slightly receding (`speed=0.683U`, course error `1.682 rad`, course dot
  `-0.111`), has active joints (`phi_dot=(-0.394,0.260) rad/T`), but turns at
  only `-0.061 rad/T`. The target ray rotates near `-0.577 rad/T`, so activity
  was restored without enough inward yaw response. The stand-alone posterior
  phase run turns faster at its minimum (`-0.143 rad/T`) while preserving a
  coherent late return, but its nearly parked joints show that response-phase
  control does not by itself retain the carrier.

## Policy hypothesis

Use the completed `1.175L` phase-balanced terminal-energy policy as the
scaffold and add the already-bounded posterior phase-response mechanism as one
small compatible combination. The energy regulator remains even in measured
anterior velocity and does not move either equilibrium; the response mechanism
derives desired yaw from normalized body-frame target-ray rate plus course
error, subtracts measured yaw, and translates only the deficit into posterior
lag using measured anterior phase. Thus amplitude retention and steering
response remain separate CPG coordinates. No gain, curvature, equilibrium,
distance selector, posterior brake, or command bound from either completed
mechanism is retuned.

Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a tighter return with improved mean/final distance while preserving
the coherent first approach, active terminal joints, and comparable clamp/load
residence. Reject the combination if it changes the first return, phase
activity collapses, requested-sign yaw does not improve, the wake/orbit
expands, commands or loads rise materially, or closest/near-target/final
statistics retain the noncapturing class.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish coupled-oscillator control and classical traveling-wave turning
source_mechanism: regulate rhythmic amplitude independently from a low-dimensional response-driven posterior phase coordinate
transferable_invariant: preserve phase-balanced energy about the commanded bend, then translate persistent geometric turn deficit into bounded posterior wave phase without moving the locomotor equilibrium
nontransferable_details: published gains, dimensional frequencies, robot duty ratios, species-specific envelopes, full-body joint counts, clocked phase, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized anterior phase-plane activity and measured velocity retain the carrier; normalized body-frame target/course geometry and measured yaw form a terminal response residual that modulates posterior lag in the two-joint state-feedback contract
falsification: reject if cruise or the first return changes, joints park or saturate, response yaw does not improve, the wake or orbit expands, load margins worsen, or closest, near-target, mean, and final distance fail to improve over the 1.175L energy scaffold
```

## Evaluation boundary

The current candidate's coupled CFD outcome is unavailable until this worker
exits. Completed-rollout evidence and frozen-trace probes can justify the
mechanism, locality, sign, boundedness, reflection equivariance, and parameter
ownership, but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed `1.175L` terminal-energy controller
and adds the completed stand-alone posterior phase-response law without
retuning either mechanism. The anterior command and all equilibria are
unchanged by the added response coordinate. It uses no time, step count,
hidden state, world coordinate, target identity, route, randomness, file I/O,
or mutable global state.

Exact replay over all `18182` states of the `1.175L` energy trace gives
`0.0109/0.474 rad/T^2` mean/maximum maximum-joint action change overall and
only `0.000044/0.00244 rad/T^2` beyond `3L`. Inside `1.5L`, the change is
`0.0417/0.172 rad/T^2`; at the `1.175L` minimum the anterior command remains
exactly `5.853 rad/T^2` and the posterior command changes from `0.282` to
`0.243 rad/T^2`. Frozen anterior/posterior clamp fractions remain exactly
`0.2264/0.1030`, all commands are finite and bounded by `+/-28 rad/T^2`, and
full-trace lateral reflection negates both commands with zero residual. All
`53` direct `params.FIELD` references are among the `53` fields returned by
`target_policy_params()`. These checks establish a local, bounded,
reflection-equivariant compound test only; they do not predict its coupled
trajectory.
