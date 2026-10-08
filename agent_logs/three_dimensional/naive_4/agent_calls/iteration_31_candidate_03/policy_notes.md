# Axial-response allocation with terminal translational-LOS damping

## Evidence diagnosis before the policy edit

- All four current samples satisfy the frozen rollout contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and capture. I inspected the combined sheets for
  the strongest route-scale result (`solver_6f6a10775fde`) and the weakest
  current scalar control (`solver_07403e1ebc74`) from release through capture.
  Their top-down rows show a release transient developing into an organized,
  alternating lateral wake and smooth target-directed translation. Their
  oblique body/Lambda2 rows retain compact three-dimensional caudal structures
  without wake collapse, collision, virtual-boundary exit, or out-of-plane
  instability. With zero background flow, this is self-propulsion rather than
  advection. No failed-termination keyframe sheet is present among the current
  samples; the weaker capture is the most informative visual control, and
  inherited failed trajectories are used only as logged evidence.
- The axial-force-gated sample is the only current route-scale improvement.
  Against the replicated forward-speed-gated parent, it changes capture from
  `15.977511T` to `15.768509T`, distance integral from `1.928581L` to
  `1.924071L`, shifts from `238` to `232`, and score from `-0.045506` to
  `-0.041679`. It delays the `8L` crossing by `0.0110T` but advances the
  `6/4/2/1.25L` crossings by `0.0660/0.0935/0.1540/0.1650T`. Mean posterior
  demand falls from `25.473` to `25.221 rad/T^2` and peak lateral force is
  effectively unchanged (`0.03334` versus `0.03329`), while posterior
  acceleration-limit residence rises from `22.58%` to `23.58%` and excursion
  grows from `33.1` to `34.7 deg`. The coherent two-view wake and later
  milestone gains make the response allocator positive, but not evidence for
  a stronger wave scalar or lower force threshold.
- The two sampled translational-LOS terminal variants leave every milestone
  through `1.25L` and the `15.977511T` capture step unchanged. The direct
  kinematic cross-product version nevertheless improves final distance from
  `0.744403L` to `0.744039L`, distance integral from `1.928581L` to
  `1.928275L`, and score from `-0.045506` to `-0.045128`, with unchanged
  acceleration-limit residence and force/moment envelope. Its inherited
  replay support begins only at `15.823509T` below `0.9L`; this is disjoint
  from the axial-response allocation's inherited support through about
  `3.66T`. The evidence therefore supports one small compatible combination,
  not another terminal threshold or propulsion-gain sweep.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a traveling bend while measured hydrodynamic response selects bounded supplemental posterior authority
transferable_invariant: keep the anterior rhythm and base posterior wave intact, and allocate only a bounded posterior-wave increment from normalized body-frame propulsive response
nontransferable_details: published force laws and gains, species-specific envelopes, dimensional frequencies, exact Strouhal values, exact vortex phases, clock-defined bursts, and task-specific routes
policy_translation: promote the sampled axial-force allocator unchanged, then retain the separately sampled terminal geometry edit that opposes only translational line-of-sight reopening inside the established closing corridor
falsification: reject the combination if it fails to retain capture and the coherent two-view wake, delays route milestones or raises loads and limiting materially, regresses distance integral or crossing geometry, or changes no feasible action beyond either sampled parent

## One candidate hypothesis

Use the evaluated axial-response-gated controller as the route-scale base. Its
existing speed-deficit and outside-approach envelope defines where the
posterior increment is eligible; normalized body-forward force then
interpolates only between already bounded base and boosted posterior commands.
The base wave is never removed, a non-finite force observation safely drops
only authority-increasing demand, and favorable unloading by the evaluated
endpoint is retained.

Within that controller, replace only the near-capture net-bearing-rate input
with the sampled direct translational line-of-sight rate computed from
normalized body-frame target displacement and velocity. The terminal branch
opposes this rate only when it increases absolute bearing and only inside the
existing closing capture corridor. This separates useful target-relative
translation from body yaw without altering redirect direction, carrier
propulsion, or approach scheduling.

The falsifiable expectation is to retain the axial allocator's earlier
`6/4/2/1.25L` milestones and approximately `15.77T` capture while improving
its final crossing or distance integral without disrupting the coherent wake.
Because the route-scale and terminal edits had disjoint inherited support,
pre-corridor divergence, lost capture, or material limiting/load growth would
falsify their compatibility. Formal CFD remains post-exit; no outcome for this
combined candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `6bd8c1fbb6e42f8feeb065ede2f1bb3e731e1eaaa766ec14bf7fc863ecd1c47f`.
  Relative to the evaluated axial-force parent, its executable difference is
  confined to the direct translational line-of-sight terminal response; the
  complete response allocator is otherwise source-identical.
- Static schema validation resolves all `52` direct `params.FIELD` references
  against exactly the `52` fields returned by `target_policy_params()`, with
  no missing or unused field. The lightweight Julia contract returns two
  finite accelerations.
- A deterministic sweep of `20,000` paired states across target side and
  distance, body-frame velocity and force, bearing and yaw response, and joint
  phase returns finite bounded commands with zero lateral-reflection error.
  A non-finite observation probe also returns a finite action.
- Reconstructing the sampled axial-force trace changes eight posterior
  commands and no anterior commands relative to that parent, from
  `15.6695T/0.8789L` through `15.7080T/0.8231L`, with maximum difference
  `0.719 rad/T^2`. Reconstructing the sampled direct-translational terminal
  trace changes 222 posterior commands and no anterior commands relative to
  that parent, only from `0.0770T` through `3.6575T`, with maximum difference
  `6.059 rad/T^2`. This confirms disjoint feasible support for the combined
  mechanisms on both inherited traces; replay does not predict their new
  closed-loop hydrodynamic outcome.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported for this account. Its prescribed
  guidance-materiality, lightweight policy-contract, and solver editable-
  boundary commands were therefore run directly and separately; all pass. The
  first guidance check found the rendered `README.md` marking the same assigned
  parent twice; removing only the duplicate marker repaired that inherited
  metadata defect. No CFD was run.
