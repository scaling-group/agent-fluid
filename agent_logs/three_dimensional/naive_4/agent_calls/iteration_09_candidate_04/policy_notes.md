# Carrier-phase-residual redirect candidate

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled rollouts are finite captures from direct uniform still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected
  both rows of every combined keyframe sheet. Each top-down row develops a
  coherent alternating red/blue wake by `4T` and retains it through capture;
  each oblique row shows compact three-dimensional Lambda2 structures behind
  the traveling bend. The fish turn and translate under their own actuation,
  with no visible wake collapse, boundary exit, or instability.
- The assigned parent's closing-conditioned redirect is now positive sampled
  evidence. Its evaluated child, `solver_4c0e1314ad61`, is the strongest of
  the four current captures: score `-0.063208`, capture at `0.745L` after
  `16.225T`, and posterior hard-limit residence `21.3%`. The allocator-only
  sample follows the same route through the `2L` crossing but captures at
  `16.258T`; the two unallocated approach variants also capture at `16.258T`
  and spend `58.3-59.3%` of samples at the posterior acceleration limit.
  Thus the carrier, posterior-only mean bend, attenuation-only opposing-wave
  relief, mean-first acceleration allocation, and approach-lowered redirect
  onset should all be preserved.
- The remaining actuator signal is not a new route error on every tail beat.
  Across all four samples from `4T` to their `2L` crossings, a linear
  projection on normalized anterior joint angle and velocity explains `97.3%`
  of body-frame lateral-velocity variance. Within far, middle, and approach
  distance bands, the same two joint-phase coordinates explain `94.3-99.1%`
  of instantaneous target-versus-course-error variance. The fitted
  coefficients are stable across the two sampled trajectory families: the
  angle term lies between `-0.14` and `-0.17 rad`, and the normalized
  joint-velocity term between `+0.54` and `+0.64 rad`. Treating all of that
  repeatable carrier signature as persistent navigation error needlessly
  switches strong redirect authority within a beat.
- A fixed-trace counterfactual on the best sample gives a conservative design
  boundary. Removing one quarter of the evidenced phase component reduces
  mean far-field strong-redirect gate occupancy from `0.184` to `0.097` and
  mean-tail-target variability from `11.06` to `9.54 deg`, while leaving the
  final sub-`0.8L` gate (`0.852` versus `0.849`) and mean bend (`18.50` versus
  `18.46 deg`) nearly unchanged. This is not closed-loop evidence, but it
  selects a partial residual that preserves the established terminal redirect
  rather than replacing it with an untested phase-neutral controller.
- Inherited optimizer logs rule out shared anterior bias, two-sided lobe
  amplification, short-window yaw-rate feedback, and scalar carrier shrink.
  They either quenched the traveling bend, increased limiting, or retained the
  former upper-exit topology. The proposed residual uses the already observed
  joint state and does not reintroduce those mechanisms.

## Policy hypothesis

Preserve the evaluated best candidate exactly except for one compact feedback
mechanism. Estimate the repeatable carrier contribution to the instantaneous
target-versus-course response from `q1/A` and `qdot1/(omega*A)`. Once forward
motion makes course measurement reliable, subtract only one quarter of that
odd, normalized phase component before computing the strong redirect gate.
Keep the evaluated raw error for redirect direction, lower-authority cruise
steering, opposing-wave relief, and acceleration-headroom allocation. Admit a
residual-gated posterior command only when it requires no more instantaneous
acceleration than the inherited command; this makes the new mechanism
relief-only on every observed state instead of trading fewer gate openings for
stronger wave acceleration.

The expectation is the same coherent wake, early milestones, and terminal
redirect, with less beat-scale strong-curvature switching and no increase in
the current `21.3%` posterior hard-limit residence. Falsify the mechanism if
capture is lost or later than `16.258T`, the path changes into the inherited
upper exit, early target progress weakens, posterior limiting or loads rise,
or the correction reverses rather than preserving reflection symmetry.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual path control
source_mechanism: preserve the rhythmic locomotion carrier while assigning high steering authority to the slower observation residual rather than the repeatable carrier-phase response
transferable_invariant: separate fast joint-phase-correlated motion from persistent target-course mismatch before opening a high-authority redirect
nontransferable_details: published CPG gains, clock phase, species-specific envelopes, dimensional speeds and distances, prescribed vortex phase, and task-specific routes
policy_translation: normalized anterior joint angle and velocity predict an odd carrier component of body-frame response error; a bounded partial subtraction selects the existing posterior redirect gate, while raw-error wave relief and a pointwise acceleration-dominance guard preserve the captured carrier
falsification: reject if coherent propulsion or capture is lost, arrival exceeds 16.258T, posterior limiting or loads increase, or the former upper-exit topology returns

The candidate has no same-worker CFD result. Deterministic replay and contract
checks can establish boundedness, symmetry, and the intended signal separation;
only the later rollout can establish the wake and trajectory claims.

## Non-CFD refinement and verification

- A direct first translation applied the phase residual to both redirect gate
  and turn. Fixed-trace replay rejected it before handoff: posterior hard-limit
  occupancy would have increased from `21.3%` to `29.8%`. Merely reducing
  apparent steering variance can free an opposing wave contribution and raise
  actuator demand; later workers should not equate a quieter gate with lower
  effort without replaying the complete allocator.
- The final relief-only translation changes `425` of `2,950` posterior commands
  on the strongest sampled trace, leaves the anterior command exact, lowers
  mean absolute posterior acceleration from `25.673` to `25.627 rad/T^2`
  overall and from `25.435` to `25.245 rad/T^2` inside `1.75L`, and keeps
  fixed-trace hard-limit occupancy at `21.3%`. These are counterfactual command
  checks on inherited states, not a claim about the later closed-loop result.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. Its three
  prescribed commands were run directly: the material-guidance check, Julia
  policy-contract check, and solver-boundary check all pass. A separate schema
  audit finds all `32` direct `params.FIELD` references in the returned
  parameter object, and a `6,561`-state sweep returns finite bounded actions
  with exact lateral-reflection equivariance. No CFD was run.
