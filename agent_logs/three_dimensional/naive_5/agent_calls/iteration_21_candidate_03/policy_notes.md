# Coupled acceleration-envelope candidate

## Evidence read before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and moving-window transport
  that preserves inertial coordinates. Three executions are trajectory- and
  image-identical speed-guarded policies that capture at `0.749366L` and
  `27.5770T`; their duplicated outcome establishes fixed-condition
  determinism, not geometric robustness. The fourth is the angle-guarded
  predecessor, which captures at `0.749992L` and `27.7695T`.
- In both unique combined keyframe sheets, the top-down row shows genuine
  self-propulsion from rest, an organized alternating wake, sustained
  target-directed translation, and a late correct-sign turn into the capture
  circle. The oblique body/Lambda2 row shows coherent three-dimensional wake
  structures along the same route. The wake trails the body while the storage
  window follows it; neither view suggests imposed-flow advection or a
  moving-window artifact. No sampled failed rollout is available, so the
  angle-guarded predecessor is the informative defect comparison.
- The speed-viability mechanism removes all `1124/10098` exact joint-speed
  contacts from the predecessor while retaining zero angle contacts. Maximum
  joint speeds become `259.63` and `258.03 deg/T`; peak planar force changes
  only from `0.022123` to `0.022180`, peak yaw moment falls from `0.010414` to
  `0.010343`, acceleration-clamp exposure falls from `1700/10098` to
  `1686/10028`, and arrival improves by `0.1925T`. This supports promotion of
  the speed guard without moving either joint-limit threshold.
- The remaining `1686/10028` acceleration-clamp samples span `1.2595--24.5905T`
  and `12.341--2.113L`, rather than being a terminal-only event: joint 1
  accounts for `1083` and joint 2 for `603`. About half occur while the command
  is speed-increasing and half while it is speed-reducing, so an energy-pump
  gate alone would leave much of the componentwise clipping untouched. The
  inherited stronger fixed-brake rate barrier also left 34 speed contacts,
  increased acceleration-clamp exposure to 1725, raised force/moment loads,
  and scored worse; scalar strengthening of either viability brake is not the
  next supported test.
- At capture the guarded fish remains closing rapidly with world velocity
  about `(-0.385,-0.503)L/T`; however, inherited completed tests already reject
  terminal damping, reverse-wave braking, recoil, deeper-curvature, and
  instantaneous-intercept branches. The current candidate therefore preserves
  the evidenced carrier, target-line response, terminal logic, and both
  viability guards.

## Policy hypothesis

Add one reflection-equivariant, coupled acceleration-envelope projection to the
completed carrier and steering command before the angle and speed guards.
Below a soft joint-acceleration band, both commands pass through exactly. Above
it, smoothly compress the larger absolute command toward the existing policy
limit and scale both joint commands by the same factor. This removes ordinary
independent component clipping while preserving the instantaneous anterior/
posterior command ratio and sign, hence the traveling-bend coordination that
the two visual rows show is productive. Keeping both viability guards
downstream preserves their full stopping and speed-braking authority; the hard
clamp remains as a final numerical guard.

The falsifiable expectation is repeat capture with the same coherent route,
zero angle and speed contacts, fewer exact acceleration-clamp samples, and no
increase in force or yaw-moment exposure. Reject the mechanism if capture is
lost, the late route or wake topology changes materially, either joint contact
returns, high-command scaling creates inadequate safety braking, or reduced
clipping merely trades for slower arrival or larger loads. The new CFD result
is produced only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: useful propulsion depends on directional anterior-to-posterior coordination, while bounded feedback should modulate a rhythmic carrier without replacing it
transferable_invariant: enforce the actuator envelope without changing the instantaneous relative direction and ratio of the two-joint traveling-bend command whenever the command is already viable
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, Strouhal targets, body-wave splines, and task-specific routes
policy_translation: retain all body-frame target-line feedback, apply one smooth common scale to the completed carrier and steering accelerations only above a normalized soft command band, then leave the downstream joint-state safety guards at full authority
falsification: reject if repeat capture or coherent self-propulsion is lost, sub-band commands change, angle or speed contact returns, acceleration-clamp exposure does not fall, or arrival and force/moment loads worsen

## Non-CFD implementation audit

- The mandated check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were run
  directly and separately instead; all pass, and no CFD was run.
- Exactly one non-empty `candidate_target_policy.jl` exists under `solver/`,
  and the new direct parameter reference is owned by
  `target_policy_params()`. A nominal sub-band state exactly matches the
  sampled parent. On a synthetic unguarded command pair, the parent output
  `(29.1739,28.4669)` is projected to `(28.2605,27.5756)` with the ratio
  preserved to floating-point tolerance. On an extreme outward state the
  downstream angle guard retains its full `-30` anterior brake.
- A deterministic grid of 19,683 finite states confirms bounded two-joint
  output and lateral reflection equivariance. This validates contract,
  pass-through, common scaling, guard ordering, and symmetry only; it is not a
  prediction of the unevaluated CFD trajectory.
