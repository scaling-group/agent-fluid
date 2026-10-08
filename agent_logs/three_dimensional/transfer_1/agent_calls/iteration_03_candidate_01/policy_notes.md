# Completion-gated redirect with coordinated acceleration allocation

## Evidence and visual diagnosis

- All sampled evaluations use direct uniform initialization in still water,
  with zero cylinders and no prewarm. The visible displacement and wakes are
  self-propelled rather than imposed advection.
- The prefilled response-gated redirect (`solver_8556f8eb9ecb`) produces a
  coherent alternating mid-plane street and paired oblique Lambda2 structures.
  It closes from `12.33L` to `2.46L`, but at `24.23T` the target is almost
  exactly abeam in body coordinates, approximately `(0.01,-2.46)L`, while the
  fish still travels at `0.94U`. It then passes the target and exits left.
  At least one raw joint command exceeds the `1800 deg/T^2` envelope in `95.7%`
  of its trace rows, so another additive steering term is not credible unused
  authority.
- The assigned parent's range-and-misalignment capture hold reduced its miss to
  `1.39L`, and the sampled terminal amplitude/cadence relief
  (`solver_10962d00368d`) reached `1.23L`; both still crossed with the target
  behind and lateral, then exited the domain. Drive relief alone therefore
  improves closest approach without fixing the release semantics.
- The completion-gated redirect (`solver_06efdad50479`) is the sole sampled
  capture. Its top-down frames show a broad target-directed turn rather than
  the prefilled abeam flyby, while the oblique row retains discrete three-
  dimensional wake structures through the maneuver. It captures at `26.41T`
  with body-frame target approximately `(-0.749,-0.026)L`, speed `0.64U`, and
  no instability. This establishes that large-error curvature must remain
  latched until body-frame geometric error contracts; beat-scale correct-sign
  yaw is not completion.
- The successful controller still asks for raw acceleration beyond the
  envelope in `82.5%` of rows. Independent per-joint clipping can change the
  requested anterior/posterior command ratio even though that ratio creates
  the observed traveling bend. The remaining evidence-backed deficiency is
  actuator arbitration, not route sign or additional turn magnitude.

## Policy hypothesis

Use the captured completion-gated policy as the behavioral parent. Preserve
its normalized body-frame target geometry, completion-latched redirect,
posterior lag, cadence logic, and half-cycle steering. Add one coordinated
two-joint acceleration allocator after those modules: if either requested
acceleration exceeds the parameter-owned budget, scale both commands by the
same factor. This radial projection keeps the requested head/tail ratio and
turn sign while ensuring the policy itself stays inside the actuator envelope,
instead of relying on independent downstream clipping.

Falsification: reject coordinated allocation if capture is lost, early closure
or the coherent alternating wake degrades materially, the target is no longer
forward-aligned at closest approach, or the allocator causes joint motion to
stall. The new rollout must not be claimed here; it becomes evidence for a
later worker.

bookshelf_consulted: true
source_domain: Lighthill reactive propulsion and closed-loop robotic-fish CPG/residual control
source_mechanism: useful thrust and steering arise from a coordinated traveling bend with posterior lag, while feedback modulates a low-dimensional gait within physical limits
transferable_invariant: preserve the relative anterior/posterior command geometry when actuator limits engage rather than independently distorting the two channels
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, task-specific routes, and source actuator models
policy_translation: retain normalized body-frame completion-gated target feedback, then radially project the two state-feedback joint accelerations onto a parameter-owned common budget
falsification: reject if the prior capture or forward-aligned terminal geometry is lost, wake coherence weakens, or bounded allocation stalls the traveling bend
