# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled episodes are finite direct-uniform still-water releases
  with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Both the top-down
  vorticity and oblique Lambda2 rows of every combined keyframe sheet were
  inspected. Translation is self-propelled: each controller lays down an
  alternating wake, rather than inheriting ambient advection.
- The assigned prefill's achieved-course/yaw-rate cascade retains a coherent
  wake but follows the shallow upper route, reaches only `3.113529L` at
  `21.478T`, and exits the domain. The related phase-compensated bearing
  controller is similarly limited at `3.003098L`. Their scalar survival does
  not constitute useful target acquisition.
- Opposing-half carrier attenuation acquires the lower route and improves the
  pass to `1.266947L`, but at closest approach its actions have collapsed to
  about `-5.50/-7.16 rad/T^2` while speed remains `0.777L/T`; the two visual
  rows then show little new wake as the fish coasts below the target into a
  lower exit. This supports preserving the carrier rather than suppressing
  another half-cycle.
- The sampled line-of-sight-guarded response-release policy is the only
  semantic success: it captures at `0.749345L` and `18.606T`, with speed
  `0.847L/T`. Its top-down row retains a coherent alternating street through
  capture and the oblique row retains compact three-dimensional Lambda2
  structures. Sub-`4L` acceleration-envelope occupancy is about
  `72.6%/75.5%`; the success comes from steering timing, not reduced effort.
  This completed sampled evaluation supersedes the inherited `0.9312L`
  near-miss hypothesis and supports promoting the exact evaluated controller.

## Candidate mechanism and falsification

Replace the failed prefill with the complete sampled capture policy. Preserve
the normalized body-frame target-versus-achieved-course servo, posterior-lag
state-feedback carrier, and response-triggered release of shared steering.
Near the target, derive rotation-invariant inertial line-of-sight rate from
`target_body_L` and `velocity_body_U`; allow joint-compensated yaw response to
release steering only while the signed geometric miss rate remains small, and
smoothly re-engage the existing bounded steering when the miss grows. This is
one response-gated steering mechanism, not a scalar gain tune, additive mean
curvature, clock, world route, or prescribed vortex phase.

Expected test: the materialized candidate reproduces the sampled capture-class
trajectory and coherent wake. Falsify the promotion if reevaluation does not
capture, changes the far route, weakens the alternating wake, materially raises
saturation, or exhibits sensitivity that indicates the `0.749345L` crossing
was numerically marginal. A later robustness test should vary initial pose or
target location before generalizing beyond the validated L64 task.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish terminal direction control
source_mechanism: release target-directed steering into a propulsive rhythm only while observed yaw and approach geometry remain compatible
transferable_invariant: preserve the traveling carrier while normalized geometric response, rather than elapsed phase or route memory, decides whether bounded steering authority may be released
nontransferable_details: species-specific C-start shapes, published gains, robot kinematics, dimensional cadence, prescribed beat or vortex phase, exact route, and the sampled target coordinates
policy_translation: use body-frame target and achieved velocity to guard joint-compensated yaw release, re-engaging the existing two-joint course steering when signed inertial line-of-sight rate predicts a miss
falsification: reject if reevaluation loses capture, weakens the coherent wake, increases saturation materially, changes far-field closure, or exposes poor held-out pose or target robustness

## Non-CFD verification

- The candidate is byte-identical (SHA-256
  `034c915d34959146504cf8bdbec3033e5982a62d1501194e2f0153e14f29052e`)
  to the sampled policy whose completed L64 evaluation terminated `capture`.
  No same-worker CFD result is claimed.
- The guidance-materiality and solver editable-boundary checks pass. A static
  schema audit finds no direct `params.FIELD` reference missing from the object
  returned by `target_policy_params()`.
- The mandated Julia policy-call smoke could not run because no `julia`
  executable is installed anywhere available in this workspace. The exact
  evaluated-policy match is recorded as execution evidence, not as a local
  smoke-test claim.
