# Harmful-impulse posterior damping candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts and the relevant assigned-parent rollouts satisfy
  the frozen contract: direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and `horizon`
  termination at `100T`. I inspected both the top-down mid-plane-vorticity and
  oblique body/Lambda2 rows. The sampled policies self-propel through coherent
  alternating planar wakes with compact three-dimensional structures, but all
  settle into broad powered return loops; passive advection, collision, domain
  exit, wake collapse, and numerical instability do not explain the misses.
- The four current samples reach only `2.215--2.439L`. Their mean distances are
  tightly clustered at `3.859--3.875L`, and their final distances at
  `3.310--3.502L`. The top-down sheets show nearly the same oversized orbit,
  while the oblique sheets show continued propulsion around a common bent-body
  state. This agrees with the inherited trace diagnosis of near-zero joint
  velocity despite body speed near `0.68U`: recent equilibrium release,
  rear-selector, posterior phase, and dual-joint activity remedies changed
  controller details without changing the useful trajectory class.
- The completed two-sided anterior phase-balanced regulator remains the
  evidence-backed scaffold. Its visibly tighter active-wake return reaches
  `1.175/4.041/3.243L` minimum/mean/final distance, remains inside `1.25L` for
  about `2.35T`, and retains mean anterior/posterior absolute joint velocity
  near `0.775/0.360 rad/T` inside `2L`. At its minimum, speed is `0.683U`,
  course error is `1.682 rad`, course dot is `-0.111`, and the joints remain in
  a moving counterphase transition rather than a parked C-bend.
- The assigned parent's force-selected posterior reinforcement is a concrete
  negative control. Although force on the `1.175L` trace predicted short-horizon
  course-error reduction, adding positive posterior work during the measured
  helpful impulse regressed to `2.391L` minimum and `3.489L` final distance and
  visually recovered the broad parked loop. Helpful-force correlation therefore
  did not establish that reinforcing the generating tail stroke was causal.
  Requested-half-cycle energy, posterior phase/energy, direct response
  acceleration, and repeated activity-floor changes are likewise closed by the
  inherited results and are not being retuned here.

## Policy hypothesis

Restore the exact completed `1.175L` anterior phase-balanced scaffold. Preserve
its body-frame bearing curvature, target-behind C-turn, continuous course hold,
moving equilibria, symmetric anterior activity regulator, posterior lag and
brake, wave envelope, and command reserve. Add one different response topology
to joint 2: compute the signed component of measured normalized body force that
rotates translational course relative to the target ray. Only when that impulse
is outward under the existing target-behind terminal gate, apply a bounded
acceleration opposite measured posterior velocity. This removes energy from a
currently harmful tail stroke instead of adding energy to a correlated helpful
stroke. It moves neither mean curvature nor nominal phase, and it vanishes for
helpful force, zero tail motion, or missing terminal geometry.

Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a tighter final return while preserving the coherent first return,
active terminal joint motion, and comparable clamp/load margins. Reject if the
damping parks the posterior joint, suppresses the traveling wake, merely trades
inward force for lower thrust, changes the first return, raises switching/load,
or fails to improve closest, residence, mean, and final-distance evidence over
the exact phase-balanced scaffold.

```text
bookshelf_consulted: true
source_domain: wake-interaction disturbance rejection and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow target-route feedback from fast hydrodynamic-response feedback and use the smallest bounded correction that preserves the traveling carrier
transferable_invariant: retain the target-selected rhythmic scaffold while measured force selects temporary negative work only on a stroke currently rotating translational course away from the target
nontransferable_details: published gains, dimensional beat frequencies, species-specific kinematics, full-body joint counts, clocked CPG phase, exact vortex phases, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target and velocity define signed course error; normalized body force classifies an outward impulse, and measured posterior velocity supplies a reflection-equivariant bounded damping action within the existing two-joint terminal gate
falsification: reject if cruise or the first return changes, tail motion or wake propagation collapses, load or clamp margins worsen, or closest approach, near-target residence, mean distance, and final distance fail to improve over the 1.175L phase-balanced scaffold
```

## Evaluation boundary

The coupled CFD result becomes evidence only after this worker exits. Frozen
completed-state replay and deterministic probes can establish response sign,
negative joint-space work, terminal locality, boundedness, reflection symmetry,
and parameter ownership, but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate restores the completed `1.175L` policy and adds three owned
parameters for one harmful-impulse damping term. Anterior action is unchanged.
The term uses normalized body-frame target, velocity, and force to classify the
instantaneous course-turning force, then opposes measured posterior velocity
only for the outward sign under the existing terminal selector. It changes no
curvature, equilibrium, oscillator, anterior activity law, posterior target or
lag, wave authority, brake, or `+/-28 rad/T^2` command reserve, and contains no
time, step count, hidden state, world coordinate, target identity, route,
randomness, file access, or mutable state.

Exact Julia evaluation over all `18182` completed scaffold states gives a
posterior action delta of only `1.16e-5/0.00114 rad/T^2` mean/maximum beyond
`3L`, but `0.0406/0.282 rad/T^2` inside `1.5L`; the full-trace maximum is
`0.452 rad/T^2`. The term is nonzero on `62.3%` of states inside `1.5L`, and
its action delta times measured posterior velocity is nonpositive on every
state (range `-0.315` to `0` in incremental joint-space work). At the parent's
`1.175L` minimum it is exactly zero because the instantaneous force is not
outward. Full-trace lateral reflection negates both actions with zero numerical
residual, all outputs remain finite and within the declared reserve, and every
direct `params.FIELD` reference names a returned parameter. These probes
establish sign, locality, boundedness, and equivariance only; no formal CFD was
run.
