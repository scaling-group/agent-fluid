# Response-retained approach-cadence candidate

## Completed evidence and visual diagnosis before editing

- All four sampled episodes terminate in finite `capture` from direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  The
  assigned v43 axis-selective parent is strongest: it captures at
  `17.75400 T`, score `-0.07917`, and total/observed distance integrals
  `1.96508/1.34990 L`.  Its mean/max speed, any-joint acceleration-limit
  residence, and peak normalized lateral-force/yaw-moment magnitudes are
  `0.7168/0.9603 L/T`, `44.30%`, and `0.03225/0.01609`.
- Three separately written full-axial-release siblings reproduce capture at
  `17.89700 T`, score `-0.08687`, and integrals `1.97313/1.35927 L`.  They
  gain `0.0050/0.0195 L` over the parent at `2/4 T`, but the parent reverses
  that lead by `6 T` and is closer by `0.0378/0.0720/0.0929/0.0909 L` at
  `8/10/12/16 T`.  Thus ignoring sway for the entire posterior launch gives
  a short launch gain but a worse route.  Keeping total-speed governance on
  the base wave and reserving axial release for the small phase-even energy
  residual is the completed semantic improvement; this rules out another
  launch-amplitude increase.
- I inspected the combined sheets for the strongest parent and the readable
  full-axial comparator from release through capture.  Their top-down rows
  show active self-propulsion on the same smooth target-signed arc, with the
  compact startup disturbance developing into a coherent alternating
  posterior street.  Their oblique rows show compact paired Lambda2
  structures following the caudal region without wake collapse, reversal,
  collision, or domain exit.  One other sibling's oblique row is black, which
  is a rendering failure rather than evidence about its 3D wake.
- The inherited logs bound the next edit.  Posterior launch energy and axial
  response are already useful, whereas phase-selected launch, route-wide
  lateral-load confidence, raw-crossflow dropout bridging, reverse spillover,
  and whole-wave rate projection either underperform or fail.  The current
  carrier, selective crossflow pose cue, steering, launch envelope, and
  carrier-first allocation should therefore remain unchanged.
- The remaining measured opportunity occurs only inside the `2.1 L` approach
  region.  Over `16-17 T` and `17 T` to capture, mean closing response is
  `0.9996/0.9994` and mean speed is `0.791/0.756 L/T`, but the approach gate
  lowers the cadence multiplier from the far-route value near `1.114` to
  `1.089/1.055` (and `1.041` at the terminal sample).  Mean turn load remains
  finite at `0.429/0.409`; the completed rollout shows neither instability nor
  excess terminal speed.

## One-candidate policy hypothesis

Preserve v43 exactly through launch and the far/middle route.  In the existing
cadence branch only, blend the distance gate back toward full cadence when the
normalized closing response is productive and the bounded turn load leaves
headroom.  Proximity alone will therefore not withdraw established rhythmic
propulsion during a stable crossing, while weak closure or heavy steering
restores the evaluated approach scheduling continuously.  This adds no clock,
route identity, mean bend, direct flow actuation, or new launch amplitude.

Frozen-trace reconstruction changes no command outside `2.1 L`.  On the
completed parent trace it would raise the mean frequency scale only from
`1.0893` to `1.1037` over `16-17 T` and from `1.0547` to `1.0898` after
`17 T`; the terminal value becomes `1.0797`.  These are structural values,
not a closed-loop claim.  The intended signature is capture before
`17.754 T` with total/observed integrals below `1.96508/1.34990 L`, while
retaining the smooth arc, coherent two-view wake, and the parent's speed,
saturation, force, and moment envelope.  Formal CFD occurs only after this
worker exits.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal capture control
source_mechanism: modulate an established rhythmic gait with measured task response, retaining propulsion through approach while yielding when steering or closure indicates correction is needed
transferable_invariant: proximity is not by itself evidence that propulsion should be withdrawn; bounded cadence may persist when normalized body-frame response still closes the target and steering demand leaves authority
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed near-target stages, exact vortex phases, and task-specific routes
policy_translation: blend only the normalized approach cadence gate toward one using productive closing response and one-minus bounded target-derived turn load; preserve the state-feedback carrier, posterior launch, curvature, and componentwise actuator projection
falsification: reject if capture or distance integrals regress, the late trajectory turns away or overshoots before capture, acceleration-limit residence grows materially, the alternating wake degrades, or maximum speed and normalized force/moment exceed the completed v43 envelope
```

## Evidence boundary

All outcomes and visual claims above come from the assigned parent, sampled
solver results, inherited optimizer notes, and inherited durable guidance.
The candidate below has no same-worker CFD evidence.

## No-CFD implementation audit

- The single candidate is
  `dogfish_target_control_v44_response_retained_approach_cadence`, with
  SHA-256
  `aead2d5677b05212572ec28f47864bf4256979e86ad386fcdf0e082e0faa4620`.
  Its only control change from completed v43 is the response/turn-load blend
  applied to the existing cadence distance gate.
- A targeted Julia comparison confirms exact parent actions outside the
  approach region and for a near-target state without positive closure.  A
  productive near-target state changes action, remains finite, and stays
  inside the componentwise acceleration limit.  All `66` direct
  `params.FIELD` references resolve against fields returned by
  `target_policy_params()`.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this account.  Its material-guidance check, lightweight
  Julia contract, and solver editable-boundary command were therefore run
  locally and separately and all pass; the targeted mechanism audit also
  passes.  The duplicate rendered assigned-parent marker in the workspace
  README was removed so the prescribed guidance comparison has exactly one
  parent.  No formal CFD was run.
