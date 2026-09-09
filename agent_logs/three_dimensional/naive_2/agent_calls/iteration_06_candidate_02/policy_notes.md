# Wake-policy candidate notes

## Evidence and visual diagnosis before editing

- The assigned parent guidance, its inherited step-4/step-5 notes, and all four
  sampled solver evaluations were reviewed first. Every sample reports direct
  uniform still water (`U_infinity=(0,0,0)`), no cylinders, and no prewarm.
  Their combined sheets show body-connected alternating top-down wakes and
  three-dimensional oblique Lambda2 structures, so the long leftward tracks
  are self-propelled and none of the comparisons is an advection artifact or
  numerical instability.
- The sampled response-steering baseline `solver_77835bec7423` preserves the
  cleanest nearly horizontal wake and useful translation, reaching `3.174L`
  at `18.09T` before passing above the target and exiting the left boundary at
  `27.43T`. The assigned-parent approach hold `solver_1fbf1e40b119` improves
  closest approach to `2.703L` and the score from `-10.730` to `-8.507`, but
  its sheet shows a much sharper terminal curl. The center descends only to
  `12.541L`, then rises to the upper margin and exits at `24.52T`; therefore
  symmetric carrier relief with unrelieved half-cycle steering improves
  distance but does not produce capture or a better termination class.
- The sampled full-circle, misalignment-gated approach policy
  `solver_4b6f0dc046cd` is the strongest geometric comparator even though its
  scalar score is lower: it restores propulsion when the nose aligns, descends
  to center `y=12.064L`, and reaches `2.319L` at `18.03T`. It still curls back
  upward and exits at `27.23T`. At `15--16T`, its full-circle pursuit bearing is
  only about `+0.05--+0.06rad`, but body-lateral velocity remains
  `+0.89--+0.81U`; the inherited slip term therefore retains a large negative
  steering request (`turn_request` about `-0.77-- -0.67`) precisely when the
  body axis is aimed toward the target. This spends the aligned interval on
  continued yaw/skid rather than translating along the aimed body axis.
- Inherited logs rule out broad rate barriers, persistent mean curvature, and
  early course-crossflow reinforcement: those mechanisms weakened translation
  or produced wrong-way loops. The sampled approach variants retain similar
  95th/99th-percentile planar loads to the baseline, but each has an isolated
  much larger terminal force/moment spike, so a useful release must also avoid
  replacing the miss with a violent terminal maneuver.

## Single candidate hypothesis

Use `solver_4b6f0dc046cd` as the evidenced comparator and add one compact
aim-then-translate allocation mechanism. Preserve its joint-state traveling
bend, posterior lag, full-circle body-frame pursuit angle, response-compensated
shared half-cycle redirect, and distance/misalignment-conditioned carrier
relief. Reuse the same smooth proximity and angular-alignment gates to attenuate
the half-cycle steering channel only when the target is near and the body axis
is aligned; at the same time the sampled carrier rule already returns toward
full drive. Far from the target or while angular error remains large, the
sampled redirect is unchanged. Near an aligned target, the controller should
stop feeding the observed lateral skid and convert the achieved heading into
down-target translation without a clock, coordinate, or hidden mode.

This candidate is falsified if it fails to improve below the sampled `2.319L`
closest approach, if it still curls to the upper boundary without a tighter
second approach, or if early leftward progress and the coherent alternating
wake deteriorate. Capture or a better termination class is the primary test;
distance improvement alone is insufficient, and any apparent gain accompanied
by more hard-limit occupancy or larger sustained force/moment loads is not a
robust transfer.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG terminal approach
source_mechanism: a strong geometry-gated redirect releases into an intact propulsive rhythm once observed alignment is established
transferable_invariant: steering authority should fall while propulsive authority returns when normalized target angle is small, so achieved heading becomes translation instead of continued curvature
nontransferable_details: published gains, dimensional frequency, species-specific C-start shape, robot linkage geometry, duty ratios, exact vortex phase, maneuver timing, and task-specific routes
policy_translation: use smooth body-frame distance and full-circle target-angle gates to retain shared two-joint half-cycle redirect when misaligned but attenuate it and restore the state-feedback carrier when near and aligned
falsification: reject if capture or termination topology does not improve with closest approach, or if translation, wake coherence, actuator occupancy, or load histories worsen

## Dry validation only

The mandated guidance/notes semantic check, lightweight Julia policy contract,
and editable-boundary check pass; no CFD was run. All direct `params.FIELD`
references resolve to fields returned by `target_policy_params()`. A
58,320-state grid spanning joint phase and rate, target fore/aft and lateral
geometry, distance, body slip, and yaw response produced finite actions
strictly inside the smooth `30 rad/T^2` envelope and exact left/right
reflection (maximum error `0.0`). On the sampled full-circle trajectory, the
new steering allocation remains about `0.95` at the outer approach state but
falls to about `0.11--0.12` during the `15--16T` near-aligned interval where
the inherited steering request stayed large. These checks establish schema,
boundedness, symmetry, and gate semantics only; the post-worker CFD evaluation
must decide the physical falsifiers above.
