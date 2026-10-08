# Candidate diagnosis and hypothesis

## Evidence read before the policy edit

- All four sampled evaluations report `uniform_direct` initialization with
  `flow_velocity_L_per_T=[0,0,0]`; the release frames contain no developed wake,
  so there is no prewarm contract failure. The top-down sheets then show the
  fish translating under its own traveling bend and leaving a coherent,
  alternating vorticity street. The oblique Lambda2 sheets show compact 3D
  structures shed behind the posterior body without a visible instability.
- The assigned-parent candidate `solver_a0cc85d2f5b2` is the strongest finite
  sample: capture at `16.0435T`, score `-0.0583110`, mean distance `1.94101L`,
  and observed distance integral `1.31388L`. The continuity predecessor
  `solver_4c0e1314ad61` captures at `16.2250T` with score `-0.0632084`, mean
  distance `1.94670L`, and observed integral `1.32273L`. Their visual wake
  topology is alike, so the improvement is a useful trajectory/control change,
  not a transition from advection or weak propulsion to a different gait.
- The same-step alternatives do not beat the parent mechanism. Bounded bearing
  phase lead (`solver_bffa3def5d62`) and stronger response-gated terminal wave
  unloading (`solver_1199437e225a`) both retain capture at `16.2250T` but regress
  to scores `-0.0655095` and `-0.0644162`. Thus the evidence does not support
  another additive trend term or deeper near-target wave suppression.
- The assigned optimizer logs show a capture-only lineage improving from
  `-0.0662837` and `-0.0677545` through the continuity policy at `-0.0632084`
  to the carrier-phase-residual parent at `-0.0583110`. All sampled policies
  retain the coherent carrier and hit the `260 deg/T` joint-rate ceiling; the
  parent remains finite with maximum joint excursions about `26.3/31.5 deg`.
- Reconstructing the parent gate from the logged normalized body-frame state
  shows why a guard remains useful: the residual gate is lower on average
  (`0.145` versus raw `0.226`) but still exceeds the raw gate on `20.1%` of
  samples. Most excess is small, yet it violates the intended interpretation
  of carrier removal: a phase estimate should not manufacture persistent route
  evidence. Raw/residual/minimum gates spend `18.5/9.4/9.3%` of samples above
  `0.5`, respectively.

## One candidate

Keep the parent oscillator, posterior traveling bend, cruise curvature,
closing-conditioned approach, raw redirect direction, wave relief, and
mean-first acceleration allocation. Change only the semantics of the
carrier-phase residual: compute the raw and residual redirect gates as before,
then use their minimum. The phase model therefore becomes attenuation-only;
it may veto high-authority curvature when the apparent target-versus-course
mismatch is carrier-synchronous, but it cannot open or strengthen a redirect.
This is a feedback-structure change, not a scalar gain adjustment.

Expected result: preserve the parent's coherent self-propulsion and capture
class while removing the small residual-created authority intervals. A useful
improvement would be earlier capture or a lower distance integral with no worse
joint-limit residence or load spikes. Falsify the candidate if it loses
capture, delays arrival beyond the parent, weakens the alternating wake/forward
progress, or if later traces show that the clipped intervals contained a
persistent course correction rather than beat-synchronous sway.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and residual path-following control
source_mechanism: preserve a rhythmic locomotor carrier while sensor feedback modulates a bounded low-dimensional route command
transferable_invariant: fast phase-synchronous response should not create slow route authority; an uncertain residual may conservatively attenuate the persistent command while leaving the carrier intact
nontransferable_details: published gains, clock-driven CPG phase, species-specific envelopes, dimensional frequencies, and source-task routes
policy_translation: normalized anterior joint phase estimates carrier-synchronous course sway; raw body-frame bearing-versus-course error owns redirect sign and magnitude, while the phase residual can only lower its bounded strong-redirect gate
falsification: reject if capture or early progress regresses, wake coherence is lost, loads or limit residence rise, or the veto removes a correction that remains persistent across carrier phase
