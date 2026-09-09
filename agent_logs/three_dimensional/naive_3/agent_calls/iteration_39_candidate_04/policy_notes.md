# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for `solver_a6820a0af3d7` (the closest sampled finite rollout) and
  `solver_b5de8ff4a388` (the clearest parked-return failure), and cross-checked
  all four sampled traces, diagnostics, and scores. Each evaluation reports
  direct uniform initialization with `U_infinity=(0,0,0)`, no prewarm, and a
  `100T` horizon. The fish is self-propelled rather than advected: the sheets
  show coherent alternating wakes and repeated powered loops, while the
  trajectories retain about `0.67U` speed near their minima.
- The visible failure is an oversized closed orbit, not absent propulsion or a
  broken 3D wake. The four sampled candidates finish at `3.310--3.502L` and
  reach only `2.215--2.439L`. Near every sampled minimum, `course_dot` is about
  `-0.13`, course error is about `+1.70 rad`, body lateral velocity is about
  `+0.50U`, and useful yaw remains near `-0.25 rad/T`. Three mechanisms park
  both joints at roughly `0.001--0.003 rad/T`; posterior turn-response phase
  modulation (`solver_fbea116ed491`) also leaves the same broad loop. Thus
  more yaw, static bend release, or another geometry-only posterior phase
  command is not supported.
- The assigned parent and inherited worker scores identify the active scaffold
  that is absent from the prefill: two-sided, velocity-odd anterior energy at
  low terminal activity reached `1.175L` and stayed inside `1.25L` for about
  `2.35T`. Stronger radial energy (`1.366L`), a requested-side pulse
  (`1.702L`), duty asymmetry (`2.362L`), an equal-and-opposite counterphase
  burst (`1.192L` with shorter residence), and response-held equilibrium
  release (`1.177L` with worse mean distance) do not justify changing that
  anterior law. The candidate therefore reconstructs that anterior-only
  scaffold rather than retaining the prefilled parked-bend release.
- A force/course cross-check provides a distinct feedback signal. For samples
  inside `3L`, the body-frame force component that rotates velocity toward the
  target has median normalized magnitude about `0.00096`; when its sign is
  useful, mean measured course rotation is `-0.31` to `-0.34 rad/T`, whereas
  opposite-sign samples rotate outward at `+0.84` to `+0.95 rad/T`. This is
  evidence for using force as a gait-phase selector, not evidence that a
  particular gain is already correct.

## Policy hypothesis

Preserve the evidenced mean bends, nominal lag, course hold, and exact
phase-balanced anterior regulator. Add one capture-local posterior energy
residual parallel to measured posterior velocity only when the current
body-frame hydrodynamic force is already rotating translational velocity
toward the target. A steep `1.35L` distance envelope prevents the residual
from changing the established first return outside the terminal region; a
force threshold selects productive force phases instead of adding continuous
posterior drive. This tests course conversion directly rather than assuming
that extra body yaw implies inward translation.

Falsify the mechanism if evaluation changes the first return, broadens the
loop, parks either joint, weakens wake coherence, increases clamp/load
residence, or fails to improve closest approach and time inside `1.25L`
together. In particular, extra yaw without a more positive `course_dot` is a
negative result even if the closest-distance scalar changes slightly.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and wake-adaptive swimming
source_mechanism: sensory modulation of a rhythmic carrier and selective preservation of useful fluid-induced motion
transferable_invariant: preserve the traveling-wave carrier and reinforce only actuation phases whose measured hydrodynamic response advances the body-frame task objective
nontransferable_details: published gains, species kinematics, dimensional frequencies, exact vortex phases, organized-cylinder-wake assumptions, and prescribed routes
policy_translation: use normalized body-frame target, velocity, force, joint velocity, and distance to gate a bounded posterior velocity-odd residual while leaving mean curvature and nominal lag unchanged
falsification: reject on lost active motion or wake coherence, a changed first return, higher clamp or load residence, yaw without inward course rotation, or no joint improvement in closest approach and near-target residence
