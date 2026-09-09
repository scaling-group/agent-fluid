# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent, all four sampled evaluations, and the inherited
  optimizer evaluations use direct uniform quiescent initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and finite
  dynamics. Their translation and wakes are self-propelled rather than
  advection or initialization artifacts.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows of the
  combined sheets for the strongest sampled carrier (`2.443L` minimum), the
  distance-relief failure (`2.845L`), and the inherited posterior-course-guard
  failure (`2.697L`). All three retain long alternating three-dimensional
  wakes, approach from the upper right, pass the target on its lower side,
  turn onto a powered near-vertical descent, and leave the lower boundary.
  This is a repeatable course-topology failure, not lost propulsion, wake
  collapse, or instability.
- The current samples reject proximity-only carrier relief (`2.845L`), full
  target-direction posterior gating (`2.494L`), and slip-magnitude phase-lag
  relief (`2.822L`). Inherited logs sharpen the boundary: posterior
  half-cycle steering reached `3.661L`, stronger closing-gated C-bends reached
  `2.468L` but raised mean/final distance and loads, unrestricted course-angle
  feedback reversed the route and reached only `12.150L`, matched-window
  target-ray-drift lead reached `3.167L`, and the sign-restricted posterior
  course guard reached `2.697L`; every finite variant still left the domain.
  Another residual, scalar gain, or perturbation of the cruise carrier is not
  supported by this evidence.
- The strongest carrier is already committed to the miss before the late
  redirect: at `15.554T` it is still moving at about `0.765U`, its head is
  already `0.700L` below the target while `2.915L` to its right, and it later
  reaches only `2.443L`. The visual trail likewise shows substantial
  downward momentum accumulated during nearly aligned propulsion. A useful
  test must prevent that commitment, not add another late correction.

## Policy hypothesis

Replace continuous steering perturbations of the powered carrier with one
continuous geometry-gated gait mechanism. When full body-frame target
direction is materially misaligned, smoothly suppress the traveling wave and
track a bounded same-sign two-joint C-bend; as alignment appears, measured
geometry releases the bend and restores the evidenced posterior-lag cruise.
The switch has no hidden mode, clock, route, or world coordinate: it is a
memoryless blend driven by normalized body-frame direction and measured joint
state. This tests whether an align-then-propel separation can avoid building
the lateral momentum that defeated simultaneous propel-and-steer variants.

Expected evidence is a compact initial redirect, restoration of the long
alternating wake after alignment, a shallower passage by `8--16T`, and a
meaningfully different trajectory or termination with minimum distance below
`2.443L`. Falsify the mechanism if it chatters between gaits, makes a tight
curl or wrong-side release, never restores propulsion, loses early distance
progress, increases load/limit residence, or reproduces the powered lower
exit and the established closest-approach band.

```text
bookshelf_consulted: true
source_domain: biological C-start redirects combined with sensor-modulated robotic-fish CPG direction tracking
source_mechanism: large observed direction error selects a bounded body bend, while recovered alignment releases into a posterior-lag propulsive rhythm
transferable_invariant: separate redirect and propulsion continuously using measured body-frame target alignment and joint state so lateral momentum is not built faster than steering can correct it
nontransferable_details: species-specific C-start shapes, published gains, dimensional timings, robot geometry, explicit gait-state machines, exact vortex phases, and task-specific routes
policy_translation: blend a two-joint same-sign C-bend tracker with the established joint-state oscillator and lagged posterior wave using bounded full target-direction alignment
falsification: reject on wrong-side or tight-curl release, gait chatter, lost wake restoration or early closing, no improvement beyond 2.443L or the lower-exit topology, or worse actuator/load residence
```

## Implemented candidate and pre-CFD checks

The candidate implements only the continuous redirect/cruise blend above. It
retains the sampled cruise oscillator, posterior lag, acute-bearing curvature,
alignment gate, and command reserve; material full target-direction error
smoothly replaces that carrier with a slower damped C-bend tracker. At an
evidence-like initial body-frame direction and joint pose, the synthetic
commands are about `(4.73, 20.85)`, below the configured limit, and a reflected
target/joint state produces exactly their negatives. Extreme finite direction,
yaw-rate, and joint-rate inputs remain finite and bounded.

The required guidance semantic check, lightweight Julia policy-contract check,
and solver boundary check pass. These are deterministic preflight results, not
a hydrodynamic evaluation; capture, wake restoration, trajectory class, loads,
and clamp residence remain for the downstream CFD evaluator.
