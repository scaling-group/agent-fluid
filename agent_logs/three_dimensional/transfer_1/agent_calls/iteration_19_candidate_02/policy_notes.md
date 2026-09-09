# Wake-policy candidate diagnosis

## Evidence read before policy edit

- All four sampled rollouts and the three inherited assigned-parent rollouts
  use direct uniform still-water initialization at `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. Their translation and wakes are therefore
  released-swimmer behavior rather than ambient advection.
- I inspected both rows of all four sampled combined keyframe sheets and the
  three inherited failure sheets. The exact prefilled speed-reserve bytes
  capture four times at `0.7466--0.7499L` after `18.205--18.668T`; top-down
  vorticity remains alternating and the oblique Lambda2 structures remain
  compact through capture. The three inherited variants also retain an active
  traveling wake and remain numerically stable, but exit below the target
  after closest approaches of `1.6860L`, `1.4601L`, and `3.7595L`. The
  distinction is terminal/path geometry, not propulsion collapse or advection.
- The latest inherited velocity-half-cycle candidate is especially
  informative because its implementation contradicts its stated hypothesis.
  `within_beat_steering_scale` was applied at every distance: no terminal or
  intercept gate appears in its arguments or return value. On the closing
  branch at about `4L`, its center is already near `(13.09,8.47)L`, versus
  `(13.14,11.21)L` for the highest-scoring sampled baseline. It bottoms out at
  `3.7595L`, so this run does not test terminal half-cycle allocation at all;
  it falsifies ungated phase asymmetry and the practice of accepting a claimed
  far-field invariant without checking the executable expression.
- The earlier carrier-acceleration half-cycle allocation was explicitly gated
  but reached only `1.6860L`, and terminal yaw damping reached only `1.4601L`.
  Together with four repeat captures for the prefill, this rejects another
  additive-steering redistribution or yaw residual. The remaining shelf
  alternative is a small posterior wave-shape/phase-lag modulation that keeps
  the proven head steering, carrier reserve, route error, and response release
  intact and is algebraically zero outside the intercept region.

## One candidate hypothesis

Preserve the sampled controller outside the existing `2.75L` intercept gate.
Inside that gate only, add a small signed posterior target-bias pulse when the
observed anterior joint moves fastest through neutral curvature. The pulse is
proportional to the existing body-frame turn request, fades when the proven
response release is active, and uses only normalized joint state. This moves a
small amount of requested curvature into posterior wave shape without
attenuating the traveling bend or repeating either failed all-joint
half-cycle steering allocation.

Expected test: the candidate must remain command-identical to the four-capture
baseline outside `2.75L`, retain the coherent top-down and oblique wakes, and
enter the capture circle on a less grazing path without increasing action or
speed saturation or the sampled force/moment envelope. Formal CFD runs only
after this worker exits, so this is a falsifiable hypothesis, not new evidence.

Falsification: reject the mechanism if any far-field output differs, the same
below-target exit remains, closest approach worsens from the repeat-supported
capture class, the posterior beat or alternating wake weakens, or clipping,
speed-limit residence, lateral force, or yaw moment rises materially.

bookshelf_consulted: true
source_domain: fish and robotic-fish turning by posterior phase-lag or wave-shape modulation
source_mechanism: embed a bounded target-directed curvature pulse in the posterior traveling wave instead of redistributing the additive steering acceleration across both joint half-cycles
transferable_invariant: a small state-synchronous change in posterior wave shape can realize turning while preserving the active propulsive carrier
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, oscillator clocks, exact vortex phases, prescribed paths, and task coordinates
policy_translation: use normalized anterior joint speed as a clock-free phase cue and the existing body-frame turn and intercept gates to add a bounded posterior target bias that is exactly zero outside the terminal region
falsification: reject if far-field commands change, capture reliability or closest approach worsens, the alternating wake weakens, or saturation and force or yaw-moment loads exceed the repeat-supported baseline

## Non-CFD verification

- The guidance semantic check passes after resolving the duplicated rendered
  assigned-parent marker; it recognizes this file and the material reusable
  update in `guidance/control_experience.md`.
- The mandated policy-contract assertions pass under Julia `1.12.6`: the
  parameter object has no forbidden `L` field and the policy returns two
  finite accelerations for the full adapter state.
- A direct Julia comparison with the sampled baseline returns bit-identical
  actions at `4L`, while a non-saturated `1.5L` state activates only the new
  posterior term. Mirroring target lateral position, lateral velocity, joint
  state, yaw rate, and previous action produces exactly sign-mirrored output.
- The solver editable-boundary check passes. No CFD rollout was run.
