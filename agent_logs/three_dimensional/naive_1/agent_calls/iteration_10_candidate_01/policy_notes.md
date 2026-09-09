# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The assigned parent and all four sampled solver evaluations satisfy the frozen
flow contract: direct uniform initialization at `U_infinity=(0,0,0)`, no
cylinders or prewarm, finite moving-window dynamics, and no numerical
instability. I inspected every combined keyframe sheet from release through
termination, including both its top-down vorticity row and oblique body/Lambda2
row, then cross-checked the visual reading against `wake_metrics.csv`,
`wake_diagnostics.json`, controller sources, assigned-parent guidance, and the
inherited optimization notes.

The best sampled policy is the half-cycle-steered terminal-slip carrier. It
captures at `0.74858L` and `19.00799T`, with score `-0.211642` and mean scored
distance `2.09994L`. Its top-down row develops a coherent alternating
target-directed street and its oblique row retains compact bilateral caudal
Lambda2 packets through first crossing. The projected base, unprojected base,
and raw terminal-slip variants also capture at `19.01899--19.22800T`, but have
worse mean distances of `2.11536--2.12198L`; their similar wake topology makes
the sampled half-cycle result the strongest finite carrier rather than evidence
for a new propulsion gain.

The assigned parent's different phase mechanism is an informative failure. It
protected the target-helpful anterior half-cycle only by reducing terminal
lateral-velocity release. The fish remained self-propelled and its wake stayed
coherent, but it missed at `1.11459L` near `20.01450T`, formed a nearly straight
street away from the target, and exited left at `32.07053T` and `8.90170L`.
Peak normalized planar force and yaw moment (`0.02861` and `0.01690`) overlap
the capture family, so load growth or wake collapse does not explain the route
loss. This rejects phase-gating of the small terminal slip release: preserving
oscillation is insufficient when the modulation removes the target-side
authority needed at first crossing.

The successful half-cycle policy instead applies observed anterior joint phase
to the persistent geometry-owned differential curvature. It scales both bias
shares together in `[0.8,1.2]`, so normalized body-frame target geometry still
owns sign and the posterior lag remains intact. Its command and rate contact
(`61.05%/73.06%` acceleration and `10.73%/14.70%` joint rate) remain within the
sampled capture band, so it is an exploitation candidate, not an actuation
relief claim. Inherited outward rate barriers remain excluded because they
removed rate contact but lost capture near `5L`; the inherited line-of-sight
velocity residual remains excluded because it missed near `0.95L` and exited.

## Single-candidate policy hypothesis

Promote the evaluated half-cycle-steered terminal-slip policy as this worker's
one candidate. Preserve the projected oscillator, posterior lag, target-owned
route sign, capture-safe terminal body-lateral-velocity lead, and one-sided yaw
release. Use anterior joint displacement relative to the current biased center
to redistribute the existing head/tail curvature shares across the observed
beat, strengthening the target-aligned half-cycle and weakening the opposed
half-cycle without changing their signs, ratio, or the acceleration envelope.

Expect this state-feedback placement of phase conditioning to reproduce the
sampled capture class and coherent wake while avoiding the assigned parent's
terminal authority loss. Falsify it if capture is lost; the near-miss/left-exit
topology returns; arrival or mean distance falls outside the sampled capture
band; force, moment, or saturation materially worsens; the top-down street or
oblique caudal structures lose coherence; target-owned sign reverses; or a
returned acceleration exceeds the owned envelope. The new CFD outcome is not
available to this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning with state-dependent asymmetric flapping, informed by classical mean-curvature steering
source_mechanism: concentrate bounded steering authority in the target-useful beat half-cycle while retaining a low-dimensional traveling rhythm
transferable_invariant: persistent normalized body-frame target geometry owns turn sign, while observed joint phase may redistribute but never invert bounded curvature authority across a beat
nontransferable_details: published gains, duty ratios, dimensional frequencies, motor models, species-specific kinematics, full-body waveforms, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: retain the captured projected two-joint carrier and infer target-aligned anterior displacement from joint state; multiply both opposite-sign curvature shares by one positive bounded phase factor
falsification: reject if capture or wake coherence is lost, the near-miss and left-exit route returns, performance leaves the capture repeat band, load or saturation worsens, carrier phase is distorted, steering sign reverses, or returned acceleration exceeds the owned envelope
