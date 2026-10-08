# Adverse-load-relieved posterior-response candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and capture. I inspected the assigned-parent and
  sampled-best combined sheets from release through capture. Their top-down
  rows show a release transient developing into a coherent alternating wake
  and a smooth target-directed arc, so the fish is self-propelled rather than
  advected by the zero background flow. Their oblique body/Lambda2 rows retain
  compact three-dimensional caudal structures without wake collapse,
  collision, virtual-boundary exit, or out-of-plane instability. No
  failed-termination keyframe sheet is present in the current sample; the
  lower-value finite capture and inherited logged regressions are the
  informative controls rather than a claimed visual failure.
- The assigned parent is the axial-force-gated posterior allocator. Against
  the inherited, replicated speed-only branch, it changes capture from
  `15.977511T` to `15.768509T`, distance integral from `1.928580797L` to
  `1.924071330L`, moving-window shifts from `238` to `232`, and score from
  `-0.045506315` to `-0.041679331`. It advances the `6/4/2/1.25L`
  milestones by `0.0660/0.0935/0.1540/0.1650T` while retaining the coherent
  two-view wake. Mean posterior demand falls from `25.473` to
  `25.221 rad/T^2`, but posterior acceleration-limit residence rises from
  `22.58%` to `23.58%`. This is evidence for response allocation, not for
  increasing the wave gain or lowering its positive-force threshold.
- Three independently sourced policies replace the parent's terminal net
  bearing-rate damper with exact translational line-of-sight rate. They are
  byte-identical in trajectory and wake evidence and retain the same capture
  step and every route milestone as the parent, changing only final distance
  from `0.745725L` to `0.745720L` and distance integral from `1.924071L` to
  `1.924067L`. This is a terminal-scale observation result, not new route
  diversity; another terminal threshold, curvature scalar, or equivalent
  line-of-sight decomposition is not justified by the current sample.
- The parent's force allocator changes feasible posterior action only in the
  early low-speed envelope. Through its inherited support near `3.663T`, 216
  of 665 samples (`32.5%`) report adverse normalized body-forward force. The
  adverse magnitude has median `0.000789` and 90th-percentile `0.001604`, and
  it is localized to repeatable joint-state lobes. The current allocator
  removes only the supplemental boost on those lobes and retains the entire
  base posterior wave. Its large route gain establishes the response signal;
  the remaining adverse-load support motivates one conservative test of
  response-conditioned base-wave relief, while the inherited pre-limit-guard
  regressions require milestone and distance-integral benefit rather than
  command relief alone.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a directional traveling bend while measured axial load continuously allocates posterior wave authority
transferable_invariant: keep the anterior rhythm and zero-load base wave intact, reinforce the posterior wave only under propulsive body-frame response, and apply bounded relief only after a clearly adverse response is observed
nontransferable_details: published thrust laws and gains, species-specific envelopes, dimensional frequencies, exact Strouhal values, exact tail or vortex phase, source force scales, clock-defined bursts, and task-specific routes
policy_translation: retain the assigned parent's positive-force interpolation and all navigation; inside its existing low-speed recovery envelope only, smoothly interpolate from the proven base posterior command toward a mildly relieved feasible endpoint as normalized body-forward force becomes adverse, with zero-force startup and all positive-response actions unchanged
falsification: reject if early or route milestones regress, capture is delayed or lost, the coherent alternating two-view wake changes adversely, distance integral worsens, or lower limiting and load occur without target-progress benefit

## One candidate hypothesis

Keep the assigned-parent anterior oscillator, steering, redirect, approach,
terminal shaping, positive-force posterior boost, mean-first allocation, and
exact actuator projection unchanged. Add one reflection-equivariant adverse
load branch within the already evaluated low-speed recovery envelope. At zero
or positive body-forward force it is exactly inactive. As measured force turns
adverse, it smoothly interpolates only the feasible posterior action toward a
base-wave endpoint with a small bounded relief; startup therefore retains the
base carrier and a non-finite force observation removes all sensory
modulation. The final selector may reduce but never increase instantaneous
posterior command magnitude relative to the assigned parent on the same
state.

This is a bidirectional sensor-to-wave allocation test, not scalar-only gain
tuning. The falsifiable expectation is that avoiding a fraction of posterior
motion on evidenced adverse-response lobes will retain the parent's later
milestone and capture gains while advancing at least one early milestone or
reducing the distance integral, with no new limiting or lateral-load cost. A
lower command statistic without route benefit is a negative result under the
inherited guard evidence. Formal CFD remains post-exit, so no outcome for this
candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `b608fbba04f47d0435b64b40ff2d502bb4509a2789b85cf38568f969a3673c05`.
  Static schema validation resolves all 54 direct `params.FIELD` references
  against exactly 54 fields returned by `target_policy_params()`, with no
  missing or unused field. The lightweight Julia contract returns two finite
  bounded accelerations.
- A deterministic 20,000-pair sweep across target side and distance,
  body-frame velocity and axial/lateral force, bearing and yaw response, and
  joint phase returns finite bounded commands with zero lateral-reflection
  error. A non-finite force probe also returns a finite action by selecting the
  zero-response parent path.
- Counterfactual evaluation on reconstructed assigned-parent states changes
  58 posterior commands and no anterior commands, only from
  `0.077000-3.657503T` and `12.326552-11.798628L`. Changed states have
  body-forward force from `-0.0021345` to `-0.0000040` and forward speed from
  `0-0.340311U`; maximum and mean changed-command magnitudes are `2.5782` and
  `0.1189 rad/T^2`. No zero/positive-force or post-recovery state changes,
  no changed command has larger magnitude than its parent command, and no new
  acceleration-limit hit appears. This establishes feasible, early,
  non-clamp-equivalent support but does not predict the unevaluated closed-loop
  hydrodynamic response.
- The guidance-materiality check, lightweight Julia policy contract, and
  solver editable-boundary check pass locally. The first materiality run
  exposed two identical assigned-parent markers in the rendered workspace
  `README.md`; removing only the duplicate repaired that inherited metadata
  defect without changing the assigned parent. The configured check-runner was
  invoked after these edits, but its pinned `gpt-5.4-mini` model is unavailable
  for this account; its three prescribed commands were therefore run directly
  and pass. No CFD was run.
