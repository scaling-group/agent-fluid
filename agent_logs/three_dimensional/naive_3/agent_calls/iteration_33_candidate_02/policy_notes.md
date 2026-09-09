# Terminal wave-energy regulation candidate

## Evidence diagnosis before the policy edit

- All sampled and inherited evaluations satisfy the Phase 2 contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and `horizon` termination at `100T`. I inspected
  both the top-down mid-plane-vorticity and oblique body/Lambda2 rows for all
  four sampled sheets and the latest inherited half-cycle sheet. Every fish is
  self-propelled and retains an alternating planar wake with compact 3D wake
  structures through its turns. The misses are controlled powered orbits, not
  passive advection, wake collapse, collision, exit, or instability.
- The completed terminal course hold (`solver_6eb170b0d70a`) remains the useful
  scaffold at `1.241/4.158/2.082L` minimum/mean/final distance and roughly
  `0.47T` inside `1.25L`. At its late minimum it still travels at `0.669U`, has
  `1.692 rad` target-ray/course error, slightly receding course dot `-0.121`,
  requested-sign yaw near `0.129 rad/T`, and modest commands. Its normalized
  anterior phase-plane activity about the commanded C-turn equilibrium is
  `0.110` at the minimum and has median `0.523` over states inside `1.8L`.
- The sampled rear-direction blend, joint-state unbend, and fixed-sign restart
  remain broad coherent failures at `2.366L`, `2.215L`, and `2.369L` minimum
  distance. Their representative minima park both joints near the commanded
  common C-bend with normalized anterior activity at or below `0.018`.
- The latest inherited target-behind anterior half-cycle pulse is now also a
  completed negative result. It improves on those broad descendants to
  `1.702L` minimum but regresses mean/final distance to `3.921/3.574L` and
  remains a noncapture horizon orbit. The visual sheet retains a coherent wake
  but loses the parent's tight return. Inside `1.8L`, its normalized anterior
  activity is only `0.004/0.011/0.015` at the 10th/50th/90th percentiles; at
  the minimum both joints are nearly stationary and commands are about
  `(0.060,0.048) rad/T^2`. A pulse proportional to the useful signed velocity
  vanishes as the wave decays and therefore does not preserve the carrier.

## Policy hypothesis

Return to the completed course-hold policy and preserve its geometry-released
C-turn, continuous course-response hold, equilibrium curvatures, posterior
lag/brake, phase modulation, wave envelope, and command bound. Add one new
feedback mechanism: under the existing target-behind terminal selector,
measure anterior phase-plane activity about the already commanded equilibrium
and add bounded acceleration parallel to measured anterior velocity only when
that activity falls below a declared floor. Unlike the failed one-sided pulse,
both velocity half-cycles receive energy; unlike the fixed-sign restart and
unbend, the term cannot create or move a static equilibrium. This is an
activity-regulated limit-cycle mechanism, not scalar-only tuning of the base
oscillator gain.

Support requires preservation of the coherent ahead-side recovery plus
capture, a pass below `1.241L`, longer residence inside `1.25L`, or a tighter
terminal loop with improved mean/final distance and comparable clamp/load
residence. Reject if the first recovery changes, normalized wave activity still
collapses, excess speed or wake curvature enlarges the orbit, command/load
residence rises, or the noncapturing distance class remains.

```text
bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish CPG control
source_mechanism: closed-loop oscillator amplitude regulation preserves a propagating anterior-to-posterior bend instead of replacing rhythmic motion with a static bias or a one-sided kick
transferable_invariant: when a terminal maneuver loses its traveling wave, measure phase-plane activity about the commanded equilibrium and add bounded energy parallel to existing motion on both half-cycles while retaining posterior lag
nontransferable_details: published CPG gains, dimensional frequencies, species-specific amplitude envelopes, full-body joint counts, clocked oscillator phase, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame target-behind and terminal course geometry gate an even activity deficit; measured anterior joint position and velocity produce a reflection-equivariant velocity-parallel acceleration within the unchanged two-joint lag contract
falsification: reject if the ahead-side return changes, activity still collapses, the wake curls or propulsion overshoots, clamp/load margins worsen, or closest, near-target residence, mean, and final distance retain the noncapturing class
```

## Evaluation boundary

The coupled CFD outcome is unavailable until this worker exits. Frozen-trace
replay and dry probes can establish locality, action scale, reflection
equivariance, finiteness, bounds, and parameter ownership, but cannot establish
hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed course-hold policy and adds three owned
parameters for one terminal activity regulator. The regulator computes
normalized anterior position and velocity about the existing C-turn
equilibrium, smoothly selects an activity deficit, and adds acceleration
parallel to measured velocity on both half-cycles. It changes no equilibrium,
posterior target, lag, brake, phase modulation, carrier envelope, curvature
magnitude, distance/course threshold, or `+/-28 rad/T^2` command reserve. It
uses no time, step count, mutable state, world coordinate, target identity,
route, random input, or file access.

Exact Julia replay over all `18182` states of the completed course-hold trace
changes maximum-joint action by only `2.58e-5/0.00133 rad/T^2` mean/maximum
beyond `3L` and `1.88e-5/0.00784 rad/T^2` over ahead-side states. Inside
`1.5L`, mean/maximum action change is `0.352/0.658 rad/T^2`; at the `1.241L`
minimum, anterior action changes from `0.970` to `0.562 rad/T^2` while the
posterior action remains `0.868 rad/T^2`. Frozen anterior/posterior clamp
fractions remain exactly `0.3285/0.1016`, every action is finite and bounded,
and full-trace lateral reflection negates both actions with zero residual.
These checks establish locality and a bounded two-sided energy test only; they
do not predict the coupled trajectory.

All `47` direct parameter references are fields returned by
`target_policy_params()`. The required material-guidance check, lightweight
Julia contract, schema audit, and solver editable-boundary check pass. The
rendered `README.md` contained the assigned-parent marker twice; removing only
that duplicate made the mandated baseline comparison unambiguous. No formal
CFD was run.
