# Axial-force-coherent posterior energy injection

## Completed evidence and visual diagnosis before editing

- The four sampled solvers are byte-identical v50 policies and byte-identical
  trajectories.  All start directly from uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm, then self-propel to
  `capture` at `17.41299 T`, score `-0.0595203`, final distance
  `0.745094 L`, and total/observed distance integrals
  `1.945327/1.329976 L`.  They are repeated evidence for one strong finite
  comparator, not four independent controller mechanisms.
- I inspected both rows of every sampled combined sheet and the two inherited
  step-39 mechanism regressions.  Every top-down row shows a smooth
  target-signed arc and compact startup vorticity developing into an organized
  alternating posterior street through capture, with no passive advection,
  reversal, collision, boundary exit, or wake collapse.  Two sampled v50
  sheets have fully black oblique rows; the readable reproductions show compact
  paired caudal Lambda2 structures at release, `4 T`, `12/16 T`, and capture,
  with an intermittent missing middle panel.  The inherited de-gaited-course
  sheet is also black in the oblique row, while the terminal-duty sheet shows
  the same paired structures as v50.  Those missing panels are rendering
  limitations, and neither regressed policy creates a beneficial visible wake
  topology.
- The completed regressions sharpen the terminal-course boundary.  Adding an
  analytically carrier-rejected course signal only to posterior wave shape
  retains the `17.41299 T` capture but worsens score, total integral, and final
  distance to `-0.059942`, `1.945667 L`, and `0.745503 L`.  Translating
  de-gaited terminal bearing divergence into posterior half-cycle duty is worse
  at `-0.062276`, `1.947549 L`, and `0.747766 L`, and raises exact any-joint
  acceleration-limit residence from `40.11%` to `40.21%`.  Their observed
  integrals also worsen to `1.329978/1.329991 L`; changing either the signal
  treatment or actuator placement does not rescue extra terminal course
  correction.
- V50 already has useful propulsion and steering but leaves a distinct
  response signal unused.  On its completed trace, normalized forward body-axis
  force `-force_body_L[1]` spans about `-0.00664` to `0.01569` and is positive
  above `0.0005` on about `64.5%` of settled states.  The positive-force subset
  has mean `0.00644`; during final approach, positive force is associated with
  positive posterior velocity on about `75%` of supported states.  This
  calibrates a bounded hydrodynamic-response cue without treating lateral sway,
  a short derivative window, exact vortex phase, or terminal geometry as new
  route error.

## Sole candidate and policy hypothesis

Preserve v50's normalized body-frame target sensing, state-feedback oscillator,
posterior lag, whole-wave pose rejection, selective crossflow confidence,
route and redirect steering, launch allocation, carrier-first spillover,
half-cycle steering, geometry-qualified posterior turn-shape release, approach
priority, and componentwise action projection.  Add one new carrier mechanism:
after observed positive closing and outside large body-frame target errors,
pass normalized forward body-axis force through a smooth one-sided confidence and multiply it
by normalized posterior joint velocity.  Add the resulting small signed
acceleration to the posterior carrier before steering allocation.  This injects
energy along an observed posterior stroke only when the hydrodynamic reaction
is propulsive; it supplies no independent mean-turn sign, prescribes no phase,
does not change the anterior oscillator, and cannot expand the actuator
envelope.  Distance tapering makes
it yield through approach, while response and reflection-even geometric
arbitration protect launch and the established target-signed arc.

The next CFD rollout should preserve the v50 route and organized two-view wake
while using force-coherent posterior work to improve broad/middle closing and
capture time or either distance integral.  Falsify the mechanism if it creates
a mean bend or beat-synchronous weave, delays or shallows capture, increases
posterior or total limit residence without a closure benefit, loses the
target-signed arc or wake coherence, or materially exceeds the established
`0.9831 L/T`, `0.032252`, and `0.016092` speed/normalized-force/moment
envelope.  Formal CFD runs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: Lighthill reactive-thrust theory and sensor-modulated robotic-fish CPG control
source_mechanism: posterior kinematics generate reactive thrust, while measured response can gate a low-dimensional rhythmic energy residual without replacing the carrier
transferable_invariant: preserve the productive traveling wave and add energy only along an observed posterior stroke whose normalized body-axis hydrodynamic reaction is propulsive
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, full-body oscillator states, exact vortex phases, prescribed routes, and task-specific force histories
policy_translation: smoothly normalize positive `-force_body_L[1]`, multiply it by normalized posterior joint velocity and closing/body-frame-angle/distance arbitration, then add a bounded acceleration to the posterior carrier before residual steering and physical projection
falsification: reject if capture, distance integrals, route, saturation, loads, or readable two-view wake regress; the force cue must not create mean curvature or merely amplify every half-cycle
```

## Evidence boundary

All outcome and visual claims above come from the assigned-parent guidance,
the sampled completed solver evidence, and inherited optimizer logs.  The
force-coherent controller is one unevaluated policy hypothesis; no same-worker
CFD outcome is claimed.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v56_force_coherent_posterior_energy`, SHA-256
  `bc15943b90e2ef2ccd98236e00e5a5186b9163cd6c7cb60255f8147bd6a5daf0`.
  All `70` distinct direct `params.FIELD` references resolve among the `72`
  fields returned by `target_policy_params()`; the other fields are the
  version label and inherited `control_period` metadata.
- Frozen reconstruction over all `3,166` v50 trace rows finds finite support
  on `2,141` states, maximum/mean absolute injected acceleration
  `0.3288/0.0625 rad/T^2`, and nonnegative injected posterior power on every
  state.  The head command is exactly unchanged; final projection changes
  `784` posterior outputs by at most `0.3148 rad/T^2`, and the reconstruction's
  any-joint limit-contact count is unchanged.  The residual is exactly zero
  without positive axial force or observed closing.  This establishes scope,
  sign, and headroom only, not closed-loop performance.
- A direct mirrored-state test confirms the isolated new mechanism is exactly
  reflection-odd: forward-force confidence, closing, distance, and absolute
  body-frame angle are even, while posterior joint velocity supplies the odd
  acceleration direction.  The lightweight Julia contract, static parameter-
  schema guard, material-guidance check, and solver editable-boundary check
  pass.  The configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account; its three exact
  no-CFD commands were therefore run locally and separately and all pass.  No
  formal CFD was run.
