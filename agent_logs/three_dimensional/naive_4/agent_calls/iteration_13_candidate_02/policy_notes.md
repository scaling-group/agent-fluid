# Response-conditioned redirect with posterior speed headroom

## Pre-edit visual and quantitative diagnosis

- All four sampled rollouts satisfy the direct, uniform still-water contract:
  `initialization_mode=uniform_direct`, `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. I inspected the top-down vorticity and oblique Lambda2 rows
  for the best-scoring `solver_94565263e129`, the earlier
  carrier-phase-residual capture `solver_a0cc85d2f5b2`, and the distinct
  speed-headroom result `solver_29c7c83f8e3e`. In every top-down sequence the
  fish is self-propelled, establishes a coherent alternating red/blue street
  by `4T`, and turns into the capture circle without boundary interaction. The
  oblique sequences retain compact three-dimensional wake structures behind
  the posterior traveling bend through capture. There is no visual failure,
  wake collapse, passive advection, or numerical instability in this sample;
  the informative failure is therefore a mechanism regression measured in the
  trajectory and actuator histories, not a different termination class.
- The assigned parent `solver_94565263e129` is the strongest finite sample by
  scalar score. It crosses `8/6/4/2L` at
  `9.202/11.154/13.013/14.905T`, captures at `16.049T`, has mean/held distance
  `1.939780L`, and scores `-0.056774`. Its response-conditioned approach
  release preserves rhythmic authority when either raw or phase-residual
  course mismatch opens the terminal redirect. Relative to the otherwise
  matching phase-residual carrier, it improves score from `-0.058311` while
  delaying capture by only `0.0055T`; this is positive route evidence, but its
  posterior speed-limit residence rises from `5.79%` to `6.07%` and mean
  posterior action remains high at `24.923 rad/T^2`.
- `solver_29c7c83f8e3e` is the useful actuator regression. It combines a
  narrow pre-limit posterior wave guard with the older unconditional approach
  relief, retains the coherent wake and capture, and lowers posterior
  speed-limit and acceleration-limit residence to `5.61%` and `22.38%`
  compared with `6.07%` and `22.89%` for the assigned parent. It also lowers
  peak force/moment slightly from `0.0393/0.0194` to `0.0381/0.0193` and mean
  posterior action to `24.902 rad/T^2`. However, it captures later at
  `16.071T`, increases mean distance to `1.940194L`, and regresses score to
  `-0.057037`. Because its approach-release scaffold also differs, this
  rollout neither proves nor disproves the pre-limit guard on the assigned
  parent; it motivates the missing factorial combination rather than a gain
  change.
- The inherited logs establish two boundaries that the candidate preserves.
  Exact-speed anti-windup is kinematically and trajectory equivalent in this
  integrator, so another at-clamp wrapper cannot create a new wake or route.
  Conversely, a direct pre-limit wave translation was rejected when it could
  expose a larger opposite mean command; only the sign-and-magnitude dominance
  form changed 13 posterior commands on its parent trace, reduced predicted
  one-step speed-limit rows from 169 to 160, and left acceleration-limit rows
  unchanged. Shared anterior bias, broad carrier shrink, two-sided lobe
  amplification, short-window yaw-rate steering, and attenuation-only capping
  of residual-created redirect authority remain contradicted by inherited
  evidence.

## Policy hypothesis

Keep the assigned parent's carrier-phase residual, raw redirect direction,
response-conditioned terminal release, mean-first posterior allocator,
one-sided opposing-lobe relief, and exact-limit projection. Add one compact
constraint-aware mechanism inside both the raw and residual posterior
allocation branches: normalize measured posterior joint speed by its owned
limit, smoothly attenuate only the outward wave-acceleration component in the
narrow `0.96-1.0` headroom band, and accept that guarded total only when it
retains the unguarded command sign and does not increase magnitude. The
target-directed mean curvature, damping, inward wave action, anterior carrier,
and every posterior action below the band remain unchanged.

This candidate isolates whether the sampled pre-limit wave allocation can
reduce posterior speed-boundary residence on the best-scoring terminal route
without reinstating unconditional approach relief. Expect the assigned
parent's coherent wake, early milestones, and capture class with lower
posterior speed residence and command effort. Falsify the mechanism if a
below-band or inward-wave action changes, the mean redirect is attenuated,
reflection symmetry or bounds fail, the alternating wake weakens, early
target progress or capture regresses, or limiting/load reduction merely moves
to the anterior joint.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control under bounded actuation
source_mechanism: preserve a rhythmic locomotor carrier while observed actuator state yields only the oscillatory component consuming constraint headroom
transferable_invariant: when propulsion and route correction share a bounded posterior actuator, preserve target-directed mean action and continuously attenuate only outward rhythmic demand as measured speed approaches its limit
nontransferable_details: published controller gains, motor models, species-specific envelopes, dimensional frequencies, prescribed phases, exact vortex phases, and task-specific routes
policy_translation: use normalized posterior joint speed to gate the signed wave-acceleration component in both allocation branches; retain mean curvature, inward wave action, all body-frame navigation feedback, and all commands below the headroom band
falsification: reject if below-band or inward-wave actions change, lateral reflection equivariance fails, posterior limiting is not reduced, the coherent wake or early progress weakens, capture or score regresses, or loads and anterior limiting increase without compensating route benefit

The candidate has no same-worker CFD evidence. Only contract, boundedness,
reflection symmetry, branch locality, and fixed-trace counterfactual effects
will be claimed before downstream evaluation.

## Non-CFD verification

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. I then ran its
  three prescribed commands separately. The guidance check first found a
  duplicated rendering of the same assigned parent in `README.md`; removing
  only that duplicate restored unique provenance. The material-guidance check,
  lightweight Julia policy contract, and solver editable-boundary check all
  pass. A separate schema audit confirms that all `34` direct
  `params.FIELD` references are returned by `target_policy_params()`.
- Command-aligned replay reconstructs the assigned parent's next-row logged
  actions with mean maximum-component error below `9e-7 rad/T^2`. On those
  inherited states, the candidate leaves every anterior command and every
  posterior command at or below `0.96` normalized speed exact. It changes 13
  posterior commands between normalized speeds `0.9617` and `0.9761`, never
  reverses a command or increases its magnitude, lowers fixed-trace mean
  posterior action from `24.9275` to `24.8835 rad/T^2`, and reduces one-step
  predicted posterior speed-limit rows from 177 to 168. These are
  counterfactual command effects, not a trajectory or wake claim.
- A deterministic `36,450`-state sweep over joint state, bearing, body-frame
  velocity, and target geometry returned finite bounded actions with lateral
  reflection equivariance. It also confirmed exact anterior and below-band
  equivalence to the evaluated parent and exact preservation of inward wave
  acceleration in the headroom helper. No CFD was run.
