# Candidate diagnosis and hypothesis

## Evidence read before the policy edit

- All four sampled episodes satisfy the direct-uniform still-water contract and
  terminate in capture at the same `22.154001T` control step. Three samples of
  the inherited predictive-half-cycle candidate reproduce
  `0.748384L` final distance, `2.105583L` mean distance, and `-0.210952` score.
  One of their combined sheets is complete: the top-down row shows a smooth
  S-shaped target approach with an attached alternating vorticity street, and
  the oblique row shows discrete three-dimensional Lambda2 structures from
  release through capture. The fish remains rhythmically self-propelled rather
  than coasting into the target.
- Relative to the assigned-parent boundary (`22.159500T`, `2.105808L`,
  `-0.211168`), previewing the posterior half-cycle envelope is a small but
  repeatable semantic improvement. Extending the same preview into the
  posterior recovery allocator produces a byte-identical trajectory, so that
  path is already saturated or otherwise inactive in the encountered states.
- The informative weaker sample releases the anterior redirect when measured
  moment is already target-signed. Its top-down route and capture survive, but
  the oblique row is blank and supplies no 3D-wake evidence. Mean action falls
  from `59.932` to `59.695` and anterior exact-rate-cap occupancy from `11.49%`
  to `11.02%`, while mean distance worsens to `2.105967L` and score to
  `-0.211334`; peak normalized force/moment remain the same
  (`0.030897/0.015839`). Target-signed instantaneous moment is therefore not a
  valid signal for yielding useful anterior authority in this route.
- Reconstructed body-frame geometry shows why another scalar is not the next
  test. The proximity gate is full by `16T`, while instantaneous target error
  and its preview remain materially different near approach: at `21T` the
  error is about `0.616 rad`, with instantaneous/predictive redirect envelopes
  about `0.308/0.492`; at `22T` the target-line rate has risen to about
  `0.343 rad/T`. The inherited anterior redirect still uses only the lagging
  instantaneous envelope even though both slow course curvature and posterior
  half-cycle allocation already benefit from the bounded preview.
- No inherited candidate-specific optimizer log was materialized in this
  workspace; the assigned-parent experience bank and all sampled policy,
  trajectory, diagnostic, and two-view artifacts were used instead.

## Policy hypothesis

Use the existing proximity-scaled, de-yawed target-line preview only to qualify
the envelope of the anterior redirect. Keep instantaneous `target_body_L`
lateral sign and anterior joint velocity as the turn-side and phase selectors,
and keep the inherited redirect ceiling. This is a predictive allocation of an
existing actuator pathway, not additional gain. It should begin useful
anterior turning before the instantaneous error gate catches up, preserve the
traveling carrier and separate reactive rudder, and improve both arrival and
distance integral relative to `22.154001T/2.105583L`.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and asymmetric flapping
source_mechanism: measured directional feedback modulates a bounded component of a continuing propulsive rhythm
transferable_invariant: preserve the traveling carrier while allocating limited steering effort by observed target geometry and joint-state phase
nontransferable_details: published gains, clock phase, duty ratios, species-specific envelopes, exact kinematics, and task routes
policy_translation: drive the existing anterior redirect envelope with normalized proximity-led body-frame target-line error while retaining instantaneous target-side sign, joint-state phase, and the inherited acceleration ceiling
falsification: reject if capture is later than 22.154001T, mean distance exceeds 2.105583L, the preterminal S-route or complete two-view wake degrades, or action, rate-cap occupancy, normalized force, or moment exceed the sampled envelopes
