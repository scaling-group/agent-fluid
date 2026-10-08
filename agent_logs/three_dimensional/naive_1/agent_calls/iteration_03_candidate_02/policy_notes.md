# Phase 2 candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled episodes satisfy the direct-uniform still-water contract:
`U_infinity=[0,0,0]`, no cylinders, and no prewarm snapshot. Their top-down
rows show active leftward translation followed by the same clockwise/upward
curl, while the oblique rows show compact alternating three-dimensional
caudal structures rather than passive advection or numerical wake breakup.
Every policy exits the upper virtual boundary before `9T`, so none supplies a
semantic target-control success.

The inherited notes correctly rejected phase-blind/static common-curvature
steering after those laws either extinguished the carrier or preserved the
same exit. The next generation's phase-conditioned results sharpen that
lesson. Anterior velocity-gated half-cycle drive is the strongest sample
(`solver_8596fba5898a`): relative to the target-blind seed it improves minimum
distance from `12.078L` to `11.782L`, final distance from `12.380L` to
`11.797L`, and score from `-14.825` to `-14.165`, while retaining a coherent
wake. Posterior half-cycle scaling is weaker (`12.006/12.205L` minimum/final),
and a residual shared by both joints is worse (`12.140/12.686L`). Thus the
useful actuator location is currently the anterior half-cycle, not a common
residual or posterior amplitude scaling.

That improvement is not yet directional regulation. Reconstructing bearing
from the recorded body pose shows that the best rollout crosses from small
positive error to `-0.33 rad` by about `4.5T`, then spends most of the remaining
episode between roughly `-0.5` and `-1.4 rad` while the controller continues
the upper hook. It reaches its minimum only at `8.28T`, already near the upper
boundary, and exits at `8.98T`. Its requested accelerations exceed the
`1800 deg/T^2` envelope on about `44%` of samples for each joint, versus about
`32--34%` in the seed, and both joint rates touch `260 deg/T`. More ungated
half-cycle drive would therefore spend additional command in clipping without
supplying the missing large-error redirect.

## One candidate hypothesis

Retain the best candidate's zero-centered anterior oscillator and its
small-error anterior half-cycle steering. Add one continuous burst-redirect
mode driven only by normalized body-frame bearing and measured yaw rate. When
absolute bearing becomes large, smoothly transfer steering authority from the
energy-injecting anterior residual to a bounded mean offset of the posterior
lag target, and modestly relieve posterior carrier amplitude to leave actuator
room for the redirect. Correct-sign yaw unloads the offset through a
rate-leaded error; when the response is sufficient or bearing returns to the
small-error band, the full traveling carrier and anterior half-cycle law
return automatically. This is an observation-gated feedback mode, not a
clocked maneuver or memorized route.

The predicted semantic change is a positive-yaw recovery after the persistent
negative bearing develops, replacing or materially delaying the upper exit
while retaining alternating propulsion. Falsify the mechanism if the
posterior wake collapses, the tail parks at a static offset, saturation grows,
closest/final distance fails to improve over the current best, or the same
upper-exit topology remains without a clear corrective arc.

bookshelf_consulted: true
source_domain: biological C-start redirection and closed-loop robotic-fish gait modulation
source_mechanism: large-error bounded curvature burst that releases into the propulsive rhythm as heading response develops
transferable_invariant: reserve a stronger curvature actuator for large target-relative error, unload it with measured yaw response, and restore the traveling wave after redirection
nontransferable_details: species-specific C-start shapes, published gains, dimensional beat timing, exact vortex phase, hidden maneuver stages, and task-specific routes
policy_translation: use smooth magnitude gating on body-frame bearing and rate-leaded turn error to blend from anterior half-cycle drive into a bounded posterior lag-target offset with partial carrier relief
falsification: reject if large negative bearing does not produce a corrective positive-yaw arc, if upper-boundary exit persists without later progress, or if carrier loss, static tail bend, or actuator clipping worsens
