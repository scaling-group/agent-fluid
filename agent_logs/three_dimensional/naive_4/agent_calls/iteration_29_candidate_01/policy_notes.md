# Forward-speed-gated posterior-emphasis replication candidate

## Evidence diagnosis before the policy edit

- The assigned prefill and three sampled controls share policy SHA-256
  `650a2d0d74c0edd84a42a13119a7df8a6eafbe4dbed2b73256434fb2dbb2e6e2`.
  They also share the combined-sheet SHA-256
  `c36dbb9685d5d1640376c1b3a97371d0152ca379974f4496819c96593437e72c`
  and reproduce capture at `16.054371T`, final/minimum distance
  `0.745845616L`, distance integral `1.929839552L`, 2,919 steps, 239
  moving-window shifts, and score `-0.046899933`. All report direct uniform
  still-water initialization, `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm artifact.
- The only distinct sampled policy, `solver_07403e1ebc74`, adds one bounded
  body-forward-speed gate that temporarily emphasizes the posterior traveling
  wave. It captures at `15.977511T`, reaches `0.744402707L`, lowers the
  distance integral to `1.928580797L`, uses 2,905 steps and 238 shifts, and
  scores `-0.045506315`. This is an evaluated improvement over the assigned
  parent, but it has only one sampled rollout while the control has three
  byte-identical replications.
- I inspected both combined sheets from release through capture. In each
  top-down row, the release disturbance develops into an organized alternating
  wake by the `4T` frame and the fish follows a finite, smooth target-directed
  arc; the distinct policy retains the same qualitative wake and route rather
  than being passively advected. In each oblique body/Lambda2 row, compact
  caudal structures remain coherent without wake collapse, collision,
  virtual-boundary exit, or out-of-plane instability. The terminal difference
  is below sheet resolution, so the score and trace—not vortex appearance—are
  the evidence for improvement. No failed-termination keyframe sheet is
  present among the current samples; the assigned-parent capture is the most
  informative visual control, and inherited failures are used only as logged
  trajectory evidence.
- The trace does not justify a stronger scalar. Relative to the assigned
  parent, the distinct policy reaches `12L` `0.0055T` earlier and `1.25L`
  `0.0385T` earlier, but reaches `8L` and `6L` about `0.0165T` and `0.0110T`
  later, with the `10/4/2L` milestones unchanged at trace resolution.
  Posterior acceleration-limit residence rises from `21.79%` to `22.58%`,
  posterior speed-limit residence from `5.86%` to `6.30%`, and peak lateral
  force from `0.03239` to `0.03334`, although posterior peak excursion falls
  from `36.43` to `33.12 deg` and peak moment remains about `0.0190`.
- The inherited optimizer note proposed this branch after four replicated
  terminal controllers and verified on recorded parent states that it changed
  only feasible posterior action over the low-speed interval. The new CFD
  result confirms that the branch produces physical trajectory diversity and
  a better capture, while the mixed milestones and modest limiting/load cost
  argue for exact replication before any headroom wrapper, onset adjustment,
  or gain escalation. Earlier inherited pre-limit guards already showed that
  apparently benign actuator relief can accumulate into a longer path.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: allocate posterior traveling-wave authority from measured propulsive response while preserving the anterior rhythm and directional bend
transferable_invariant: a lagged posterior wave can receive bounded extra authority while normalized body-frame forward translation is weak, then return continuously to the established carrier as the measured response develops
nontransferable_details: published thrust laws and gains, species-specific kinematics, dimensional frequency or amplitude, exact Strouhal values, clock-defined burst duration, exact vortex phase, and task-specific routes
policy_translation: promote the sampled mechanism unchanged; outside approach proximity, smoothly scale only the posterior traveling-wave target from normalized body-frame forward-speed deficit, with unit gain after recovery and no change to anterior drive, navigation, terminal roles, or actuator projections
falsification: reject the mechanism as non-reproducible if the coherent two-view wake or capture is lost, arrival and distance integral revert to or underperform the control, or posterior limiting and lateral load rise without retaining the terminal improvement

## One candidate hypothesis

Replace the assigned-parent policy with an exact source-level copy of the one
evaluated forward-speed-gated posterior-emphasis mechanism. While normalized
body-frame forward speed is at or below `0.10U`, it increases only the
posterior traveling-wave target by at most 25%; the increment fades smoothly
to zero by `0.35U` and is suppressed continuously by approach proximity. The
gate contains no time, route, world-position, target identity, or external
phase signal. Every established anterior, steering, redirect, approach,
terminal response, mean-first allocation, and exact-boundary projection branch
remains unchanged.

This is deliberately a replication candidate rather than a scalar retune or a
second mechanism. The falsifiable expectation is reproduction of the distinct
sample's coherent alternating wake and finite target-directed route, with
capture near `15.98T`, a distance integral below the assigned parent's
`1.92984L`, and no material limiting/load growth beyond the already observed
cost. A return to the parent's `16.054T` trace or loss of capture would show
that the single positive sample should not be promoted. No outcome for this
candidate is claimed before EvE's post-exit CFD evaluation.

## Non-CFD verification after the edit

- The candidate SHA-256 is
  `f915d466444cf8efad27707431c558749510254354be3998c294348dbb001f25`
  and it is byte-identical to the evaluated distinct sample. This verifies
  exact mechanism promotion rather than an unrecorded retune.
- The deterministic schema audit resolves all 51 direct `params.FIELD`
  references against exactly 51 fields returned by `target_policy_params()`,
  with no missing or unused returned field. The lightweight Julia contract
  call returns two finite accelerations, and the solver editable-boundary
  check passes.
- The configured checker was invoked, but its pinned `gpt-5.4-mini` model is
  unsupported for this account. Its three prescribed commands were therefore
  run directly and separately. The material-guidance check initially exposed
  two identical assigned-parent markers in the rendered `README.md`; removing
  only the duplicate listing preserved the same parent and made the check pass.
  No CFD was run.
