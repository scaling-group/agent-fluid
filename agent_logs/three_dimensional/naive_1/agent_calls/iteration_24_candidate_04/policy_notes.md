# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four assigned samples satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. I
  inspected every assigned combined sheet and the inherited broadside-reserve
  capture and posterior-allocation failure sheets, then cross-checked both
  visual rows against scores, diagnostics, trajectories, executable policy
  hashes, assigned-parent guidance, and inherited optimizer notes.
- The two assigned executable-identical half-cycle redistribution rollouts
  develop a body-attached alternating top-down street that bends toward the
  target and compact caudal Lambda2 structures through first crossing. They
  capture at `18.8265--18.8815T`, reproduce the best sampled mean-distance
  band (`2.08855--2.08896L`), and remain in the carrier demand/load class:
  anterior/posterior acceleration contact is `60.85--61.00%`/`72.97--73.27%`,
  rate contact is `11.01--11.07%`/`14.88--14.93%`, peak planar force
  coefficient is `0.03066--0.03171`, and peak yaw-moment coefficient is
  `0.01603--0.01632`. These are coherent self-propelled captures, not imposed
  advection or actuator relief.
- That executable carrier is not semantically robust across all inherited
  evidence. A third inherited execution captures at `18.7110T` but has mean
  distance `2.09622L`, outside the two-repeat low-integral band, and the
  assigned guidance records an executable-equivalent near miss at `0.81206L`
  followed by a left exit. Thus the lower integral is useful allocation-local
  evidence, not a guarantee of capture.
- Two independent broadside mean-curvature-reserve architectures on the
  geometry-scheduled carrier also retain capture and both coherent wake rows.
  The latest sampled reserve reaches `0.74659L` at `18.7055T`, mean distance
  `2.09386L`, and remains inside the established contact/load class
  (`60.84%`/`73.04%` acceleration contact, `10.85%`/`14.67%` rate contact,
  peak planar force `0.03275`, peak yaw moment `0.01704`). Its body-frame gate
  first activates at `17.7045T` and `1.5945L`; absolute lateral target
  fraction peaks at `0.6484` and falls to `0.1851` at capture while forward
  fraction is `0.9827`. This proves ordinary-capture compatibility and actual
  pre-capture activation, but not recovery from the inherited redistribution
  miss or a score improvement.
- The inherited posterior-allocation failure provides the semantic visual
  contrast missing from the assigned all-capture batch. Its top-down wake
  remains energetic and its oblique caudal structures remain compact, yet the
  fish bends below and away, reaches only `3.92476L`, and exits left at
  `26.213T`. Wake coherence alone is therefore not route correctness, and the
  present candidate must leave the two-joint traveling wave and both
  target-signed curvature shares intact.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish mean-curvature steering
source_mechanism: a large observed direction error gates a bounded curvature reserve while the propulsive traveling rhythm and response-based release remain active
transferable_invariant: normalized body-frame target geometry may add temporary pre-overshoot mean-curvature authority without changing turn sign or replacing the traveling wave
nontransferable_details: published gains, species-specific C-start shapes, robot geometry, dimensional cadence, prescribed beat phase, exact vortex phase, and task-specific routes
policy_translation: retain the sampled half-cycle redistribution carrier and add the sampled smooth forward-qualified broadside reserve outside the saturated route argument to both established target-signed curvature shares through the existing non-inverting response release
falsification: reject if capture or either coherent wake row is lost, the same near-miss-to-left-exit topology recurs, mean distance loses the carrier benefit without a semantic route improvement, or actuator contact and planar loads materially exceed their sampled bands
```

## Single-candidate policy hypothesis

Add exactly one broadside curvature-reserve mechanism to the prefilled
half-cycle redistribution carrier. Use the evaluated reserve schema from
`solver_de4c121e5685`: a smooth normalized body-lateral gate from `0.55` to
`0.90`, qualified by normalized forward target fraction, supplies at most a
`0.20` additive target-signed curvature request after the route `tanh`. Apply
the existing correcting-yaw release to this reserve, then preserve the same
anterior/posterior bias ratio, displacement-only half-cycle steering,
common-envelope redistribution, posterior lag, damping, and exact final
acceleration projection.

This is one observation-gated feedback addition, not scalar-only carrier gain
tuning. It combines two individually capture-compatible mechanisms whose roles
are distinct: redistribution improves sampled far/middle distance integral,
whereas the reserve supplies pre-overshoot authority outside a saturated route
argument. No clock, world coordinate, target identity, memorized route,
instantaneous velocity residual, posterior-specific allocation, terminal
release, or pointwise rate barrier is introduced. Formal CFD runs only after
this worker exits; accept the pairing only if capture and both wake views
survive, then judge whether route topology or robustness improves before
crediting its scalar score.
