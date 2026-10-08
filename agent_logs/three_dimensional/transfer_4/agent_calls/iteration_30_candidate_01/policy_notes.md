# Target-normal load-gated posterior work withdrawal

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, all four sampled scores,
  observations, metrics, diagnostics, trajectories, and policies, and the
  assigned-parent and sibling optimizer notes. Every sampled episode is a
  finite capture from direct uniform still water with `U_infinity=(0,0,0)`, no
  prewarm, no cylinders, and no boundary interaction.
- I inspected every combined keyframe sheet, with particular comparison of the
  best-scoring v20 rollout and the informative v15 mechanism baseline. In both
  the top-down mid-plane row and the oblique Lambda2 row, all four policies
  visibly self-propel from rest and retain the same coherent alternating wake
  and compact three-dimensional posterior structures through capture. There is
  no visible passive advection, wake breakup, or out-of-plane instability. The
  unresolved behavior is approach allocation and terminal transverse motion,
  not creation of propulsion.
- The sampled v24 target-normal-power policy is not evidence for terminal
  damping as implemented. Relative to the v20 scalar leader, it arrives sooner
  (`17.9960T` versus `18.0070T`), shortens center path/head cross-track
  (`13.1921L/0.7269L` versus `13.2108L/0.7317L`), and reduces near posterior
  acceleration-ceiling residence (`72.38%` versus `75.83%`). But mean
  distance/score regress from `1.950358L/-0.064028` to
  `1.950652L/-0.064407`, final alignment falls from `0.1092` to `0.0975`, and
  absolute final yaw rises from `0.9840` to `1.2697 rad/T`. Thus a useful
  body-frame load signal was applied at the wrong control surface: scaling the
  whole lagged posterior target does not preserve terminal course response.
- The course-consensus sample supplies the opposite bound. Its coherent wake
  and capture remain intact, final alignment/yaw improve to
  `0.1951/0.2761 rad/T`, and near posterior acceleration-ceiling residence is
  `72.29%`, but arrival/mean distance/score regress to
  `18.0290T/1.950783L/-0.064510`. Together with the inherited failures from
  shared course/yaw feedback and persistent posterior holds, this rules out
  another route gain, yaw-rate loop, course-error envelope, or scalar floor
  sweep.

## Single policy hypothesis

Preserve the sampled v24 odd body-frame route controller, state-feedback
anterior oscillator, posterior lag and emphasis, conserved forward mean-bend
allocation, phase-consistent reserve, half-cycle steering, and rate governor.
Keep the target-normal velocity-times-force selector, whose sampled sign and
scale predict increasing cross-course kinetic energy, but move its authority
downstream: leave the posterior wave target unchanged and withdraw only the
speed-increasing part of posterior acceleration. Reversal and deceleration
commands retain full authority, so load feedback cannot erase the traveling
wave geometry or trap the joint at the rate envelope.

The selector remains exactly inactive outside the established approach region,
when force removes target-normal kinetic energy, at rest, and on all anterior
commands. Offline replay on the sampled v24 trace leaves all `2,881` transit
samples unchanged; it affects `16.11%` of approach samples and `11.76%` of
approach samples that currently sit at the posterior acceleration ceiling,
with mean/maximum approach withdrawal `1.73%/22.56%`. These are activation
checks, not a CFD prediction. Expected evidence is the v24 transit and coherent
two-view wake with retained capture/path benefit, less posterior positive work
and ceiling residence, and recovery of terminal alignment/yaw because the
lagged target and every reversal remain intact. Falsify if transit changes,
capture or distance integral regresses materially, posterior limit residence
merely migrates, positive target-normal power is not reduced, final alignment
and yaw do not improve together, or either wake view deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body reactive propulsion
source_mechanism: preserve the traveling propulsive rhythm and posterior lag while sensory load feedback reduces only actuator work that reinforces an unwanted transverse motion
transferable_invariant: separate slow body-frame route geometry from reflection-invariant load power, and withdraw only speed-increasing posterior effort while preserving the wave target and full reversal authority
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phase, full-body kinematics, world coordinates, target location, capture radius, and task-specific routes
policy_translation: project normalized body-frame velocity and force onto the instantaneous target-line normal, smooth-gate their positive product during approach, and multiply only posterior acceleration commands aligned with posterior joint rate by bounded remaining authority
falsification: reject if pre-approach action changes, capture or distance integral worsens materially, posterior pressure migrates rather than falls, terminal path/alignment/yaw fail to improve together, reflection changes selector magnitude, reversals are weakened, or either coherent wake row deteriorates

## Lightweight validation after editing

- The mandated dedicated check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running its immutable
  checks directly found and repaired only the duplicate assigned-parent marker
  in the rendered workspace `README.md`; the guidance-materiality check then
  passed, and the solver boundary check confirms that
  `candidate_target_policy.jl` is the only solver change.
- Julia is not installed, so the executable include/action probe cannot run.
  Deterministic static checks find one definition of each public function,
  resolve all `63` direct `params.FIELD` references among the `65` fields
  returned by `target_policy_params`, confirm balanced delimiters and a
  nonempty candidate, and find no explicit elapsed time, step count, random
  source, file I/O, cylinder coordinate, target coordinate, or memorized route.
- Focused algebraic checks preserve the posterior target for every load-gate
  value, leave every non-positive joint-work command unchanged, bound positive
  posterior-work authority to `[0.60,1.0]`, and keep selector magnitude under
  lateral reflection. The sampled-trace activation figures above are offline
  contract checks only; EvE must evaluate the new CFD response after exit.
