# Geometry-agreement anterior redirect candidate

## Evidence diagnosis before the edit

All four sampled rollouts and the assigned parent's completed response-release
rollout use direct uniform still-water initialization with
`U_infinity=[0,0,0]`, no cylinders, and no prewarm. Their combined sheets show
self-propulsion rather than advection: the top-down rows retain a strong
alternating vortex street, while the oblique rows retain tail-connected
three-dimensional Lambda2 structures. The visible failure is planar route
control. Every sampled fish passes above the target and exits through the
upper virtual boundary with the organized wake still attached.

The best-score sampled policy reaches only `5.126L`; the assigned signed-
response prefill reaches `4.743L` and recedes to `5.938L`. Its inherited
response-release descendant preserves essentially the same wake and route but
worsens the minimum/final distances to `4.867L`/`6.013L`. Short-window bearing
response is therefore not a useful release signal here: it modulates the slow
posterior route request without changing the upper-exit topology. Posterior
wave attenuation is also repeatedly negative. Course-only, signed-agreement,
and closure-conditioned posterior relief reach `5.000L`, `4.743L`, and
`4.162L`, whereas the inherited full-wave approach-redistribution reference
reached `3.135L`.

The sampled trajectories localize the missing redirect. At about `12T`, body
bearing is nearly centered (`-0.07` to `-0.23 rad`) but target-versus-velocity
course error is already strongly negative (`-0.72` to `-1.00 rad`). By
`16--18T`, course error is roughly `-0.80 rad` or saturated at `-pi/2` and the
fish still carries `0.73--0.94U`, so terminal coasting is not the missing
capability. The inherited agreement-gated half-cycle policy gets lower in the
virtual field and approaches to `3.580L`, but attenuating its posterior wave
still cannot arrest the later upward turn. This separates a useful directional
gate from a harmful actuator placement.

## Single policy hypothesis

Restore the complete posterior traveling wave and preserve the evidenced
full-amplitude anterior oscillator, bounded posterior steering mean,
crossflow residual, yaw rejection, and smooth acceleration envelope. Replace
posterior half-cycle attenuation with one C-start-like response mechanism:
apply the bounded course correction as a small anterior oscillator-equilibrium
shift only when body-frame target bearing and speed-qualified
target-versus-velocity course error agree in sign. Disagreement, course
alignment, or bearing alignment releases the shift continuously. This makes
the actuator silent during the misleading startup course transient near `4T`,
but gives it authority through the persistent same-sign miss from about `8T`
onward without reducing either posterior half-cycle.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve a propulsive rhythm while observed directional error gates a bounded body-curvature redirect that releases on alignment
transferable_invariant: separate the traveling-wave carrier from a bounded geometry-triggered redirect and release the redirect when independent body-frame route and motion cues cease to agree
nontransferable_details: published gains, maneuver duration, dimensional frequency, species or robot kinematics, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: keep the full two-joint state-feedback wave; multiply bounded body-frame bearing and speed-qualified target-versus-velocity course commands, and use only positive agreement to shift the anterior oscillator equilibrium toward the course correction
falsification: reject if the far carrier or coherent 3D wake degrades, closest approach is worse than the inherited `3.135--3.580L` full-wave/agreement references, course error does not turn back before the old `16--18T` miss, the same receding upper exit persists, or saturation, peak force, or peak moment increase materially

## Evaluation boundary

No CFD outcome is claimed for this candidate. The post-worker evaluation must
compare route height and course error through `8--18T`, minimum and final
distance, termination class, acceleration-limit residence, force/moment peaks,
and both wake views. A coherent wake alone is not evidence that the redirect
worked.

## Non-CFD gate audit after the edit

Replaying only the new algebra on the assigned prefill trajectory makes the
redirect exactly zero at `4.004T`, when bearing is `-0.033 rad` and course
error is `+1.086 rad`. It then requests bounded anterior centers of about
`-2.24`, `-2.47`, and `-3.10 deg` at `8.003T`, `12.001T`, and `16.005T`, when
bearing and course agree on the miss. The reconstructed maximum at the old
closest-approach row is about `-3.50 deg`, below the owned `4 deg` limit. This
checks sign, localization, and boundedness only; it is not counterfactual CFD
evidence.
