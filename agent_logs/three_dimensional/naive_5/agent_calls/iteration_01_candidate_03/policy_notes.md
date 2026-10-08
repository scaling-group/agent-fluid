# Candidate wake-policy notes

The assigned guidance parent is `optimizer_04c42bba5b21`; no inherited
candidate-specific optimizer log was present in `logs/optimize/` before this
worker, so the diagnosis below combines that parent's control contract with
the sampled seed rollout evidence.

## Evidence diagnosis before policy edit

The only sampled rollout is the common naive seed, so the useful finite state
and the informative failure are two phases of the same trajectory. The
combined and view-specific keyframe sheets confirm direct uniform still-water
initialization (`U_infinity=0`) and genuine self-propulsion: by 4--6T the
top-down row has an alternating attached-to-shed vorticity pattern, while the
oblique row shows compact alternating Lambda2 structures trailing the body.
The wake becomes strongest and most coherent near 8T, but that visual strength
does not correspond to task progress.

Quantitatively, distance improves only from 12.328L to a best 12.078L at
6.358T, then worsens to 12.380L before `left_domain` at 8.547T. Center motion
changes from mostly target-compatible leftward motion to strong positive-y
motion; the body-frame bearing grows in magnitude from about +0.155 rad at
release to -1.18 rad near 8T as the unguided fish turns away. The trajectory
also reaches the exact 260 deg/T velocity cap on both joints, while raw policy
commands peak near 59.9 and 75.4 rad/T^2, beyond the 1800 deg/T^2 actuator
envelope. Thus the seed demonstrates a usable traveling-bend propulsion
mechanism, but its aggressive carrier wastes authority and has no route
restoring mechanism; a coherent wake alone is not a positive control result.

## Policy hypothesis

Retain a joint-state oscillator and lagged posterior target, but center both
joint motions on one bounded mean-curvature bias computed from normalized
body-frame target bearing. A positive joint bias is expected to produce
negative yaw according to the repository's matched-kinematics turn audit, so
positive bearing should rotate the fish toward zero bearing. Use `tanh` to
limit the bias and preserve the oscillatory wave. A lower-amplitude, longer
period carrier is included to keep nominal joint speed and acceleration away
from the caps observed in the sampled rollout; it is not the transferred
mechanism.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking and fish mean-curvature turning
source_mechanism: sensor-driven modulation of a rhythmic gait by bounded average bend
transferable_invariant: persistent body-frame target error can steer an existing propulsive rhythm through bounded mean curvature without prescribing phase or route
nontransferable_details: published gains, clock-driven CPG phase, species-specific kinematics, exact vortex phase, and task-specific trajectories
policy_translation: map clamped normalized body-frame bearing through tanh to a shared joint-angle center, then run the anterior state oscillator and posterior lag about that center
falsification: reject the transfer if bearing does not trend toward zero before 6T, the fish repeats an upper-boundary exit, distance fails to beat 12.078L, or biasing destroys the alternating wake or keeps either joint at its rate/acceleration cap
