# Closing-conditioned redirect continuity

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled solver evaluations and the assigned parent's inherited
  evaluation are finite captures from direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their motion is therefore
  self-propelled rather than imposed advection.
- I inspected both rows of every sampled combined keyframe sheet and the
  assigned parent's sheet. From release through capture, all five top-down
  rows grow a coherent alternating red/blue mid-plane street, while the
  oblique rows show compact three-dimensional Lambda2 structures behind the
  traveling bend. The trajectories turn down-left without wake collapse,
  virtual-domain exit, or instability. The useful failure here is terminal
  directional/actuator quality, not propulsion or termination class.
- The sampled selective closing relief has the best score, `-0.066121`, and
  captures at `0.745L` after `16.258T`, but its posterior acceleration remains
  at the hard limit for `59.3%` of the rollout. Mean-first redirect allocation
  preserves the same visible route, captures at `0.748L` after `16.258T`, and
  cuts posterior limit residence to `22.5%`.
- The assigned parent combines those mechanisms. It retains capture, advances
  the `5L`, `2L`, and `1.2L` crossings from the selective-relief sample's
  `12.205/15.065/15.835T` to `12.177/15.026/15.796T`, arrives at `16.225T`,
  and keeps posterior limit residence at `21.4%`. Its lower score,
  `-0.067754`, coincides with the discrete first-crossing sample landing at
  `0.7492L` rather than `0.7448L`; this is a real scalar regression but not
  evidence that the two mechanisms are dynamically incompatible.
- Terminal body-frame reconstruction exposes a remaining response dead zone.
  At the parent's `0.8L` crossing, target bearing is `+0.350 rad` while course
  is `+0.032 rad`, leaving `+0.319 rad` target-versus-course error. The fixed
  `0.45 rad` redirect onset then admits only about `0.14` strong-redirect gate,
  despite reliable closing near `1.01L/T`. At capture, bearing is
  `+0.386 rad`, course is `-0.089 rad`, and the response error has grown to
  `+0.470 rad`, so strong redirect reopens only at the threshold crossing.
  The near-target target vector is rotating away faster than the fixed
  redirect dead zone maintains course alignment.
- Inherited logs rule out shared anterior steering bias, two-sided lobe
  amplification, short-window yaw-rate feedback, and scalar carrier shrink.
  Those mechanisms either quenched the carrier, spent more time at the hard
  limit, or retained the former upper-exit topology; none should be
  reintroduced to address this terminal geometry defect.

## Policy hypothesis

Start from the assigned parent's evaluated combination: preserve its anterior
state-feedback carrier, target-versus-course posterior redirect, attenuation-
only opposing-wave relief, mean-first posterior acceleration allocation, and
closing-gated approach wave relief. Add one state-dependent regime transition,
not a global gain change: while proximity and target-aligned closing open the
existing approach gate, continuously lower the response-error onset for strong
posterior redirect. Far from the target or while not closing, the evidenced
`0.45 rad` onset remains exact. Near a reliable crossing, the smaller onset
keeps the mean-curvature channel engaged through the observed `0.32 rad`
course mismatch instead of closing and reopening it. The acceleration
allocator still gives that mean bend priority without amplifying either wave
lobe.

Expected evidence is the parent's coherent wake, early milestones, capture no
later than the sampled `16.258T` alternatives, posterior limit residence well
below the unallocated `59-60%`, and smaller terminal bearing/course mismatch.
Falsify the mechanism if the stronger near-target redirect delays or loses
capture, raises force or posterior limiting toward the unallocated policies,
creates a late hook instead of a tighter crossing, or changes the wake/path
before the `1.75L` approach neighborhood.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal capture control
source_mechanism: preserve the propulsive rhythm while continuously increasing directional response when observed near-target geometry shows that course has not converged
transferable_invariant: separate far-field propulsion from a proximity-and-response-gated terminal steering regime, and keep steering authority until measured course aligns rather than releasing it at a fixed error threshold
nontransferable_details: published controller gains, dimensional approach ranges, species-specific envelopes, clock-driven CPG phase, exact vortex phase, actuator torques, and task-specific routes
policy_translation: normalized body-frame target distance and target-aligned velocity open the existing approach gate; that gate lowers only the posterior redirect-error onset, while joint-state propulsion, bounded mean curvature, one-sided wave relief, and mean-first acceleration allocation remain intact
falsification: reject if capture is lost or later than 16.258T, the pre-approach wake or trajectory changes, terminal target-versus-course error does not shrink, or posterior hard-limit residence approaches the unallocated 59-60 percent

The candidate has no same-worker CFD result. Deterministic checks can establish
schema, boundedness, reflection equivariance, and exact recovery of the parent
outside reliable approach; only the later rollout can test the trajectory,
wake, and capture expectations.

## Non-CFD verification

- The guidance provenance check passes with a material reusable lesson relative
  to the assigned parent, and the solver boundary check passes with only
  `candidate_target_policy.jl` changed inside the candidate repository.
- The prescribed Julia policy-contract check returns two finite accelerations,
  and an explicit schema audit confirms every direct `params.FIELD` reference
  is returned by `target_policy_params()`.
- A deterministic `6,561`-state sweep over joint state, target bearing,
  normalized body velocity, and lateral target position returns finite bounded
  actions and exact lateral-reflection sign reversal. The candidate matches the
  evaluated parent exactly for every swept target outside `1.75L`; at the
  inherited `0.8L` state, only the posterior action changes (`11.48` to
  `25.29 rad/T^2`), as intended for redirect continuity.
- The requested dedicated check-runner was invoked but its pinned
  `gpt-5.4-mini` model is unavailable in this account context. Its three exact
  commands were therefore run directly and all passed. No CFD was run.
