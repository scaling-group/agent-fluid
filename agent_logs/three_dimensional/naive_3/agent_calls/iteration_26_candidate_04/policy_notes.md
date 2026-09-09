# Terminal propulsive-release candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected both the top-down mid-plane-vorticity and oblique body/Lambda2
  rows of every combined keyframe sheet. Every fish self-propels and produces
  a coherent three-dimensional wake; passive advection, collision, wake
  collapse, domain exit, and numerical instability do not explain the misses.
- The assigned response-held parent (`solver_2c7a9d1d6ee7`) retains a broad
  powered C-orbit at `2.377/4.458/4.163L` minimum/mean/final distance. The
  sampled nonclosing wave contraction (`solver_17c80feba915`) is worse at
  `2.484/4.545/4.673L`, and response-selected posterior counterbend
  (`solver_bac4e1917fd6`) reaches only `2.249/4.355/3.701L`. Their top-down
  rows show repeated broad loops, while the oblique rows show compact
  alternating structures rather than loss of propulsion.
- The course-response curvature reserve (`solver_951085a20092`) is a semantic
  improvement and the strongest scaffold: it reaches
  `1.314/4.056/3.077L` minimum/mean/final distance, repeats later passes near
  `1.35L`, and preserves horizon survival. Inside `3L`, mean absolute yaw is
  about `0.530 rad/T`, versus `1.164--1.313 rad/T` for the other three, and
  anterior command-reserve residence falls to about `0.159` from
  `0.691--0.716`. Thus added same-sign course-response curvature successfully
  changes the orbit and should be preserved rather than replaced by another
  scalar drive, duty, static bend-allocation, or posterior-counterbend edit.
- Its remaining miss has a distinct terminal signature. At the best
  `1.3137L` pass (`69.283T`), speed is still `0.652U`, target-ray/course error
  is `1.672 rad`, radial response is approximately zero, yaw is only
  `-0.137 rad/T`, and commands are just `(1.61,-0.06) rad/T^2`. On the inward
  leg from about `2.02L` to `1.37L`, the target is already behind the head,
  course dot remains positive (`0.47` to `0.11`), and normalized two-joint
  speed falls from `0.059` to `0.020`. The same low-activity, finite-speed
  inward leg recurs near `92--94T`. Visually, the later top-down panels have
  long curved shear bands rather than the early discrete alternating street,
  while the oblique row shows the body continuing around the target. This is
  a near-target static-C-bend/coasting orbit, not excessive beat energy.

## Policy hypothesis

Start from the sampled course-response reserve, preserving its cruise carrier,
posterior lag/brake, geometry-released C-turn, and same-sign nonclosing turn
reserve. Add one compact terminal propulsive release. Only when the target is
near and behind, normalized translational course is positively closing, and
measured joint-speed activity is low, continuously release the redirect
equilibrium toward neutral and restore the posterior traveling-wave envelope.
This uses the already inward momentum instead of continuing the static C-bend;
the low-activity gate keeps the active first pass and ordinary cruise intact.
All selectors use normalized body-frame geometry, normalized velocity, and
joint state, with no time, route, hidden stage, or world-frame command.

Support requires preservation of the coherent approach plus capture, a pass
inside `1.31L`, a visibly inward terminal leg, or material minimum/mean/final
distance improvement without higher clamp/load residence. Reject if the
release changes cruise or the active first pass, destroys the coherent wake,
causes a powered domain exit, transfers persistent saturation posteriorly, or
retains the same `1.3L` noncapturing orbit.

```text
bookshelf_consulted: true
source_domain: biological C-start release and sensor-modulated robotic-fish CPG direction control
source_mechanism: release a strong bounded redirect into a posteriorly emphasized traveling wave after measured motion establishes a useful course response
transferable_invariant: separate strong turning from propulsive translation and select release from observed geometric and kinematic response rather than elapsed maneuver time
nontransferable_details: species-specific C-start stages, published CPG gains, dimensional beat frequency, full-body kinematics, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame target projection and target-ray/course dot, together with normalized two-joint speed, continuously remove only the near-target redirect equilibrium and restore the existing posterior wave on a low-activity inward leg
falsification: reject if cruise or the active first pass changes, wake coherence or horizon survival is lost, clamp/load residence rises, or no closer inward leg, capture, or useful distance improvement appears
```

## Evaluation boundary

The current worker has no same-worker coupled CFD result. Frozen-trace replay
and direct controller probes after the edit can establish selector locality,
reflection equivariance, finite outputs, parameter ownership, and command
reserve only. EvE evaluates the fluid-coupled candidate after this worker
exits.

## Implemented candidate and non-CFD probes

The candidate starts from the sampled course-response-reserve policy and adds
seven owned terminal-release parameters. Its smooth selector combines distance,
the existing target-behind weight, target-ray/course dot, and two-joint speed.
It partially removes both redirect equilibria and restores the existing wave;
it does not add a second oscillator, external phase, fixed route, or scalar
drive change. A proposed `0.55` maximum release was reduced to `0.45` after
frozen replay showed avoidable posterior reserve contact.

Replay over all `18,182` states of the improved sampled trace gives exactly
zero action change through `12T`. Across the active first pass (`39--46T`),
mean/maximum two-action change is only `0.070/5.328 rad/T^2`; the representative
`41.003T`, `1.799L` action is unchanged. On the diagnosed low-activity inward
legs, the mechanism is material: mean action change is `6.579 rad/T^2` over
`65--73T` and `6.643 rad/T^2` over `90--98T`. At `67.672T`, `1.574L`, it
changes the frozen action from `(5.105,-0.628)` to
`(21.407,22.879) rad/T^2`, while adding no component-clamp residence on either
later-pass window. These counterfactual actions establish locality and reserve,
not an integrated trajectory prediction.

All `47` direct parameter references are returned by
`target_policy_params()`. Mirroring body-frame lateral target/velocity, joint
state, bearing, and yaw gives exactly negated actions; zero-target/zero-speed
and large finite probes remain finite, and commands respect the declared
`+/-28 rad/T^2` reserve. No formal CFD was run.
