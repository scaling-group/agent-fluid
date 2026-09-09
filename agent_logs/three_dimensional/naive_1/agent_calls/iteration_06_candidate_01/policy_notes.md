# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the edit

All four sampled evaluations satisfy the frozen evidence contract: direct
uniform initialization in still water with `U_infinity=[0,0,0]`, no cylinders
or prewarm, finite dynamics, and valid moving-window transport. I inspected
the combined top-down vorticity and oblique body/Lambda2 sheets for the
best-scored capture, the prefilled capture, and the assigned parent's
rate-guard failure, then cross-checked the views against `wake_metrics.csv`,
`trajectory.csv`, `wake_diagnostics.json`, controller sources, and inherited
optimization notes.

The four sampled policy files have identical executable equations and
parameters; their source differences are comments only, and two files are
byte-identical. All four capture at `0.7482--0.7497L` in
`19.228--19.784T`, with scores from `-0.243312` to `-0.229933`. Their
top-down rows consistently show self-propelled target-directed translation and
a coherent alternating street through capture, while the oblique rows retain
finite compact caudal Lambda2 structures. The score spread is therefore a
repeatability band for one controller, not evidence for choosing a scalar gain
from a comment-only variant.

The assigned parent tested an outward-acceleration rate guard at `85%` of the
joint-rate envelope while preserving the route equations. Its wake remained
coherent in both views, but the trajectory lost the downward target turn,
reached only `5.0277L`, and exited high at `22.132T` with final distance
`5.9506L`. An independent inherited `80%` guard repeated the same topology:
`5.3386L` minimum and high-side exit at `21.203T`. Thus reducing same-sign
acceleration as joint rate rises is a concrete negative result: it changes the
carrier/mean-curvature interaction enough to erase capture, even though wake
coherence alone makes the motion look propulsive.

The narrower defect remains policy-interface demand. The repeated captures
return raw accelerations above `1800 deg/T^2` on about `61.7--62.2%` of
anterior and `71.7--72.3%` of posterior rows. However, the episode's
`integrate_joint_state` already hard-clamps each returned acceleration to that
same physical envelope before updating rate and angle. Therefore a policy-side
hard projection at the identical limit is behaviorally equivalent to the
captured controller, whereas a rate-dependent taper is not.

## Single-candidate policy hypothesis

Preserve the evidenced oscillator, posterior lag, normalized body-frame
lateral request, differential curvature, and one-sided yaw release exactly.
Add only a policy-owned acceleration-envelope parameter and hard-clamp the two
completed commands immediately before return. This should reproduce the
captured applied joint trajectory while ensuring that the public policy never
requests an acceleration outside its owned physical envelope. It is an
isolated interface ablation of the failed guard bundle: no rate feedback,
distance stage, gain change, or new route channel is added.

Falsify the candidate if returned commands exceed the owned envelope, if the
policy output differs from the episode's existing hard projection for any
finite state, or if formal CFD loses the repeated capture/wake/trajectory
topology beyond the observed repeatability band. The new CFD result is not
available to this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: actuator-limited robotic-fish state-feedback CPG control and classical traveling-bend propulsion
source_mechanism: preserve a low-dimensional propulsive carrier and enforce the physical actuator envelope at the command interface
transferable_invariant: actuator projection must preserve target-owned mean curvature and carrier phase; measured-rate feedback is a separate mechanism that requires its own evidence
nontransferable_details: published CPG gains, dimensional beat rates, motor models, species-specific envelopes, exact vortex phases, full-body kinematics, and task-specific routes
policy_translation: retain the captured normalized body-frame differential-curvature equations and clamp only their completed two-joint acceleration outputs at the policy-owned episode envelope
falsification: reject if output bounds fail, capture or coherent posterior wake is lost, or high-side route topology returns despite exact equivalence to the episode projection
