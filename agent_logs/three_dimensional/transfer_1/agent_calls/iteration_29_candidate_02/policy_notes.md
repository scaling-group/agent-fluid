# Axial-confident posterior approach-wave candidate

## Completed evidence and visual diagnosis before editing

- All four sampled evaluations are finite `capture` episodes initialized
  directly from uniform still water with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm snapshot.  The v43 axis-selective energy-launch controller
  remains the strongest completed result: it captures at `17.75400 T`, score
  `-0.07917`, and total/observed distance integrals `1.96508/1.34990 L`.
  Mean/max speed, any-joint acceleration-limit residence, and peak normalized
  planar force/moment are `0.7168/0.9603 L/T`, `44.14%`, and
  `0.03225/0.01609`.
- The three sampled approach variants are essentially terminal-only changes.
  They are byte-identical to v43 through the `16 T` checkpoint and all capture
  at `17.74850 T`.  Ungated and axial-confidence cadence retention worsen the
  total integral to `1.96640/1.96625 L` and increase limit residence to
  `44.31/44.41%`; divergence-retained steering reaches `1.96528 L` with
  `44.16%` residence.  Their observed integrals improve by only
  `0.00003-0.00006 L`, and none beats v43's total integral or score.  This is
  not evidence for another near-target cadence or steering-gate refinement.
- I inspected all four combined sheets from release through capture.  Every
  top-down row shows active self-propulsion on the same smooth target-signed
  arc: a compact startup disturbance grows into an organized alternating
  posterior vorticity street, with no reversal, collision, domain exit, or
  visible instability before capture.  The readable v43 and axial-cadence
  oblique rows show compact paired Lambda2 structures following the caudal
  wake through approach.  The other two oblique rows are black rendering
  failures, so they cannot support comparative 3D-wake claims.  The useful
  test should preserve this wake rather than seek a new topology.
- Assigned-parent guidance and inherited logs rule out whole-launch axial
  release, beat-phase launch concentration, route-wide load confidence,
  raw-crossflow dropout bridging, reverse spillover, and whole-wave rate
  projection.  The inherited posterior-only approach-thrust proposal remains
  unevaluated.  The current samples sharpen it: axial response gives a small
  terminal advantage over total-speed cadence, but cadence consumes anterior
  carrier authority and does not improve the completed route semantics.

## One-candidate policy hypothesis

Start from the completed v43 controller, not from either terminal gate stack.
Preserve its carrier, target sensing, selective crossflow pose cue, geometric
redirect, curvature, launch governor, half-cycle steering, and carrier-first
spillover.  Inside the existing `2.1 L` approach region, add one bounded
zero-mean posterior-wave residual only while measured target closure is
productive, body motion has positive forward-axis confidence rather than
lateral sway, and target-derived turn load leaves authority.  This changes no
anterior cadence, no mean route or redirect curvature, and no action outside
the approach region.

The intended signature is to retain v43's exact launch and middle route while
matching the siblings' small terminal arrival benefit without their anterior
saturation increase: capture no later than `17.754 T`, total/observed
integrals no worse than `1.96508/1.34990 L`, and no material increase beyond
`0.9603 L/T`, `44.14%`, and `0.03225/0.01609` maximum speed, limit residence,
and normalized force/moment.  Formal CFD occurs only after this worker exits;
none of those intended outcomes is claimed here.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and sensor-modulated robotic-fish CPG control
source_mechanism: posterior traveling-wave kinematics supply reactive thrust, while closed-loop gait emphasis should persist only under a measured propulsive response and yield to steering
transferable_invariant: when a coherent carrier already closes the target, place a bounded propulsion residual in posterior wave shape and retain it only under normalized positive axial-motion confidence, productive closing, and available turn authority
nontransferable_details: published gains, dimensional cadence or amplitude, species and robot kinematics, full-body envelopes, exact vortex phases, prescribed approach stages, and task-specific routes
policy_translation: multiply a zero-mean posterior-wave approach residual by normalized proximity, productive body-frame closing response, positive forward-speed fraction, and one-minus bounded target-derived turn load; preserve target-derived mean curvature and componentwise action limits
falsification: reject if capture, total or observed distance integral, or terminal axial closure regresses; if anterior or posterior limit residence, lateral crossing, speed, or normalized loads grow materially; or if readable two-view evidence loses the organized alternating wake
```

## Evidence boundary

All completed outcomes and visual claims above come from sampled CFD, the
assigned parent guidance, and inherited optimizer notes.  The candidate below
has no same-worker CFD evidence.

## No-CFD implementation audit

- The single candidate is
  `dogfish_target_control_v46_axial_confident_posterior_approach_wave`, with
  SHA-256
  `a5f52d232bda83c9b8cc9ffe2c63239be997163f75688b69216b98139d90d320`.
  All `66` distinct direct `params.FIELD` references resolve among the `68`
  fields returned by `target_policy_params()`.
- A targeted Julia comparison against completed v43 confirms byte-equal
  two-joint actions outside the `2.1 L` approach region, under nonpositive
  closing, and under backward axial motion.  In a productive, forward-moving
  approach state the anterior action remains exactly unchanged and only the
  posterior action changes by `-0.33645 rad/T^2`; the corresponding mirrored
  state reverses the residual sign.  Tested outputs remain finite within the
  componentwise acceleration bound.  This is a structural audit, not a
  closed-loop result.
- The material-guidance check, lightweight Julia policy contract, and solver
  editable-boundary check pass locally.  The rendered `README.md` initially
  marked the same assigned parent twice; removing only that duplicate marker
  made the required parent comparison unambiguous.  No formal CFD was run.
