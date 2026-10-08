# Target-normal anterior half-cycle rate envelope

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned-parent policy,
  optimizer note, completed score, observation, metrics, diagnostics, and
  trajectory, plus all four sampled solver policies and results. Every rollout
  is a finite capture from direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and no boundary or numerical
  termination. Three sampled v31 policies are byte-identical reruns with the
  exact `18.0125T`, `-0.064000`, and `1.950346L` mean-distance trajectory, so
  they establish determinism rather than three mechanisms. The distinct v20
  yaw-power selector captures at `18.0070T` and scores `-0.064028` but has
  worse final alignment, yaw, and posterior ceiling residence.
- I inspected the combined keyframe sheets for sampled v31, sampled v20, and
  assigned-parent v38 from release through capture, including both the
  top-down mid-plane vorticity row and oblique Lambda2 row. In all three, the
  fish visibly self-propels from the quiescent release, turns toward the
  target, and sheds a coherent alternating reverse street with compact paired
  three-dimensional posterior structures. There is no passive advection,
  reciprocal standing wiggle, wake collapse, boundary interaction, or
  out-of-plane instability. Their sheets are effectively indistinguishable at
  the sampled resolution; trajectory and actuator histories, not vortex
  appearance, distinguish the terminal mechanisms.
- Sampled v31 is the closure/scalar reference: center path and maximum head
  cross-track are `13.2149L/0.7327L`, final course alignment/speed/absolute yaw
  are `0.1297/0.8806U/0.8077 rad/T`, and near acceleration-ceiling residence is
  `69.29/75.89%` for the anterior/posterior joints. Its crossing is fast but
  oblique, and normalized anterior angle/rate explain about `99%` of raw-yaw
  variance in inherited comparisons.
- The assigned v38 parent routed a dimensionless closing-stride event to only
  the anterior speed-increasing rate envelope. It retained capture and the
  coherent two-view wake, lowered near anterior rate residence above `96%`
  from `15.99%` to `13.92%`, improved final alignment from `0.1297` to
  `0.1957`, and reduced absolute final yaw from `0.8077` to
  `0.3716 rad/T`, without migrating acceleration-ceiling residence posteriorly
  (`75.89%` to `75.70%`). But it delayed capture to `18.0180T`, regressed mean
  distance/score to `1.951162L/-0.065002`, crossed more shallowly at
  `0.749383L`, and did not materially change path or cross-track. Thus the
  anterior rate envelope is a real terminal damping channel, but a phase-free
  closing-stride selector withdraws useful closure as well as excess motion.
- Inherited v26 supplies the phase-selection clue. Its target-normal slip times
  summed-joint-rate selector improved final alignment/yaw, path/cross-track,
  and posterior ceiling residence relative to v20, although placing relief on
  the posterior wave slightly regressed score. Completed balanced posterior
  duty, phase reset, load-power, shared yaw/course, common carrier, and
  response-triggered mean-bend variants do not improve closure and terminal
  state together. The untested separation is to keep v31's posterior
  propulsion untouched while applying the evidenced slip/phase relationship
  only to the yaw-dominant anterior rate envelope.

## Single policy hypothesis

Start from evaluated v31 and preserve its odd body-frame route controller,
state-feedback cadence and energy pump, posterior lag/emphasis and work
reserve, v20 approach envelope, conserved v19 mean-bend allocation,
course-consensus posterior duty surface, half-cycle steering, and full
reversal authority. During only a positively closing, moving, misaligned
approach, resolve body velocity normal to the instantaneous head-to-target
line and compare its sign with normalized anterior joint rate. If the signs
agree, the observed anterior half-cycle reinforces cross-course motion;
smoothly advance only that joint's speed-increasing rate governor. Leave the
opposing half-cycle, every speed-reducing/reversal command, and all posterior
commands unchanged.

This is a phase-selective energy-envelope mechanism, not a scalar onset tune.
Target-normal velocity and anterior joint rate both reverse under lateral
reflection, so their product and scheduled onset are invariant while the
joint command reflects. The selector is exactly inactive outside `2.10L`,
without positive target closure, at zero cross-course motion, on the opposing
half-cycle, and in the aligned capture corridor. Offline replay on sampled v31
gives positive phase authority on `205/394` approach samples and identifies
`45` speed-increasing high-rate samples that could change; the scheduled onset
never falls below about `0.896` of the physical rate limit despite retaining
v38's bounded `0.82` floor parameter. These are reachability checks, not CFD
evidence.

Expected evidence is v31-identical far/middle action and coherent two-view
wake, retained capture and observed-closure class, v38-like improvement in
anterior high-rate residence and terminal yaw/alignment, but less arrival and
distance-integral loss because the cross-course-opposing anterior half-cycle
remains untouched. Falsify if any pre-approach output changes; the selector
acts while receding, aligned, or on the opposing phase; capture, arrival,
observed distance integral, path, or cross-track regresses materially; terminal
slip/alignment/yaw and anterior residence fail to improve together; actuator
pressure migrates posteriorly; reflection fails; or either coherent wake view
worsens.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control, half-cycle asymmetric turning, and elongated-body reactive propulsion
source_mechanism: preserve a posterior-emphasized traveling propulsive wave while sensory state limits only the anterior stroke half-cycle that reinforces lateral target error
transferable_invariant: separate slow body-frame route geometry from reflection-invariant slip-by-joint-phase selection, retain posterior lag and authority, and withdraw only speed-increasing anterior work on a counterproductive half-cycle
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: project normalized body velocity onto the instantaneous target-line normal, multiply its bounded sign by normalized anterior joint rate, and use only their positive product during a positively closing misaligned approach to advance the anterior speed-increasing rate envelope
falsification: reject if transit changes, the selector acts while receding or on the opposing half-cycle, capture or observed closure regresses materially, terminal slip/alignment/yaw and anterior residence do not improve together without posterior pressure migration, reflection fails, or either coherent wake row deteriorates
```

## Lightweight validation after editing

- The mandated dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. I ran its immutable
  commands directly. The guidance-materiality check passes, and the boundary
  check passes with `candidate_target_policy.jl` as the only solver change.
- Julia is not installed, so the executable include/action probe cannot run.
  No CFD was attempted. Deterministic static checks find one definition of
  each public function, cover all `68` direct `params.FIELD` references with
  the `70` unique fields returned by `target_policy_params`, confirm balanced
  delimiters and a nonempty candidate, and find no explicit time, elapsed time,
  step count, randomness, file I/O, mutable global state, cylinder input, fixed
  target coordinate, or memorized route.
- Offline replay of only the new selector on evaluated v31 confirms the note's
  `205/394` positive-authority and `45` potentially changed approach samples.
  Mean/maximum authority are `0.082172/0.457963`, minimum scheduled onset is
  `0.895885`, and the potential action window is `15.8510T--17.9025T`.
  Focused cases are exactly inactive outside approach, while receding, at zero
  target-normal slip, on the opposing half-cycle, and in the aligned corridor.
  Ten thousand randomized simultaneous lateral reflections preserve authority
  and onset to machine precision while reversing both signed selector inputs.
  These are reachability, boundedness, and symmetry checks on completed data,
  not claims about the pending v39 flow response.
