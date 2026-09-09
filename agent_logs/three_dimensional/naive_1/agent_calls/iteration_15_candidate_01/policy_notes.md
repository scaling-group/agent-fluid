# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All sampled and inherited comparison rollouts used direct uniform still-water
initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I
inspected both rows of the combined keyframe sheets for the strongest sampled
capture and the assigned parent's newly completed posterior-preservation
failure, then cross-checked the images against their observations, metrics,
diagnostics, trajectories, policies, inherited notes, and durable guidance.

The two executable-identical geometry-only schedules are the strongest clean
comparison. They reduce the rhythmic envelope only with absolute normalized
body-frame lateral target fraction while leaving differential curvature,
displacement-only half-cycle steering, response release, and posterior lag
unchanged. Both form a coherent alternating top-down street and compact
caudal Lambda2 structures along a broad target-directed trajectory. They
capture at `18.65050T` and `18.68350T`, with mean scored distances
`2.09340L` and `2.09405L`. The response-coupled prefill has the same visible
wake and route class and captures at `18.66150T` and `2.09362L`; those values
sit inside the geometry-only repeat spread, so multiplying gait relief by the
existing yaw-response gate adds complexity without an attributable benefit.
The terminal range/lateral-velocity compound is also weaker: it keeps capture
but arrives at `19.05201T`, has mean distance `2.09874L`, and takes a larger
vertical excursion.

The newest inherited result is the decisive failure boundary. Scaling the
posterior displacement-plus-lag wave by the inverse relieved anterior envelope
keeps an energetic top-down street and compact three-dimensional caudal
structures, proving continued self-propulsion. However, its sheet turns
steeply downward by `16T` and continues away at `24--28T`; the trajectory
reaches only `3.14646L`, exits left at `28.07753T`, and finishes `9.21649L`
from the target. Acceleration-envelope contact also rises to about
`63.9%/74.7%`, versus about `61%/73%` in the captured geometry schedules.
Thus separately preserving posterior sweep does not preserve the captured
route or reduce demand; the whole traveling-bend carrier must remain inside
one coherent geometry-scheduled envelope.

## Single-candidate policy hypothesis

Restore the replicated geometry-only redirect/cruise mechanism. Absolute
normalized lateral target fraction schedules a bounded reduction of only the
oscillator amplitude; correcting yaw continues to release target-signed mean
curvature but no longer weakens the gait schedule. Preserve displacement-only
phase redistribution, the non-inverting response-release gate, differential
curvature shares, posterior lag, and the final acceleration projection. This
is one architectural separation of route response from gait scheduling, with
no gain changes, terminal residual, posterior compensation, or new actuator
channel.

The expected result is another capture in the established geometry-schedule
route band with both coherent wake views intact. Falsify the candidate if it
loses capture, leaves the `18.650--18.684T` and `2.0934--2.0941L` replicated
band beyond finite variability, repeats the downward exit, or worsens joint
saturation or planar loads. The evidence does not justify calling this demand
relief; acceleration and rate contact remain separate unresolved problems.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and biological redirect-to-cruise transitions
source_mechanism: sensor-driven rhythmic-envelope modulation remains separate from target-signed mean-curvature steering and observed beat phase
transferable_invariant: persistent normalized body-frame target misalignment may schedule the whole two-joint traveling-bend envelope continuously while steering response releases curvature, without independently rescaling posterior wave state
nontransferable_details: published gains, dimensional frequencies, duty ratios, C-start timing, species-specific envelopes, motor models, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: use absolute lateral target direction cosine to schedule the existing bounded oscillator envelope; retain target-owned curvature sign, displacement-only half-cycle phase, response release, posterior lag, and final projection unchanged
falsification: reject if capture or either coherent wake view is lost, the route leaves the replicated capture band, the downward exit returns, or saturation and planar loads materially worsen
