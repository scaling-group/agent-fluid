# Terminal reverse-wave braking candidate

## Visual and trace diagnosis before the edit

- All sampled and inherited rollouts are contract-valid direct-uniform still
  water (`U_infinity=(0,0,0)`, no cylinders, no prewarm).  The alternating
  top-down vortices stay attached to the moving fish and the oblique Lambda2
  row shows a body-generated three-dimensional trail, so the useful motion is
  self-propulsion rather than moving-window advection.
- The scalar-best sampled `solver_b6ed3f84ab58` is not the useful carrier: it
  remains in the upper corridor, reaches only `5.386L`, touches the joint-angle
  boundary, and peaks near `0.212` planar force and `0.0968` yaw moment.  Its
  late visual curl and roughly tenfold load increase agree with the inherited
  warning against posterior half-cycle redistribution.
- The sampled closing-gated redirect `solver_e7a7a878626e` is the useful finite
  reference despite its lower scalar score.  Both visual rows show a coherent
  broad downward turn through the target neighborhood.  It reaches `0.827823L`
  at `27.489T` without angle-limit contact and with peak planar force/yaw moment
  near `0.0214/0.00979`, but passes the target and exits left.  At closest
  approach it still translates at about `0.664L/T`; both joints and commands
  have nearly settled into the same-sign redirect while bearing has worsened
  to about `-0.935 rad`.  The failure is therefore residual translational
  momentum after a productive, low-load turn, not weak propulsion, wake loss,
  or insufficient static bend depth.
- The assigned parent's inherited anterior counter-sweep is now completed
  evidence: it reached `0.828153L`, retained `left_domain`, and approached at
  about `0.659L/T` with the same coherent visual topology.  The other inherited
  coordinated C-to-S recoil reached `0.830575L`; the earlier same-side anterior
  reflex reached `0.831781L`.  Their angle clearance and peak loads remained
  benign, but none changed the termination or beat `0.827823L`.  Together with
  the recorded posterior-damping and posterior-counterbend failures, this
  closes more bend-attainment-triggered terminal sweeps as a supported branch.

## Policy hypothesis

Recover the response-released, terminal-miss-vetoed near-capture controller
without its failed terminal depth or recovery additions.  Preserve its far
traveling-wave carrier, steering side, C-bend entry, and response release.
Add one different terminal mechanism: when normalized body-frame range is
inside the approach zone, the measured course has an unsafe projected miss,
and positive closing speed is high, blend the settled redirect into an active
joint-state oscillator whose posterior phase relation is reversed.  The
anterior carrier uses the already evaluated oscillator; changing the sign of
the posterior lag reverses wave propagation rather than merely damping or
deepening a joint target.  The gate fades continuously when the course becomes
safe, closing speed falls, or the fish leaves the approach zone.

The falsifiable expectation is unchanged far-field wake and route followed by
lower closing speed before the target station, allowing the existing steering
geometry to cross the `0.75L` capture circle.  Reject the mechanism if closing
speed near `1.1L` is not materially below the roughly `0.66L/T` references, if
the reversed wave adds forward speed, if minimum distance does not beat
`0.827823L`, or if wake coherence, angle clearance, force/moment peaks, or
speed/acceleration-limit residence materially worsen.

bookshelf_consulted: true
source_domain: Taylor traveling-wave propulsion and Lighthill reactive slender-body thrust, combined with terminal approach scheduling
source_mechanism: the direction of a body wave sets the direction of reactive momentum transfer, so a sensed unsafe fast approach can replace a settled propulsive bend with a bounded reverse-propagating wave
transferable_invariant: preserve the productive carrier at range, but use observed terminal geometry and closing motion to reverse wave direction when active counter-thrust is required
nontransferable_details: published dimensional frequencies, gains, full-body wave envelopes, species-specific kinematics, exact thrust coefficients, vortex phases, world coordinates, and task-specific routes
policy_translation: normalized body-frame distance and projected miss plus positive closing speed gate the existing joint-state oscillator; only the posterior lag sign is reversed inside that gate, while far carrier, redirect side, and two-joint limits remain unchanged
falsification: reject if the terminal closing speed is not reduced, capture does not beat `0.827823L`, the reverse wave accelerates the fish through the target, or the far route, coherent wake, load envelope, angle clearance, or limit residence degrades

## Non-CFD implementation audit

Replaying the candidate and the assigned parent's anterior-sweep policy on all
`7274` frozen inherited states changes `436` commands, all at recorded ranges
`0.8282--1.7481L`; no state at or beyond the `1.75L` approach boundary changes.
The largest component change is `26.693 rad/T^2`, the mean changed-sample L1
command difference is `13.678 rad/T^2`, and neither policy adds a terminal
acceleration clamp on that frozen path; total clamp incidence is also unchanged
at `2731` samples.  All `31` direct parameter references are owned by
`target_policy_params`, an active reflected state negates both commands to
machine precision, a zero-speed state remains finite, and the lightweight
Julia contract plus solver boundary checks pass.  These algebra-only checks
establish locality, material activation, boundedness, schema coverage, and
reflection equivariance; they do not predict the unevaluated CFD result.
