# Multi-wake target-policy diagnosis

## Evidence boundary

The assigned solver parent is `solver_c3dbb22c85f8`, and the copied optimizer
parent is `optimizer_06eee0cef91b`. I used their guidance and inherited
`solver_4d4caad74a21` rollout together with all four sampled solver results.
The deliberately omitted research shelf, neighboring configurations, repository
history, and external sources were not consulted. The candidate below is a
pre-evaluation hypothesis; its CFD outcome cannot be claimed by this worker.

## Visual and metric diagnosis

- The common prewarm sheet shows the fish held at the upper-right release pose
  while the four cylinder streets develop and merge across the target corridor.
  It is common initial-condition evidence, not evidence for any controller.
- The target-blind seed `solver_f236e5345260` is the strongest finite sample:
  it visibly self-propels and briefly reaches `8.61495L`, but rotates into a
  nearly vertical descent and exits the bottom after `50.1269`. Its
  `(-3.545,-13.300)L` head displacement, exact velocity/acceleration cap
  contacts, `1496.25` mean command energy, and final `12.1226L` distance show
  that the large gait supplies motion without controlled target approach.
- Two posterior-only negative bearing biases independently reproduce an early
  down/right exit. `solver_3f6f47644ec3` (`10 deg`) and inherited
  `solver_4d4caad74a21` (`15 deg`) terminate at `16.0984` and `16.0929`, never
  improve on their initial `12.4239L` distance, and end at `14.3899L` and
  `14.4217L`. Their mean velocities remain close to their local flow and their
  head displacements are approximately `(2.58,-2.1)L`; the keyframes show no
  entry into the useful wake or turn toward the target. This satisfies the
  inherited hypothesis's explicit condition to flip or weaken the bias.
- Applying the same negative convention to both joints is worse:
  `solver_5b26e78fb728` visibly curls at release and becomes unstable after
  `1.9207`, with the anterior joint at the `45 deg` angle limit and RMS
  force/moment of `119496`/`1.236e6`. A larger shared mean bend is therefore
  not a supported remedy.
- The positive common-curvature parent `solver_c3dbb22c85f8` is finite and has
  the smallest downward displacement (`-0.814L`) and lowest effort (`0.692`
  mean command energy), but both joints stop at exactly the `8 deg` steering
  bias. The released sheet shows a nearly rigid, passively advected fish;
  distance never improves and it exits at `16.7474`. Centering the anterior
  Van der Pol state on a steady steering offset can leave it at the zero-energy
  equilibrium instead of preserving propulsion.

The local `wake_observation.json` diagnostics supply the joint extrema and
local-flow cross-check that the compact metrics omit; no external heavy VTK or
MP4 artifact was loaded.

## Single candidate hypothesis

Use the inherited finite posterior-only architecture as the controlled
comparison and change the empirically suspect steering sign, while keeping the
anterior oscillator centered at zero. A positive, smoothly bounded posterior
tail-tangent bias is driven only by body-frame bearing. The `0.75` period,
`11 deg` oscillator scale, lag, damping, and `26 rad/time^2` sub-envelope cap
are retained from `solver_4d4caad74a21`, so the sign/location test is not
confounded by adding wake probes, coordinates, a clock, or another feedback
mechanism.

The falsifiable expectation is survival beyond the approximately `16.1`
release time of both negative posterior-bias runs, less down/right displacement,
and at least some distance closure while retaining a nonzero anterior rhythm.
The hypothesis fails if the fish again exits without beating its initial
distance, if the positive bias reverses bearing but still produces no upstream
travel, or if the posterior transient drives repeated clipping. In that case,
later workers should stop treating static bearing-to-curvature sign as the
missing capability and test a bounded dynamic heading/closing feedback or a
different propulsion coupling as a separate experiment.
