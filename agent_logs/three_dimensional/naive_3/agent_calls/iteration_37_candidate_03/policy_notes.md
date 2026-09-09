# Posterior phase-balanced terminal-wave candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected the top-down mid-plane-vorticity and oblique body/Lambda2 rows
  of every combined keyframe sheet. Each fish visibly self-propels and leaves
  a coherent paired planar wake with compact three-dimensional structures
  through the broad return. Passive advection, wake collapse, collision,
  domain exit, and numerical instability do not explain the misses.
- The assigned parent (`solver_a6820a0af3d7`) is the most informative sampled
  failure. It reaches the batch's best minimum at `2.215L` but only
  `3.859/3.416L` mean/final distance. At that minimum the vehicle still moves
  at about `0.677U`, while anterior/posterior joint speeds are only
  `0.00269/0.00202 rad/T` and commands are about
  `0.0168/0.00493 rad/T^2`. Its top-down and oblique rows show a coherent,
  powered broad loop around a nearly rigid common negative C-bend. The miss is
  a coupled controller-hydrodynamic parked-bend attractor, not inadequate
  vehicle speed or actuator saturation.
- The rear selector and fixed-sign restart samples reproduce that topology at
  `2.366L` and `2.369L`. The sampled combination of phase-balanced anterior
  energy and posterior turn-response phase (`solver_fbea116ed491`) also
  regresses to `2.439/3.861/3.310L` minimum/mean/final distance. Its closest
  state has joint speeds only `0.00053/0.00179 rad/T` with modest commands,
  so the completed result falsifies the hypothesis that a slow course-error
  posterior lag residual is compatible with the anterior energy scaffold.
  It must not be retuned or retained in this candidate.
- Inherited optimizer logs identify the surviving scaffold: symmetric
  low-activity feedback parallel to anterior velocity on both half-cycles
  reaches `1.175/4.041/3.243L`, remains inside `1.25L` for about `2.35T`, and
  retains mean near-target anterior/posterior speeds near
  `0.775/0.360 rad/T`. One-sided duty bias, stronger scalar activity tuning,
  posterior thrust attenuation, static equilibria, and signed restarts all
  fail. The reusable distinction is phase-balanced active motion versus a
  static bend, not additional curvature or bulk drive.
- The latest inherited equal-and-opposite counterphase burst is now completed
  evidence, not merely a proposed mechanism. It reaches
  `1.192/4.044/3.222L`, worsens residence inside `1.25L` from about `2.35T`
  to `1.24T`, and lowers mean absolute two-joint speed inside `2L` from about
  `0.567` to `0.462 rad/T`. Its sheets preserve the same coherent return, but
  the burst does not tighten it. This closes paired counterphase acceleration;
  the remaining test must stabilize posterior rhythm independently rather
  than reallocating an anterior event across both joints.

## Policy hypothesis

Restore the completed `1.175L` anterior phase-balanced controller exactly as
the carrier and remove the sampled, now-falsified terminal posterior phase
residual. Add one different actuator role under the existing body-frame
target-behind terminal selector: measure posterior phase-plane activity about
the existing moving posterior lag target, and when that activity is deficient apply a
bounded acceleration with the sign of measured posterior velocity on both
half-cycles. This makes the quiet posterior bend locally repelling without
adding mean curvature, a preferred side, a clock, or a prescribed phase. The
anterior state-feedback oscillator still supplies the wave source and the
unchanged lag target still sets anterior-to-posterior propagation; the new
term only prevents the damped posterior tracker from becoming the stationary
end of the C-bend.

The implementation will normalize posterior position and velocity by the
redirect-scaled gait envelope, use the existing distance/speed/course terminal
weight, taper with measured phase-plane activity, and saturate its incremental
acceleration below the episode command reserve. Support requires capture, a
pass below `1.175L`, longer residence inside `1.25L`, or a materially tighter
final return while preserving the coherent wake, the first recovery, active
motion of both joints, and comparable clamp/load residence. Reject if either
joint parks, the lagged wave is disrupted, the orbit broadens, clamp/load
residence rises materially, or closest approach, residence, mean distance,
and final distance fail to improve together.

```text
bookshelf_consulted: true
source_domain: classical elongated-body traveling-wave propulsion and closed-loop coupled-oscillator robotic-fish control
source_mechanism: the anterior joint sustains and steers a rhythmic wave while a lagged posterior joint remains an active thrust-producing oscillator instead of a purely damped static tracker
transferable_invariant: stabilize phase-balanced rhythmic activity at both ends of the two-joint wave while slow body-frame geometry selects when the terminal maneuver needs that carrier
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, full-body joint counts, robot duty ratios, clocked CPG phases, exact vortex phases, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target-behind and target-ray/course weights gate a bounded velocity-odd posterior phase-plane feedback about the existing moving lag target; measured joint state supplies phase and the original anterior carrier supplies propagation
falsification: reject if cruise or the first return changes, either joint parks or saturates, posterior activity fails to recover, the wake or orbit broadens, load margins worsen, or closest approach, near-target residence, mean distance, and final distance do not improve over the 1.175L phase-balanced scaffold
```

## Evaluation boundary

The current candidate's coupled CFD result is unavailable until this worker
exits. Dry contract, schema, reflection, bound, and completed-trace replay
checks may establish implementation semantics and action scale only; they
cannot establish a hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate restores the completed `1.175L` phase-balanced controller and
adds four owned parameters for the sole posterior phase-plane mechanism. The
new action is velocity-odd, uses both posterior half-cycles, and is gated by
the existing normalized target-behind terminal geometry. It changes no mean
curvature, anterior oscillator, approach phase modulation, posterior lag
target, brake, wave envelope, or `+/-28 rad/T^2` command reserve. It contains
no elapsed time, step count, hidden state, mutable state, world coordinate,
target identity, route, randomness, or file access.

Synchronized replay over all `18181` usable states of the completed `1.175L`
trace reproduces that parent exactly when the new posterior acceleration is
disabled (zero maximum residual). With it enabled, anterior action remains
identical. Posterior action changes by only `0.000102/0.00443 rad/T^2`
mean/maximum beyond `3L`, but by `1.214/2.078 rad/T^2` inside `1.5L`. At the
parent's `1.175L` minimum it changes posterior action from about `0.431` to
`2.416 rad/T^2` while measured posterior velocity is `+0.257 rad/T`; this is
positive work on the existing half-cycle, not a bend shift. Replayed maximum
action remains `28 rad/T^2`, anterior/posterior clamp fractions remain about
`0.227/0.103`, and full-trace lateral reflection negates both actions with
zero observed residual. These probes establish locality, boundedness, and the
intended actuator semantics only; they do not predict the coupled CFD result.
