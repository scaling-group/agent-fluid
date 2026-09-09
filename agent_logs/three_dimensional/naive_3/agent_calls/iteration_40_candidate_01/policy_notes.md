# Terminal reverse-wave candidate

## Evidence diagnosis before the policy edit

- The four sampled rollouts and the assigned parent's inherited rollout all
  satisfy the Phase 2 contract: direct uniform initialization in still water
  with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and
  `horizon` termination at `100T`. I inspected their combined top-down
  mid-plane-vorticity and oblique body/Lambda2 rows. All show self-propelled
  first approaches with coherent curved planar sheets and compact 3D wake
  structures, followed by broad repeated return loops. Passive advection,
  collision, domain exit, wake collapse, and numerical instability do not
  explain the misses.
- The sampled terminal remedies are visually and dynamically one failure
  class. Posterior turn-response phase, joint-state equilibrium release,
  dual-joint activity regulation, and harmful-impulse posterior damping reach
  only `2.439`, `2.215`, `2.320`, and `2.294L`; their mean distances cluster at
  `3.859--3.877L` and final distances at `3.310--3.471L`. At each minimum the
  body still travels near `0.68U`, while both joints share a negative C-bend
  near `(-0.36,-0.38) rad` with speeds below `0.003 rad/T`. The body-frame
  target/course error is consistently about `1.70 rad`, course dot about
  `-0.13`, and yaw already about `-0.25--0.27 rad/T`. The smooth late wake
  sheets and almost unchanged oblique body pose agree with a powered/gliding
  tangential loop around a parked controller equilibrium, not an inactive
  vehicle.
- The assigned parent's bounded anterior turn-response acceleration is the
  strongest current negative control. It remains nonzero at zero joint speed
  and improves closest approach to `2.077L`, but worsens mean/final distance
  to `3.890/3.512L` and still reaches its minimum in the same C-bend at about
  `0.68U`, `1.695 rad` course error, and `-0.250 rad/T` yaw. Together with the
  inherited counterphase burst, which raised useful yaw to about `0.335 rad/T`
  but improved the phase-balanced carrier's `1.175L` minimum only to `1.192L`,
  this shows that more yaw or a nonzero parked-state curvature action does not
  by itself redirect translational course.
- The completed two-sided anterior phase-balanced regulator remains the only
  positive scaffold: it reaches `1.175/4.041/3.243L` minimum/mean/final
  distance, stays inside `1.25L` for about `2.35T`, and remains in an active
  counterphase transition at its minimum. Requested-half-cycle energy, duty
  bias, stronger or posterior activity floors, static C/S-bend changes,
  response-triggered equilibrium release, posterior phase residuals,
  positive-work force selection, and the newly completed harmful-force
  damping all fail to improve that return. The remaining architectural gap is
  not another scalar drive or steering-gain adjustment: when the target is
  behind and course is receding, the carrier has no way to request axial
  impulse toward the target without first completing a large body turn.

## Policy hypothesis

Restore the exact `1.175L` phase-balanced scaffold and remove the completed
posterior activity addition from the prefilled policy. Preserve its bearing
curvature, target-behind C-turn, continuous course hold, moving equilibria,
symmetric two-sided anterior activity regulator, posterior authority/brake,
nominal lag, wave envelope, and command reserve. Add one new terminal actuator
role: only when normalized body-frame geometry says the target is behind,
distance is close, speed is resolved, and target/course dot is nonclosing,
continuously reverse the sign of the posterior quadrature lag. The anterior
oscillator remains the carrier; changing only the lag direction converts the
same measured state rhythm from a posterior-traveling wave toward an
anterior-traveling wave, testing bounded reverse axial impulse rather than
more yaw, mean bend, energy, or thrust attenuation. The original lag returns
continuously when closure appears or terminal geometry disappears.

Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a materially tighter final return while preserving the first
approach, active joint motion, coherent 3D wake, and clamp/load margins.
Reject the mechanism if the transition through zero lag creates a reciprocal
standing wiggle, either joint parks, reverse course response does not appear,
the wake or first return degrades, commands/loads grow, or closest approach,
near-target residence, mean distance, and final distance do not improve over
the exact phase-balanced scaffold.

```text
bookshelf_consulted: true
source_domain: classical traveling-wave propulsion from swimming-sheet and elongated-body models
source_mechanism: the direction and posterior phase of a lateral traveling wave determine the direction of momentum transfer, while posterior kinematics retain the propulsive role
transferable_invariant: when steering-only feedback cannot redirect a finite-speed tangential miss, reverse the measured-state wave-propagation direction under body-frame nonclosing geometry instead of increasing scalar effort or static curvature
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact thrust coefficients, full-body waveforms, exact vortex phases, target coordinates, capture radius, and prescribed routes
policy_translation: normalized target-behind geometry, distance, speed, and target/course dot gate a continuous sign reversal of the posterior velocity-lag term while the existing anterior state-feedback oscillator and two-joint moving equilibria remain unchanged
falsification: reject if the first approach changes materially, the zero-lag transition produces reciprocal motion, either joint parks or saturates, reverse axial course response is absent, wake/load margins worsen, or closest approach, residence, mean distance, and final distance fail to improve over the 1.175L phase-balanced scaffold
```

## Evaluation boundary

The coupled CFD result becomes evidence only after this worker exits. Frozen
trace replay and deterministic probes may establish schema ownership,
terminal locality, boundedness, reflection equivariance, and actual reversal
of the quadrature coefficient; they cannot establish reverse thrust or coupled
trajectory improvement.

## Implemented candidate and non-CFD probes

The candidate is the completed `1.175L` phase-balanced policy plus one
terminal wave-direction role. Five owned parameters define a close-distance
gate, a nonclosing-course gate, and a maximum continuous lag reversal. The
new weight uses only normalized target-behind geometry, distance, resolved
body-frame speed, and target/course dot. It multiplies the existing posterior
quadrature lag; it changes no mean curvature, anterior oscillator or activity
law, posterior wave authority, brake, scalar wave envelope, nominal lag,
command limit, morphology, episode, or score. It contains no elapsed time,
step count, mutable state, randomness, world coordinate, target identity,
route, or file access.

Exact Julia replay over all `18182` states of the completed `1.175L` trace,
using the same candidate with reversal disabled as the base, leaves the
anterior action bit-for-bit unchanged. Maximum-joint action delta is
`0.000066/0.00312 rad/T^2` mean/maximum beyond `3L` and
`1.103/4.319 rad/T^2` inside `1.5L`. The lag-direction factor spans
`[-0.379,1]`; at the `1.175L` minimum it is `-0.308` and changes posterior
action from about `+0.282` to `-1.202 rad/T^2` while anterior action remains
about `+5.853 rad/T^2`. Thus the term actually reverses the quadrature phase
instead of merely attenuating it, while remaining terminal-local on the
completed trace. Candidate actions remain finite within the declared
`+/-28 rad/T^2` reserve, and sampled lateral reflections negate both actions
with zero numerical residual. All `53` direct parameter references name the
`53` fields returned by `target_policy_params()`.

The mandated material-guidance, lightweight Julia contract, and solver
editable-boundary checks pass. These probes establish implementation
semantics, locality, bounds, and equivariance only; no formal CFD was run and
reverse thrust remains the post-exit falsification target.
