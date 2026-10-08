# Yaw-power-selective terminal posterior relief

## Visual and quantitative diagnosis before editing

- I read the workspace and inherited guidance, all four sampled solver scores,
  observations, metrics, diagnostics, trajectories, and policies, plus the
  assigned parent's policy, optimization notes, and completed rollout. All
  current examples use direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination.
- I inspected both the top-down vorticity and oblique Lambda2 sheets for the
  sampled v16 leader, the episode-equivalent v12 comparator, and the assigned
  parent's v19 result. All three visibly self-propel from rest, retain a
  coherent alternating top-down street and compact three-dimensional posterior
  structures through capture, and show no passive advection, boundary event,
  wake breakup, or out-of-plane instability. The remaining distinction is
  terminal motion and allocation, not wake existence.
- Three sampled v12/v15 rollouts are exact-policy repeats at `18.0125T` and
  `-0.064599`; they are determinism evidence rather than three mechanisms. The
  v16 alignment-qualified posterior-wave envelope captures at `18.0235T` and
  improves path/head cross-track from `13.2330L/0.7417L` to
  `13.2111L/0.7232L`, near/final course alignment from `0.6637/0.0678` to
  `0.6722/0.1818`, and near/final absolute yaw from
  `1.9970/1.0891` to `1.8883/0.4200 rad/T`, with the best sampled score
  `-0.064545`.
- The assigned parent's v19 longitudinal mean-bend allocation preserves v16's
  arrival and both coherent views, shortens path/head cross-track again to
  `13.2086L/0.7207L`, raises final alignment to `0.1957`, lowers final yaw to
  `0.2875 rad/T`, and slightly reduces both joints' rate and acceleration-limit
  residence. It is a useful terminal-allocation result, but not a scalar-score
  improvement: mean distance rises from `1.950801L` to `1.950985L` and score
  regresses to `-0.064778`. Final speed remains `0.8456U` and course-sine
  magnitude remains `0.9807`, so capture still occurs with large lateral
  momentum.
- On the v16 and v19 approach traces, normalized hydrodynamic moment has
  correlation `0.971`--`0.973` with the following measured yaw acceleration.
  Its product with yaw rate is positive on about half the approach samples;
  positive-power values have a 90th percentile near `0.0123`. The current v16
  envelope suppresses posterior oscillation during high absolute yaw whether
  the measured moment is injecting or removing rotational energy. This gives a
  measured sign and scale for testing selective relief without adding another
  course-error or yaw-rate request, both of which inherited evidence rejects.

## Single policy hypothesis

Start from the completed v19 parent and preserve its odd body-frame curvature
map, state-feedback carrier, posterior lag/emphasis and phase-consistent work
reserve, route controller, alignment-qualified approach envelope, conserved
forward shift of mean steering, half-cycle steering, and reversal-preserving
rate governor. Add one selector to the existing terminal posterior-wave relief:
form normalized yaw power from `turn_rate_recent * moment_z_L2`, smoothly gate
only its positive part at the rollout-calibrated scale, and withdraw posterior
wave excursion only while the measured hydrodynamic moment is increasing the
magnitude of current yaw. When moment opposes yaw, retain the posterior wave so
its damping/propulsive half-cycle is not cancelled.

The selector is multiplied by the existing approach, misalignment, and yaw
gates, so it is exactly inactive outside `2.10L`; it changes neither the route
request nor the longitudinal mean-bend allocation. Because lateral reflection
flips both yaw and moment, their product and the selector are reflection
invariant. Expected evidence is unchanged pre-approach closure and two-view
wake coherence, v19-or-better capture/path, less terminal yaw injection, and
recovery of some v16 distance integral by preserving the non-injecting
posterior half-cycle. Falsify the mechanism if transit changes, capture or
score regresses materially, yaw/alignment do not improve together, positive
yaw work or loads increase, the wake becomes one-sided or incoherent, or
reflection changes gate magnitude.

bookshelf_consulted: true
source_domain: robotic-fish half-cycle steering and wake/load-feedback control
source_mechanism: modulate only the dynamically harmful part of an oscillatory stroke instead of suppressing both half-cycles or cancelling all lateral motion
transferable_invariant: preserve a traveling posterior wave while withdrawing work selectively when an observed signed load is adding energy to an unwanted body rotation
nontransferable_details: published gains, species-specific envelopes, dimensional cadence, exact vortex phase, full-body joint distributions, world coordinates, and task-specific routes
policy_translation: use the reflection-invariant positive product of normalized body yaw rate and normalized hydrodynamic yaw moment to gate the already validated approach-only posterior-wave relief; preserve the complete two-joint carrier, target request, and mean-bend allocation
falsification: reject if pre-approach behavior changes, capture or distance integral worsens, terminal yaw and alignment do not improve together, actuator or force/moment loads rise, reflection fails, or either coherent wake view deteriorates

## Lightweight validation after editing

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported by this account. I therefore ran its
  immutable commands directly. The guidance check initially exposed two
  identical assigned-parent markers in the rendered `README.md`; removing only
  the duplicate listing left the selected parent unchanged, and the rerun
  passes. The solver boundary check also passes with
  `candidate_target_policy.jl` as the sole solver difference.
- Julia is not installed or discoverable, so the executable include/action
  probe could not run. The deterministic static guard passes: all `64` direct
  `params.FIELD` references resolve among the `66` fields returned by
  `target_policy_params`, both public functions occur exactly once, the
  candidate is nonempty, delimiters balance, and no clock, randomness, file
  I/O, cylinder coordinate, or world-route input appears.
- Replaying only the new selector on the completed v19 trajectory makes it
  exactly zero at and beyond `2.10L`; simultaneous reflection of yaw and moment
  leaves its magnitude unchanged. Inside approach, positive-power relief is
  active on `37.63%` of samples. Mean/max posterior relief changes from the
  parent's symmetric `0.2435/0.6250` to `0.0877/0.6093`, corresponding to
  mean/min posterior-wave authority `0.9649/0.7563`. These are contract and
  activation checks, not CFD evidence; EvE must evaluate the trajectory and
  wake hypothesis after this worker exits.
