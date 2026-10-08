# Closure-loss burst-redirect candidate

## Visual and metric diagnosis before the edit

- All four assigned examples report direct-uniform still-water initialization,
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. In the compared combined
  sheets (`4482...`, the best scalar result, and `9295...`, the closest sampled
  approach), the top-down rows form persistent alternating vortex streets and
  the oblique rows retain tail-connected three-dimensional Lambda2 structures.
  The fish are self-propelled; the common failure is route geometry, not wake
  collapse or numerical instability.
- Every assigned example exits through the upper virtual boundary at about
  `20.86--21.72T`. The best-score distance-relief policy reaches only `5.126L`
  and finishes at `5.885L`; the response-release, signed half-cycle, and
  closure-gated yaw-response variants reach `4.867L`, `4.743L`, and `4.530L`
  respectively, then finish at `5.938--6.035L`. The visual final frames agree:
  an intact propulsive wake follows a high-side trajectory away from capture.
- The sampled closure-gated yaw-response descendant is the strongest current
  approach, but it is a regression from the inherited full-wave yaw-response
  result. The inherited controller reached `2.299L` at `18.41T` and survived
  to `28.41T`; adding instantaneous closure-conditioned posterior-wave relief
  reaches only `4.530L` at `17.25T` and exits at `21.72T`. Its reduced
  near-limit acceleration residence (`59.3%`) and bounded peak force/moment
  (`0.0306`/`0.0157`) do not compensate for losing `2.231L` of approach.
- At the sampled closure policy's minimum, speed remains `0.725U`, reconstructed
  target-versus-velocity course error is beyond `-pi/2` before clamping, and
  body-frame radial closure reconstructed from target dot velocity is already
  about `-0.217U`. The signed-agreement policy likewise has `-0.272U` radial
  closure at its minimum. By contrast, the response-release and amplitude-
  relief minima still show positive center-velocity radial closure despite
  head-distance minima, exposing beat/rotation sensitivity in an instantaneous
  head-distance derivative. Terminal feedback should use the kinematic radial
  cue and should not remove the traveling wave.

## Single policy hypothesis

Retain the inherited actuator-calibrated yaw-response route: full anterior
state-feedback oscillator, approach-aware anterior course redistribution,
bounded posterior mean, measured-yaw response error, state-derived posterior
lag, and its phase-compatible half-cycle attenuation. Remove the sampled
terminal posterior-wave relief completely. Add one separate C-start-like burst
redirect to posterior mean curvature only when three body-frame facts agree:
the target is near, target-versus-velocity course error is large, and the
kinematic radial closure `dot(target_body_L, velocity_body_U)/|target_body_L|`
has been lost. The extra bend uses the empirically calibrated course-to-
posterior sign, remains smoothly bounded, and releases automatically when
closure is recovered; it never attenuates the oscillator or posterior wave.

This is a new feedback primitive rather than scalar gain tuning. The completed
full-wave yaw-response result supplies the route carrier, while the assigned
failure supplies the need for a response-triggered redirect after overshoot.
Expected result: preserve the inherited deep first approach and connected wake,
then turn the still-fast fish back toward the target soon enough for a second
approach instead of repeating the high exit. Falsify the mechanism if it
perturbs the pre-loss route, destroys the alternating wake, raises joint/load
residence materially beyond the sampled envelope, or fails to create capture,
a re-approach, or a better termination topology.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish rhythmic direction control
source_mechanism: apply a bounded redirect under large observed route error, then release it into the propulsive rhythm when the measured response restores approach
transferable_invariant: keep rhythmic propulsion and corrective curvature in separate channels, triggering the latter from normalized geometry and response rather than elapsed time
nontransferable_details: species-specific C-start shape, published gains and frequencies, robot kinematics, maneuver duration, exact vortex phase, and task-specific routes
policy_translation: preserve the two-joint state-derived carrier and yaw-response route; when proximity, course misalignment, and body-frame radial closure deficit agree, add bounded posterior mean curvature and release it when closure returns
falsification: reject if the inherited first approach or wake is degraded, loads increase materially, or the redirect does not produce capture, re-approach, or a meaningfully different exit

## Evaluation boundary

No CFD result is claimed for this candidate. Its later evaluation should compare
capture and termination first, then first minimum, re-approach count and depth,
post-minimum recession, radial closure/course error, acceleration residence,
force/moment peaks, and both wake views.
