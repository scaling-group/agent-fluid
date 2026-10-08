# Posterior-only terminal course-hold candidate

## Visual diagnosis before the policy edit

- All four sampled solver examples are direct-uniform still-water rollouts
  (`U_infinity=[0,0,0]`) with no cylinders or prewarm.  They are deterministic
  replications of the v35/v36 family: all four trajectories and combined
  keyframe sheets are byte-identical despite the v36 course-consistency veto,
  and all capture at `24.6730T` and `0.748684L`, with mean distance
  `2.348256L` and score `-0.448647`.
- Both visual rows were inspected from release through capture.  The top-down
  row starts wake-free, then shows self-propelled diagonal progress, a coherent
  alternating mid-plane vortex street, and a compact hook into the capture
  disk.  The oblique row retains compact three-dimensional Lambda2 structures
  through the redirect.  The fish is neither passively advected nor losing its
  carrier to wake breakup, instability, or moving-window transport.
- The inherited terminal course-hold rollout is the informative negative
  comparator.  Its top-down and oblique sheets retain the same useful route and
  coherent wake class, but reducing both carriers over the final `1.60L`
  changes `292/4486` reconstructed parent states without improving the control
  semantics.  It captures only `0.0110T` earlier at a narrower `0.749661L`
  crossing, worsens mean distance/score to `2.348972L/-0.449580`, leaves raw
  acceleration exposure essentially unchanged (`73.483%` versus `73.473%`),
  barely changes exact-rate occupancy (`13.894%` versus `13.932%`), and raises
  peak lateral-force/yaw-moment coefficients from `0.03087/0.01559` to
  `0.03465/0.01802`.  Terminal relief is therefore not a two-joint scalar-gain
  problem.
- The v35/v36 terminal sweep is strongly transverse, but remains productive:
  near capture its normalized course error is about `+0.86`, while the
  posterior joint sits near `-44 deg` and its rate is close to zero.  Earlier
  evidence also shows that broad dual-joint rate braking destroys capture,
  whereas posterior-only coasting preserves wave direction and the route.
  This localizes the next test to follower-carrier allocation without changing
  the anterior phase anchor, target steering, or safety filters.

## Policy hypothesis

Start from the positively evaluated v36 controller and add one role-selective
terminal hold.  When normalized range is below `1.60L`, measured closing is
positive, and the body-frame velocity/target course error is large, taper only
the posterior carrier acceleration toward an owned `0.82` floor.  Preserve the
anterior state oscillator exactly, and preserve all mean-curvature,
half-cycle, course-preview, steering-priority, stroke-braking, and posterior
coast feedback.  This is the smallest falsifiable separation of the failed
two-joint hold: the phase anchor continues to organize the traveling bend while
the follower stops spending the same carrier effort during the transverse
terminal interception.

Expected evidence is no command change outside the normalized conjunction,
the established far trajectory and coherent three-dimensional wake, capture
no later than the v34 pure-coast comparator (`25.0635T`), zero posterior
hard-stop occupancy, and no regression from the low-load class.  Falsify the
mechanism if the coupled rollout merely reproduces the weaker symmetric-hold
crossing, loses capture, changes the far route, disrupts the wake, or raises
rate occupancy or peak planar loads.  The new CFD result is not available to
this worker and is not claimed here.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming, sensor-modulated robotic-fish oscillators, and terminal capture control
source_mechanism: an anterior phase anchor organizes a lagged posterior traveling bend, while approach feedback may reduce excess follower drive without discarding steering
transferable_invariant: preserve wave direction and the anterior phase anchor; under normalized near-range, positive-closing, high-course-error evidence, modulate only the posterior carrier while retaining signed target steering
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, full-body waveforms, exact vortex phases, Strouhal targets, motor models, and task-specific routes
policy_translation: retain v36 and multiply only its posterior carrier acceleration by a bounded scale from body-frame range, closing speed, and velocity-to-target course error; leave the anterior carrier, steering, and safety layers unchanged
falsification: reject if the far route changes, capture or wake coherence is lost, the weaker symmetric-hold crossing is reproduced, or posterior hard-stop, exact-rate, or low-load behavior regresses

## Pre-evaluation fixed-trace audit

- The candidate was evaluated as a pure function on all `4486` reconstructed
  states from the completed v36 trajectory; this is a locality check, not a
  coupled hydrodynamic result.  The gate is nonzero on `292` rows and changes
  `284` final commands, beginning at `22.8305T` and `1.59963L`.  Every changed
  row satisfies range below `1.60L`, positive windowed closing, and absolute
  course error above `0.55`.
- The anterior command is exactly identical to v36 on every reconstructed
  state.  The posterior command is exactly identical to the completed
  symmetric-hold branch on every state, so the next CFD evaluation isolates
  anterior-anchor preservation rather than changing the follower hypothesis.
  The sampled posterior carrier scale stays in `[0.82,1.00]`; the largest
  final-command difference from v36 is `5.5251 rad/T^2`, inside the owned
  `31.416 rad/T^2` acceleration envelope.
- All reconstructed candidate commands are finite.  Formal contract, schema,
  guidance-delta, and editable-boundary checks also pass.  The exact Julia
  public-contract probe returns two finite accelerations; the deterministic
  schema audit finds all `90` direct `params.FIELD` references among the `92`
  fields returned by `target_policy_params()`; and the solver boundary check
  reports only the allowed candidate file changed.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account.  After removing the
  duplicated assigned-parent marker from the rendered workspace `README.md`,
  the runner's three declared checks were executed directly and separately and
  all pass: reusable-guidance semantics, the Julia policy contract, and the
  solver editable boundary.  No formal CFD was run.
