# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent, the four sampled solver evaluations, and the relevant
  inherited rollouts all report direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and finite dynamics.
  Their motion is self-propulsion, not advection or an initialization artifact.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows in all
  four sampled combined sheets, then compared the inherited persistent
  terminal counterbend and target-ray-course sheets. All show a long coherent
  alternating wake through a nearly coincident inbound route. The fish then
  points nearly vertically, passes below the target, remains powered, and exits
  the lower boundary. Wake collapse and instability are not the limiting
  failures.
- The strongest sampled scalar carrier reaches `2.443L` with mean distance
  `8.443L` and survival to `31.097T`. A wrong-side lateral-velocity posterior
  counterbend preserves its coherent wake and improves closest approach to
  `2.187L`, while a geometry-persistent version regresses to `2.477L` and the
  assigned parent's same-sign response redirect reaches only `2.601L`; all
  retain the lower exit. This shows that the useful posterior S-bend is
  response-selective, not a license for a larger or more persistent mean bend.
- Adding a bounded terminal target-ray course residual to that counterbend is
  the strongest inherited local result: minimum distance improves again to
  `2.011L`. It is still incomplete because mean distance worsens to `8.740L`,
  final distance to `9.836L`, and the fish remains powered through a lower exit
  at `34.056T`. Its keyframes retain the long propulsive wake after the miss.
  Thus more equilibrium persistence is not supported; excess cross-track
  propulsion during failed closure is the remaining testable distinction.

## Policy hypothesis

Retain the evidenced alignment-gated `7 deg` carrier, the sampled
wrong-side-velocity posterior counterbend, and its bounded terminal target-ray
course residual without increasing the shared posterior equilibrium envelope.
Add one compatible approach-hold mechanism: decompose measured body-frame
velocity into target-ray closing and cross-track components, and only in the
near field, when cross-track motion is large and closure is inadequate,
attenuate the oscillatory posterior wave toward a nonzero floor. Keep the
posterior mean counterbend outside that attenuation so steering remains active,
and leave the anterior oscillator and far-field carrier unchanged.

Expected evidence is the inherited coherent inbound wake and progress, followed
by reduced terminal wake strength while the posterior S-bend continues to turn,
a minimum below `2.011L`, and preferably capture or a termination other than the
powered lower exit. Falsify the mechanism if it changes the release or
far-field route, coasts before useful closure, loses wake coherence outside the
terminal neighborhood, raises command/load residence, or retains the same
lower-exit topology without a useful distance improvement.

```text
bookshelf_consulted: true
source_domain: terminal capture control combined with Lighthill-style separation of posterior propulsion and steering kinematics
source_mechanism: preserve the traveling carrier in cruise, but during a geometrically confirmed near miss reduce excess posterior drive while retaining bounded steering authority
transferable_invariant: when normalized target-ray velocity has large cross-track content and inadequate closure, propulsion and steering authority should be scheduled separately rather than increasing persistent curvature
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, fixed approach distances, burst durations, duty ratios, and task-specific routes
policy_translation: body-frame target_body_L and velocity_body_U form reflection-equivariant closing and cross-track signals that continuously gate only the posterior oscillatory wave around the unchanged two-joint state-feedback carrier and bounded counterbend
falsification: reject on altered far-field progress, premature coasting, lost wake coherence outside approach, increased limit/load residence, no improvement beyond 2.011L, or persistence of the powered lower exit
```

## Implemented candidate and pre-CFD checks

The candidate starts from the inherited bounded target-ray counterbend and
adds only the course-and-closure-conditioned posterior-wave hold described
above. All active thresholds, scales, authority fractions, and carrier values
are owned by `target_policy_params`; the acceleration clamp remains
`28 rad/T^2` and the posterior equilibrium envelope remains `7 deg`.

Replay of the completed `2.011L` trajectory through the new hold is a gating
diagnostic, not a hydrodynamic result. Mean hold weight is `0.00069` outside
`4L`, `0.04796` between `3--4L`, and `0.45223` inside `3L`; at the inherited
minimum it is `0.78573`, where target-ray cross-track speed is `0.642U` and
closing speed only `0.093 L/T`. This matches the intended separation between
cruise and terminal approach.

The mandated guidance-semantic, lightweight Julia contract, and solver
boundary checks pass. Direct probes also pass global reflection, extreme-input
finiteness, and the configured command bounds, and all `324` repository
non-CFD assertions pass. Formal CFD remains deferred to the downstream
evaluator.
