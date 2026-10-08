# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The assigned parent is the prefilled forward-speed-gated posterior-emphasis
  policy. It captured in direct-uniform still water at `15.977511T`, with
  `0.744403L` final distance, `1.928581L` scored distance integral, and 238
  moving-window shifts.
- All four sampled rollouts report `uniform_direct` initialization,
  `U_infinity=(0,0,0)`, no cylinders, finite stable capture, and complete
  combined keyframe sheets. There are no inherited optimizer notes in this
  workspace, so the assigned-parent guidance and the four solver evaluations
  are the available inherited evidence.
- In both rows of every combined sheet, the fish is self-propelled rather than
  advected: the top-down views develop a regular alternating red/blue vortex
  street from the caudal region, while the oblique views show bounded,
  alternating three-dimensional Lambda2 structures following the translating
  fish. None shows wake collapse or numerical instability.
- The parent and both translational-slip variants remain visually and
  kinematically nearly identical through capture. They share all
  `8/6/4/2/1.25/0.9L` milestone times and arrive at `15.977511T`; their terminal
  edits change only final crossing depth (`0.744403L`, `0.744039L`, and
  `0.744325L`). This is terminal micro-shaping, not a new route.
- The axial-force-gated sample is the material contrast. Its coherent wake is
  retained, but the final sheet shows a different target entry from above with
  heading `0.698 rad`, rather than the parent family's near-horizontal entry
  with heading about `-0.03 rad`. It is slightly later at `8L` (`9.102495T`
  versus `9.091496T`) but earlier thereafter: `6/4/2/1.25/0.9L` occur at
  `10.989003/12.826005/14.646511/15.328512/15.658507T`, versus
  `11.055001/12.919506/14.800513/15.493514/15.823509T`. Capture advances to
  `15.768509T`, the scored integral falls to `1.924071L`, and shifts fall to
  232.
- The benefit is not free or monotone thrust evidence. Compared with the
  parent, mean posterior command falls from `25.472736` to
  `25.220578 rad/T^2` and posterior speed-limit residence falls from `6.299%`
  to `5.720%`, but posterior acceleration-limit residence rises from `22.582%`
  to `23.579%`, posterior excursion rises from `33.12` to `34.73 deg`, and
  peak body-lateral force rises from `0.03249` to `0.03406`. The final capture
  is also shallower at `0.745725L`.

## Policy hypothesis

Promote the sampled axial-response-gated policy as the single candidate,
without scalar retuning or an additional terminal gate. Preserve the proven
traveling-bend carrier and its speed-based low-speed eligibility envelope, but
interpolate its feasible posterior command from the base wave toward the
already bounded boosted wave only when normalized body-forward hydrodynamic
force is positive. This response-contingent actuator allocation is the only
mechanism change from the assigned parent. The sampled rollout predicts that
it will preserve the coherent two-view wake and capture while producing the
meaningfully earlier middle and terminal trajectory; the load and limiting
costs remain explicit acceptance boundaries rather than being hidden by the
better score.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and sensor-modulated robotic-fish CPG/residual control
source_mechanism: posterior wave action is most useful when tail kinematics produce a measured forward hydrodynamic response, while the autonomous carrier remains available when that response is absent
transferable_invariant: condition only supplemental posterior traveling-wave authority on a bounded body-frame propulsive-response observation, preserving the base rhythm and steering channels
nontransferable_details: published gains, species envelopes, dimensional frequencies, exact vortex phase, full-body kinematics, and task-specific routes
policy_translation: use finite `-state.force_body_L[1]` normalized by a policy-owned scale to interpolate between the existing base and boosted posterior acceleration endpoints inside the existing low-forward-speed gate; never suppress the base carrier and never exceed the boosted command magnitude
falsification: reject the transfer if capture or coherent top-down/oblique wake is lost, the `6/4/2L` milestones or distance integral regress, the branch merely reproduces the parent trajectory, or its posterior limiting and lateral-load increase outweigh the semantic route benefit
