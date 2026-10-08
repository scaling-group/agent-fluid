# Multi-wake policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common held fish above and downstream of
  four developed, interacting cylinder wakes. It fixes the initial condition
  but provides no candidate-specific phase, coordinate, or route cue.
- All four sampled released sheets are finite captures and show the same useful
  topology: the zero-centered traveling bend immediately sheds a body wake,
  drives a diagonal down-left transit, and makes one broad correction through
  the merged streets into the target. No sampled failure keyframe is retained;
  the inherited below-target collision at `58.93`, `1.872L` closest approach,
  and `537/4995` force/moment RMS is therefore used only as a quantitative
  boundary against broad propulsion reallocation.
- The assigned-parent/prefill rate-and-yaw authority separator reaches the
  target at `45.260`, with score `0.165009`, mean distance `1.71529L`, command
  energy mean `1030.54`, and force/moment RMS `438.82/4341.50`. Three sampled
  copies reproduce those metrics exactly, establishing deterministic
  materialization under the shared wake snapshot rather than robustness.
- The one distinct sampled policy keeps that scaffold but caps the heading-rate
  prediction horizon by normalized distance divided by body speed. It preserves
  the visible diagonal topology and improves score to `0.165860`, arrival to
  `45.221`, and mean distance to `1.71458L`; command energy drops slightly to
  `1030.39`, while force/moment RMS is essentially unchanged at
  `439.16/4344.77`. This narrow discriminator supports terminal prediction
  scheduling, not another gait or gain change.
- Both policies still touch about `4.538` rad/time joint-rate magnitude and
  approach the candidate soft acceleration limit. The evidence does not
  support weakening the base wave or claiming that saturation is solved.

## Policy hypothesis

Preserve the state-feedback oscillator, posterior lag, yaw-gated steering,
positive normalized-closure residual, rate-and-yaw gating of positive course
amplification, and full negative course correction. Change only the prediction
used by route steering: bound its heading-response horizon by the remaining
body-frame distance divided by normalized body speed. Far away this is exactly
the inherited controller; near capture it stops extrapolating the current turn
beyond the available closing time.

The sampled fixed-snapshot result supports a small approach/effort improvement,
not robustness or load relief. Falsify the mechanism if replay loses target
capture or the diagonal topology, meaningfully worsens `1.7153L` mean distance,
arrives later than `45.260` without a compensating load reduction, or changes
into the inherited below-target collision family.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG path following and terminal capture control
source_mechanism: preserve a low-dimensional propulsive rhythm while matching residual steering prediction to observed response and remaining approach time
transferable_invariant: do not project a measured turn farther ahead than the normalized time remaining to close the current body-frame target distance
nontransferable_details: published gains, dimensional frequencies, species-specific gait envelopes, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: cap the existing heading-rate response horizon by `distance_L / max(velocity_body_U magnitude, body_speed_floor)` before computing bounded body-frame bearing feedback; leave the two-joint base wave and authority gates unchanged
falsification: reject if capture or the inherited diagonal topology is lost, mean distance regresses beyond the parent without material load relief, or terminal steering still produces the inherited below-target pass
