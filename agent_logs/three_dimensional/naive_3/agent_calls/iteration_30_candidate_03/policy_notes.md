# Target-behind turn-rate phase-residual candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the Phase 2 flow contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no prewarm or cylinders,
  finite dynamics, and `horizon` termination at `100T`. I inspected both the
  top-down mid-plane-vorticity row and the oblique body/Lambda2 row in every
  combined keyframe sheet. The `solver_6eb170b0d70a` course-hold policy is the
  strongest finite sample (`1.241/4.158/2.082L` minimum/mean/final distance):
  it remains self-propelled, sheds an alternating compact 3D wake through the
  repeated return loop, and reaches inside `1.25L` for about `0.47T` without
  capture. Its late miss is a powered tangential turn, not advection,
  collision, domain exit, or instability.
- The assigned-parent anterior equilibrium burst is a completed negative
  result (`2.125/3.901/3.601L`). Its top-down path settles into a broad orbit
  and its late oblique wake fades; after `40T` the recorded joint-speed/action
  norms collapse even while the body coasts near `0.67U`. Target-behind gating
  does not rescue that architecture: `solver_ba444c755721` reaches only
  `1.987L`, retains the broad orbit, and likewise has weak late joint motion
  and wake structure. The sampled joint-state posterior-stroke mechanism
  (`solver_3a28e4c77f3c`) improves closest approach to `1.622L` but still
  converges to the same low-action orbit rather than restoring the powered
  `1.241L` loop. These results agree with inherited logs in rejecting more
  static equilibrium curvature, another posterior acceleration residual, or
  frozen-replay locality as evidence of coupled locality.
- In the powered course-hold sample, the late `1.241L` miss retains about
  `0.669U` speed but only about `0.13 rad/T` requested-sign yaw, while the
  target-crossing angular scale is materially larger. Reconstructing the
  inertial target-ray rate from normalized body-frame target and translational
  velocity gives roughly `-0.40 rad/T` at that miss, versus measured yaw near
  `-0.13 rad/T`. By contrast, the quenched broad-orbit samples approximately
  match yaw to target-ray rate at their repeated minima, which sustains a
  finite-radius orbit instead of turning the course inward. The remaining
  useful error is therefore a turn-rate deficit under persistent course error,
  not distance, drive amplitude, or another mean-curvature request.

## Policy hypothesis

Restore `solver_6eb170b0d70a` as the scaffold, including its anterior and
posterior equilibria, oscillator, course-response reserve, terminal course
hold, brake, wave envelope, and command bounds. Add one bounded dynamic
mechanism only after full-direction geometry puts the target behind: derive a
requested yaw rate from the signed target-course error and the normalized
target-crossing rate `speed/distance`, compare it with measured heading rate,
and translate the residual into a joint-phase-signed posterior lag shift. The
product of signed yaw deficit and measured anterior joint velocity is
reflection-even, so it can modulate lag without imposing a world-frame turn or
moving either oscillator equilibrium. The gate is effectively absent before
the target crosses behind and fades continuously with the existing terminal
selector.

Support requires preserving the coherent first recovery and late joint/wake
activity while producing capture, a pass below `1.241L`, longer residence
inside `1.25L`, or a materially smaller terminal loop with improved mean/final
distance. Reject if first-recovery geometry or yaw changes, the anterior limit
cycle or compact wake fades, posterior clamp/load residence rises, the phase
residual merely sustains another finite-radius orbit, or near-target and
distance statistics do not improve.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and two-joint phase-lag steering
source_mechanism: measured direction-response error modulates the propulsive rhythm's inter-joint phase while the anterior oscillator continues to run
transferable_invariant: compare a body-relative requested turn response with measured yaw and apply only a bounded phase residual, preserving the propulsive limit-cycle equilibrium
nontransferable_details: published CPG gains, clock phase, species-specific envelopes, dimensional frequency, full-body kinematics, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame target and velocity form a signed speed-over-distance yaw request; target-behind geometry and the existing terminal selector gate its error with measured heading rate, and anterior joint velocity converts it into a reflection-equivariant posterior lag shift
falsification: reject if the first recovery changes, joint motion or wake coherence fades, clamp/load residence rises, useful yaw does not exceed the target-ray sweep enough to contract the orbit, or closest, near-target, mean, and final distance remain noncapturing
```

## Evaluation boundary

The coupled CFD result is produced only after this worker exits. Frozen-trace
replay and dry policy checks can establish gating locality, action scale,
reflection equivariance, finiteness, command bounds, and parameter ownership,
but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate restores the completed `1.241L` course-hold controller and adds
four owned parameters for one turn-rate-deficit phase residual. It computes a
bounded requested yaw rate from `speed/distance` with the sign of the existing
target-course response, subtracts measured heading rate, and multiplies the
soft residual by measured anterior joint phase. The result changes only the
posterior lag coefficient. Both joint equilibria, oscillator drive, curvature
reserves, posterior wave envelope, braking, and command limit are identical to
the scaffold. There is no clock, step count, hidden state, world coordinate,
target identity, route, flow-phase assumption, or file access.

Frozen replay over all `18,182` states of the completed course-hold trace is
finite and remains inside the declared `+/-28 rad/T^2` command bound. Beyond
`3L`, mean/maximum action-vector change is only
`0.000157/0.00685 rad/T^2`; across the `15--21T` first-recovery window it is
`0.00235/0.0229 rad/T^2`. The mechanism becomes material on the later
`35--50T` return, where mean/maximum change is `0.156/1.460 rad/T^2`. Inside
`1.5L` the mean/maximum is `0.0623/0.218 rad/T^2`, and the frozen change at the
`1.241L` state is `0.126 rad/T^2`. These measurements establish locality and a
bounded dynamic perturbation only; inherited evidence explicitly rules out
treating them as a coupled-trajectory prediction.

All `48` direct parameter references are returned by
`target_policy_params()`. Mirroring lateral target/velocity, bearing, yaw,
joint angles, and joint velocities negates both actions with zero observed
residual across sampled parent states. The mandated guidance comparison,
lightweight Julia contract, parameter-schema audit, reflection/bounds replay,
and solver editable-boundary checks pass. No formal CFD was run.
