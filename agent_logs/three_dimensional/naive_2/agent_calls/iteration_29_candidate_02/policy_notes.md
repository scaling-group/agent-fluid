# Evidence-constrained carrier selection after the nominal plateau

## Visual diagnosis before candidate selection

- The four sampled solver examples are exact repeats: their policy files,
  trajectories, and combined keyframe sheets are byte-identical. Each is a
  finite capture from direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and 237 moving-
  window shifts. Each reaches `0.743958L` at `16.604496T`, with score
  `-0.1137286` and scored distance integral `1.998146L`. These repetitions
  establish deterministic nominal behavior, not held-out robustness or four
  independent trajectory mechanisms.
- I inspected both rows of the shared combined sheet from release through
  capture. The top-down vorticity row shows acceleration from rest, sustained
  left/down target closure on a shallow curved route, and a coherent
  alternating wake: the fish is self-propelled rather than advected. The
  oblique Lambda2 row shows compact alternating three-dimensional structures
  connected to the posterior body and traveled path. There is no inherited
  wake, collision, domain exit, wake breakup, or numerical instability.
- No distinct failure sheet exists anywhere in the current Phase-2 workspace:
  all nine available combined sheets have the same SHA-256. I therefore do
  not infer a visual failure comparison that the current evidence cannot
  supply. The assigned-parent notes provide the most informative completed
  negative controls: a closure-qualified yaw release preserved the visible
  route and wake class and arrived one `0.0055T` step earlier, yet worsened
  score/integral/crossing depth to
  `-0.1140375/1.998380L/0.744276L`; carrier-synchronous local-flow subtraction
  captured at the same time but regressed those quantities to
  `-0.115121/1.999280L/0.745252L` without an effort or load benefit.
- Inherited guidance further records regressions from line-of-sight-rate
  feedforward, bearing and moment residualization, closure-deficit relief, and
  a projected capture corridor. The recent chain has consequently completed
  at least three selections without a new mechanism, semantic outcome, or
  useful trajectory class. This activates the structured bookshelf review but
  supplies no observed response deficit for another terminal gate,
  disturbance transform, or phase modulation.

## Policy hypothesis and sole candidate

Select the prefilled normalized body-frame controller byte-for-byte as the one
multi-wake candidate in `solver/`. Preserve its full traveling-wave carrier,
raw target geometry and anterior course center, mean-preserving yaw and
lateral-response demodulation, unmodified relative-crossflow cue, posterior
half-cycle steering, smooth acceleration bound, and one-sided final-one-
percent joint-speed guard. Do not force an unevidenced mechanism into an
already-capturing nominal trajectory, and do not use the shelf to rationalize
a scalar-only gain change.

Expected test: reproduce capture, the connected wake in both views,
`16.604496T` arrival, `1.998146L` scored distance integral, `0.743958L`
crossing depth, and the sampled joint/action/load envelope. Falsify this
selection if the next nominal evaluation loses capture or fails to reproduce
those quantities. Reopen architecture work only when a completed held-out
pose or flow, or a meaningfully different trajectory, identifies a specific
response deficit that one compact bounded mechanism can test.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion, closed-loop robotic-fish CPG direction tracking, and wake-interaction control
source_mechanism: preserve a productive rhythmic carrier and recruit a distinct bounded route or disturbance channel only for an independently observed response deficit
transferable_invariant: alternating carrier-correlated motion is not itself an error; preserve an evidenced traveling carrier when completed feedback perturbations retain wake class but worsen target cost without improving feasibility or loads
nontransferable_details: published gains, dimensional frequencies and speeds, species or robot kinematics, exact vortex phases, capture thresholds, fitted coefficients from other gaits, and source-task routes
policy_translation: retain the evaluated two-joint body-frame carrier and its demonstrated kinematic response separation; decline a new primitive and scalar tuning because the nominal evidence exposes no deficit and completed terminal and fluid-residual controls regressed target cost
falsification: reopen one compact state-feedback mechanism only if held-out or semantically different evidence isolates a repeatable deficit and the translation improves capture or route cost while preserving wake connectivity, joint feasibility, effort, force, and moment

## Evidence boundary

No CFD outcome is claimed for this workspace's selection. Favorable evidence
belongs to the completed sampled and assigned-parent rollouts; negative-control
values come from inherited completed logs. Exact nominal repeats must be
collapsed to one behavioral result, and none establishes robustness to a new
pose, target, or flow.
