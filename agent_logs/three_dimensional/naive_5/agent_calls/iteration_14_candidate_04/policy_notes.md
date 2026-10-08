# Translational intercept-hold candidate

## Visual and trace diagnosis before the edit

- The sampled rollouts and inherited completed descendants are contract-valid
  direct-uniform still-water evaluations (`U_infinity=(0,0,0)`, no cylinders,
  no prewarm).  In both the top-down vorticity rows and oblique Lambda2 rows,
  the fish translates with a body-attached alternating wake.  The useful
  trajectories are self-propelled rather than advected by the moving window,
  and the near miss is not preceded by wake collapse or numerical instability.
- `solver_4f3d51f38935` is the strongest sampled visual approach.  It carries a
  coherent low-load wake through a `0.832836L` minimum, then passes the target
  at roughly `0.66L/T` and exits left.  Its trace supplies an upstream clue:
  near `12T`, while still about `8.88L` away, the measured velocity projects
  to only about `0.18L` miss, yet body-frame bearing is about `-0.51 rad` and
  crosses the static-redirect entry boundary.  By `18T` the projected miss has
  grown to about `3.96L`.  The controller can therefore disturb an already
  capture-compatible translational course because redirect entry and far
  release are dominated by body orientation rather than intercept outcome.
- `solver_b6ed3f84ab58` is the informative failure: both visual rows keep it in
  the upper corridor until the upper-margin exit, the posterior joint touches
  `45 deg`, and peak planar force/yaw moment (`0.212/0.0968`) are about ten
  times the low-load near-miss class.  More posterior half-cycle authority is
  not a safe way to correct the route.
- Completed inherited logs close the terminal-only alternatives.  A
  response-deficit anterior half-cycle residual reached `0.831067L`, an
  anterior counter-sweep `0.828153L`, a coordinated C-to-S recoil `0.830575L`,
  and a curved traveling gait about the redirect `0.875770L`; all retained the
  same coherent left-domain pass-by topology.  These results materially
  falsify the inherited open suggestion to add another response-gated terminal
  actuator patch.  They also show why the prefilled policy's unevidenced
  terminal depth increment should not be retained as if it were progress.

## Policy hypothesis

Recover the evidenced response-released, terminal-miss-vetoed carrier without
the failed terminal depth increment.  Add one upstream feedback semantic: when
the fish is closing and its current body-frame velocity projects through a
capture-compatible corridor, smoothly release the body-bearing redirect and
let the established traveling-wave carrier preserve that translational
intercept.  When projected miss leaves the corridor, the existing bounded
course/bearing steering and redirect regain authority.  This is an
observation-gated intercept hold, not a fixed route, clock stage, or scalar
increase in propulsion or steering authority.

The falsifiable expectation is a coherent low-load carrier with less
unnecessary mid-course redirect during capture-compatible velocity intervals,
followed by a closer approach or first crossing inside `0.75L`.  Reject the
mechanism if it strands the fish in the high corridor, chatters between course
states, changes the wake into a standing wiggle, raises load or limit exposure,
or cannot beat the `0.827823L` inherited reference.  In particular, reject the
instantaneous projected-intercept signal if beat-scale velocity oscillation
makes release too phase-sensitive; a later worker should then test a genuinely
filtered translational outcome rather than another corridor threshold.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking with target-approach capture scheduling
source_mechanism: preserve a productive traveling-wave carrier while sensed translational outcome, rather than body orientation alone, qualifies whether additional turning remains necessary
transferable_invariant: when measured velocity already predicts entry into the target corridor, suppress extra mean-turn authority until the predicted intercept becomes unsafe again
nontransferable_details: published gains, robot linkage geometry, species-specific envelopes, dimensional timing, exact vortex phases, capture routes, and world coordinates
policy_translation: normalized body-frame target and velocity form projected miss, positive normalized closing speed establishes approach, and their smooth bounded gate augments redirect release while retaining the two-joint state-feedback carrier
falsification: reject if capture does not occur or the minimum does not beat `0.827823L`, if beat-scale velocity makes the gate chatter, or if far progress, coherent wake structure, loads, joint clearance, or actuator-limit residence materially worsen

## Non-CFD implementation audit

- The prescribed guidance-semantic check passes after removing one duplicated
  assigned-parent marker from the rendered workspace README.  The lightweight
  Julia contract and solver editable-boundary checks also pass; no CFD was run.
- Replaying the prefilled and candidate policies on all `7234` frozen
  `solver_4f3d51f38935` trace states changes `1272` actions.  Of those, `522`
  occur at or beyond `1.75L`, establishing that the new semantic acts upstream
  rather than masquerading as another terminal-only edit.  Changed frozen
  states span `2.222--29.194T` and `0.833--12.288L`; the maximum component
  difference is `17.81 rad/T^2`, including removal of the parent's terminal
  depth target.
- Reflection of lateral target, velocity, heading rate, joint angle, and joint
  velocity negates both commands exactly (maximum algebraic error `0`), and a
  zero-speed state remains finite.  Frozen-state clamp incidence rises modestly
  from `2687` to `2740` joint samples.  That increase is not a same-worker CFD
  result, but it sharpens the falsification boundary: reject the candidate if
  the new course-hold intervals increase actual limit residence or loads, even
  if minimum distance improves.
