# Wake-policy candidate diagnosis

## Evidence diagnosis

- All four sampled evaluations use direct uniform still-water initialization at
  `U_infinity=(0,0,0)` and terminate in capture at `0.7492--0.7499L`.
  `solver_ac993a461b7c` is the strongest finite score (`-0.14991`), while the
  assigned parent/prefill `solver_55f3a103ab95` captures later (`18.7495T`) and
  scores `-0.15335`.
- The combined sheets for those two policies show self-propelled motion rather
  than advection: both lay down a persistent alternating top-down vortex street
  and bilateral oblique Lambda2 structures from release through the terminal
  approach. There is no visible carrier collapse, collision, or unstable wake.
  The parent anterior-transfer trajectory therefore supplies no visual reason
  to disturb the traveling bend or posterior propulsive allocation.
- No sampled combined sheet is a failure. The inherited optimizer logs provide
  the informative negative class: three stable `left_domain` outcomes pass at
  `1.179--1.411L` and finish at `10.11--10.55L`. Parent guidance further records
  exact speed-reserve lower exits at `1.464--1.646L`, while all recorded capture
  approaches retain positive history-window closing speed inside `4L`.
- The sampled unsupported-bearing qualifier captures at `18.6560T` with the
  best sampled score while preserving the same coherent two-view wake. One run
  cannot establish repeat reliability, but it is stronger evidence than the
  parent's fixed anterior/posterior steering transfer, whose one capture is
  later and has no clipping, speed-limit, load, or score benefit.

## Candidate hypothesis

Materialize an exact-policy repeat of the sampled outer-terminal unsupported-
bearing qualifier. Preserve the intercept-guarded speed-reserve carrier and
fixed steering allocation. Admit body-frame target bearing only in the
`2.0--4.0L` outer-terminal region when achieved-course error is nearly zero,
then remove it before the inner intercept gate. This tests whether the new
semantic cue repeats capture without perturbing far-field closure, the capture
corridor, either wake view, or the repeat-backed actuator/load envelope.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking over a rhythmic CPG
source_mechanism: modulate the low-dimensional steering request with observed target direction while preserving the locomotor carrier
transferable_invariant: a target-geometry residual may qualify an under-informative course command without replacing the traveling bend
nontransferable_details: published gains, clocked CPG phase, robot morphology, dimensional timing, and task-specific paths
policy_translation: smoothly add normalized body-frame target bearing only when outer-terminal achieved-course error is near zero; leave the two-joint carrier and allocation unchanged
falsification: reject if an exact repeat exits, changes far-field motion, weakens either coherent wake, loses capture, or worsens clipping, joint-speed residence, force, or moment beyond the repeat-backed envelope
