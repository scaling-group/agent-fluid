# Phase-selected anterior stroke candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected both rows of every combined keyframe sheet. The top-down sheets
  show self-propelled curved trajectories and alternating mid-plane wakes; the
  oblique sheets show compact three-dimensional Lambda2 structures through the
  early approach. None of the misses is passive advection, collision, domain
  exit, or numerical instability.
- The terminal course-hold sample (`solver_6eb170b0d70a`) remains the strongest
  scaffold: `1.241/4.158/2.082L` minimum/mean/final distance, about `0.47T`
  inside `1.25L`, finite `0.669U` speed at the closest pass, and a visibly
  coherent return-loop wake. Its joint cycle remains active after `40T`
  (mean absolute anterior/posterior joint speeds about `1.190/0.511 rad/T`),
  so its residual miss is tangential steering, not absent propulsion.
- The assigned parent's response-released anterior equilibrium burst is a
  completed negative result. It reaches only `2.125/3.901/3.601L`; after
  `40T`, mean absolute joint speeds/actions fall to about
  `0.0076/0.0064 rad/T` and `0.0406/0.0200 rad/T^2`. The late oblique structures
  and top-down alternating wake fade while the body continues coasting near
  `0.68U`. Moving the oscillator equilibrium therefore converted the useful
  terminal loop into a nearly static C-bend rather than adding turn response.
- Full target-behind gating does not rescue that equilibrium mechanism. The
  sampled gated anterior burst (`solver_ba444c755721`) reaches only
  `1.987/3.887/3.522L`, spends about `1.01T` inside `2L` and none inside
  `1.25L`, and has similarly weak late joint speeds (`0.0089/0.0075 rad/T`).
  Inherited logs correctly established negligible frozen action on the
  ahead-side first recovery, but the coupled rollout shows that frozen-trace
  locality is not integrated dynamic locality.
- The joint-state posterior stroke (`solver_3a28e4c77f3c`) is the informative
  partial result: it improves the parent's minimum to `1.622L` and spends
  about `14.27T` inside `2L`, but worsens mean/final distance to
  `3.964/3.799L`, never enters `1.25L`, and also settles to weak late joint
  motion (`0.0158/0.0111 rad/T`). A bend-ready state gate can alter the useful
  trajectory, but trading posterior mean curvature for wave scale still does
  not preserve the active carrier. Together with the inherited failed
  unphased posterior acceleration residual, this leaves true beat-half-cycle
  selection as a distinct untested mechanism.

## Policy hypothesis

Restore `solver_6eb170b0d70a` as the scaffold and preserve its oscillator,
bearing curvature, posterior brake and lag modulation, geometry-released
C-turn, course-response reserve, terminal course hold, equilibrium curvatures,
wave envelopes, and command limit. Add one compact mechanism: when the existing
terminal selector is active, the target is fully behind, course error is large,
and requested-sign yaw has not developed, add bounded anterior acceleration
only during the measured joint-velocity half-cycle already moving toward the
requested bend. Release the residual smoothly on the return half-cycle and as
useful yaw develops. This changes neither oscillator equilibrium nor the
posterior lag target and therefore tests phase-selected steering authority
without another static C-bend or unphased tail kick.

Support requires preservation of the coherent first recovery and late joint/wake
energy plus capture, a pass below `1.241L`, longer residence inside `1.25L`, or
a materially tighter terminal loop with improved final/mean distance and
comparable clamp/load residence. Reject if the first recovery changes, joint
motion or the compact wake fades, useful yaw does not develop, clamp/load
residence rises, or the same noncapturing orbit remains.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish asymmetric flapping and biological response-released burst turning
source_mechanism: strengthen only the turn-useful beat half-cycle while retaining the traveling propulsive rhythm, then release the maneuver as measured turn response develops
transferable_invariant: preserve the oscillator equilibria and posteriorly lagged carrier; inject bounded steering energy only in the state-observed half-cycle that already moves toward the requested bend
nontransferable_details: published gains and duty ratios, clocked CPG phase, species-specific C-start stages and kinematics, dimensional beat frequency, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame target/course geometry and speed select the terminal miss, signed heading rate releases it, and signed normalized anterior joint velocity selects a reflection-equivariant turn-useful half-cycle under the two-joint acceleration contract
falsification: reject if the early recovery changes, the joint cycle or compact wake fades, requested-sign yaw fails to increase, clamp/load residence rises, or closest, near-target residence, mean, and final distance retain the noncapturing class
```

## Evaluation boundary

The coupled CFD rollout occurs only after this worker exits. Frozen completed
trace replay and dry controller checks can establish selector locality, action
scale, reflection equivariance, finiteness, bounds, and parameter ownership;
they cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate restores the completed course-hold policy and adds six owned
parameters for one anterior half-cycle residual. Its engagement uses the
existing normalized terminal distance/speed/course gate, squared target-behind
geometry, large course error, and requested-sign yaw deficit. Signed anterior
joint velocity is the only phase selector: the residual is exactly zero at
zero velocity and on the return half-cycle. Both equilibrium curvatures, the
Van der Pol carrier, posterior mean, posterior lag target, wave envelopes,
brake, and command limit are unchanged. There is no clock, step count, hidden
state, world coordinate, target identity, route, file access, or random input.

Frozen replay over all `18,182` states of the completed
`solver_6eb170b0d70a` trajectory remains finite and bounded. At its `1.241L`
closest pass, the new anterior action delta is `-1.617 rad/T^2`; inside `1.5L`
the mean/maximum absolute delta is `0.538/2.106 rad/T^2`. Beyond `3L` it is
only `0.000123/0.00591 rad/T^2`, and over target-ahead states it is
`0.000022/0.00954 rad/T^2`. The maximum absolute replay delta is
`2.322 rad/T^2`. Posterior action is instantaneously identical to the scaffold
at every replayed state; any later posterior change must arise through the
coupled anterior state, not a changed tail command.

Paired synthetic probes give a `-2.756 rad/T^2` anterior delta on a terminal
turn-useful stroke and exactly zero delta on the matching return-stroke and
rest states. Far, target-ahead, zero-speed, and large-finite states are finite
and within the declared `+/-28 rad/T^2` reserve. Mirroring lateral target and
velocity, both joint states, bearing, and yaw negates both actions with zero
observed residual. All `50` direct parameter references are returned by
`target_policy_params()`. The mandated material guidance/notes check,
lightweight Julia policy contract, deterministic parameter-schema audit, and
solver editable-boundary check pass. No formal CFD was run.
