# Posterior stroke-reversal response-bridge candidate

## Evidence diagnosis before the policy edit

- All four sampled solver evaluations satisfy the frozen experiment contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture. Three independently
  sourced terminal-line variants have byte-identical combined wake sheets and
  trajectories: capture at `15.768509T`, final/minimum distance `0.745720L`,
  distance integral `1.924067L`, 2,867 steps, 232 moving-window shifts, and
  score `-0.041674176`. The force-only parent differs only in eight terminal
  commands and reaches the same milestones and capture step at `0.745725L`,
  `1.924071L`, and `-0.041679331`. These terminal observation rewrites are not
  useful route diversity.
- I inspected the best sampled sheet and the inherited adverse-load-relief
  sheet from release through termination. In both top-down rows, the release
  disturbance grows into a coherent alternating lateral wake and the fish
  follows a smooth target-directed arc; zero background flow rules out passive
  advection. In both oblique body/Lambda2 rows, compact paired caudal
  structures persist without wake collapse, collision, virtual-boundary exit,
  or out-of-plane instability. Their route difference is below sheet
  resolution, so the metrics and traces—not vortex prominence—decide the
  comparison.
- The inherited adverse-load branch is a concrete negative result. It reduced
  only the base posterior endpoint during negative axial load and advanced the
  `8L/6L` crossings slightly, but the benefit reversed by `4L`: capture moved
  from `15.768509T` to `15.785009T`, distance integral from `1.924067L` to
  `1.925588L`, final distance from `0.745720L` to `0.747963L`, and score from
  `-0.041674` to `-0.043610`. Lower posterior acceleration-limit residence
  (`23.58%` to `23.21%`) and lower peak lateral force (`0.03329` to `0.03157`)
  did not compensate for the longer route. Negative measured force is
  therefore not permission to weaken the carrier on this response allocator.
- The proven positive-force allocator remains the physically useful parent:
  inherited evidence shows that it improved the speed-only recovery carrier
  from `15.977511T`, `1.928581L`, and `-0.045506` to `15.768509T`,
  `1.924071L`, and `-0.041679` while preserving the coherent two-view wake.
  The current four-solver sample then shows that three terminal rewrites do not
  alter this route. The next test should change feasible early propulsion while
  retaining the base traveling wave and every navigation and terminal role.
- A parent-trace counterfactual separates the feasible boosted and base
  posterior endpoints. Among 234 endpoint-different states below full measured
  force, 114 have a boost increment that opposes current posterior velocity,
  i.e. prepares stroke reversal. Only `64.0%` of those states have positive
  force at the same instant, but after `0.055T` all `114/114` do and their mean
  normalized body-forward force is `0.002783`, versus `54.2%` and `0.001010`
  for the velocity-aiding complement. This is retrospective association, not
  proof of causality, but it supports one bounded test of a phase-advanced
  response bridge rather than another force threshold or recovery gain.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior traveling wave while joint-state phase feedback prepares the next propulsive tail-load lobe
transferable_invariant: retain the anterior rhythm, base traveling wave, and measured positive-load reinforcement, but allow only the already bounded supplemental posterior endpoint to begin during a normalized velocity-opposing stroke-reversal state that locally predicts the next propulsive response
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact Strouhal values, exact tail or vortex phase, source force scales, clock-defined phase advances, and task-specific routes
policy_translation: inside the evaluated low-speed recovery envelope, form normalized negative incremental posterior work from the feasible boosted-minus-base acceleration and posterior joint velocity; smoothly union that reversal gate with the existing body-forward-force gate while leaving the base endpoint, mean steering, terminal control, and actuator projection unchanged
falsification: reject if the coherent alternating two-view wake changes adversely, any established milestone or capture regresses, distance integral worsens, limiting or lateral load rises without target-progress benefit, or the new gate changes no feasible early posterior commands

## One candidate hypothesis

Keep the current anterior oscillator, base and supplemental traveling waves,
force-response allocation, route steering, redirect, approach, terminal
line-of-sight roles, mean-first posterior allocation, and exact actuator
projection unchanged. Add one smooth joint-state bridge to the existing force
response gate. It measures only the negative work of the feasible supplemental
acceleration difference against posterior joint velocity, normalized by the
declared acceleration and velocity limits. Thus it opens at stroke reversal,
not at a copied time or vortex phase, and it can choose only between the two
already bounded controller endpoints. Zero reversal evidence reproduces the
parent force gate; zero or adverse force never weakens the base carrier.

The falsifiable expectation is that phase-advancing the sampled positive-load
reinforcement will improve an early or middle distance milestone and retain
the parent's later capture gain without disrupting wake coherence. The result
must be judged on milestones, distance integral, capture, limiting, and loads;
lower effort alone is not success. Formal CFD occurs after this worker exits,
so no outcome for this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `592084891d9df17e77259b9156a0b248b4154bea93b003a14fa6be378e11499d`.
  Static schema validation resolves all 53 direct `params.FIELD` references
  against exactly 53 fields returned by `target_policy_params()`, with no
  missing or unused field. The lightweight Julia contract returns two finite
  bounded accelerations.
- A deterministic 20,000-pair sweep across target side and distance,
  body-frame velocity and force, bearing and yaw response, and joint state
  returns finite actions within the declared acceleration limit with zero
  lateral-reflection error. A non-finite axial-force probe returns a finite
  action by removing measured-force reinforcement while retaining only valid
  normalized joint-state feedback.
- Counterfactual evaluation on reconstructed assigned-parent states changes
  84 posterior commands and no anterior commands, only from
  `0.352000-3.657503T`. Maximum and mean changes are `1.7165` and
  `0.6966 rad/T^2`; every change moves within the base-to-boosted endpoint
  interval, no post-recovery command changes, and no new acceleration-limit
  hit appears. This establishes feasible, non-clamp-equivalent early support
  without predicting the unevaluated closed-loop result.
- Guidance materiality, the finite policy contract, deterministic parameter
  ownership, and solver editable-boundary checks pass. The configured
  check-runner was invoked, but its pinned `gpt-5.4-mini` model is unavailable
  for this account; its prescribed checks were therefore run directly and
  separately. The first materiality check exposed two identical assigned-parent
  markers in the rendered workspace `README.md`; removing only the duplicate
  repaired that inherited metadata defect without changing the parent. No CFD
  was run.
