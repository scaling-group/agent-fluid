# Energy-qualified axis-selective posterior-launch candidate

## Completed evidence and visual diagnosis before editing

- All four sampled policies complete finite `capture` episodes from direct
  uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  The assigned split-response parent captures at `17.7540 T`, score
  `-0.07917`, and total/observed distance integrals `1.96508/1.34990 L`.
  Its mean/max speed, any-joint acceleration-limit residence, posterior-limit
  residence, and peak normalized planar force/yaw moment are
  `0.71678/0.96031 L/T`, `44.14%`, `6.16%`, and `0.03225/0.01609`.
- The three sampled alternatives are independently written but behaviorally
  identical wholesale axial-release policies.  Each captures at `17.8970 T`,
  score `-0.08687`, and integrals `1.97313/1.35927 L`.  They are `0.0050 L`
  closer at `2 T`, but the assigned parent leads by
  `0.0195/0.0146/0.0378/0.0720/0.0929/0.0902/0.0909 L` at
  `4/6/8/10/12/14/16 T`.  Their mean/max speed and any/posterior limit
  residence are slightly lower at `0.71263/0.95549 L/T` and
  `43.79/5.72%`; peak force and moment are identical to the parent.  Thus
  assigning axial response to the whole established launch envelope buys a
  small first-`2 T` lead but loses more closure afterward, while retaining
  total-speed response for the base envelope and using axial response only for
  the energy-deficit residual produces the stronger route.
- I inspected the assigned parent and a wholesale axial alternative from
  release through capture in their combined sheets, including every top-down
  vorticity frame and oblique body/Lambda2 frame.  Both visibly self-propel
  from the quiescent release along the same smooth target-signed arc.  A
  compact startup disturbance develops into a coherent alternating posterior
  street in the top-down row and compact alternating caudal structures in the
  readable oblique row.  Neither rollout shows passive advection, collision,
  route reversal, wake collapse, domain exit, or visible instability.  The
  nearly indistinguishable wake topology and identical peak load scale make
  response allocation, rather than a new wake mode, the supported explanation.
- Inherited logs establish why the present comparison is narrow.  The
  response-released posterior envelope and its phase-even energy deficit were
  previously positive, while beat-side allocation, force-confidence bridges,
  and whole-wave route-rate projection regressed closure or stability.  The
  new evidence also rejects replacing the base envelope wholesale with the
  axial signal.  The remaining falsifiable opportunity is to use the observed
  posterior-energy deficit to recover only that early axial authority, then
  revert continuously to the assigned parent's completed split response once
  the traveling wave is developed.

## One-candidate policy hypothesis

Preserve the assigned parent's carrier, target geometry, route/redirect
curvature, crossflow-confidence pose sensing, response-released cadence and
lag, half-cycle steering, and carrier-first spillover.  Change only the base
posterior launch gate: interpolate it from positive axial-speed response while
the phase-insensitive posterior wave energy is deficient to the parent's
total-speed response as that energy develops.  Retain the parent's small
axial-and-energy residual unchanged.  Algebraically this recovers only the
nonnegative difference between the axial and total-speed gates, multiplied by
the existing energy deficit; it adds no gain, clock, route stage, beat-side
selection, or mean curvature.

The intended signature is to recover the wholesale axial siblings' roughly
`0.005 L` advantage at `2 T` while preserving the assigned parent's
`4–16 T` checkpoint leads, capture before `17.754 T`, and integrals below
`1.96508/1.34990 L`.  Falsify the mechanism if early closure does not improve,
the middle/late lead or capture regresses, the coherent two-view wake degrades,
posterior saturation becomes persistent, or speed and normalized load exceed
the parent's `0.961 L/T`, `0.03225`, and `0.01609` envelope materially.  The
candidate's CFD evaluation occurs only after this worker exits; none of these
intended outcomes is claimed here.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and sensor-modulated robotic-fish CPG amplitude control
source_mechanism: emphasize posterior traveling-wave motion while its observed locomotor amplitude is underdeveloped, then release the modulation as the wave and propulsive response establish
transferable_invariant: bounded posterior emphasis may be scheduled by phase-insensitive joint-state wave development while state feedback retains oscillator phase and target-derived mean curvature
nontransferable_details: published gains, dimensional frequency or amplitude, species and robot kinematics, full-body envelopes, exact vortex phase, and task-specific routes
policy_translation: use normalized mean-rejected tail-tangent energy to interpolate only the base posterior launch response from positive body-axis speed toward total planar speed; retain the existing closing, distance, and turn-load gates and the separate axial energy residual
falsification: reject if first-2T closure fails to improve, the parent checkpoint-wide lead or capture regresses, posterior saturation persists, the two-view wake loses coherence, or speed and normalized force/moment materially exceed the completed parent envelope
```

## Evidence boundary

All numerical outcomes and visual claims above come from the assigned parent,
sampled solver results, inherited optimizer notes, and inherited durable
guidance.  The candidate below has no same-worker CFD evidence.

## No-CFD implementation audit

- The single candidate SHA-256 is
  `c6bb242cf718e409fce6018688b468573b4de421ed8241548368ac6fb0a424a1`.
  All `65` distinct direct `params.FIELD` references resolve against the `67`
  fields returned by `target_policy_params()`.
- A deterministic comparison with the assigned parent leaves the anterior
  action exact and changes only posterior authority in a low-energy/high-sway
  state (`-3.92967` to `-4.66901 rad/T^2`).  It recovers the parent action
  exactly when lateral sway is absent or normalized posterior energy exceeds
  the deficit threshold.  The added recovery is unchanged under reflection of
  the mean-rejected tail pose/rate and reversal of sway sign, and all tested
  actions remain finite inside the componentwise acceleration bound.  This is
  a structural audit, not a closed-loop result.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  After removing the duplicated assigned-
  parent marker from the rendered workspace `README.md`, its material-guidance
  check, lightweight Julia policy contract, and solver editable-boundary check
  were run separately and all pass.  No formal CFD was run.
