# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts and all three assigned-parent rollouts report
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. Their translation and wakes therefore come from
  released-swimmer dynamics rather than background advection.
- The current prefill is the repeat-backed
  `dogfish3d_intercept_guarded_speed_reserve_v1` baseline. Its two current
  samples capture at `0.7466--0.7494L` after `18.3205--18.6010T`; inherited
  logs establish two more exact captures. The two current exact
  `dogfish3d_speed_reserve_posterior_wave_shape_v1` samples also capture, at
  `0.7480--0.7492L` after `18.1995--18.4690T`. Their scores and mean distances
  overlap the baseline range, so the result establishes two-run compatibility
  and repeatability evidence, not superiority.
- I inspected the combined top-down vorticity and oblique Lambda2 rows for the
  highest-scoring baseline capture, a posterior-wave capture, and the assigned
  parent's geometry-gated yaw-brake failure. Both capture policies visibly
  self-propel through termination with organized alternating mid-plane
  vortices and compact three-dimensional structures. The yaw brake likewise
  retains an active wake, but turns below the target, reaches only `1.5097L`,
  and exits the lower boundary. Its failure is terminal steering topology, not
  advection, carrier collapse, or numerical instability.
- Trace cross-checks agree with the images. The posterior repeats reach the
  capture boundary at `0.857--0.905L/T`; action clamps on
  `68.24--68.46%` / `70.94--70.96%` of rows, speed-limit residence is
  `10.81--10.88%` / `11.58--12.00%`, peak force norm is
  `0.0314--0.0319`, and peak yaw moment is `0.0161--0.0167`. These ranges are
  close to the sampled baseline envelope and do not establish an actuator or
  load improvement. The failed yaw brake still travels at `0.829L/T` at its
  closest pass, confirming that more damping or scalar route gain is not the
  evidenced next test.

## One candidate hypothesis

Install an exact third copy of the sampled posterior-wave policy, with no gain
or gate changes. It preserves the achieved-course/intercept route controller,
the state-feedback traveling bend, additive steering, and sparse outward
carrier reserve. Only inside the existing normalized intercept-distance gate,
anterior joint speed supplies a clock-free phase cue for a small target-signed
posterior target bias. Repeating exact bytes isolates whether this compact
wave-shape mechanism survives the direct-uniform rollout variability before a
later worker judges any benefit beyond compatibility.

Expected test: remain identical to the four-capture baseline outside `2.75L`,
retain both coherent wake views, and obtain a third capture without leaving the
sampled force, moment, speed-limit, or clipping envelope. A third capture would
support robustness of the mechanism but still would not prove superiority
unless later evidence shows better arrival, path variation, loads, or actuator
use.

Falsification: reject the posterior pulse and restore the exact speed-reserve
baseline if this repeat misses, changes far-field closure, weakens the active
traveling wake, or raises loads or saturation outside the sampled envelope.
Do not answer a failed repeat by scalar-only pulse tuning or by stacking the
falsified yaw brake.

bookshelf_consulted: true
source_domain: fish and robotic-fish turning through posterior phase-lag or wave-shape modulation
source_mechanism: embed bounded target-directed posterior curvature within an active traveling bend
transferable_invariant: state-synchronous posterior wave-shape steering can remain subordinate to and preserve rhythmic propulsion
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator phase, exact vortex phase, and task-specific routes
policy_translation: use normalized anterior joint speed as a clock-free phase cue and existing body-frame turn and intercept gates to add a bounded tail-target bias that is zero in the far field
falsification: reject if exact replay loses capture, alters far-field closure, weakens either wake view, or increases saturation or force and yaw-moment loads beyond the sampled baseline envelope
