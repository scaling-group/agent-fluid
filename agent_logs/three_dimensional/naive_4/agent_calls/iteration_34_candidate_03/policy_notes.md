# Carrier-demodulated force-and-moment response candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and capture. I inspected the combined sheets
  for the distinct best-scoring parent and the weaker repeated control from
  release through capture. Their top-down rows show a release transient that
  develops into a coherent alternating lateral wake behind a smooth,
  target-directed, self-propelled path. Their oblique body/Lambda2 rows retain
  compact three-dimensional caudal structures without wake collapse,
  collision, virtual-boundary exit, or out-of-plane instability. No failed
  termination is present in this sample, so the repeated weaker capture and
  inherited logged regressions are the informative controls rather than a
  claimed visual failure.
- Three independently sourced control policies produce byte-identical combined
  sheets and trajectories: capture at `15.768509T`, distance integral
  `1.924067L`, final distance `0.745720L`, `232` moving-window shifts, and
  score `-0.041674`. The assigned parent adds the carrier-demodulated
  yaw-moment branch and improves capture to `15.735508T`, distance integral to
  `1.919818L`, final distance to `0.744372L`, shifts to `231`, and score to
  `-0.037222`. It advances the `8/6/4/2/1.25L` milestones by
  `0.0275/0.0330/0.0165/0.0440/0.0385T`. The two-view wake remains coherent,
  mean posterior demand falls from `25.221` to `25.012 rad/T^2`, and posterior
  acceleration-limit residence is effectively unchanged (`23.58%` versus
  `23.59%`). This is route-scale positive evidence for carrier-demodulated
  hydrodynamic response, not justification for increasing curvature or
  retuning the moment threshold.
- The benefit has costs that bound the next test: posterior excursion increases
  from `34.7` to `35.2 deg`, peak lateral force from `0.03329` to `0.03380`,
  and peak yaw moment from `0.01895` to `0.01920` in normalized trace units.
  The inherited adverse-axial-force experiment also warns that reducing
  pointwise load or demand can lengthen the route even while the wake looks
  unchanged. The next mechanism must therefore preserve the parent's maximum
  response curvature and be judged by route milestones, distance integral,
  capture, and loads together.
- The assigned-parent trace exposes a second normalized response channel. Over
  the route regime (`t>4T`, distance `>2L`), normalized anterior joint
  position and velocity explain `96.12%` of body-lateral-force variance; the
  fitted residual has 5th/50th/95th percentiles
  `-0.00570/0.00053/0.00572`. The corresponding force- and moment-opposition
  gates are strongly related (`0.87` correlation), so adding their curvatures
  would double-count the same response. They nevertheless have complementary
  support: on the parent trace, 155 states have strong force-only opposition
  and 159 have strong moment-only opposition. Taking their maximum within the
  existing moment envelope adds feasible response on 451 states, with at most
  `0.57 deg` more mean curvature than the parent on a reconstructed state and
  no increase in the declared hydrodynamic curvature ceiling.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction studies
source_mechanism: separate slow target-directed steering from fast body-frame force and moment disturbances after subtracting the repeatable locomotor carrier
transferable_invariant: preserve the traveling-bend carrier and route command, reject only measured hydrodynamic residuals that oppose the requested turn, and avoid cancelling aiding lateral response
nontransferable_details: published gains, dimensional force or moment scales, species-specific kinematics, exact Strouhal values, exact tail or vortex phase, source wake geometry, clock-defined events, and task-specific routes
policy_translation: predict normalized lateral force from normalized anterior joint position and velocity, subtract that carrier prediction, form a bounded opposition gate against the reliable redirect direction, and union it with the successful moment-residual gate inside one shared posterior-curvature envelope that fades through the established approach
falsification: reject if capture or any established milestone regresses, distance integral worsens, the coherent alternating two-view wake degrades, posterior excursion or force and moment loads grow without route benefit, or the force channel is trajectory-equivalent to the parent

## One candidate hypothesis

Keep the assigned-parent anterior oscillator, posterior traveling wave,
positive-axial-force propulsion allocation, target/course steering, redirect,
approach and terminal laws, moment residual, mean-first allocation, and exact
actuator projection unchanged. Add one reflection-equivariant lateral-force
residual to the existing hydrodynamic response observer. A non-finite force
observation selects its carrier prediction and therefore contributes zero
residual. The new force gate opens only when reliable target-directed redirect
duty already exists and measured non-carrier lateral force points against that
turn. The force and moment gates combine by `max`, then use the parent's single
`2 deg` curvature limit; they cannot stack authority.

This is a new observation-to-actuation mechanism rather than scalar gain
tuning. The falsifiable expectation is that force-only opposition support will
advance at least one route milestone or lower distance integral while retaining
capture, the parent's coherent wake, and its force/moment and joint envelopes.
Formal CFD occurs only after this worker exits, so no outcome for this candidate
is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `38b3d0a81022c54952563577dfee60c6c9681feacf9565ed46185093daf591af`.
  Static schema inspection resolves all 59 direct `params.FIELD` references
  against exactly 59 fields returned by `target_policy_params()`, with no
  missing or unused field. The lightweight Julia policy probe returns two
  finite bounded accelerations.
- A deterministic 20,000-state sweep across both target sides, distance,
  body-frame velocity and force, yaw moment and rate, bearing rate, and joint
  phase returns finite commands within the declared acceleration limit with
  zero lateral-reflection error. A non-finite lateral-force probe also returns
  finite action by selecting the carrier-force prediction and zero new
  residual.
- Counterfactual evaluation on reconstructed assigned-parent states changes
  127 posterior commands and no anterior command, with feasible support from
  `0.253-15.642T` and `12.326-0.872L`. The maximum and mean changed-command
  magnitudes are `1.2334` and `0.1541 rad/T^2`; no new acceleration-limit hit
  appears. This establishes non-clamp-equivalent action support without
  predicting the unevaluated closed-loop hydrodynamic response.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were run
  directly and separately: guidance materiality and deterministic schema,
  the lightweight Julia contract, and the solver editable-boundary check all
  pass. The first materiality run exposed two identical assigned-parent
  markers in the rendered workspace `README.md`; removing only the duplicate
  repaired that inherited metadata defect without changing the parent. No CFD
  was run.
