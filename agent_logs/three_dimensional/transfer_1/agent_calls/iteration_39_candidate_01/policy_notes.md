# Distance-arbitrated posterior-response candidate

## Completed evidence and visual diagnosis before editing

- All four sampled solver examples are byte-identical v50 policies and finite
  captures from direct uniform still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm.  They reproduce capture at `17.41299 T`, score
  `-0.0595203`, total/observed distance integrals `1.945327/1.329976 L`, and
  final distance `0.745094 L`.
- The readable sampled combined sheet shows active self-propulsion on a smooth
  target-signed arc.  Compact startup vorticity grows into an organized
  alternating posterior street, and the oblique row shows compact paired
  caudal Lambda2 structures at its readable release, `4/12/16 T`, and capture
  frames.  Another sampled combined sheet has a black oblique row, and the
  inherited v54 sheet does too; those are visualization failures rather than
  evidence of a physical wake change.  No sampled rollout reverses, collides,
  exits the domain, or loses wake coherence before capture.
- Metrics agree with the readable visual: v50 reduces distance monotonically
  from `12.32772 L` to capture, reaches `10.2632/8.6885/6.9471/5.1802 L` at
  `6/8/10/12 T`, and stays within maximum speed `0.98310 L/T`, any-joint
  acceleration-limit residence `40.11%`, and peak normalized force/moment
  `0.032252/0.016092`.
- The assigned-parent inherited v54 axial-response release is the informative
  mechanism failure.  It is farther from the target at every `2 T` checkpoint
  through `16 T`, captures later at `17.59999 T`, and worsens score and
  total/observed integrals to `-0.0710911` and `1.957031/1.342079 L`.
  Any-joint limit residence also rises to `43.31%`; unchanged peak force and
  moment provide no compensating wake/load benefit.  Releasing supplementary
  curvature merely because axial speed is low therefore does not recover the
  early route.
- Inherited completed comparisons expose a different, state-localized
  crossover.  Relative to v49, v50 gives up `0.0249/0.0225 L` at `6/8 T` but
  leads by `0.0128/0.0364/0.0355/0.0373 L` at `10/12/14/16 T`.  V49 releases
  the small posterior steering residual from correct-sign yaw without v50's
  angular-completion qualifier; v50 retains more curvature until geometry
  contracts.  Separate inherited tests reject decisive nonlinear completion,
  axial blending, deadband normalization, and instantaneous course slip in
  route, desired-rate, or posterior-shape channels.  The remaining supported
  hypothesis is continuous arbitration between completed far and middle/late
  response laws, not another scalar reshaping or added thrust cue.

## One-candidate policy hypothesis

Preserve v50's normalized body-frame target sensing, state-feedback traveling-
wave carrier, posterior lag, selective crossflow pose confidence, route and
redirect steering, launch response, carrier-first spillover, half-cycle
steering, approach priority, and componentwise actuator projection.  Change
only the out-of-band correct-yaw release of its small phase-even posterior
turn-shape residual.  At far target distance, use the completed v49-style yaw
release so propulsion is not taxed by supplementary curvature; across a smooth
body-length-normalized distance band, continuously restore v50's geometric
completion qualifier, which owns the stronger middle/late route.  The
centerline-contraction branch and immediate approach behavior remain v50.

The next CFD rollout should recover some of the inherited `6-8 T` lead while
preserving or improving v50's `10-16 T` closure and capture.  Reject the
candidate if it loses capture, worsens either distance integral, introduces a
switching kink, changes the target-signed arc or coherent two-view wake, or
materially exceeds v50's speed, saturation, force, or moment envelope.  Formal
CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological burst-to-cruise redirection
source_mechanism: preserve a productive traveling-wave oscillator while a bounded steering residual yields or returns continuously from observed navigation geometry
transferable_invariant: when propulsion and maneuver curvature compete, arbitrate only the supplementary steering residual from normalized target geometry while leaving the carrier and base route feedback active
nontransferable_details: published gains, dimensional cadence, species-specific curvature and timing, full-body kinematics, exact vortex phases, and task-specific world-frame routes
policy_translation: blend the completed unqualified correct-yaw release into v50's geometrically qualified release across a smooth body-length target-distance band; retain all carrier, route, redirect, approach, and actuator-projection mechanisms
falsification: reject if the far-route lead is not recovered, v50 middle or terminal closure regresses, capture or reflection symmetry is lost, switching becomes nonsmooth, or speed, saturation, normalized loads, or coherent wake structure exceed the completed envelope
```

## Evidence boundary

All outcome claims above come from the assigned-parent guidance, current
sampled solver results, and inherited optimizer logs.  This candidate is an
unevaluated mechanism hypothesis; no same-worker CFD result is claimed.

## No-CFD implementation audit

- The lightweight Julia contract returns two finite accelerations, and every
  direct parameter reference resolves to the candidate parameter object.
- Replaying reconstructed observations from the completed v50 trace changes
  `28` frozen states: `23` beyond `9 L`, `5` in the `7-9 L` transition, and
  none at or inside `7 L`.  Maximum action difference is
  `0.04103 rad/T^2`, all outputs remain componentwise bounded, and the near
  route is exactly v50 on the frozen states.  This is an action-support check,
  not a prediction of the unevaluated closed-loop trajectory.
