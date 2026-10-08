# Terminal steering-headroom allocation

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, all four sampled solver scores,
  observations, metrics, diagnostics, trajectories, and policies, plus the
  assigned-parent optimizer notes and its now-completed v34 evaluation. Every
  examined rollout is a finite capture from direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and no boundary or numerical
  termination.
- I inspected the combined sheets for the sampled v31 scalar leader, the v26
  slip-synchronous regression, and the assigned-parent v34 result, including
  the top-down mid-plane vorticity and oblique Lambda2 rows from release to
  capture. All three visibly self-propel from rest, turn toward the target,
  retain a coherent alternating reverse wake and compact three-dimensional
  posterior structures, and show no passive advection, standing wiggle, wake
  breakup, boundary interaction, or out-of-plane instability. V34 has no
  visible wake-topology advantage over v31. The remaining distinction is
  terminal control allocation rather than propulsion creation.
- V31 is the sampled scalar leader at score/mean distance
  `-0.064000/1.950346L`, but its observed distance integral `1.336756L` is
  worse than v20's `1.336706L` and v25's `1.336693L`. It captures at
  `18.0125T` with center path `13.2149L`, final alignment `0.1297`, absolute
  yaw `0.8077 rad/T`, and near anterior/posterior acceleration-ceiling
  residence `69.29/75.89%`. Its small score edge partly comes from the
  discrete capture and terminal-hold terms, not a broadly improved approach.
- V26's one-sided slip feathering preserves the same two-view wake and improves
  final alignment/yaw to `0.1728/0.6545 rad/T`, path to `13.2064L`, and near
  posterior ceiling residence to `74.11%`, but regresses score/mean distance
  to `-0.064149/1.950469L`. The inherited balanced-duty and phase-reset tests
  also regress. Thus posterior wave suppression, redistribution, or phase
  changes are already bounded negative directions despite some terminal-state
  improvement.
- The assigned parent added response-triggered forward mean-bend allocation to
  v31. Its pre-evaluation replay reported activity on `220/394` approach
  samples and mean/maximum extra anterior share `0.0190/0.0873`; the completed
  CFD then regressed score/mean distance to `-0.064408/1.950675L` while leaving
  arrival/path, final alignment/yaw, and near posterior ceiling residence
  essentially at v31 (`18.0125T`, `13.2152L`, `0.1292/0.8088 rad/T`, and
  `75.89%`). The coherent wake was retained. This falsifies short-window
  bearing-centering as a useful slow event for another mean-bend share and
  gives no basis for increasing that share.
- The remaining evidenced mismatch is actuator-specific: v31 spends more of
  the approach at the posterior acceleration ceiling than the anterior one,
  while the evaluated v19 longitudinal allocation shows that moving steering
  work forward can improve terminal yaw without destroying the posterior
  traveling wake. Unlike v34, the direct half-cycle steering acceleration is
  still tail-heavy (`head_turn_share=0.70`, `tail_turn_share=1.00`) and is not
  allocated by current joint headroom before the independent hard clamp.

## Single policy hypothesis

Start from evaluated v31 and preserve its odd body-frame route controller,
state-feedback anterior oscillator, posterior lag and emphasis, phase-consistent
reserve, v20 envelope, conserved v19 mean-bend allocation, bounded duty ratio,
cadence, and reversal-preserving rate governor. Add one terminal control-
allocation mechanism only: during the already defined moving, misaligned
approach, detect when the current tail steering increment would increase the
magnitude of a near-ceiling posterior acceleration. Move a bounded part of
that increment to the anterior joint only while the anterior predicted
acceleration and signed rate have headroom. Subtract exactly the moved amount
from the tail increment, so the summed direct steering request is conserved.

This does not scale or suppress the posterior carrier, alter its phase lag, or
change the mean tangent. It is exactly inactive outside the approach, when
tail steering relieves rather than increases acceleration load, when the tail
is below the normalized pressure onset, or when the anterior joint lacks
directional acceleration/rate headroom. Under lateral reflection all joint
states, drive accelerations, and steering increments reverse while normalized
pressures and the allocation magnitude remain invariant, so both final joint
commands reverse.

Expected evidence is v31-identical far/middle action and coherent two-view
wake, retained capture and observed-distance-integral class, with less clipped
posterior steering, no migration into anterior limit residence, and joint
improvement in terminal path, alignment, and yaw. Falsify if any pre-approach
output changes; the direct steering sum is not conserved; posterior cadence,
lag, wave target, or total mean tangent changes; capture or observed closure
regresses materially; limit residence merely migrates anteriorly; terminal
alignment and yaw do not improve together; reflection fails; or either wake
view deteriorates.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish steering
source_mechanism: retain the lagged posterior traveling wave for thrust while sensory feedback assigns more steering work to the anterior body when posterior actuation is constrained
transferable_invariant: preserve the propulsive carrier, cadence, lag, and net bounded steering request while redistributing only steering work according to normalized joint headroom
nontransferable_details: published gains, dimensional cadence, species-specific body envelopes, robot linkage geometry, exact vortex phases, full-body CPG topology, world coordinates, and task-specific routes
policy_translation: use approach authority plus normalized predicted joint acceleration and rate headroom to transfer only tail load-increasing steering acceleration to the anterior joint, subtracting the identical increment from the tail
falsification: reject if transit changes, the posterior carrier or mean bend changes, capture or closure regresses materially, pressure migrates anteriorly, alignment and yaw fail to improve together, reflection fails, or either coherent wake view worsens
```

## Lightweight validation after editing

- The mandated dedicated checker was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account. Running its immutable checks directly
  gives `PASS` for guidance materiality and `PASS` for the solver boundary.
  Julia is not installed, so the executable include/action smoke probe could
  not run. No CFD was attempted.
- Deterministic static checks find one definition of each public function,
  resolve all `68` direct `params.FIELD` references among the `70` fields
  returned by `target_policy_params`, confirm balanced delimiters and exactly
  one nonempty `candidate_target_policy.jl` under `solver/`, and find no hidden
  clock, step counter, randomness, file I/O, cylinder coordinate, or memorized
  route input.
- One hundred thousand deterministic algebraic probes of the new allocator
  pass exact pre-approach inactivity, conservation of the summed direct
  steering increment, bounded transfer, and lateral-reflection symmetry. The
  allocator activated on `18,095` broad synthetic pressure/headroom probes;
  these are contract and reachability checks, not claims about the pending CFD
  response.
