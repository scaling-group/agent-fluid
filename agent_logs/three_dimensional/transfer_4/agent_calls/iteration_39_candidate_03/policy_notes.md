# Target-normal hydrodynamic-work rectifier

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned-parent notes and
  rollout, every sampled score, observation, metric, diagnostic, trajectory,
  and policy, and the inherited terminal-control logs. All four current solver
  samples are byte-identical v31 deterministic reruns: each captures at
  `18.0125T`, scores `-0.0640004`, has mean/observed distance integrals
  `1.950346L/1.336756L`, and terminates at `0.748395L`. Each confirms direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm,
  no cylinders, and no boundary or numerical failure.
- I inspected the combined current v31 and inherited positive-work sheets from
  release through capture. In both top-down mid-plane rows the fish self-propels
  along the same broad target-directed arc and sheds a coherent alternating
  wake. Both oblique Lambda2 rows retain compact three-dimensional posterior
  structures without out-of-plane instability. The informative failure is not
  passive advection, wake breakup, or the turn sign: it is the inherited
  closing-stride positive-joint-work governor preserving that topology while
  worsening score/mean distance to `-0.064699/1.950910L`, observed integral to
  `1.336764L`, and final distance to `0.749072L`, with essentially unchanged
  final alignment/yaw (`0.1301/0.8088 rad/T`) and only a `0.51` percentage-point
  reduction in near posterior acceleration-ceiling residence.
- The current leader still crosses fast and obliquely: final alignment/speed/
  absolute yaw are `0.1297/0.8806U/0.8077 rad/T`, head cross-track is
  `0.7327L`, and near anterior/posterior acceleration-ceiling residence is
  `69.29/75.89%`. Common cadence contraction, common amplitude contraction,
  and stride-selected posterior positive-work withdrawal all retained capture
  but reduced useful closure, so another closing-stride scalar channel is not
  supported.
- Reprojection of the evaluated v31 trace onto the instantaneous target-normal
  direction gives mean approach cross-course speed `0.5299U`. Target-normal
  hydrodynamic power alternates sign: it reinforces cross-course motion on
  `47.46%` of samples below `2.10L`, opposes it on the remainder, has mean
  `-9.53e-6`, mean absolute magnitude `0.00719`, and a positive 90th percentile
  near `0.0101`. This distinguishes harmful from helpful fluid work within the
  same productive gait and motivates a centered work rectifier rather than
  another route-wide energy reduction.

## Single policy hypothesis

Start from evaluated v31 and preserve its odd body-frame route map,
state-feedback cadence and amplitude target, posterior lag/emphasis,
phase-consistent reserve, terminal mean-bend allocation, course-consensus duty
surface, half-cycle steering, and reversal-preserving rate governor. During
only the moving, misaligned approach, project body-frame center velocity and
hydrodynamic force onto the direction normal to the observed target vector.
Use their signed product to apply a bounded, centered multiplier to the
posterior traveling-wave target: weaken the posterior wave while hydrodynamic
force is adding cross-course kinetic energy, and strengthen it by the same
maximum amount while the force opposes cross-course motion. At zero
target-normal power the evaluated v31 output is unchanged.

This is a sensor-selected energy-flow mechanism, not a gain sweep over cadence,
amplitude, course error, mean steering, or raw yaw. Target-normal velocity and
force both reverse under lateral reflection, so their product, the selector,
and the posterior multiplier remain invariant while signed joint commands
reflect. Expected evidence is exact v31 output outside `2.10L`, retained
capture and closure/path class, and a smaller fast oblique crossing with better
alignment/yaw and no migration of acceleration-ceiling residence. Falsify if
the multiplier changes transit; reflection changes its value; it strengthens
positive target-normal work or weakens negative work; capture, observed
distance integral, path, or cross-track regresses materially; terminal state
and non-migrating load residence do not improve together; or either coherent
wake view deteriorates.

```text
bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish CPG control
source_mechanism: preserve useful fluid-assisted lateral motion while applying bounded feedback only to fluid work that reinforces unwanted motion
transferable_invariant: classify target-normal hydrodynamic work by the sign of normalized body-frame force times velocity, attenuate energy-adding phases, and retain energy-opposing phases without changing the underlying traveling rhythm
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, cylinder-wake phases, full-body waveforms, world coordinates, target location, capture radius, and task-specific routes
policy_translation: below the established approach distance, use the product of target-normal body-frame velocity and force to center a bounded posterior-wave multiplier around one while preserving cadence, amplitude target, posterior lag, total mean bend, steering, and reversal authority
falsification: reject if pre-approach output changes, lateral reflection changes the multiplier, helpful and harmful work are not separated, capture or observed closure/path regresses materially, terminal alignment/yaw and non-migrating limit residence do not improve together, or either wake view worsens
```

## Lightweight validation after editing

- The mandated dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. I ran the same immutable
  checks directly. The guidance check initially exposed two identical rendered
  markers for the same assigned parent in `README.md`; removing only the
  duplicate made the parent unambiguous. The notes/guidance materiality check
  and solver-boundary check then passed.
- Julia is not installed, so the executable include/action probe cannot run.
  No CFD was attempted. Static checks find one definition of each public
  function, cover all `68` direct `params.FIELD` references with the `70`
  fields returned by `target_policy_params`, confirm balanced delimiters and a
  nonempty candidate, and find no explicit time, step count, randomness, file
  I/O, cylinder coordinate, fixed target coordinate, or memorized-route input.
- Offline replay of only the new task-space selector over the evaluated v31
  trace gives exactly the parent multiplier `1.0` on all `2881` samples outside
  `2.10L`. Across the `394` approach samples, measured target-normal work is
  positive/negative on `187/207` samples; the gated rectifier spans
  `-0.5572` to `0.5576` and schedules a mild posterior multiplier of
  `0.9554` to `1.0446`. Focused lateral-reflection cases preserve the work
  product and multiplier exactly, and sign checks confirm positive work can
  only reduce the multiplier while negative work can only increase it. These
  establish reachability and symmetry, not a pending CFD outcome.
- The final candidate SHA-256 is
  `3c2e1ba23d84373f1f070702909aa2eae3ad698e94bd4dc2781b6e548ff83287`.
