# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held in the upper-right while four
  developed cylinder streets interact around the second-row target. This is a
  common initial condition, not a transferable vortex phase or route.
- The assigned parent reaches the target after `149.605` released units with
  `4.35835L` mean distance, `96932.99` total command energy, and
  `0.13206/15.49/308.48` RMS relative crossflow/lateral force/yaw moment. Its
  released sheet shows active upstream motion and an alternating posterior-
  lagged bend, but a broader midcourse fold before wake-corridor entry.
- Three independent sampled solvers add only positive-closing-speed
  qualification to the parent's bearing-rate damping and reproduce the same
  stronger finite result: capture at `137.357`, `4.18356L` mean distance,
  `90228.38` total energy, and `0.12955/14.75/303.02` RMS crossflow/force/
  moment. Their sheet retains the alternating traveling bend and shows a
  tighter redirect through the interacting wake. Their `-10.914L` upstream
  head displacement and body x-speed magnitude exceeding mean local-flow x
  establish self-propulsion rather than passive advection.
- No current sampled solver is a semantic failure, so the informative
  mechanism failure comes from the inherited logs and keyframes. Same-sign
  posterior half-cycle modulation makes repeated large loops above and below
  the useful corridor, delaying capture to `279.439`, raising mean distance to
  `6.982L`, and nearly doubling energy to `182836`. Other inherited additions
  (bearing-history smoothing, unconditioned crossflow or lateral-target
  residuals, posterior counter-modulation, and tail-lag modulation) also
  retain capture only with worse arrival, distance, effort, or load. The
  evidence supports restoring the isolated replicated mechanism rather than
  stacking a novel residual or changing gait gains.

## Candidate hypothesis

Make exactly one feedback-topology change to the assigned parent. Preserve
instantaneous body-frame bearing as route owner, the bounded moment residual,
state-inferred half-cycle asymmetry, oscillator, and posterior lag. Multiply
only `bearing_window_rate` damping by a smooth gate from positive normalized
`window_closing_speed_L`. Bearing change without closing can be body rotation;
withhold that damping until measured targetward translation corroborates the
response, then restore it continuously. The expected formal result is the
sampled `137.357`-unit capture topology with lower distance integral, total
effort, crossflow, and loads than the assigned parent. Falsify if capture,
upstream translation, or the alternating wave is lost, or if arrival,
distance, effort, load, or cap contact regresses toward or beyond the
rate-only parent.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and nonsteady fish redirect control
source_mechanism: release target-response damping only after observed response is corroborated by targetward translation
transferable_invariant: persistent normalized body-frame target geometry should own route steering, while response damping should depend on normalized measured progress rather than elapsed time or assumed wake phase
nontransferable_details: published gains, dimensional gait settings, species-specific redirect kinematics, robot linkage geometry, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: preserve the state-feedback two-joint traveling bend and multiply only normalized bearing-rate damping by a bounded gate from positive normalized closing speed
falsification: reject if progress qualification loses or slows capture, raises distance integral, effort, load, or cap contact, destroys posterior lag, or recreates a loop or boundary exit
