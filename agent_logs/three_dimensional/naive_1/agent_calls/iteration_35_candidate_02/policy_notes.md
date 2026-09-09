# Wake-policy diagnosis and candidate hypothesis

## Evidence read before editing

- The assigned parent is the prefilled half-cycle envelope-redistribution
  controller. Its inherited guidance identifies two executable-equivalent
  redistribution misses (`0.81206L` and `1.25093L`) with coherent wakes, so
  another scalar adjustment or recovery compound is not attributable.
- All four sampled evaluations are valid direct-uniform still-water runs:
  `U_infinity=(0,0,0)`, no cylinders, and capture termination. The two
  executable-identical redistribution samples capture at `18.8265T` and
  `18.8815T`; the rearward-route branch captures at `18.9640T` without
  exercising rearward recovery; and the clean envelope ablation captures at
  `18.6010T`.
- In every combined keyframe sheet, the top-down row develops an alternating,
  target-bending vorticity street from release through capture. The oblique row
  shows compact alternating caudal Lambda2 structures rather than passive
  advection or a broken standing wiggle. This agrees with zero background flow,
  roughly `11.58L` distance reduction, finite planar loads, and capture.
- The clean ablation is the strongest semantic comparison because it removes
  exactly one phase-dependent drive channel while preserving displacement-phase
  steering. Relative to the two sampled redistribution repeats, it arrives
  `0.2255--0.2805T` earlier, but its peak planar force/moment
  (`0.01605/0.02968/0.01656`) is modestly above their sampled ranges and its
  acceleration/rate contact (`60.88%/72.95%`, `10.88%/14.96%`) overlaps them.
  Thus the evidence supports separation and capture compatibility, not demand
  relief or a scalar-score gain.
- No sampled solver in this workspace is a multimodal failure; the informative
  failure boundary is therefore inherited rather than visually reclassified.
  The notes do not claim that the current worker observed images for those
  inherited misses. The assigned-parent step-34 scalar log is also only a
  capture result and cannot attribute a new mechanism without its route and
  wake histories.

## Candidate

Hypothesis: remove only phase-dependent amplitude-relief redistribution from
the assigned parent, while retaining normalized body-lateral target geometry,
one-sided correcting-yaw release, differential mean curvature,
displacement-only half-cycle steering, the common geometry-owned relief, the
posterior lag, and final acceleration projection. This adopts the sampled
clean ablation as the single candidate. It should preserve the coherent
two-view wake and capture class while removing the drive-envelope channel that
has contradictory inherited route semantics. Reject the hypothesis if the new
rollout loses capture or either wake row, reproduces the downward/left miss,
raises loads beyond the clean-carrier spread, or is credited as actuator relief
despite unchanged limit contact.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical traveling-wave propulsion
source_mechanism: bounded sensor-driven steering asymmetry layered on a coordinated propulsive oscillator
transferable_invariant: keep target-signed steering modulation separate from the common traveling-wave envelope so steering does not reallocate the propulsive carrier
nontransferable_details: published gains, duty ratios, clock phase, species envelopes, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-lateral target feedback and observed anterior-displacement half-cycle curvature, but remove phase-dependent amplitude relief from both joints' shared carrier
falsification: reject on lost capture, loss of either coherent wake view, the inherited downward/left topology, or load and limit-contact degradation outside the clean-carrier evidence band
