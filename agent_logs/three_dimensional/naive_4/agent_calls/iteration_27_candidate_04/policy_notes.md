# Aligned-translation posterior phase-lag candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no prewarm
  or cylinders, finite dynamics, capture after 2,919 steps at approximately
  `16.0544T`, and 239 moving-window shifts. Their translation is therefore
  self-propelled rather than background-flow advection.
- I inspected the combined keyframe sheets for one copy of the strongest
  sampled policy (`solver_197b19357040`) and the only distinct sampled
  regression (`solver_8474fe870fa5`) from release through termination. In
  both top-down vorticity rows, the fish follows the same smooth target-directed
  arc behind a coherent alternating lateral wake. In both oblique body/Lambda2
  rows, compact three-dimensional caudal structures persist through capture;
  neither sheet shows reciprocal standing motion, wake breakup, collision,
  passive drift, virtual exit, or out-of-plane instability. The two sheets are
  indistinguishable at their resolution, consistent with a terminal-only
  action difference.
- The current sample contains no failed termination to inspect visually. The
  best policy is duplicated as `solver_197b19357040` and
  `solver_b8f061aba429`, with byte-identical source and outcome: capture at
  `16.054371T`, final distance `0.745846L`, scored distance integral
  `1.929840L`, and score `-0.0468999`. The net-rate parent is duplicated as
  `solver_8474fe870fa5` and `solver_acb79e618a5d`: the same arrival step and
  wake, but final distance `0.745854L`, integral `1.929846L`, and score
  `-0.0469084`. Treating these four records as four independent trajectories
  would overstate the evidence; they establish two deterministic terminal
  variants, not route diversity.
- Inherited notes supply a documented negative boundary rather than a
  currently inspectable failure sheet. A route-wide two-degree
  carrier-demodulated residual brake opened near `4.34T` across about 950
  commands, remained wake-coherent, but missed capture at `0.785816L`, curled
  away, and exited at `29.293T` with final distance `9.122L` and score
  `-10.1782`. The successful residual instead shares the existing three-degree
  response envelope inside the positive-closing safe-intercept corridor and
  changes only four posterior commands from `1.518L` to `1.259L`. Thus neither
  broader residual damping nor another terminal response threshold is
  supported.
- The assigned-parent experience shows three consecutive generations of
  successful but trace-scale terminal shaping with the same route, wake,
  milestones, and arrival step. It also records that the established carrier
  has posterior emphasis and a coherent traveling bend, while indiscriminate
  wave relief, pre-limit guarding, shared anterior bias, and posterior approach
  release delayed progress or regressed crossing. A follow-up should retain
  the entire steering/approach scaffold and test a different actuator role
  whose success criterion is earlier milestones or arrival, not a few more
  microunits of terminal distance.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: elongated-body propulsion and closed-loop robotic-fish CPG modulation
source_mechanism: posterior phase-lag modulation preserves a traveling bend while separating propulsive wave shaping from target-directed mean curvature
transferable_invariant: after self-propelled translation is reliable, modestly increase posterior wave lag only when measured steering demand has released, and restore the proven baseline continuously when redirect or approach authority is needed
nontransferable_details: published gains, dimensional frequencies, Strouhal targets, clock-defined CPG phase, species-specific envelopes, full-body kinematics, exact vortex phases, and source-task routes
policy_translation: keep the evaluated state-feedback oscillator, posterior mean steering, wave relief, approach logic, and terminal response unchanged; use normalized forward-speed reliability and the complement of measured redirect/approach duty to blend one bounded extra lag into the posterior joint target
falsification: reject if the new lag changes the established turn topology, delays any 8/6/4/2/1.25L milestone or capture, disrupts the coherent two-view wake, raises posterior excursion, acceleration-limit residence, or force/moment peaks materially, or acts only during the terminal beat without improving observed distance integral

## One candidate hypothesis

Add exactly one feedback mechanism to the sampled-best policy: an
aligned-translation posterior phase-lag boost. The boost is zero at release,
during high-authority redirect, and throughout the closing approach. It opens
smoothly only after body-frame forward translation is reliable and both raw
and carrier-residual redirect selectors have released, then increases the
lagged posterior wave without adding mean curvature, changing oscillator
frequency, amplifying steering lobes, or using time, coordinates, or mutable
phase. The baseline `tail_lag_gain` remains the fallback under any steering or
approach demand.

This is an exploratory architecture candidate, not a claimed same-worker CFD
improvement. Its intended evidence is earlier distance milestones and lower
distance integral while preserving capture, the coherent alternating 3D wake,
and the parent's limit/load envelope. If it only changes effort or final
crossing, the mechanism has not met its purpose.

## Non-CFD verification after the edit

- Candidate SHA-256:
  `500df167ff124a5707e669e7e68f7d2a59810bd47c06a9092d1c009233bc20be`.
  All 49 direct `params.FIELD` references resolve to the 49 fields returned by
  `target_policy_params()`.
- Counterfactual replay on the sampled-best recorded states changes only the
  posterior command on 807 of 2,919 samples, from `0.5775T` through
  `14.9985T` (`12.322L` through `1.796L`). Maximum posterior acceleration
  difference is `2.264 rad/T^2`, and the difference is identically zero for
  all recorded states at or inside the established `1.75L` approach. This
  verifies cruise support beyond a terminal threshold; it does not predict the
  unevaluated closed-loop hydrodynamic response.
- A deterministic 58,320-state body-frame audit keeps both commands finite and
  within `31.416 rad/T^2`, removes outward acceleration at either exact joint
  speed boundary, and has zero numerical lateral-reflection error. The
  non-finite task-observation fallback is finite. The configured check-runner
  was invoked but its pinned `gpt-5.4-mini` model is unavailable for this
  account; its material-guidance, lightweight policy-contract, and
  editable-boundary commands were therefore run directly and separately, and
  all pass. No CFD was run.
