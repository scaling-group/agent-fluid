# Response-conditioned approach-release candidate

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled rollouts use the required `uniform_direct` initialization
  with `U_infinity=(0,0,0)`, no prewarm, and no cylinders. I inspected the
  combined sheets for the best-scoring `solver_5739c176b0d4` capture and the
  distinct lower-scoring `solver_1199437e225a` capture from release through
  termination. In both top-down rows the fish translates under its own
  traveling bend and establishes a coherent alternating red/blue wake by
  `4T`; in both oblique rows compact three-dimensional Lambda2 structures
  persist behind the posterior body through capture. Neither sheet shows
  advection, wake collapse, a boundary interaction, or numerical instability.
  The useful distinction is therefore route and control response, not wake
  existence.
- The assigned parent `solver_5739c176b0d4` and the semantically matching
  phase-residual sample `solver_a0cc85d2f5b2` are the strongest finite
  evidence: both cross `8/6/4/2L` at `9.202/11.154/13.013/14.905T`, capture at
  `16.044T`, score `-0.058311`, and have observed/held mean distance
  `1.9410L`. Their peak joint excursions are `26.3/31.5 deg`; posterior exact
  acceleration-limit residence is `22.7%`, and peak force/moment coefficients
  are `0.0393/0.0194`. The speed-limit anti-windup sample
  `solver_bf77448adfd7` removes infeasible commands and lowers mean posterior
  action from `25.514` to `24.871 rad/T^2`, but its entire trajectory, capture
  time, and score remain identical. Exact-boundary projection is a valid
  effort cleanup, not evidence of further target progress in this integrator.
- The distinct `solver_1199437e225a` response-gated terminal-wave variant
  preserves the same visible wake but captures later at `16.225T`, scores
  `-0.064416`, and raises mean distance to `1.9477L`. Its inherited
  closing-redirect base lacks the winning carrier-phase residual, so it does
  not isolate wave unloading; nevertheless it supplies no positive evidence
  for deeper near-target wave suppression. The inherited attenuation-only
  residual gate is a cleaner negative result: it prevents the residual from
  ever opening redirect authority and regresses from `-0.058311` to
  `-0.064714`. Later controllers should preserve the evaluated residual gate,
  including the intervals where it opens useful authority.
- The remaining opportunity is the independent approach drive-relief gate.
  On the assigned-parent trace, after the `1.75L` crossing the fish is already
  closing at a mean `1.065 U`, while unconditional proximity-plus-closing
  relief averages `0.517`. The raw and phase-residual redirect gates agree
  that strong route correction is unnecessary for much of this band: a
  conservative maximum of their normalized demand would reduce mean applied
  approach relief to `0.292`. Conversely, below `0.8L` the same consensus
  demand is `0.991`, so the inherited terminal damping and wave floor would be
  almost fully restored exactly where the final correction remains active.
  This separates propulsion release from the redirect itself without using a
  clock, coordinates, or a new route.

## Policy hypothesis

Preserve the evaluated carrier-phase-residual redirect, raw-error direction,
mean-first posterior allocator, bounds, and closing-conditioned redirect onset
exactly. Add one response-conditioned release mechanism: proximity and closing
may enable approach mode, but anterior damping and posterior wave attenuation
are applied only in proportion to the larger of the raw and phase-residual
normalized redirect demands. Taking the larger demand prevents either phase
interpretation alone from manufacturing a low-demand release. When both agree
that the course has responded, the unchanged traveling-bend carrier returns;
when either still sees a strong mismatch, the evaluated approach relief is
retained.

The expected result is unchanged far-field milestones and wake topology,
followed by stronger target-aligned propulsion during the early approach and
capture no later than `16.044T`, without increasing peak loads or posterior
limit residence materially. Falsify the mechanism if any command changes at
or above `1.75L`, the alternating wake weakens, capture is delayed or lost,
the route acquires a terminal loop, the final correction loses its existing
relief, or joint/load limits worsen enough to outweigh arrival improvement.

bookshelf_consulted: true
source_domain: biological C-start recovery and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve a rhythmic locomotor carrier, engage bounded high-authority curvature for large observed mismatch, and release continuously into propulsion when the measured response realigns
transferable_invariant: separate route correction from propulsion relief so a resolved target-course mismatch restores the established carrier while unresolved mismatch retains bounded steering authority
nontransferable_details: species-specific burst kinematics, published gains, dimensional speeds and distances, prescribed CPG or vortex phase, exact wake geometry, and task-specific routes
policy_translation: normalized body-frame target bearing and course form raw and joint-phase-residual redirect demands; their conservative maximum gates only the existing approach damping and posterior wave attenuation, leaving the two-joint redirect law and all far-field commands unchanged
falsification: reject if far-field commands change, coherent propulsion or capture is lost, arrival exceeds 16.044T, terminal correction is prematurely released, or saturation and loads worsen without compensating target progress

The candidate has no same-worker CFD result. Only deterministic contract,
symmetry, boundedness, and fixed-trace counterfactual checks will be claimed
before downstream evaluation.

## Non-CFD verification

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` runtime is unavailable for this ChatGPT account. I ran its
  three prescribed commands directly after removing one duplicated rendering
  of the assigned-parent marker from the workspace `README.md`. The material
  guidance/provenance check, lightweight Julia policy contract, and solver
  editable-boundary check all pass.
- All `32` direct `params.FIELD` references are returned by
  `target_policy_params()`. A `6,561`-state sweep spanning joint angle and
  velocity, bearing, body-frame velocity, and near/far target geometry returns
  finite bounded actions with lateral-reflection equivariance. Every one of
  the `2,187` far-field states matches the evaluated parent exactly.
- A command-aligned replay reconstructs the parent's logged actions within
  `5.2e-5 rad/T^2`. The new gate changes `92/2,916` anterior and `62/2,916`
  posterior commands, all after the `1.75L` boundary. On those fixed states,
  mean approach anterior action falls from `23.839` to `23.321 rad/T^2`,
  posterior action changes from `25.652` to `25.746 rad/T^2`, and posterior
  acceleration-limit residence remains `27.98%`. Anterior approach limit
  residence rises modestly from `45.24%` to `47.02%`, so later CFD must weigh
  any arrival benefit against that cost. Below `0.8L`, where the terminal
  redirect is active, the maximum action difference is only
  `0.086 rad/T^2`.
- These replay results establish locality and the intended control semantics,
  not a new trajectory or wake result. Formal CFD remains deferred to EvE.
