# Terminal target-course yaw-rate tracking

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance, the inherited optimizer notes and
  completed scores, all four sampled policies, scores, observations, metrics,
  diagnostics, and trajectories, and both the top-down vorticity and oblique
  Lambda2 rows of every sampled combined keyframe sheet. All evidence is
  contract-valid: each rollout starts directly from uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, and no cylinders.
- All four samples are stable captures with the same gross physical behavior.
  The fish self-propel from rest; the top-down sheets develop a coherent,
  advecting alternating street and the oblique sheets retain compact
  three-dimensional posterior structures through capture. There is no passive
  advection, collision, wake breakup, or out-of-plane instability. The useful
  discriminator is therefore terminal route state rather than wake existence.
- The sampled alignment-qualified posterior-envelope leader scores
  `-0.064545`, has mean distance `1.950801L`, and captures at `18.0235T`.
  Inherited analysis shows that it preserves the leading transit exactly and,
  versus the episode-equivalent phase-reference baseline, shortens center path
  from `13.2330L` to `13.2111L`, raises final course alignment from `0.0678`
  to `0.1818`, and reduces final absolute yaw from `1.0891` to
  `0.4200 rad/T`. Yet its terminal course sine reaches `0.9833`, so it still
  crosses with substantial lateral velocity rather than settling on course.
- The assigned signed-course-residual parent is an informative negative result.
  Adding course error directly to mean turn preserved capture and the two-view
  wake but regressed score/mean distance to `-0.064645/1.950875L`, changed
  arrival to `18.0180T`, reduced final alignment to `0.1640`, and increased
  final absolute yaw to `0.5884 rad/T`. A direct course-to-curvature command
  can continue reinforcing the selected turn side after the body has already
  reached or exceeded a useful angular response.

## Single policy hypothesis

Start from the sampled-leading alignment-qualified posterior envelope,
including its odd target-to-curvature map, anterior state-feedback oscillator,
posterior lag/emphasis, phase-consistent reserve, far/middle route observer,
approach handoff, half-cycle steering, and reversal-preserving rate governor.
Replace only the failed direct terminal course-to-curvature residual with one
bounded desired-yaw-rate loop. Inside the established normalized approach
region and only with measured motion, map the signed body-frame target/velocity
cross product to a desired turn rate, compare it with observed recent turn
rate, and feed back the bounded rate error after ordinary approach attenuation.

This gives signed course authority before the body responds, but reverses into
braking once measured yaw exceeds the course-selected rate. It is exactly
inactive outside `2.10L` and at rest, remains odd under lateral reflection, and
does not alter the validated transit wave, cadence, posterior envelope, or mean
curvature map. The expected signature is unchanged pre-approach closure and
wake class, retention of capture and sampled-best mean distance, and higher
terminal alignment with lower yaw and no route widening. Falsify it if any
pre-approach trajectory changes, capture or mean-distance performance is lost,
terminal path/alignment/yaw fails to improve, acceleration pressure migrates
without benefit, reflection symmetry fails, or either wake view deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and continuous terminal capture staging
source_mechanism: modulate a propulsive oscillator with closed-loop direction feedback, then damp terminal yaw without suppressing the transit carrier
transferable_invariant: signed course error should define a bounded desired angular response whose error is closed around measured body turn rate, so corrective bend yields to braking after the response develops
nontransferable_details: published controller gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: normalize the body-frame target/velocity cross product, map it to a bounded desired yaw rate, subtract observed recent turn rate, and apply the bounded error only inside the existing distance-and-speed terminal gate while preserving the two-joint wave and posterior envelope
falsification: reject if pre-approach behavior changes, sampled-best capture or mean distance is lost, terminal course/path/yaw does not improve, saturation migrates, reflection fails, or either coherent wake view worsens

## Lightweight validation after editing

- The required dedicated checker was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable to this account. Running its immutable checks locally
  gives PASS for the material guidance update and solver boundary; the latter
  confirms that `candidate_target_policy.jl` is the only solver change. The
  guidance check initially exposed two identical assigned-parent markers in
  the rendered workspace `README.md`; removing only the duplicate left the
  selected parent unchanged and the rerun passed.
- No Julia executable is installed or discoverable, so the checker's exact
  Julia load probe cannot run in this shell. The deterministic schema guard
  passes independently: all `66` direct `params.FIELD` names resolve among
  `68` unique returned fields, both public functions occur exactly once, the
  candidate remains nonempty, and raw delimiter counts balance.
- Replaying only the proposed formula over the sampled leader's recorded
  trajectory leaves the correction exactly zero for all `2881` samples at or
  beyond `2.10L`. Within approach its mean absolute turn-request contribution
  is `0.1437` (range `-0.2372` to `0.2675`), compared with `0.1603` for the
  failed direct residual. At the recorded final state it changes the direct
  residual's `-0.3395` continued turn command into a `+0.0781` yaw brake
  because measured yaw `-0.4200 rad/T` has passed the desired
  `-0.3366 rad/T`. Focused probes are zero outside approach, at rest, and for
  an aligned settled state; lateral reflection flips the correction with equal
  magnitude to machine precision. These are activation and contract checks,
  not CFD evidence; EvE must evaluate the trajectory hypothesis after exit.
