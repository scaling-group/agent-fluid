# Corrective-consensus centered posterior duty ratio

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned optimizer logs,
  all four sampled policies, scores, observations, metrics, diagnostics, and
  trajectories. Every sample is a finite capture from direct uniform still
  water with `U_infinity=[0,0,0]`, no cylinders or prewarm, and the moving-
  window contract intact.
- I inspected the combined keyframe sheets for the newly best-scoring v31
  course-consensus duty-ratio policy and the informative v26 slip-synchronous
  regression, including the top-down mid-plane vorticity and oblique Lambda2
  rows from release through capture. Both visibly self-propel from rest and
  retain a coherent alternating wake and compact three-dimensional posterior
  structures. There is no passive advection, boundary interaction, standing
  wiggle, wake breakup, or out-of-plane instability. Their difference is a
  terminal half-cycle allocation effect, not loss of basic propulsion.
- V31 is now the scalar leader at score/mean distance
  `-0.0640004/1.950346L`; relative to the prior v20 leader it improves final
  course alignment/yaw from `0.1092/0.9840 rad/T` to
  `0.1297/0.8077 rad/T`, but delays capture from `18.0070T` to `18.0125T`,
  lengthens center path from `13.2108L` to `13.2149L`, and leaves near
  posterior acceleration-ceiling residence effectively unchanged at
  `75.89%` versus `75.83%`. This is a small useful result, not evidence that
  the inherited selector has broad terminal authority.
- V26 weakens only the posterior half-cycle whose observed motion reinforces
  target-normal slip. Against v31 it improves final alignment/yaw to
  `0.1728/0.6545 rad/T`, shortens center path to `13.2064L`, and lowers near
  posterior acceleration-ceiling residence to `74.11%`, but regresses score
  and mean distance to `-0.0641495/1.950469L` at the same `18.0125T` capture.
  Thus the slip/phase sign is useful, while unilateral wave suppression buys
  damping with lost closure.
- A convention audit on the v31 approach shows positive signed target-versus-
  velocity course error in `95.9%` of sampled rows while the direct normalized
  body-frame geometric turn request is negative in `100%`. The corrective
  relationship is therefore a negative product for this adapter. Replaying
  the full v31 request approximately on its trace makes the inherited positive-
  product "consensus" active in only `5.3%` of approach rows, consistent with
  its tiny realized effect. This semantic sign must be repaired before another
  duty gain or envelope tune is meaningful.

## Single policy hypothesis

Start from evaluated v31 and preserve its odd target-to-curvature map, state-
feedback anterior oscillator, posterior lag and emphasis, v20 yaw-power
envelope, conserved forward mean-bend allocation, half-cycle steering, rate
governor, and all far/middle behavior. Change only the semantic polarity of
the terminal course-consensus selector: qualify centered posterior duty-ratio
redistribution when `-turn_command * signed_course_error` is positive. The
existing duty factor then weakens the half-cycle whose tail motion reinforces
the measured target-normal slip and strengthens the opposing half-cycle by the
same bounded factor around unity. This transfers the terminal benefit visible
in v26 without its one-sided loss of posterior wave authority.

The selector remains exactly inactive at and beyond `2.10L`, at rest, or when
the controller request is not corrective for current course slip. Under a
lateral reflection, turn request, course error, and observed tail phase all
reverse; the consensus authority and duty factor remain invariant while joint
commands reflect. Expected evidence is v31-class transit, capture, distance
integral, and coherent two-view wake, with a material improvement in terminal
alignment/yaw or path and no increase in posterior limit residence. Falsify if
transit changes, capture or score regresses materially, the realized duty is
chronically suppressive, terminal yaw and alignment do not improve together,
actuator pressure migrates, reflection fails, or either wake row deteriorates.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and half-cycle amplitude asymmetry
source_mechanism: steer a rhythmic traveling gait by feedback-selected redistribution between opposing stroke half-cycles instead of suppressing the whole carrier
transferable_invariant: preserve cadence, posterior lag, and mean wave authority while sensed directional error selects a bounded, centered half-cycle asymmetry
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, exact vortex phases, full-body CPG topology, world coordinates, and task-specific routes
policy_translation: use normalized body-frame course error and the measured odd turn command to select corrective negative-product consensus, then combine that authority with observed normalized tail-rate phase in the existing bounded posterior duty factor
falsification: reject if far/middle action changes, duty becomes chronically suppressive, capture or distance integral regresses, alignment and yaw fail to improve together, load migrates, reflection fails, or either coherent wake view worsens
```

## Lightweight validation after editing

- The mandated dedicated check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running the immutable
  checks directly gives `PASS` for guidance materiality and `PASS` for the
  solver boundary after removing the rendered `README.md`'s duplicate marker
  for the same assigned parent. Julia is not installed, so the executable
  include/action smoke probe cannot run. No CFD was run.
- Static checks find one definition of each public function, all `66` direct
  `params.FIELD` references among the `68` fields returned by
  `target_policy_params`, balanced delimiters, a nonempty candidate, and no
  explicit time, step count, randomness, file I/O, cylinder coordinate,
  target coordinate, or memorized route input.
- Approximate offline replay of the corrected selector on the sampled v31
  trace leaves all `2,881` rows at or beyond `2.10L` at exactly zero duty
  authority and unity factor. It activates on `74.11%` of the `394` approach
  rows; approach authority is mean/maximum `0.2730/0.6425`, and the realized
  duty factor is mean/minimum/maximum `0.9928/0.9429/1.0531`. Ten thousand
  algebraic probes confirm that lateral reflection preserves consensus
  authority and the duty factor, which remains within its configured
  `[0.84,1.16]` bound. These are selectivity and contract checks, not a claim
  about the pending CFD result.
