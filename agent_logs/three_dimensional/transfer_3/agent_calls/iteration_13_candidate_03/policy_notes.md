# Signed collision-course C-bend candidate

## Visual diagnosis recorded before the policy edit

- All sampled and inherited evaluations use direct uniform initialization in
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The
  top-down motion and both the alternating mid-plane street and compact
  oblique Lambda2 structures are therefore self-propelled, not advection or a
  moving-window artifact.
- Both rows of the combined keyframe sheets were inspected for the assigned
  collision-course parent (`solver_dca1b5640cb9`), the response-gated capture
  (`solver_d2c490cfb432`), the safe-intercept failure
  (`solver_8b2127dcbcfc`), and the inherited executable-equivalent response
  repeat (`solver_261cd8d79b24`). The two completed captures retain coherent
  wakes and arrive from above at `19.59--19.78T`. The two later failures retain
  propulsion but pass high, reaching only `1.712L` and `2.273L` before left
  exits near `28.9T`; wake collapse is not the limiting event.
- The response-gated controller is not yet a reproducible success. Its sampled
  copy captures at `0.749L`, but the inherited repeat has identical executable
  controller expressions (only comments and the inert `version` string differ)
  and crosses the target station at `y=11.857L`, misses by `2.273L`, and exits
  left. The repeat also raises raw acceleration-envelope occupancy from
  `39.5%/71.6%` to `61.5%/76.2%`. The terminal-release child similarly crosses
  at `y=11.255L`, misses by `1.712L`, and raises occupancy to `60.6%/76.4%`.
  Thus a terminal release is downstream of the actual sensitivity: useful
  lateral correction must be established earlier, before the route command
  and posterior action spend most of the approach saturated.
- The assigned parent supplies a distinct useful cue. On its captured trace,
  the constant-velocity gate is already about `0.75` at `8T`, when bearing and
  bounded yaw-demand gates are nearly off and predicted miss is `4.34L`; near
  `14T`, its bearing gate is about `0.03` while the unsafe-intercept gate is
  about `0.92`. However, the parent uses this predictive cue only as an
  unsigned recruitment weight and still attenuates the anterior bend by the
  instantaneous yaw request, producing about `2.3 deg` rather than the
  available bounded redirect at `8T`. This leaves collision-course information
  unable to command curvature when bearing and LOS terms cancel transiently.

## Policy hypothesis recorded before editing

Preserve the assigned parent's evaluated `28 degree`, `0.55T` traveling bend,
phase-conditioned posterior response, `6 degree` anterior bound, bearing
branch, and constant-velocity range/closing/miss gates. Change one control
semantic: retain the sign of the body-frame cross product in the predicted
closest-pass estimate and let the gated signed miss issue its own anterior
curvature request. Combine it as residual authority around the bearing request
so agreement recruits the bounded C-bend earlier, disagreement releases or
reverses it, and a safe predicted intercept turns the predictive branch off.
This is a sensory collision-course redirect, not a larger curvature limit or
carrier-gain retune.

Expected evidence is the parent's coherent carrier with an earlier lateral
route correction, less prolonged late saturation, target-station crossing no
higher than the parent's `10.208L`, and repeatable capture rather than the
`11.255--11.857L` high-pass topology. Falsify the mechanism if it creates the
known lower curl, weakens the wake, materially increases load or envelope
occupancy, or fails to beat the `1.712L` and `2.273L` repeat failures.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: an observed collision-course error directly recruits bounded mean curvature on a persistent rhythmic carrier and releases as a safe intercept is established
transferable_invariant: preserve propulsion while a signed sensory route error commands reversible bounded redirect authority instead of merely gating an unrelated instantaneous request
nontransferable_details: species-specific C-start shapes and timing, robot linkage geometry, published gains, dimensional frequencies, exact vortex phases, world-frame routes, and task coordinates
policy_translation: form a signed closest-pass estimate from normalized body-frame target and rigid velocity, gate it by normalized range and closing motion, and blend its bounded anterior-center request with the bearing request under the two-joint state-feedback contract
falsification: reject if the route curls below the target or to a boundary, the coherent wake or load history worsens, or repeated evaluation retains the more-than-1.7L high pass despite predictive recruitment

## Dry validation after editing

- Offline replay on the assigned parent's recorded states keeps the unchanged
  `6 deg` bound while raising the anterior request from `2.30` to `4.50 deg`
  at `8T` and from `4.07` to `5.09 deg` at the `14T` bearing lull. On the
  response-capture trace, the request returns from `5.84 deg` at `12T` to
  `4.86 deg` when predicted miss falls to `0.03L` at `14T`, so the new branch
  does not become a static bias. This replay tests signal semantics only; it
  does not predict the changed closed-loop CFD trajectory.
- The deterministic parameter-schema comparison passes: every direct
  `params.FIELD` reference is declared by `target_policy_params()`. The
  guidance semantic check and solver boundary check also pass after removing
  a duplicated assigned-parent marker from the rendered workspace README.
- The mandated check-runner was invoked. Its Julia contract probe cannot start
  because no `julia` executable exists in this worker environment; the static
  schema check, bounded finite expressions, and reflection-equivariant sign
  structure were inspected instead. No CFD rollout was run, and no outcome for
  this candidate is claimed here.
