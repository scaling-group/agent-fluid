# Evidence-selected intercept-conditioned anterior energy release

## Pre-edit visual and quantitative diagnosis

- All four sampled evaluations are finite captures from the required direct,
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm. I inspected the top-down mid-plane vorticity and oblique 3D
  Lambda2 rows in every combined keyframe sheet. Each shows self-propulsion,
  a traveling posterior bend, an alternating red/blue wake established by
  about `4T`, and compact three-dimensional structures retained through the
  target crossing. None shows passive advection, wake collapse, a boundary
  interaction, or numerical instability. Because every sample captures and
  their sheets are visually near-identical, the informative failures are
  control-role and trajectory regressions rather than a failure-class image.
- The assigned parent `solver_29c7c83f8e3e` combines unconditional approach
  settling with a narrow posterior outward-wave speed guard. It captures at
  `16.0710T`, scores `-0.057037`, has mean/held distance `1.940194L`, and
  requires `236` moving-window shifts. Its `8/6/4/2L` crossings are
  `9.1905/11.1595/13.0405/14.9215T`. Thus its modestly lower approach
  posterior acceleration-limit residence (`20.7%`) does not compensate for a
  later, longer route.
- The strongest sampled policy is `solver_5187bb13ebc0`. Its normalized
  body-frame predicted-miss signal releases only anterior approach damping
  inside a reliable closing corridor; posterior wave settling and all mean
  steering remain on the response-conditioned path. It preserves the same
  coherent two-view wake, returns to `229` window shifts, advances capture to
  `16.0545T`, lowers mean/held distance to `1.938857L`, improves final crossing
  to `0.744345L`, and scores `-0.055617`. The matching corridor variant that
  also releases posterior settling (`solver_736250db9a8b`) has identical
  milestones through `1.25L` and the same capture time but raises approach
  posterior acceleration saturation from `24.0%` to `29.2%`, worsens final
  distance to `0.745354L`, and scores `-0.056672`. Releasing high-authority
  mean steering instead (`solver_3b5e36735c7f`) is also worse at `0.745652L`
  and `-0.056973`. The corridor observation is useful only with narrow
  control-role ownership: anterior braking may yield, while posterior relief
  and target-directed mean curvature remain intact.
- Inherited optimizer logs supply the factorial speed-guard result missing
  from the four current samples. On the response-conditioned approach parent,
  the same normalized pre-limit outward-wave guard reduced posterior speed
  and acceleration-limit residence and slightly reduced peak force/moment,
  yet delayed every `8/6/4/2L` milestone, moved capture from `16.049T` to
  `16.077T`, and regressed score from `-0.056774` to `-0.058139`. Together
  with the assigned-parent result, this rejects pointwise joint-speed relief
  as a route improvement on this carrier; another guard or scalar onset tune
  is not warranted.

## Policy hypothesis

Use the evaluated `solver_5187bb13ebc0` control structure as this workspace's
single candidate. Preserve its state-feedback oscillator, carrier-phase
residual redirect selector, raw target-versus-course turn direction,
mean-first posterior allocator, one-sided opposing-wave relief, response-
conditioned approach settling, and exact speed-clamp projection. Compute the
reflection-even straight-course miss from normalized body-frame target and
velocity. Only when proximity, target closing, course reliability, and a safe
intercept agree, release residual anterior velocity damping. Do not release
posterior wave settling or either mean-curvature path, and remove the assigned
parent's pre-limit speed guard.

This candidate is an evidence-selected restoration of a sampled policy, not a
new scalar setting. Its prior rollout supports coherent propulsion and capture;
the downstream evaluation should falsify reuse if it does not reproduce the
same termination class and useful route. Reject the transferable mechanism if
the pre-approach trajectory changes, the two-view wake loses coherence,
capture or any distance milestone regresses, or terminal energy increases
loads/limiting without retaining the sampled distance-integral benefit.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal biological capture
source_mechanism: preserve the rhythmic carrier and target-directed steering while sensor feedback releases only a measured terminal braking role
transferable_invariant: on a reliable closing intercept, remove residual locomotor braking before removing steering or posterior wave-shaping authority, and restore braking continuously if the projected miss degrades
nontransferable_details: published gains, dimensional burst timing, species-specific capture kinematics, prescribed oscillator or vortex phase, exact source-task capture radii, and task-specific routes
policy_translation: use normalized body-frame target and velocity to form a bounded reflection-even closest-miss gate; apply it only to anterior velocity damping while raw bearing/course feedback retains redirect direction and all posterior control roles
falsification: reject if the gate acts outside a closing reliable approach, breaks lateral reflection equivariance, changes posterior or mean-steering semantics, or loses coherent propulsion, milestones, capture, distance-integral benefit, or acceptable loads

## Non-CFD verification after the policy edit

- The selected source SHA-256 is
  `a01d9c5c1d5943bd930a4141f47681a1c361fbfcbab59326a51225fc8816bfc2`,
  byte-identical to the evaluated `solver_5187bb13ebc0` policy. This establishes
  exact controller reuse; the rollout evidence above remains prior evidence,
  not a same-worker CFD claim.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this account. Its three commands were run directly and
  separately instead. The material guidance/provenance check initially found
  the same assigned parent marked twice in the rendered workspace `README.md`;
  removing only the duplicate marker repaired provenance. The rerun, the
  lightweight Julia policy contract, and the solver editable-boundary check
  all pass.
- Static inspection confirms that all `35` direct `params.FIELD` references
  are among the `35` fields returned by `target_policy_params()`. A
  deterministic `6,561`-state sweep over joint state, exact speed limits,
  target side/distance, bearing, and body-frame lateral velocity returns finite
  bounded actions, no outward action at either exact speed boundary, and zero
  lateral-reflection error.

No formal CFD was run in this worker.
