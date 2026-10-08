# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. All terminate in capture, so this iteration compares route
  progress, arrival, wake organization, loads, and actuator viability rather
  than treating first-crossing depth as a separate success class.
- The combined top-down vorticity and oblique Lambda2 sheets were inspected for
  the best-score sample (`solver_fb7bddf12f80`), the weakest-score but still
  finite capture (`solver_8e7135ef9173`), the assigned parent
  (`solver_93fdf80136b2`), and the force-commutated comparison
  (`solver_3065fba218c6`). From release through termination, each fish is
  self-propelled rather than advected, produces an orderly alternating wake,
  and retains a compact coherent three-dimensional wake through the same late
  target-side hook. None shows wake breakup, wasteful broad curling, boundary
  interaction, or numerical instability. The nearly identical visible
  topology rules out another carrier-gain or terminal-waveform interpretation.
- Metrics nevertheless replicate an upstream route improvement. Relative to
  the translation-consistent sample's `10.4643/6.2320/1.8942L` distances at
  `8/16/24T`, all three descendants containing posterior course-slip vectoring
  reach `10.4536--10.4546/6.1888--6.1924/1.8095--1.8216L` and capture
  `0.0825--0.1540T` earlier. They retain zero angle/rate/action contacts; their
  maximum angle/rate/action are about `0.770 rad`, `4.514 rad/T`, and
  `29.725 rad/T^2`. The modest peak-load increase from the baseline's
  `0.01883/0.00979` planar force/yaw moment to at most `0.01944/0.00987` is a
  falsification boundary, not permission to strengthen the scalar vectoring.
- The nested alternatives do not supply another semantic gain. Instantaneous
  force commutation captures fastest at `26.0920T` but worsens mean distance to
  `2.51220L`, reaches only `0.749919L`, and loses score to `-0.609997` versus
  the uncommutated vectoring sample's `2.50987L`, `0.748361L`, and `-0.607211`.
  The assigned parent's near-target route-priority arbitration improves the
  `24T` distance and arrival slightly but trades the crossing to `0.748769L`
  and score to `-0.607378`; this milliscale exchange leaves the same visible
  hook and is not evidence for more arbitration or terminal threshold tuning.
- The remaining course error is upstream and geometric. In the assigned-parent
  trace, normalized velocity-to-target course error remains about `0.69` at
  `8T` and `0.54` at `16T`, with projected misses near `7.2L` and `3.3L`, even
  while body bearing is only about `-0.05` and `-0.18 rad`. Thus the existing
  bearing-triggered same-sign redirect does not address the largest
  translational misalignment. An inherited step-31 log proposed a
  course-triggered redirect for this condition, but its materialized candidate
  contains no `course_redirect` parameter or gate and evaluates in the old
  shallow-capture family. That archived duplicate cannot falsify a mechanism
  absent from its source.

## Policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, evidenced
posterior course-slip vectoring, target-line response, capture modulation,
course-priority handoff, coordinated acceleration projection, and angle/rate
viability guards. Add exactly one upstream redirect trigger: when translation
is observable and closing, both normalized course error and velocity-projected
miss smoothly engage the already calibrated same-sign two-joint redirect even
if folded body bearing is small. Combine that gate with the bearing gate as a
bounded union, while retaining the redirect's measured yaw/bend release and
the existing downstream feasibility projections. As course error or projected
miss falls, the burst releases continuously into the productive posterior
traveling wave; it is inactive in the sampled middle/terminal corridor.

The falsifiable expectation is earlier target-directed course acquisition,
lower mean distance, and earlier capture with a visibly changed upstream route,
while preserving the coherent two-view wake, zero actuator contacts, and the
sampled vectoring load envelope. Reject the mechanism if the redirect suppresses
propulsion, persists into the terminal corridor, loses capture, returns only a
milliscale-equivalent path, reaches an actuator envelope, or materially exceeds
`0.01944/0.00987` peak planar force/yaw moment.

bookshelf_consulted: true
source_domain: biological C-start turning and sensor-modulated robotic-fish closed-loop steering
source_mechanism: large observed route error engages bounded curvature and observed response releases the swimmer back into its propulsive rhythm
transferable_invariant: engage a temporary turn mode from normalized geometric error and release it from measured response rather than elapsed time
nontransferable_details: species-specific C-start kinematics, published gains, dimensional burst duration, robot linkage geometry, clock phase, exact vortex phase, and prescribed routes
policy_translation: normalized body-frame velocity-to-target course error and projected miss gate the existing two-joint redirect, while joint state and phase-rejected yaw preserve its response release
falsification: reject on unchanged upstream course, lost or slower capture, loss of coherent propulsion, redirect persistence near the target, actuator contact, or materially higher force and yaw-moment exposure

## Non-CFD audit after the policy edit

- Every direct `params.FIELD` reference is owned by the returned 55-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations, and a deterministic 486-state grid spanning beyond-limit
  joint angles/rates, both lateral sides, and negative/zero/positive closing
  speeds remains finite and inside the `30 rad/T^2` policy envelope.
- Paired lateral reflections produce exactly sign-reflected two-joint commands
  on both the stress grid and every reconstructed assigned-parent trace row.
  The new gate is multiplied by positive closing speed and translation
  confidence, so non-closing and unobservable-course states pass through.
- Re-evaluating the parent and candidate on reconstructed observations from all
  4,749 assigned-parent trajectory rows changes 1,388 post-guard command pairs,
  including 954 by more than `0.05 rad/T^2`. The maximum separation is
  `9.8432 rad/T^2`, while the candidate's peak frozen-state command remains the
  parent's `29.7244 rad/T^2`. Activation is confined to sampled states outside
  about `3.54L`; no row at or inside `3L` changes. This establishes a bounded,
  material upstream mechanism and exact terminal pass-through only. Formal CFD
  evaluation occurs after this worker exits.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this ChatGPT account. Its three prescribed commands were run
  directly as the established fallback: the material-guidance check, Julia
  contract/schema check, and solver editable-boundary check all pass. The
  guidance check first exposed the rendered `README.md`'s duplicated
  assigned-parent marker; removing only that duplicate marker repaired it. No
  CFD was run.
