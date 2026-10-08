# Candidate wake-policy notes

## Evidence diagnosis before policy edit

- All four sampled solver evaluations and the assigned-parent evaluation satisfy
  the direct-uniform still-water contract (`U_infinity=[0,0,0]`, no cylinders,
  no prewarm) and terminate in capture. The sampled final distances span only
  `0.748338--0.748829L` at `26.2405--26.3615T`; the assigned parent reaches
  `0.749053L` at `26.4220T`.
- The combined sheets for the best sampled policy, the history-only comparator,
  and the assigned parent were inspected in both views. Their top-down rows show
  genuine self-propulsion, a regular alternating wake, and the same late upward
  hook into a grazing capture. Their oblique Lambda2 rows retain an organized
  three-dimensional wake through the approach. No view shows imposed advection,
  wake breakup, boundary interaction, or moving-window-induced rotation.
- Metrics support the visual equivalence. The best sampled policy reaches
  `0.748338L` at `26.2460T`; the assigned parent's translation-qualified
  response magnitude is `0.000714L` shallower and `0.1760T` slower, with only
  `0.0493L` maximum head-path separation. Both have zero angle, speed, and
  acceleration contacts and the same peak planar force/yaw moment
  (`0.018834/0.009789`). The parent therefore preserved safety but did not
  produce a semantic clearance or route improvement.
- The inherited log explains why response-magnitude qualification was tested:
  the folded bearing-plus-turn observer oscillates at gait frequency while
  body-frame translational line-of-sight rotation keeps a persistent side.
  Its completed result now shows that changing demand magnitude while retaining
  the same half-cycle timing remains in the shallow-capture family. Together
  with completed carrier-relief, posterior-amplitude, residual-arbitration, and
  terminal-waveform negatives, this does not support another gain, threshold,
  or amplitude edit.

## Policy hypothesis

Start from the best sampled translation-side policy. Preserve its state-feedback
traveling bend, posterior lag, large-error redirect, line-of-sight residual,
capture-gated posterior modulation, coordinated command projection, and joint
viability guards. Add one bounded duty-ratio mechanism to the anterior carrier:
when the existing body-frame translational observer is reliable, agrees with
course error, the fish is closing, and measured yaw response is deficient,
smoothly reduce only the restoring acceleration while joint 1 is returning from
the requested target-side bend. Startup, far travel, course/translation
disagreement, outward motion, the non-target half-cycle, adequate-response
states, and fully redirected states remain pass-through; partial redirect
blends attenuate the dwell continuously.

The mechanism changes phase residence rather than peak steering amplitude: it
should prolong target-side curvature enough to leave the common late-hook path
while keeping the productive traveling wake and existing command envelope.
Falsify it if formal CFD loses capture or coherent wake structure, raises any
actuator contact or the sampled force/moment envelope, slows the route, or again
produces only a milliscale-equivalent shallow crossing. If rejected, later
workers should not tune the dwell fraction or its inherited gates; they should
test a separately measured translational-response variable such as course
curvature rather than another command-side transformation.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning with asymmetric flapping duty ratio
source_mechanism: change residence on one target-selected part of a rhythmic cycle while retaining the propulsive oscillator
transferable_invariant: persistent route feedback may alter phase timing on the useful turn side without increasing peak rhythmic authority
nontransferable_details: published duty ratios, CPG gains, clock phase, robot linkage geometry, species kinematics, dimensional frequencies, and task-specific routes
policy_translation: use normalized body-frame course and translational line-of-sight agreement plus joint-state phase to reduce only target-side return stiffness in the existing anterior oscillator
falsification: reject if capture, coherent three-dimensional propulsion, zero-contact operation, or the sampled load envelope is lost, or if the head path remains in the same shallow cluster

## Non-CFD implementation audit

- Replaying both policies on the `4772` frozen best-sample states changes `245`
  command rows, with `94` changes above `0.05 rad/T^2` and a maximum change of
  `1.719 rad/T^2` near `24.987T`. No row at or beyond `4.5L` changes, and the
  candidate's frozen-state peak remains the parent's `29.726 rad/T^2`. This
  establishes material, bounded activation and exact far-route pass-through;
  it is not a claim about the unevaluated hydrodynamic trajectory.
- The public two-joint contract returns finite output. A deterministic
  `20,000`-state edge/random probe remains within the `30 rad/T^2` policy
  envelope and has zero numerical reflection-equivariance error.
