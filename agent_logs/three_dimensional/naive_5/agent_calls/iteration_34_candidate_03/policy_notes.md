# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. All capture without angle, speed, or applied-acceleration contact,
  so route progress, response, wake organization, and loads are the useful
  discriminants rather than termination class alone.
- Both visual rows were inspected for the strongest sampled policy
  (`solver_c65157fcb0b0`) and the informative force-commutated comparison
  (`solver_3065fba218c6`) from release through capture. The top-down sheets show
  genuine self-propulsion and an orderly alternating wake followed by the same
  target-side terminal hook. The oblique Lambda2 sheets retain a compact,
  coherent three-dimensional wake. Neither shows imposed advection, boundary
  interaction, wake breakup, numerical instability, or moving-window-induced
  body rotation. The visuals support retaining the carrier and rule out a
  stronger oscillator or another instantaneous-load phase gate.
- The assigned course/miss-triggered redirect is a real finite improvement. It
  captures at `0.749266L` and `25.9710T`, with score `-0.596086` and mean
  distance `2.498175L`, versus the unredirected posterior-vectoring sample's
  `0.748361L`, `26.1635T`, `-0.607211`, and `2.509866L`. It remains within the
  actuator envelope (maximum angle/rate/action about
  `0.7635 rad`, `4.5150 rad/T`, and `29.6581 rad/T^2`) and retains modest peak
  planar force/yaw moment (`0.01885/0.01010`). This supports preserving the
  bounded upstream burst rather than treating its small crossing-depth trade as
  a reason to revert it.
- The redirect does not, however, validate its proposed earlier course
  acquisition. At `8/12T` its velocity-projected miss is `7.85/6.22L`, worse
  than the unredirected sample's `7.17/6.03L`, despite slightly better distance.
  After the upstream trigger has withdrawn, the assigned trace retains
  body-normal velocity of about `0.269/0.239 U` at `20/22T`, versus only
  `0.028/0.021 U` in the unredirected sample. Its normalized course error and
  projected miss are consequently `0.743/2.90L` and `0.760/2.14L`, versus
  `0.362/1.44L` and `0.438/1.27L`. This is a distinct middle-corridor response
  deficit: more burst curvature or a stronger course-trigger scalar is not
  supported, while the low-sideslip comparison demonstrates an observable
  response boundary.
- The other nested alternatives reinforce that boundary. Conflict authority
  reallocation captures later at `26.1250T` with mean distance `2.510405L`, and
  instantaneous force commutation captures at `26.0920T` but worsens mean
  distance to `2.512198L` and crosses only `0.000081L` inside the radius. Both
  visual views retain the same route family. The inherited step-30--33 notes
  also show that these branches were explicit response/allocation tests, while
  the now-evaluated upstream redirect was the first materialized course-trigger
  after an earlier archived candidate omitted its proposed gate. Do not retune
  either rejected allocation or use force sign as a beat-phase command.

## Policy hypothesis

Preserve the assigned state-feedback traveling bend, course-triggered
response-released redirect, upstream posterior vectoring, target-line residual,
capture modulation, coordinated acceleration projection, and angle/rate
viability guards. Add exactly one response mechanism after the burst: in the
middle approach, compare normalized body-normal velocity with the
geometry-defined course side. When lateral translation is both material and
opposite the needed course correction, apply a bounded target-side posterior
wave-shape shift using anterior joint-state phase. Positive closing speed,
translation confidence, the existing course-slip deficit, and redirect release
qualify the correction; a continuous distance window withdraws it before the
final capture approach. Far travel, low sideslip, helpful sideslip, non-closing
motion, active redirect, and the terminal controller pass through.

The falsifiable expectation is to retain the assigned parent's upstream
distance/arrival gain while reducing the `20--22T` normalized course error and
projected miss, producing a visibly straighter middle handoff or added capture
margin without exceeding its `0.01885/0.01010` load regime or restoring any
actuator contact. Reject the mechanism if it erases upstream progress, leaves
the middle route unchanged, over-corrects helpful lateral motion, loses capture
or wake coherence, alters the terminal corridor materially, or increases
force/moment or limit exposure.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish CPG steering
source_mechanism: use a bounded posterior wave-shape correction to redirect reactive thrust when observed translational response lags body aim, while preserving the anterior rhythmic carrier
transferable_invariant: separate a temporary curvature redirect from measured post-turn sideslip recovery, and allocate the latter through posterior traveling-wave shape only while the response deficit persists
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot linkage geometry, clock phase, exact vortex phase, and prescribed routes
policy_translation: normalized body-frame lateral velocity, target-course geometry, closing speed, distance, and joint-state phase gate a bounded posterior target shift after the existing response-released redirect
falsification: reject on lost capture or coherent three-dimensional propulsion, unchanged or worse middle projected miss, erased upstream progress, helpful-slip cancellation, actuator contact, or peak load above the assigned-parent regime

## Non-CFD audit after the policy edit

- Every direct `params.FIELD` reference is owned by the returned 59-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations, and the candidate remained non-empty throughout the edit.
- A deterministic 33,750-state grid spanning both lateral sides, negative,
  zero, and positive closing speeds, all distance regimes, and beyond-limit
  joint angles/rates remains finite and inside the `30 rad/T^2` policy
  envelope. Paired lateral reflections have zero numerical command error.
- Re-evaluating the assigned parent and candidate on 4,722 reconstructed
  parent-trace states changes 266 post-guard command pairs, including 138 by
  more than `0.05 rad/T^2`. The largest separation is
  `0.617656 rad/T^2`, while the candidate's peak frozen-state command remains
  the parent's `29.658046 rad/T^2`. Activation is confined to
  `18.876--25.014T` and `4.499--1.172L`; far travel and the final approach
  pass through. This establishes a material bounded middle-response test, not
  CFD evidence of improvement.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this ChatGPT account. Its three prescribed commands were run
  directly as the established fallback. The guidance check first exposed the
  rendered `README.md`'s duplicated assigned-parent marker; removing only that
  duplicate marker repaired it. The material-guidance, Julia contract/schema,
  and solver editable-boundary checks then pass. No formal CFD was run.
