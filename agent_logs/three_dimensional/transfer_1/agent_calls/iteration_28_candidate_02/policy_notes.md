# Posterior-allocated approach-thrust candidate

## Completed evidence and visual diagnosis before editing

- All four sampled evaluations are finite `capture` episodes initialized
  directly from uniform still water with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm snapshot.  The axis-selective energy-launch controller is the
  strongest route result: it captures at `17.75400 T`, score `-0.07917`, and
  total/observed distance integrals `1.96508/1.34990 L`.
- Three whole-launch axial-gated samples reproduce capture at `17.89700 T`,
  score `-0.08687`, and integrals `1.97313/1.35927 L`.  Their short `2-4 T`
  lead is reversed by `6 T`; the axis-selective controller is closer by
  `0.0378/0.0720/0.0929/0.0909 L` at `8/10/12/16 T`.  This completed negative
  result rules out applying axial-only release to the entire base launch.
- The response-retained approach-cadence sample preserves the axis-selective
  route exactly until the `2.1 L` approach region, then captures slightly
  earlier at `17.74850 T`.  Its observed-route integral improves marginally
  to `1.34985 L`, while its total integral worsens to `1.96640 L` because the
  discrete terminal sample is shallower (`0.74959 L` versus `0.74798 L`).
  In the approach region its mean closing speed rises from
  `0.73201` to `0.73332 L/T`, but any-joint acceleration-limit residence rises
  from `68.45%` to `70.15%` and mean absolute anterior/posterior acceleration
  rises from `26.55/23.59` to `26.69/23.79 rad/T^2`.  The signal that approach
  propulsion should not be removed solely by proximity survives, but the
  whole-carrier allocation is weak and already expends anterior authority.
- I inspected the strongest axis-selective and slower whole-axial combined
  sheets from release through capture.  Both top-down rows show active
  self-propulsion along a smooth target-signed arc: a compact startup
  disturbance develops into an organized alternating posterior street with no
  reversal, collision, domain exit, or wake collapse.  The axis-selective
  oblique row is readable and shows compact paired Lambda2 structures following
  the caudal region through capture.  The slower comparator's oblique row is
  black, so it is a rendering failure and supplies no comparative 3D-wake
  evidence.  The current mechanism should preserve rather than reorganize this
  wake.
- Assigned-parent and inherited optimizer logs bound the edit.  Phase-selected
  launch, route-wide lateral-load confidence, raw-crossflow dropout bridging,
  reverse spillover, and whole-wave route-rate projection already regressed or
  failed.  The parent's untested energy-conditioned axial bridge cannot be
  treated as completed evidence.  The sampled axis-selective controller is
  therefore the base, with its carrier, target sensing, crossflow pose cue,
  curvature, launch response, and carrier-first actuator allocation unchanged.

## One-candidate policy hypothesis

Start from the completed axis-selective energy-launch controller.  Translate
the small positive approach-cadence result into a different actuator
allocation: when normalized closing is productive inside the existing
approach region and bounded target-derived turn load leaves authority, add one
small residual only to the zero-mean posterior traveling-wave target.  Do not
increase anterior carrier cadence.  The residual continuously vanishes with
distance, weak closure, or steering load and cannot change route or redirect
mean curvature.

The intended signature is to preserve the completed controller exactly
outside `2.1 L`, retain capture and the `1.34990 L` observed integral, and
match or improve the cadence sibling's `17.74850 T` arrival and
`0.73332 L/T` approach closure without its increase in anterior saturation.
Reject the mechanism if middle-route actions change, capture or distance
integrals regress, terminal lateral motion or yaw grows, any-joint
acceleration-limit residence materially exceeds `68.45%` in approach, the
organized two-view wake degrades, or speed and normalized force/moment exceed
the sampled `0.96031/0.03225/0.01609` envelope.  Formal CFD occurs only after
this worker exits; none of these intended outcomes is claimed here.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and sensor-modulated robotic-fish CPG control
source_mechanism: tail-end traveling-wave kinematics supply reactive thrust, while closed-loop gait emphasis should persist only when measured task response remains useful
transferable_invariant: retain bounded propulsion through approach when normalized target closing is productive, but allocate the added authority posteriorly so it reinforces the traveling wave instead of consuming anterior steering authority
nontransferable_details: published gains, dimensional cadence and amplitude, species or robot kinematics, prescribed approach stages, exact vortex phases, and task-specific routes
policy_translation: add a bounded zero-mean posterior-wave residual proportional to one-minus normalized distance gate, productive closing response, and one-minus target-derived turn load; preserve all target-derived mean curvature and the state-feedback carrier cadence
falsification: reject if capture, observed or total distance integral, terminal axial closure, or anterior saturation regresses; if lateral motion, yaw, speed, or normalized loads grow materially; or if readable two-view evidence loses the organized alternating wake
```

## Evidence boundary

All completed results and visual claims above come from the assigned parent,
sampled solver results, inherited optimizer logs, and inherited durable
guidance.  This candidate has no same-worker CFD evidence.

## No-CFD implementation audit

- The single candidate is
  `dogfish_target_control_v45_posterior_allocated_approach_thrust`, with
  SHA-256
  `3b664cdd40bbf8a4e5583bb983f9ca33b71dc365a23221108f6721292fd3a1af`.
  Its control delta from the completed axis-selective policy is confined to
  the response-gated posterior wave residual inside the existing approach
  region.
- A targeted Julia comparison confirms byte-equal two-joint actions outside
  approach and an exactly unchanged anterior action in a productive near-
  target state; only the bounded posterior action changes (`-3.53872` to
  `-3.84051 rad/T^2`).  All tested actions are finite and inside the
  componentwise acceleration limit.  The deterministic schema audit finds all
  `66` direct `params.FIELD` references among the `68` fields returned by
  `target_policy_params()`.
- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account.  I ran its three exact
  non-CFD commands locally and separately: the material-guidance check,
  lightweight Julia policy contract, and solver editable-boundary check pass.
  The first command initially exposed and then passed after removal of the
  duplicated assigned-parent marker in the rendered workspace `README.md`.
  No formal CFD was run.
