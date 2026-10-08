# Candidate diagnosis and policy hypothesis

## Visual and metric diagnosis before the edit

- All four sampled rollouts and the assigned parent's inherited rollout use
  direct uniform still-water initialization with `U_infinity=[0,0,0]`, no
  cylinders, and no prewarm. In the sampled best-score distance-relief sheet
  and informative closure-conditioned failure sheet, the top-down rows retain
  alternating vortex streets and the oblique rows show tail-connected 3D
  Lambda2 structures through exit. Their common failure is route control: they
  approach only to `5.126L` and `4.162L` respectively and both leave through
  the upper boundary. Carrier formation is not the missing capability.
- The assigned parent's convention-aware yaw-response rollout is a semantic
  improvement that was unavailable when its candidate was written. It reaches
  `2.299L`, compared with the sampled `4.162L` best approach, survives to
  `28.41T`, and lowers acceleration near-limit residence to about `55.0%`
  versus `66.0--70.3%` in the closure- and distance-relief samples. Peak speed
  (`0.990U`), planar force (`0.0341`), and yaw moment (`0.0175`) remain finite
  and within the sampled envelopes. Its top-down row keeps an alternating wake
  through the useful transit; its oblique row remains tail-connected through
  the approach. The final panels show a sharp late bend rather than numerical
  wake collapse.
- This improvement validates the parent's empirical convention only within a
  boundary: posterior actuator-coordinate route request and physical yaw have
  opposite useful signs. The policy's requested-yaw residual redirects the
  path farther downward than the four sampled controllers. It is not a capture
  mechanism by itself: the fish reaches its minimum near `18.41T` with speed
  about `0.783U`, the target still about `2.06L` lateral in body coordinates,
  and a nearly maximal wrong-response residual (requested physical yaw about
  `+0.80 rad/T`, measured short-window yaw about `-2.01 rad/T`). It then passes
  the target longitudinally, recedes to `8.092L`, and exits high.
- Existing alternatives do not support another scalar or proximity scheduler.
  Distance/closure drive relief and bearing-course agreement gates retained the
  same upper-exit topology, while the direct geometric sign reversal reached
  only `6.850L`. At the inherited `2.299L` minimum the mean posterior curvature
  is already effectively saturated, but the phase-compatible opposing
  half-cycle gate still has room to attenuate only the counterproductive wave
  excursion. The missing capability is therefore response-conditioned use of
  that distinct actuator, not more mean-curvature gain.

## Single candidate hypothesis

Start from the inherited convention-aware yaw-response controller, including
its full anterior state-feedback carrier, posterior lag, bounded mean
curvature, crossflow residual, approach-aware anterior redistribution, and
course-gated posterior half-cycle relief. Add one compatible mechanism: form a
bounded directional deficit from the positive agreement of actuator-coordinate
route request and actual-minus-requested physical yaw residual. After forward
speed is established, use that deficit to add limited attenuation only on the
posterior half-cycle already identified as opposing the requested turn. A
correct or overachieving yaw response makes the addition exactly silent; the
useful half-cycle is never amplified or attenuated.

Expected result: preserve the parent's early targetward route and coherent 3D
wake while adding steering authority near the observed `2.299L` response
failure, so the fish redirects farther downward before longitudinally passing
the target. Reject the mechanism if closest approach is worse than `2.299L`,
the same upper exit persists without a materially different targetward arc, or
acceleration residence, peak force, peak moment, or wake organization degrade
relative to the inherited parent. A capture or a new termination class is the
strong semantic success criterion; scalar score alone is insufficient.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and asymmetric flapping
source_mechanism: preserve a rhythmic carrier while observed directional-response deficit gates bounded asymmetric turning authority
transferable_invariant: compare requested and measured directional response in one calibrated body-relative convention, add phase-selective authority only during response deficit, and release it when response appears
nontransferable_details: published gains, robot geometry, dimensional frequencies, duty ratios, species kinematics, exact vortex phases, maneuver duration, and task-specific routes
policy_translation: retain normalized body-frame target, velocity, crossflow, yaw, and joint-state phase; map the posterior request to opposite-sign physical yaw and let its bounded undershoot activate only extra opposing-half-cycle relief
falsification: reject if the inherited 2.299L approach or coherent carrier is lost, the upper-exit topology remains without a more targetward arc, or saturation and hydrodynamic loads materially increase

## Evaluation boundary

No CFD result is claimed for this candidate. The post-worker evaluation should
compare semantic termination and minimum distance first, then longitudinal and
lateral target components at closest approach, post-minimum recession,
requested-versus-measured yaw response, speed, acceleration-limit residence,
force/moment peaks, and both wake views.

Replaying only the new algebra on the inherited parent history keeps the
posterior wave scale in `[0.503, 1.0]`. Its mean changes only from `0.982` to
`0.977` at distances of at least `8L`, compared with `0.831` to `0.783` inside
`3L`. At the observed `2.299L` minimum, the response-deficit gate is `0.927`
and changes the opposing-half-cycle scale from `0.782` to `0.653`; at rest the
forward-speed gate makes the addition zero. This establishes boundedness and
localization on a completed history, not a counterfactual hydrodynamic result.
