# Course-consensus constant-magnitude posterior phase rotation

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, assigned parent guidance,
  sampled policies, scores, observations, summary metrics, diagnostics,
  trajectories, and inherited worker notes before selecting an architecture.
  Every supplied rollout is a finite capture from direct uniform still water
  with `U_infinity=[0,0,0]`, no cylinders or prewarm, and the moving-window
  contract intact. There is no failed termination among the current visual
  samples, so I compared the best-scoring finite capture (`v31`) with the
  weakest sampled regression (`v26`) and used inherited mechanism failures as
  nonvisual bounds.
- I inspected both rows of the combined keyframe sheets for `v31` and `v26`
  from release through capture. In the top-down mid-plane views both fish
  self-propel from rest and shed a coherent alternating vortex street; in the
  oblique Lambda2 views the posterior motion retains compact paired
  three-dimensional structures. Neither case shows passive advection,
  standing reciprocal motion, wake breakup, boundary interaction, or
  out-of-plane instability. Their differences are terminal allocation effects,
  not loss of propulsion.
- The assigned `v25` parent captures at `18.0070T` with score/mean distance
  `-0.064035/1.950361L`, center path `13.1972L`, final alignment/yaw
  `0.1036/1.1215 rad/T`, and near posterior acceleration-ceiling residence
  `73.03%`. Together with the inherited `v24` and positive-work-governor
  results, it completes three placements of instantaneous target-normal power
  that fail to improve distance integral and terminal alignment/yaw together.
  I therefore remove that online selector rather than retune or relocate it.
- The sampled `v31` duty-ratio primitive is the scalar leader at
  `-0.064000/1.950346L`, but relative to its `v20` base it delays capture one
  step to `18.0125T`, lengthens center path from `13.2108L` to `13.2149L`, and
  leaves near posterior acceleration-ceiling residence unchanged at about
  `75.9%`. Final alignment/yaw improve only from `0.1092/0.9840` to
  `0.1297/0.8077 rad/T`, remaining behind the sampled `v26` phase-selective
  feathering result (`0.1728/0.6545`) and inherited `v16` envelope
  (`0.1818/0.4200`). Both wake rows remain coherent. The inherited offline
  replay also shows that the nominal `[0.84,1.16]` duty bound realized only
  `0.9861`--`1.0187` on the parent trace. This is evidence that bounded
  half-cycle redistribution is safe for closure, but not that amplifying the
  same duty surface will solve terminal course quality.

## Single policy hypothesis

Start from the evaluated `v20` carrier and route controller, retaining its odd
target-to-curvature map, anterior state-feedback oscillator, posterior
emphasis, phase-consistent work reserve, alignment/yaw-power-qualified
posterior envelope, conserved approach mean-bend allocation, half-cycle
steering, and reversal-preserving rate governor. Replace `v31`'s posterior
duty-ratio scaling with one different actuator primitive: when the normalized
signed target-versus-velocity course error agrees with the existing signed
turn command during a moving, misaligned approach, rotate the posterior target
between observed anterior angle and rate components while holding the
coefficient-vector magnitude constant.

The rotation is exactly zero at and beyond `2.10L`, at rest, or when course and
route turn disagree. At zero authority the evaluated posterior target is
algebraically unchanged. At nonzero authority it changes relative joint phase
without scaling posterior-wave magnitude, cadence, or mean curvature. Lateral
reflection reverses the joint state, course error, and turn request together;
the consensus authority and phase angle remain invariant while the target and
joint commands reverse. The expected result is `v20`-identical far/middle
action and coherent two-view wake, retained capture and distance-integral
class, with terminal course correction arising from wave timing rather than
another shared bend or amplitude withdrawal. Falsify if transit output changes,
the phase rotation changes coefficient magnitude, capture or score regresses
materially, path and alignment/yaw do not improve together, pressure migrates
between joints, reflection fails, or either wake view deteriorates.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG phase modulation and elongated-body reactive propulsion
source_mechanism: steer by changing the relative phase of a posterior-emphasized traveling bend while retaining the underlying rhythmic carrier
transferable_invariant: a bounded sensory-selected phase change can redirect posterior reactive work without adding mean curvature or changing oscillatory magnitude
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, full-body kinematics, world coordinates, target location, capture radius, and task-specific routes
policy_translation: use normalized body-frame turn/course agreement only as an approach selector, then rotate the lagged posterior target in the observed anterior angle-rate phase plane at constant coefficient norm under the two-joint state-feedback contract
falsification: reject if pre-approach output changes, posterior coefficient norm is not conserved, capture or distance integral regresses, path and alignment/yaw fail to improve jointly, saturation migrates, reflection fails, or either coherent wake view worsens
```

## Lightweight validation after editing

- I invoked the mandated dedicated check-runner, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. I then ran its immutable
  checks directly. The guidance-materiality check passes after removing one
  duplicated assigned-parent marker from the rendered workspace `README.md`,
  and the solver-boundary check passes with
  `candidate_target_policy.jl` as the only solver change.
- No Julia executable exists in `PATH`, `/usr`, or `/opt`, so the executable
  include/action probe cannot run here. Static checks find one definition of
  each public function, all `66` direct `params.FIELD` references among the
  `68` fields returned by `target_policy_params`, no schema misses, a nonempty
  candidate, and no direct state reference to time, step, iteration, task
  identity, target coordinates, or cylinder data.
- The new authority is the same state-feedback selector whose inherited `v31`
  replay is exactly zero for all `2,881` samples at or beyond `2.10L`, zero at
  rest or turn/course disagreement, and has approach mean/maximum
  `0.1721/0.6425`. The configured `0.30 rad` phase bound therefore replays as
  mean/maximum `0.05163/0.19275 rad`. Across the entire authority interval,
  the rotated angle/rate coefficient norm equals the baseline
  `sqrt(1+0.8^2)=1.280624847487` to `2.22e-16`; at the replayed maximum the
  coefficients are `0.828234/0.976744`, both finite and positive. Algebraically,
  lateral reflection preserves authority and phase while negating the wave
  target. These are contract and activation checks, not a CFD result; EvE must
  evaluate the candidate after this worker exits.
