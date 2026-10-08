# Odd-harmonic carrier demodulation for yaw-moment rejection

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen rollout contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and capture. The best moment-residual policy
  and the prefilled moment-plus-translational-terminal policy have different
  source hashes but byte-identical trajectories and combined wake sheets at
  `15.735508T`, final/minimum distance `0.744372L`, distance integral
  `1.919818L`, 2,861 steps, 231 moving-window shifts, and score `-0.037222`.
  The terminal translation branch is therefore inactive at trajectory scale
  on this route; another terminal threshold or line-of-sight rewrite would not
  provide useful diversity.
- I inspected the sampled-best and weakest finite combined sheets from release
  through capture. Their top-down rows show the release transient growing into
  a coherent alternating caudal wake behind a smooth target-directed arc; the
  zero background flow makes this self-propulsion rather than advection. The
  oblique body/Lambda2 rows retain compact alternating three-dimensional wake
  structures without collapse, collision, virtual-boundary exit, or
  out-of-plane instability. The sheets are nearly indistinguishable, so the
  route metrics and actuator histories, not vortex prominence, determine the
  mechanism comparison.
- Carrier-demodulated yaw-moment rejection is the only material winner in the
  current sample. Relative to the axial-response/terminal-line control, it
  advances the `8/6/4/2/1.25L` milestones by
  `0.0275/0.0330/0.0165/0.0440/0.0385T`, advances capture from
  `15.768509T` to `15.735508T`, and lowers distance integral from
  `1.924067L` to `1.919818L`. Mean posterior demand also falls from
  `25.221` to `25.012 rad/T^2`, although posterior acceleration-limit
  residence is essentially unchanged (`23.58%` versus `23.59%`) and peak
  lateral force rises modestly from `0.03329` to `0.03380`.
- Adding a second posterior mean-curvature increment only when demodulated
  lateral force corroborates adverse moment is a concrete negative result.
  Against moment-only it delays every `8/6/4/2/1.25L` milestone, capture to
  `15.746509T`, and distance integral to `1.921600L`, despite reducing
  posterior limit residence to `23.30%` and peak lateral force to `0.03327`.
  Independent load agreement is therefore not permission to stack more mean
  bend; lower limiting or force does not compensate for the longer route.
- The successful moment observer currently models the repeatable carrier load
  as linear in normalized anterior-joint position and velocity. On both the
  axial-response control and moment-policy traces in the route regime
  (`t>4T`, distance `>2L`), a compact reflection-odd model that also includes
  their cubic terms raises explained moment variance from
  `95.96/96.14%` to `97.08/97.20%`; its coefficients agree closely across
  the two independent trajectories. Requiring both the proven linear observer
  and this refined observer to label moment as adverse would suppress 614/629
  route samples on the two traces. Those suppressed states are followed by
  mean ten-sample absolute course-error increases of `0.0138/0.0173 rad`,
  whereas the retained active states change by `-0.0097/0.0060 rad`. This
  retrospective association is not a causal rollout result, but it supports
  a bounded carrier-harmonic veto rather than more steering authority.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-disturbance rejection
source_mechanism: separate repeatable nonlinear locomotor load from hydrodynamic yaw disturbance before applying bounded residual steering
transferable_invariant: preserve the traveling-bend carrier and target-directed mean turn while a compact reflection-odd joint-state observer removes repeatable carrier harmonics from measured body-frame yaw moment
nontransferable_details: published CPG gains, dimensional moment scales, species-specific kinematics, exact tail or vortex phase, source wake geometry, clock-defined events, and task-specific routes
policy_translation: retain the sampled linear moment-residual curvature branch and all propulsion, navigation, approach, terminal, and actuator roles, but let a second odd-cubic anterior-phase prediction veto supplemental moment steering when the measured load is explainable as nonlinear carrier motion; keep the residual scale and curvature ceiling unchanged
falsification: reject if capture or any established milestone regresses, distance integral worsens, the coherent two-view wake or force envelope degrades, posterior limiting rises without route benefit, or the refined observer changes no feasible posterior actions

## One candidate hypothesis

Produce exactly one candidate by preserving the prefilled carrier, positive
axial-response allocation, target/course steering, redirect, approach,
terminal response, mean-first posterior allocation, and exact actuator
projection. Change only the carrier classifier inside the already successful
yaw-moment rejection mechanism. Retain its evaluated linear prediction and add
a four-term reflection-odd prediction using normalized anterior position,
velocity, and their cubic harmonics. Supplemental moment curvature receives
the smaller of the two opposition gates, so the refined observer can veto but
cannot open mean-steering authority that the proven observer withheld. The
four refined coefficients are calibrated from the two sampled traces in
normalized body-frame units; the bookshelf supplies only the
separation-of-carrier-and-disturbance invariant.

The moment residual scale and `2 deg` curvature ceiling remain unchanged, so
this is a semantic observer refinement rather than an authority increase or a
gain sweep. The falsifiable expectation is that vetoing repeatable nonlinear
carrier load prevents unnecessary posterior mean correction while retaining
the moment branch's earlier route and capture. Formal CFD remains post-exit,
so no result for this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `b4e1e14611e1c4ef6e36d50b03ebe24a503da41e208106d802c0c33ff99b38f3`.
  Static schema validation resolves exactly 60 direct `params.FIELD`
  references against the same 60 fields returned by
  `target_policy_params()`, with no missing or unused parameter.
- A direct replacement of the linear classifier was rejected during the
  implementation audit because it could open moment steering where the
  evaluated classifier was closed. The finalized minimum of the linear and
  odd-cubic opposition gates makes the new observer veto-only at the
  mean-curvature level. A state-wise replay over the sampled-best snapshots
  changes 249 posterior commands and no anterior commands, with mean/maximum
  differences `0.0890/1.9128 rad/T^2`; the support is therefore feasible and
  not trajectory-equivalent. Because posterior mean/wave cancellation is
  nonlinear, eight replayed outputs newly reach the existing acceleration
  ceiling even though the curvature gate never grows. This is within the
  declared envelope but makes limit residence an explicit CFD falsification
  metric rather than a claimed pointwise benefit.
- A deterministic 5,000-pair sweep across mirrored target geometry,
  body-frame velocity and loads, joint state, bearing response, and yaw
  response returns finite actions within the declared acceleration bound with
  zero lateral-reflection error. Non-finite target, velocity, force, moment,
  bearing, and yaw inputs also return a finite fallback action.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed checks were therefore
  run directly and separately: the guidance-materiality check, lightweight
  Julia policy contract, and solver editable-boundary check all pass. No
  formal CFD was run.
