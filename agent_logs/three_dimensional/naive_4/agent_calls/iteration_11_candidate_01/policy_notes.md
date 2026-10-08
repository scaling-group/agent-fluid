# Evidence-selected carrier residual with exact-limit anti-windup

## Pre-edit visual and quantitative diagnosis

- All sampled rollouts use the required direct uniform initialization in still
  water: `initialization_mode=uniform_direct`, background velocity is exactly
  zero, no cylinders are present, and the release frames show no developed
  wake. I inspected the top-down vorticity and oblique Lambda2 rows in the
  combined sheets for the assigned parent, the three tied best samples, and
  the attenuation-only residual alternative. By `4T` each fish is visibly
  self-propelled and leaves a coherent alternating wake; the oblique views
  retain compact three-dimensional structures without wake collapse or
  instability through capture. Visual topology therefore does not distinguish
  these late candidates; trajectory and actuator histories do.
- The assigned parent `solver_1199437e225a` captures at `16.225T`, crosses
  `8/6/4/2L` at `9.246/11.209/13.140/15.026T`, and scores `-0.064416` with an
  observed distance integral of `1.32274L`. Its response-gated extra terminal
  wave unloading does not improve the earlier closing-conditioned route.
- The carrier-phase-residual samples `solver_5739c176b0d4` and
  `solver_a0cc85d2f5b2` advance every milestone to
  `9.202/11.154/13.013/14.905T`, capture at `16.044T`, and score `-0.058311`
  with observed distance integral `1.31388L`. Their peak force/moment remain
  comparable to the parent (`0.0393L^2/0.0194L^3` versus
  `0.0389L^2/0.0195L^3`), so the phase residual is the strongest sampled route
  mechanism rather than a scalar-only preference.
- The attenuation-only residual alternative from the inherited optimizer log
  is the informative mechanism regression. Capping residual-gated authority
  by the raw gate preserves the visible carrier and capture, but delays every
  milestone relative to the unconstrained residual, captures at `16.115T`,
  and regresses to `-0.064714`. The residual must be allowed to open as well as
  close high-authority intervals; raw target-versus-course error should still
  own redirect sign and wave/headroom allocation.
- `solver_bf77448adfd7` adds exact joint-speed-boundary anti-windup to the
  successful phase residual. Its complete closed-loop trajectory, wake, score,
  milestones, joint extrema, force, and moment match the unprojected best,
  while mean absolute commanded acceleration falls from
  `23.452/25.514` to `23.294/24.871 rad/T^2`. This confirms that same-sign
  outward acceleration at the measured `260 deg/T` clamp is kinematically
  redundant in this actuator model.

## One candidate and falsification

Replace the assigned parent's terminal wave-unloading branch with the sampled
carrier-phase-residual redirect, and retain the evaluated exact-boundary
anti-windup projection. Normalized anterior joint angle and velocity remove a
conservative repeatable carrier contribution only from the high-authority
redirect gate; raw normalized body-frame target-versus-course error continues
to set redirect direction, wave relief, and acceleration allocation. The
projection removes only outward acceleration when a measured joint velocity is
already at its owned physical limit. This is one compatible route-selection
and constraint-handling candidate; it does not change the oscillator gains,
copy a route, or add time/state outside the public two-joint contract.

Expected result: recover the sampled best's coherent wake, earlier milestones,
`16.044T` capture class, and lower observed distance integral relative to the
assigned parent while avoiding actuator demand that cannot change clamped
joint kinematics. Falsify the route mechanism if the rollout loses capture,
returns to `16.225T`-class arrival, weakens the coherent alternating wake, or
raises load/limit residence materially. Falsify anti-windup equivalence if the
downstream actuator model lets an outward command at the exact speed boundary
affect joint motion, work, compliance, or fluid coupling.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and residual path-following control
source_mechanism: preserve a rhythmic locomotor carrier while normalized sensor feedback modulates a bounded low-dimensional route command
transferable_invariant: separate repeatable joint-phase-correlated motion from persistent target-course mismatch, and keep infeasible boundary demand outside the carrier and route laws
nontransferable_details: published gains, clock-driven CPG phase, species-specific envelopes, dimensional frequencies, exact vortex phases, motor models, and task-specific routes
policy_translation: normalized anterior joint angle and velocity select the existing posterior redirect gate; raw body-frame bearing-versus-course error retains direction and wave allocation, while normalized joint speed projects only same-sign acceleration at the exact clamp
falsification: reject if capture or early progress regresses, wake coherence is lost, loads or limit residence rise materially, reflection equivariance fails, or projected boundary commands are not kinematically redundant

The candidate has no same-worker CFD result. Only sampled closed-loop evidence
and deterministic contract checks can support it before downstream evaluation.

## Non-CFD verification

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account; it made no
  edits. I ran its exact three commands separately. The guidance check first
  exposed a duplicated rendering of the same assigned guidance parent in
  `README.md`; removing only that duplicate restored unambiguous provenance.
  The guidance semantic check, lightweight Julia policy contract, and solver
  editable-boundary check then all passed.
- A static audit confirms that all `33` direct `params.FIELD` references exist
  in `target_policy_params()`. A deterministic state sweep spanning joint
  signs, exact speed limits, bearing, forward/lateral velocity, and body-frame
  target side returned finite bounded actions with lateral-reflection
  equivariance and no outward command at either exact velocity boundary.
- The candidate file is byte-identical to the sampled closed-loop
  anti-windup controller whose capture and effort evidence is reported above.
  This is evidence selection and contract verification, not a same-worker CFD
  claim.
