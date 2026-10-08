# Terminal hydrodynamic-moment rejection candidate

## Visual and quantitative diagnosis before editing

- Every sampled rollout and inherited completed follow-up is contract-valid:
  direct uniform still water with `U_infinity=(0,0,0)`, no prewarm, no
  cylinders, and capture. I inspected the top-down vorticity and oblique
  Lambda2 sheets for the sampled-leading posterior envelope and the inherited
  desired-yaw-rate regression. Both show genuine self-propulsion from rest, a
  coherent alternating wake, and compact three-dimensional posterior
  structures through capture. There is no passive advection, collision, wake
  breakup, domain exit, or out-of-plane instability. Their visible routes are
  nearly indistinguishable, so terminal state and load histories, not gross
  wake existence, discriminate the controllers.
- The sampled-leading alignment-qualified posterior envelope captures at
  `18.0235T` with score `-0.064545`, center path `13.2111L`, near/final course
  alignment `0.6722/0.1818`, and near/final absolute yaw
  `1.8883/0.4200 rad/T`. It is exactly inactive before the `2.10L` approach and
  improves all four terminal quantities over the phase-consistent parent while
  preserving the same transit and wake. This candidate therefore starts from
  that evaluated policy rather than the prefilled episode-equivalent v12.
- Three completed attempts to turn the remaining signed course error into a
  desired-yaw-rate reference or rate-error correction all captured but scored
  below the envelope leader: `-0.064995`, `-0.064888`, and `-0.064862`. The
  latter two shorten path only to `13.2040L` and `13.2101L` while reducing
  final alignment to `0.1505/0.1547` and increasing final absolute yaw to
  `0.7306/0.6323 rad/T`. Together with the earlier direct-curvature residual
  and course-persistent envelope regressions, this is evidence against another
  terminal course scalar, desired-rate blend, or posterior-amplitude hold.
- The sampled-leading trajectory instead exposes a fast observable not used by
  those variants. Below `2.10L`, normalized hydrodynamic moment has RMS
  `0.00840` and correlation `0.9595` with centered yaw acceleration, while its
  correlation with yaw rate is only `-0.2225`. The moment therefore identifies
  beat-scale angular acceleration before it accumulates into course motion.
  A gate requiring moment and yaw to have the same sign isolates the `37.6%`
  of approach samples in which the measured load is increasing current yaw
  magnitude, rather than cancelling useful deceleration.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: wake-disturbance rejection and sensor-modulated robotic-fish direction control
source_mechanism: retain the slow target-directed propulsive controller while a small bounded residual rejects fast observed crossflow, force, or yaw-moment disturbances
transferable_invariant: persistent target geometry and beat-scale hydrodynamic yaw acceleration require separate feedback paths; reject only measured moment that reinforces current yaw, and continuously release the rejection when the load becomes restorative
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, cylinder-wake timing, full-body oscillator networks, and task-specific routes
policy_translation: preserve the sampled-leading two-joint traveling wave and terminal posterior envelope; inside the normalized approach only, form a reflection-invariant reinforcement gate from bounded `moment_z_L2` and `turn_rate_recent`, then add an odd opposite-moment correction through the established same-signed steering/yaw channel
falsification: reject if any pre-approach output changes, capture or the sampled-best score and mean distance are lost, terminal yaw/alignment/path fails to improve, acceleration residence migrates without benefit, reflection equivariance fails, or either coherent wake view deteriorates

## One-candidate policy hypothesis

Use the moment coefficient at its measured approach RMS as the normalization,
not as a copied literature gain. Smoothly multiply its signed bounded response
by approach depth, poor course alignment, and the positive product of bounded
moment and yaw responses. The resulting correction is exactly zero outside
`2.10L`, at zero moment, at zero yaw, and whenever moment opposes the current
turn. Its sign is opposite the measured moment on the established same-signed
steering/yaw channel, so it opposes the reinforcing load without adding
another course-error-to-curvature or course-error-to-yaw reference.

Replayed on the sampled leader, a `0.75` maximum request gain activates in
`37.6%` of approach samples, has mean absolute authority `0.0274` and maximum
`0.1896` versus `1.3572` RMS inherited turn request, and remains exactly zero
before approach. This is deliberately a small fast residual, not a replacement
gait or scalar retune. Expected evidence is unchanged transit and two-view wake,
retained capture/mean distance, and reduced terminal yaw-acceleration excursions
with no loss of the envelope leader's alignment and path gains.

## Lightweight validation after editing

- The required dedicated check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running its immutable
  checks directly gives PASS for the material reusable-guidance update and the
  repository boundary; the latter confirms that the candidate policy is the
  only solver difference. I removed one duplicate assigned-parent marker from
  the rendered workspace `README.md`; the same parent remains selected.
- Julia is not installed or discoverable, so the exact include/action probe
  cannot run in this shell. The deterministic schema guard passes: all `63`
  direct `params.FIELD` names resolve among `65` unique returned fields, both
  public functions occur exactly once, the candidate is nonempty, and raw
  delimiter counts balance. No clock, step counter, random source, mutable
  global, cylinder coordinate, target identity, or world-frame route appears.
- A direct diff against the sampled-leading policy contains only the new
  normalized moment parameters/residual, removal of its dormant zero-gain
  moment expression, and explanatory metadata. Focused algebraic probes make
  the residual exactly zero outside approach, at zero moment, at zero yaw, and
  when moment opposes yaw. Mirroring moment and yaw flips a representative
  residual from `+0.318769` to `-0.318769` with unchanged magnitude. These are
  contract and mechanism checks, not CFD evidence; EvE must evaluate the
  trajectory hypothesis after this worker exits.
