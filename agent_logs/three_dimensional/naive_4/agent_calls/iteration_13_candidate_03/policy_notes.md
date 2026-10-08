# Response-conditioned terminal relief with posterior wave headroom

## Pre-edit visual and quantitative diagnosis

- All four sampled rollouts satisfy the experiment contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. I inspected both the top-down vorticity and oblique Lambda2 rows of
  the combined sheets for the best-scoring `solver_94565263e129`, the distinct
  pre-limit guard `solver_29c7c83f8e3e`, and the lower-scoring common-base
  capture `solver_a0cc85d2f5b2`. The release frames are quiescent. By `4T`,
  each fish has translated under its own traveling bend and formed a coherent
  alternating red/blue wake; compact three-dimensional Lambda2 structures
  persist behind the posterior body at `12T` and capture. There is no visual or
  diagnostic evidence of passive advection, wake collapse, boundary contact,
  or numerical instability. The current samples contain no failed termination,
  so the common-base capture is the most informative lower-performing visual
  comparison rather than a claimed failure.
- The assigned parent `solver_bf77448adfd7` adds exact-speed-boundary
  anti-windup to `solver_a0cc85d2f5b2`. Both capture on step `2917` at
  `16.043510T`, have minimum/final distance `0.746962L`, mean held distance
  `1.941006L`, score `-0.058311`, the same distance crossings, and numerically
  identical body trajectory, joint state, force, and moment histories. Only
  the logged action differs where the episode integrator would already clip an
  outward velocity increment. This is concrete negative evidence: exact-clamp
  projection cleans infeasible command effort but cannot improve navigation in
  this hard-clipped actuator model.
- `solver_94565263e129` supplies the strongest finite route evidence. It keeps
  the carrier, phase-residual redirect, raw-error turn direction, mean-first
  allocator, and exact-boundary projection, but applies approach damping and
  posterior wave reduction only when high-authority redirect duty is low. It
  retains the common base's `8/4/2/1L` crossings at
  `9.202/13.013/14.905/15.807T`, captures at `16.049T`, lowers mean held
  distance to `1.939780L`, and improves score to `-0.056774`. At capture it
  has a more surge-aligned world velocity `(-1.174,-0.081)U` than the common
  base `(-1.096,-0.232)U`, while peak planar force/moment coefficients remain
  comparable (`0.0311/0.0194`). The coherent wake and bounded joint excursions
  (`26.3/31.7 deg`) survive the change, although acceleration limiting remains
  substantial.
- The inherited `solver_210913739316` log is the useful opposite-sign test:
  strengthening approach relief when redirect demand is high regressed to
  score `-0.059985` and final distance `0.748557L`. The sampled best instead
  releases gait relief when redirect duty is high. Later designs should retain
  that semantic direction rather than interpreting all proximity-plus-closing
  states as permission to suppress the carrier.
- `solver_29c7c83f8e3e` tests a distinct constraint mechanism on the common
  base. Its smooth guard acts before the posterior speed clamp, attenuates only
  outward rhythmic acceleration, preserves mean curvature through a
  sign-and-magnitude dominance test, retains capture and the coherent wake,
  and improves score to `-0.057037` with final distance `0.744924L`. Its
  capture is later (`16.071T`) and its `4/2/1L` crossings lag the best, so it
  should not replace the best controller wholesale. The evidence supports
  testing the guard locally on the best terminal-relief scaffold.

## Policy hypothesis

Use `solver_94565263e129` as the evaluated route/approach base and add only the
pre-limit posterior wave-headroom mechanism from `solver_29c7c83f8e3e`. The
normalized posterior speed opens a smooth guard in the narrow `0.96-1.0`
physical-limit band. Only a wave-acceleration component pointing outward with
posterior velocity may yield; mean-curvature tracking, damping, inward wave
action, all commands below the band, and the anterior oscillator remain
unchanged. Apply the same operation to the raw and carrier-residual allocator
branches and accept it only when total action keeps the unguarded sign and no
larger magnitude. The exact-boundary projection remains as command hygiene.

This tests whether the independently useful terminal-response and
constraint-headroom mechanisms compose: expect the sampled best's early
milestones and response-conditioned terminal route, with no loss of the
coherent traveling wake and with fewer posterior speed-limit encounters or a
smaller held-distance term. The candidate has no same-worker CFD evidence.
Falsify the combination if capture is lost or delayed materially, early
crossings regress, posterior speed or acceleration limiting rises, the mean
redirect is attenuated, wake coherence weakens, load peaks grow without target
progress, or the guard changes any below-band/inward-wave action.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control under bounded actuation and terminal target capture
source_mechanism: preserve the rhythmic locomotion carrier while response feedback allocates shared posterior authority between route curvature and propulsion
transferable_invariant: when a bounded posterior actuator must turn and propel, release approach suppression during unresolved route correction and yield only outward rhythmic demand as measured speed consumes constraint headroom
nontransferable_details: published gains, dimensional frequencies and distances, motor models, species-specific envelopes, prescribed CPG or vortex phase, exact wake geometry, and task-specific routes
policy_translation: normalized body-frame target/course response gates the existing terminal relief, while normalized posterior joint speed gates only outward wave acceleration inside the two-joint mean-first allocator
falsification: reject if below-band or inward-wave commands change, reflection equivariance fails, mean steering weakens, coherent propulsion or capture is lost, arrival regresses materially, or limiting and loads worsen without compensating target progress

## Non-CFD verification

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. I ran its three exact
  commands separately. After removing a duplicated rendering of the same
  assigned-parent marker from workspace `README.md`, the material guidance
  check passes; the lightweight Julia policy-contract check and solver
  editable-boundary check also pass. No CFD was run.
- All `34` direct `params.FIELD` references are returned by
  `target_policy_params()`. A deterministic `25,515`-state sweep over joint
  angles, joint speeds, target bearing/distance, and body-frame velocity
  returned finite bounded actions with lateral-reflection equivariance. Every
  anterior action and all `10,935` states below the posterior guard band match
  the evaluated `solver_94565263e129` controller exactly. Every changed
  posterior action retains the unguarded sign and has no larger magnitude.
- Replaying the candidate on the sampled-best trajectory reconstructs the
  next logged baseline command within `2.60e-4 rad/T^2`. The guard changes
  only `13/2918` posterior commands, all between `0.9617` and `0.9761` of the
  owned speed limit; it leaves every anterior command exact and lowers
  fixed-trace mean absolute posterior action from `24.927461` to
  `24.883493 rad/T^2`. These results establish locality, boundedness, and the
  intended allocator semantics on inherited states, not a new wake, route, or
  score result.
