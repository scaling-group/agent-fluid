# Closing-stride anterior rate envelope

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned-parent optimizer
  note and completed score, all four sampled policies, scores, observations,
  metrics, diagnostics, trajectories, and combined keyframe sheets, plus the
  inherited optimizer notes and completed results. Every sampled rollout is a
  finite capture from direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and no boundary or numerical
  termination. Three samples are byte-identical v31 policy reruns with exact
  trajectories, so they are determinism evidence rather than three mechanisms.
- I inspected both rows of the combined sheets from release to capture for the
  sampled v31 scalar leader and the distinct v26 regression. In the top-down
  mid-plane row, both fish self-propel from rest, turn toward the target, and
  shed the same coherent alternating reverse street without a standing wiggle,
  wake breakup, or boundary interaction. The oblique Lambda2 row shows compact
  paired three-dimensional posterior structures and no out-of-plane
  instability. The target circle enters only at the final frames. There is no
  background advection to exploit; the unresolved difference is terminal
  carrier state, not propulsion creation or route polarity.
- V31 is the sampled scalar leader at `18.0125T`, score/mean distance
  `-0.064000/1.950346L`, observed distance integral `1.336756L`, center path
  `13.2149L`, and head cross-track `0.7327L`. It crosses fast but obliquely:
  final course alignment is `0.1297`, absolute yaw is `0.8077 rad/T`, speed is
  `0.8806U`, and near posterior acceleration-ceiling residence is `75.89%`.
  V26 is identical through about `15.96T` and preserves the same wake and
  arrival class; its one-sided posterior slip feather improves path/cross-track
  to `13.2064L/0.7265L`, final alignment/yaw to
  `0.1728/0.6545 rad/T`, and near posterior ceiling residence to `74.11%`, but
  regresses score/mean distance to `-0.064149/1.950469L`.
- The assigned parent then reduced the anterior phase-plane energy setpoint
  throughout the distance-qualified approach. It retained capture, but the
  completed score regressed to `-0.064886` with a shallower `0.749256L`
  crossing. Inherited completed closing-stride tests likewise show that common
  cadence relief improves crossing yaw/alignment but regresses score, arrival,
  path, cross-track, and mean near alignment, while common amplitude relief
  scores `-0.064492`. Thus the target-relative excess-motion event is
  observable, but reducing the whole traveling carrier is the wrong channel.
  Existing evidence also rejects another shared yaw/course loop, posterior
  duty/sign variant, phase reset, persistent posterior hold, mean-bend share,
  force-power selector, headroom transfer, or generic saturation threshold.
- The remaining evidence-backed separation is joint role. Earlier posterior-
  priority allocation produced the major route-efficiency gain, while inherited
  regressions report that normalized anterior angle/rate explain about
  `99%` of raw yaw-rate variance. The v31 anterior rate still resides above
  `96%` of its limit for `15.68%` of the rollout. That supports testing whether
  late speed-increasing anterior work can be withdrawn without suppressing the
  lagged posterior propulsion channel.

## Single policy hypothesis

Start from evaluated v31 and preserve its odd body-frame route controller,
state-feedback cadence and energy pump, posterior lag/emphasis and work reserve,
v20 approach envelope, conserved v19 mean-bend allocation, course-consensus
duty surface, half-cycle steering, and reversal authority. Reuse the inherited
dimensionless closing-stride event, but route it only to the anterior joint's
speed-increasing rate governor. During a moving, misaligned approach in which
one nominal beat would close a large fraction of remaining range, continuously
move the anterior governor onset below its cruise value. Leave posterior
governor onset, target, gain, lag, cadence, amplitude, and mean bend unchanged.

This is a joint-specific energy-envelope mechanism: it clips no reversal or
speed-reducing command, selects no beat side, and does not lower the common
oscillator. It is exactly inactive outside `2.10L`, while receding or at rest,
and in the aligned capture corridor. Distance, closing speed, alignment, and
absolute normalized anterior rate are invariant under lateral reflection, so
the scheduled onset is invariant while joint states and commands reflect.

Expected evidence is v31-identical far/middle output and coherent two-view
wake, retained capture and observed-closure class, reduced anterior high-rate
residence and carrier-locked yaw, and no migration of limit pressure to the
posterior joint. Falsify if any pre-approach output changes; capture, arrival,
observed distance integral, path, or cross-track regresses materially; the
governor activates while receding or aligned; posterior propulsion or wake
coherence falls; reflection fails; or terminal alignment/yaw and non-migrating
joint residence do not improve together.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: retain a posterior-emphasized traveling propulsive wave while sensory state selectively limits excess anterior oscillator work
transferable_invariant: preserve state-derived cadence, signed mean curvature, posterior lag, and posterior authority while withdrawing only speed-increasing anterior work during an observed terminal excess-motion event
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: use nominal period times positive windowed closing speed divided by normalized remaining distance to lower only the anterior speed-increasing rate-governor onset during a moving misaligned approach; leave posterior target, governor, lag, wave gain, cadence, and mean bend unchanged
falsification: reject if transit changes, capture or observed closure regresses materially, the selector activates while receding or aligned, posterior propulsion falls, terminal alignment/yaw and non-migrating actuator residence fail to improve together, reflection fails, or either coherent wake view worsens
```

## Lightweight validation after editing

- The mandated dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. I therefore ran its
  immutable commands directly. The guidance-materiality check passes after
  removing only the duplicate copied-parent marker from the rendered workspace
  README, and the solver-boundary check passes with
  `candidate_target_policy.jl` as the only solver change.
- Julia is not installed, so the executable include/action probe cannot run.
  No CFD was attempted. Deterministic static checks find one definition of each
  public function, cover all `69` direct `params.FIELD` references with the
  `71` unique fields returned by `target_policy_params`, confirm balanced
  delimiters and a nonempty candidate, and find no explicit clock, elapsed
  time, step count, randomness, file I/O, mutable global state, cylinder input,
  fixed target coordinate, or memorized route.
- Offline replay of only the new selector on evaluated v31 leaves every sample
  at or beyond `2.10L` at the exact cruise onset. It is positive on `274/394`
  approach samples, with mean/maximum authority `0.19586/0.62640` and minimum
  scheduled anterior onset `0.87230`; because the envelope also requires
  speed-increasing acceleration above that onset, only `26/394` completed-trace
  approach samples would change. V26 and v20 give the same `26` high-rate
  samples, authority means `0.19419/0.19708`, and minimum onsets
  `0.87386/0.87200`. Focused cases confirm exact inactivity outside the
  approach, without positive closure, and in the aligned corridor. One
  thousand randomized simultaneous-reflection cases preserve onset magnitude
  and reverse the governed command exactly. These are selector, contract, and
  reachability checks on completed traces, not claims about the pending CFD
  response.
