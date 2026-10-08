# Adverse-axial-response posterior-wave relief candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and capture. The three translational-LOS
  policies have distinct source hashes but byte-identical trajectories and
  combined sheets. They capture at `15.768509T`, cross at `0.745720148L`, have
  distance integral `1.924067164L`, use 2,867 steps and 232 moving-window
  shifts, and score `-0.041674176`. The assigned axial-response parent has the
  same arrival step, milestones, shifts, force/moment peaks, and joint-limit
  residence; it differs only at the crossing (`0.745725095L`, distance
  integral `1.924071330L`, score `-0.041679331`). The three-way replication
  therefore bounds translational-LOS damping as a trace-scale terminal edit,
  not a new trajectory mechanism.
- I inspected the combined sheets for a replicated translational-LOS result
  and the assigned parent from release through capture. In both top-down rows,
  a release transient becomes an organized alternating lateral wake by `4T`
  and the fish follows a smooth target-directed arc. In both oblique
  body/Lambda2 rows, compact caudal structures persist without collision,
  wake collapse, virtual exit, or out-of-plane instability. With zero
  background flow, the translation is self-propelled rather than advection.
  The terminal differences are below sheet resolution, so their tiny metric
  difference does not justify another terminal onset, curvature, or rate edit.
  No failed-termination sheet is present; the slightly weaker finite parent is
  the informative visual control, while inherited failures are used only as
  logged trajectory evidence.
- The inherited logs establish the route-scale base to preserve. Adding the
  axial-force selector to the replicated forward-speed-gated carrier advanced
  capture from `15.977511T` to `15.768509T`, lowered distance integral from
  `1.928581L` to `1.924071L`, and retained the coherent two-view wake. It did
  not advance the `8L` milestone and raised posterior acceleration-limit
  residence from `22.58%` to `23.58%`, so this evidence supports response
  allocation but not a stronger boost, lower positive-force threshold, or
  broader speed envelope.
- On the assigned-parent trace, the existing low-speed response envelope is
  open for 693 samples through `4.070T`. Body-forward force is nonpositive on
  220 samples; these samples have mean forward acceleration `-0.467 U/T`,
  compared with `+0.719 U/T` on the 233 samples at or above the existing
  `0.003` positive-force scale. The adverse-force magnitude spans
  `0-0.00272`, and the same adverse subset carries `2.27%` posterior
  acceleration-limit residence. This supports one bidirectional extension of
  the evaluated response allocator: retain its positive-load reinforcement,
  but briefly unload the posterior traveling-wave component when measured
  axial load is adverse. Earlier pre-limit guards warn that lower pointwise
  command is not sufficient evidence of route benefit, so the new branch must
  be judged by early milestones, distance integral, and capture.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive posterior propulsion, wake-load interaction, and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a traveling bend while measured axial hydrodynamic response modulates only bounded posterior-wave authority
transferable_invariant: keep the anterior rhythm, mean steering, and base posterior wave intact while a normalized body-frame load signal reinforces favorable response and relieves adverse response continuously
nontransferable_details: published force laws and gains, species-specific envelopes, dimensional frequencies, exact Strouhal values, exact vortex or tail phases, source force scales, clock-defined bursts, and task-specific routes
policy_translation: promote the replicated translational-LOS axial-response policy as the base; inside its already evaluated low-speed and outside-approach envelope, retain positive-force reinforcement and add a smooth adverse-force branch that reduces only the posterior traveling-wave endpoint, never anterior drive or mean curvature
falsification: reject if early distance milestones fail to advance, the coherent alternating two-view wake or target-directed route changes adversely, capture or distance integral regresses, limiting or force/moment peaks grow materially, or the branch changes only clamp-rejected action

## One candidate hypothesis

Use the best replicated translational-LOS policy as the unchanged navigation
and terminal base. Extend only its sampled axial-response allocation from a
one-sided selector to a bounded three-endpoint posterior-wave law. Positive
body-forward force continues to interpolate from the base wave to the
evaluated 25% reinforced wave. Adverse body-forward force, normalized by the
same evidenced `0.003` load scale, instead interpolates toward a 15% relieved
posterior wave. The adverse branch is multiplied by the existing low-speed
and outside-approach eligibility gate, so it releases continuously after
forward recovery and cannot alter the established approach controller.

The anterior oscillator, base posterior wave, steering and redirect
direction, one-sided turn relief, approach scheduling, translational-LOS
terminal response, mean-first allocation, and exact velocity-boundary
projection remain unchanged. To avoid turning wave relief into an
authority-increasing pulse, the adverse endpoint is accepted only where its
feasible interpolated posterior acceleration is no larger in magnitude than
the already evaluated command. This safeguard does not claim route neutrality:
the inherited pre-limit failures make milestone and capture preservation part
of the falsification test.

The falsifiable expectation is less cyclic braking during the measured
adverse-load subset, earlier `12/10/8L` progress, and retention of the
`15.7685T` capture and coherent wake without worse posterior limiting or peak
loads. A lower mean command without route or distance-integral improvement is
a negative outcome. Formal CFD occurs only after this worker exits, so no new
rollout result is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `4b1e46082842eb362c46ce7e5a07daa66c9da13fd2b9841e8bd1e53c5b2d42dd`.
  Its executable base is the sampled translational-LOS axial-response policy;
  the only new observation-to-action mechanism is adverse-force posterior-wave
  relief.
- Static schema validation resolves all 53 direct `params.FIELD` references
  against exactly the 53 fields returned by `target_policy_params()`, with no
  missing or unused fields. The lightweight Julia contract returns two finite
  accelerations.
- A deterministic sweep of 20,000 reflection-paired states across target side
  and distance, body-frame velocity and force, bearing/yaw response, and joint
  phase returns finite bounded commands with zero reflection error. Positive
  axial-force states exactly reproduce the sampled base. The adverse branch
  changes 617 sweep states, never increases posterior command magnitude, and
  a non-finite observation probe remains finite.
- Counterfactual comparison on reconstructed assigned-parent states changes
  56 posterior commands and no anterior commands, only from
  `0.0770-3.6575T`. All changed samples have adverse axial force; maximum and
  mean posterior-command differences are `0.7448` and
  `0.0376 rad/T^2`, no changed command is larger than the sampled base, and no
  new acceleration-limit hit appears. This establishes early, feasible,
  non-clamp-equivalent action support but does not predict closed-loop CFD.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Its three prescribed
  checks were run directly and separately. The guidance-materiality check
  initially exposed two identical assigned-parent markers in the rendered
  `README.md`; removing only the duplicate repaired that inherited metadata
  defect. Material guidance, the lightweight policy contract, and the solver
  editable-boundary check all pass. No CFD was run.
