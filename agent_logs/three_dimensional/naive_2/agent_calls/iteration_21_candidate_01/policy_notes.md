# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts are valid direct-uniform still-water episodes with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and nominal
  capture. Three are byte-identical replicas of the assigned-parent policy and
  trajectory (`0.745621L`, `16.609995T`, score `-0.115560`); they establish
  repeatability of one nominal arc, not pose or flow robustness.
- The distinct sampled child adds approach-gated joint-phase subtraction to
  both posterior velocity-course and relative-crossflow feedback. It retains
  capture and improves scored distance integral from `1.999656L` to
  `1.998146L`, arrival by one logged step to `16.604496T`, final distance to
  `0.743958L`, and score to `-0.113729`.
- The combined keyframe sheets show both policies self-propelling on essentially
  the same target-directed arc. In both top-down rows, a coherent alternating
  street grows behind the tail and remains strongly lateral at capture. Both
  oblique rows retain connected tail-shed Lambda2 structures without breakup,
  collision, domain exit, or visible instability. The distinct child's last
  two frames differ only subtly from the replicated parent; the scalar change
  is not a visibly new trajectory class.
- The detailed traces expose a tradeoff hidden by score. Relative to the
  parent, the dual-channel child raises peak planar force from `0.035828` to
  `0.037165`, peak moment from `0.017759` to `0.018356`, acceleration-near-limit
  residence from `73.91%` to `74.10%`, and speed-near-limit residence from
  `27.42%` to `27.59%`. Thus the prior prediction that full lateral
  demodulation would improve arrival without worse loads is not cleanly
  validated.
- The inherited trace identification remains strong: inside `6L`, centered
  anterior joint angle and velocity explain `99.80%` of raw body-lateral
  velocity variance. Offline reconstruction on the parent trace shows that
  the fitted subtraction changes the normalized crossflow contribution much
  more than the posterior course contribution (approach-region correction RMS
  about `0.452` versus `0.129`). Coupling the same observer into both paths
  therefore does not identify which path caused the marginal benefit or the
  added load.

## Policy hypothesis

Preserve the assigned parent's raw target-versus-velocity course signal,
anterior course center, full traveling-wave carrier, centered-coordinate yaw
demodulator, posterior half-cycle mechanism, and speed-boundary projection.
Add the sampled approach-gated lateral phase estimate only to relative
crossflow, where it removes the carrier's own sway from the fast disturbance
channel. Do not also alter the target-course path in this candidate. This is a
single-channel structural ablation of the completed dual-channel child, not a
scalar gain change.

Expected result: preserve the nominal capture and connected wake while
retaining any benefit from exposing directional crossflow, with less duplicate
route correction and no increase over the parent's force, moment, or limit
residence. Falsify if capture is lost or delayed, score/distance integral
regresses beyond the replicated parent, the wake disconnects, phase-correlated
crossflow persists, or any load/limit metric exceeds the parent without a
semantic trajectory improvement.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and wake-disturbance residual control
source_mechanism: separate slow target geometry from fast rhythmic locomotor and disturbance response, using the smallest bounded residual feedback that preserves propulsion
transferable_invariant: internally generated beat sway should be removed from a fast crossflow disturbance cue, and one physical residual should not be injected redundantly into multiple steering paths without evidence
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, and source-task routes
policy_translation: estimate normalized body-lateral carrier sway from centered anterior joint angle and velocity on approach; correct only body-frame relative crossflow before bounded posterior steering while preserving raw target course and the two-joint carrier
falsification: reject if nominal capture, arrival, distance integral, connected wake, joint history, saturation, force, or moment worsens, or if the corrected crossflow remains carrier-correlated
