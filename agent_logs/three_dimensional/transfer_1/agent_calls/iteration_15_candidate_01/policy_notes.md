# Wake-policy candidate diagnosis

## Evidence read before candidate selection

- All four sampled solver rollouts and the inherited total-command-governor
  failure report direct uniform still-water initialization with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Motion in both visual
  rows is therefore self-propelled rather than ambient advection or a reused
  wake.
- Both rows of the combined sheets were inspected for the strongest sampled
  finite result (`solver_6b0e320e2f55`) and the informative inherited failure
  (`solver_f7fc92921b5e`), with the prefilled projected-miss capture
  (`solver_5c1f6245a363`) as the candidate-specific comparison. The successful
  policies lay down a coherent alternating top-down street and compact paired
  oblique Lambda2 structures through capture. The governor failure also keeps
  swimming after its `1.3877L` pass, then turns away and exits the domain; it
  is a steering/allocation regression rather than wake collapse, collision,
  or numerical instability.
- Three sampled policies are byte-identical instances of the inherited
  projected-intercept plus sparse outward-carrier-reserve controller. All
  three capture at `18.2050--18.6010T`, establishing that route/capture
  topology as repeat-supported despite terminal trajectory variability.
  Their head/tail acceleration clamp fractions remain about
  `68.5--68.7%/70.6--71.0%`, and exact speed-limit residence remains about
  `10.4--10.6%/11.3--11.6%`.
- The prefilled policy adds one terminal signed projected-miss steering blend
  to that repeat-supported controller. Its first completed evaluation also
  captures at `0.7477L` and preserves the coherent wake, so the mechanism has
  positive semantic evidence. It does not yet improve secondary metrics:
  arrival is `18.5405T`, score is `-0.16291`, clamp fractions are
  `68.5%/71.0%`, and exact speed-limit residence is `10.6%/11.4%`. These are
  comparable to, not better than, the three unblended captures. A single
  threshold crossing is insufficient repeatability evidence because earlier
  terminal mechanisms have diverged on exact-policy repeats.
- The inherited total-command speed governor reduced speed-limit residence
  but lost capture and exited after a `1.3877L` pass. Half-cycle, phase-lag,
  static-curvature, carrier-collapse, and scalar cadence variants are already
  negative evidence. Stacking yaw damping, another allocation layer, or gain
  tuning onto the one-run projected-miss success would confound the next
  evaluation.

## Candidate and falsification

Submit the prefilled
`dogfish3d_speed_reserve_projected_miss_turn_v1` policy byte-for-byte as one
reproducibility candidate. It preserves the joint-state traveling bend,
achieved-course outer loop, projected-intercept release veto, sparse
outward-carrier reserve, and the new bounded terminal blend from course error
to normalized signed projected miss. No new mechanism or scalar is added.

Expected test: reproduce capture while retaining the alternating planar and
three-dimensional wake and comparable load envelope. This isolates whether
signed projected miss is a repeatable terminal steering observation rather
than a one-run threshold crossing. Secondary improvement is welcome but is
not claimed from the first evaluation.

Falsification: do not retain the signed projected-miss blend as a durable
mechanism if this exact repeat loses capture, returns the lower-domain exit,
grows projected miss after activation, weakens the terminal wake, or raises
force/moment or actuator-envelope residence. If it fails, restore the
three-repeat speed-reserve controller and seek a state discriminator for the
divergent terminal approaches before adding another steering realization.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and adaptive capture control
source_mechanism: preserve a rhythmic propulsive carrier while sensed interception geometry shapes a bounded steering residual
transferable_invariant: after broad route acquisition, normalized signed predicted miss can continuously select terminal steering side without prescribing a route or suppressing propulsion
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact gait or vortex phase, learned policies, and task-specific paths
policy_translation: exactly replay the two-joint carrier and body-frame terminal blend from course request toward the bounded signed target/velocity projected-miss command inside two body lengths
falsification: reject if exact replay loses capture, projected miss grows after activation, wake coherence weakens, saturation or loads rise, or the lower-domain exit returns

## Non-CFD verification

- Candidate SHA-256 is `cd57377d579c511a8ec3ed1240e804f421d2994c5b6fc7f2796bbae664849173`,
  exactly matching the evaluated `solver_5c1f6245a363` policy as required for
  the reproducibility test.
- The designated checker passes the material guidance-delta/provenance check,
  deterministic parameter-schema guard, and solver editable-boundary check.
- The lightweight finite two-joint policy contract passes through the
  documented Julia wrapper. The bare `julia` executable was absent from
  `PATH`; this was an environment lookup failure, not a policy failure. No CFD
  rollout was run.
