# Terminal measured-yaw release on the captured residual-steering carrier

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled solver results are finite captures from the required direct,
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, and no instability. I inspected both the top-down mid-plane
  vorticity and oblique body/Lambda2 rows in the combined sheets for the best
  sampled finite candidate `solver_10780c7bba63`, its prefill baseline
  `solver_13f39699efc8`, and the assigned-parent negative
  `solver_b2d799c7da39`. Each is self-propelled rather than advected: a
  traveling posterior bend develops a strong alternating red/blue wake by
  about `4T`, compact three-dimensional posterior structures remain through
  the target crossing, and there is no wake collapse, boundary interaction,
  or visible instability. There is no failure-class image in this sample; the
  informative failure is a terminal control-allocation regression within the
  capture class.
- Three current samples are exact repetitions of the prefill yaw-opposition
  carrier: identical policy and wake-sheet hashes, `16.0545T` capture,
  `0.747530L` final distance, `1.931257L` distance integral, and score
  `-0.048654`. This confirms a deterministic physical trajectory rather than
  solver noise. Together with the inherited guidance's byte-identical
  step-9-through-step-11 history, it supplies the structured shelf
  reconsultation signal; repeated scalar-equivalent outcomes are not a reason
  for another gain edit.
- The strongest current result, `solver_10780c7bba63`, adds only a closing-
  corridor release of the supplemental yaw-residual curvature when normalized
  measured heading rate is already target-signed. It preserves the baseline's
  `8/6/4/2/1.25/1.0L` milestones
  (`9.075/11.044/12.920/14.801/15.532/15.796T`), wake topology, capture step,
  acceleration-limit residence (`49.195/21.857%`), and joint extrema. Only
  the posterior law is directly changed; closed-loop divergence begins at
  `1.510L`, with `90/2919` posterior commands differing. The crossing improves
  to `0.746955L`, the distance integral to `1.930773L`, and score to
  `-0.048055`, while mean absolute posterior command falls slightly from
  `24.6164` to `24.5998 rad/T^2`. Peak lateral force changes only from
  `0.033205` to `0.033240`, with unchanged `0.019026` peak yaw moment.
- The assigned parent's target-bearing-support alternative is the necessary
  negative boundary. It attenuates the same supplemental branch according to
  `abs(bearing)/abs(raw_response_error)` throughout the closing approach,
  changes `120` posterior commands from `1.671L`, preserves every milestone
  and the coherent wake, but crosses at `0.747637L`, raises mean posterior
  command to `24.6428 rad/T^2`, and scores `-0.048763`. Target alignment alone
  therefore does not identify when carrier-residual correction is redundant;
  measured target-signed yaw response is the better release condition in the
  current closed-loop evidence.
- Earlier inherited logs also reject nearby scalar or clamp-equivalent work:
  exact speed-boundary projection repeatedly left the physical trajectory
  unchanged, while pre-limit posterior headroom guarding reduced limiting and
  loads but delayed all distance milestones and capture. The edit must change
  feasible supplemental steering under a response gate, not add another
  joint-limit wrapper or tune a threshold without a new mechanism.

## Policy hypothesis

Use the sampled `solver_10780c7bba63` controller as this workspace's single
candidate. Preserve the state-feedback traveling-bend oscillator, raw and
carrier-phase-residual redirect paths, one-sided opposing-wave relief,
mean-first posterior allocation, response-conditioned approach settling,
intercept-conditioned anterior damping release, and exact speed-boundary
projection. Add one owned scale for normalized target-aiding yaw. Only when
proximity, target closing, course reliability, predicted capture corridor,
and measured yaw in the requested turn direction all agree, release the
supplemental carrier-yaw-residual curvature. Do not attenuate the base target/
course steering, posterior wave shaping, or anterior carrier through this
gate.

This is an evidence-selected control-role change, not scalar-only gain tuning.
The downstream evaluation should reproduce the sampled coherent wake and
route while retaining the slightly improved crossing. Falsify the mechanism
if any pre-approach milestone changes, capture is lost or delayed, the
alternating two-view wake degrades, posterior limiting or loads rise
materially, or the terminal distance/distance integral returns to the prefill
or target-bearing-support result.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG residual control and terminal biological capture
source_mechanism: preserve a rhythmic locomotor carrier while measured target-aiding response releases only redundant supplemental steering near capture
transferable_invariant: sensory feedback should modulate a residual action by observed response; on a reliable closing intercept, release supplemental curvature only when actual yaw already aids the requested turn, while preserving the base carrier and target steering
nontransferable_details: published gains, dimensional turn rates, species-specific capture kinematics, prescribed oscillator or vortex phase, exact capture radius, and task-specific routes
policy_translation: normalize heading rate by the joint-state carrier frequency, combine its target-signed component with normalized body-frame proximity, closing speed, course reliability, and predicted miss, and apply the bounded gate only to carrier-residual posterior mean curvature
falsification: reject if the release acts outside a closing reliable capture corridor, breaks lateral reflection equivariance, changes the base steering or propulsion roles, or loses coherent wake, route milestones, capture, distance-integral benefit, or acceptable loads

## Non-CFD verification after the policy edit

- The final candidate SHA-256 is
  `505e677d9c18f859e3dabe4d47acc711b910b7d6fcfad8f59fa6e58511260b0f`,
  byte-identical to evaluated `solver_10780c7bba63`. This establishes exact
  controller reuse; the rollout evidence above remains prior evidence rather
  than a same-worker CFD claim.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this ChatGPT account. Its three prescribed checks were run
  directly and separately: the material guidance/provenance check, lightweight
  Julia policy-contract check, and solver editable-boundary check all pass.
- Static schema inspection confirms that all `42` direct `params.FIELD`
  references name the `42` fields returned by `target_policy_params()`. A
  deterministic `6,561`-state sweep across joint position and speed limits,
  target side, bearing, body-frame lateral velocity, and measured yaw returns
  finite bounded commands, zero outward acceleration at exact speed limits,
  and zero lateral-reflection error.

No formal CFD was run in this worker.
