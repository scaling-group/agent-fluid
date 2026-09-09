# Terminal target-ray-rate response candidate

## Evidence diagnosis before the policy edit

- All sampled and inherited evaluations satisfy the Phase 2 evidence contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected both the top-down mid-plane-vorticity and oblique body/Lambda2
  rows. Every fish self-propels and retains a coherent alternating planar wake
  with compact three-dimensional structures through its turns. The remaining
  failure is a controlled powered orbit, not advection, collision, boundary
  exit, wake collapse, or numerical instability.
- The completed terminal course hold (`solver_6eb170b0d70a`) remains the useful
  scaffold despite its lower scalar score: it reaches
  `1.241/4.157/2.082L` minimum/mean/final distance, spends about `0.47T` inside
  `1.25L`, and visibly forms the tightest return loop. At its `97.092T`
  minimum it still moves at `0.669U`; the target/course cross and dot are
  `0.993/-0.121`, so the course error is `1.692 rad`. The instantaneous inertial
  target-ray rate computed from normalized body-frame geometry is therefore
  about `-speed*course_cross/distance = -0.535 rad/T`, while measured yaw is
  only `-0.129 rad/T`. The `-0.406 rad/T` residual directly quantifies the
  visible tangential turn-response deficit without using world coordinates or
  history.
- The sampled rear-direction blend, joint-state unbend, and fixed-sign restart
  regress to `2.215--2.369L` closest approach and broad quiet-C-bend loops.
  The assigned parent's symmetric velocity-parallel energy regulator is now
  completed evidence: it retains a coherent return topology but reaches only
  `1.615/4.089/2.811L`, never enters `1.25L`, and at its minimum has strong
  anterior motion (`phi_dot_1=-0.927 rad/T`) yet wrong-sign yaw
  (`+0.374 rad/T`). Independent inherited symmetric energy variants reach only
  `1.631L` and `1.491L`. Thus low phase-plane activity is a discriminator of
  several weak descendants, but restoring activity is not the missing terminal
  steering mechanism. Do not add another energy floor, velocity-aligned pulse,
  equilibrium kick, drive scalar, or curvature-limit retune.

## Policy hypothesis

Return exactly to the completed course-hold scaffold and preserve its
geometry-released C-turn, continuous course hold, oscillator, equilibrium
curvatures, posterior lag/brake and phase modulation, wave envelope, and
command bound. Add one new response semantic under the already-local terminal
selector: derive the inertial line-of-sight angular rate from normalized
body-frame target/course geometry, subtract measured body yaw, and apply a
small bounded anterior acceleration in the residual direction. Unlike the
failed activity regulators, the action is independent of oscillator amplitude;
unlike fixed yaw thresholds, its requested response scales continuously with
observed tangential speed and distance and releases when yaw follows the target
ray. The posterior target remains unchanged.

Support requires preserving the coherent ahead-side recovery plus capture, a
pass below `1.241L`, longer residence inside `1.25L`, or a tighter terminal
loop with improved mean/final distance and comparable clamp/load residence.
Reject if the first recovery moves, the residual creates another parked bend,
gait-scale yaw makes the action chatter, the wake curls or stalls, load/limit
residence rises, or the noncapturing distance class remains.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and nonsteady biological redirect control
source_mechanism: persistent target geometry requests a bounded turn response that releases when measured body rotation follows the target direction while the posterior propulsive wave is retained
transferable_invariant: separate geometric turn demand from measured turn response and retain the traveling-wave carrier; use the response residual rather than oscillator amplitude or a fixed maneuver stage
nontransferable_details: published gains, dimensional frequencies, species-specific C-start kinematics, full-body joint counts, clocked CPG phase, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target and velocity directions give line-of-sight angular rate as `-speed*course_cross/distance`; subtract normalized measured heading rate and gate a bounded reflection-equivariant anterior residual by the existing target-behind terminal selector within the two-joint contract
falsification: reject if the first recovery changes, the target-ray-rate residual does not shrink, a quiet bend or chatter appears, wake coherence or load margins degrade, or closest, near-target residence, mean, and final distance do not improve
```

## Evaluation boundary

The coupled CFD outcome is unavailable until this worker exits. Frozen-trace
replay and dry probes can establish selector locality, action scale, reflection
equivariance, finiteness, bounds, and parameter ownership, but cannot establish
hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate returns to the completed course-hold policy and adds two owned
parameters for one terminal target-ray-rate residual. The target-ray rate is
computed only from normalized body-frame target/course geometry, speed, and
distance; measured heading rate supplies the response. The existing squared
target-behind and terminal course weights localize the residual. It changes no
equilibrium curvature, posterior target, lag, brake, phase modulation, wave
envelope, course/distance selector, or `+/-28 rad/T^2` command reserve, and it
uses no time, step count, mutable state, world coordinate, target identity,
route, random input, or file access.

Exact Julia replay over all `18182` completed course-hold states changes
maximum-joint action by only `8.36e-5/0.00236 rad/T^2` mean/maximum beyond
`3L`, but by `0.517/0.909 rad/T^2` inside `1.5L`. At the `1.241L` minimum the
computed target-ray/yaw residual is `-0.405 rad/T`, and candidate anterior
action changes from `0.970` to `0.111 rad/T^2`; posterior action is exactly
unchanged. Frozen anterior/posterior clamp fractions remain
`0.3285/0.1016`, all actions are finite and bounded, and a lateral-reflection
probe negates both actions with zero residual. These checks establish a local,
bounded response test only; they do not predict the coupled trajectory.

All `46` direct parameter references are fields returned by
`target_policy_params()`. The required material-guidance check, lightweight
Julia contract, schema audit, and solver editable-boundary check pass. The
rendered `README.md` contained the assigned-parent marker twice; removing only
the duplicate made the mandated baseline comparison unambiguous. No formal CFD
was run.
