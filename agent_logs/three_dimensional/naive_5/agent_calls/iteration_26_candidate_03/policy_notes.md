# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, and moving-window transport.
  The strongest finite example (`solver_168198d1e6b6`, also reproduced exactly
  by `solver_27d0c0c038bc` and `solver_7f1d02b1e9e9`) captures at
  `0.748829L` and `26.2955T`. The most informative lower-scoring comparison
  (`solver_5de1fba6b9e8`) is not a termination failure: the unmodified
  coordinated carrier also captures at `0.749242L` and `26.2955T`.
- Both combined keyframe sheets were inspected from release through
  termination. Their top-down rows show self-propulsion and a coherent
  alternating wake, not advection, while their oblique Lambda2 rows show a
  stable three-dimensional wake and the same late hook into the target. No
  visible route change distinguishes the posterior phase-lag edit from its
  parent.
- Metrics and diagnostics agree with the images. Both comparisons have zero
  angle, joint-rate, and acceleration-limit contacts; identical peak planar
  force coefficient `0.01883` and yaw-moment coefficient `0.00979`; and the
  same `2.5197L` mean-distance scale. On the sampled trace the projected miss
  remains about `1.19L` at `22T` and `0.97L` at `24T`. The posterior edit
  changes only the capture-scale tail allocation and improves final clearance
  by just `0.000413L`, so it is a reproducible finite tie-break rather than a
  semantic trajectory improvement.

## Policy hypothesis

Preserve the evidenced traveling carrier, line-of-sight response closure,
posterior capture modulation, and feasibility guards. Introduce one
middle-approach response-arbitration mechanism: when positive inertial
target-line response deficit requests the opposite steering half-cycle from
the bearing/course channel, smoothly withdraw only the conflicting anterior
route half-cycle instead of superposing both allocations. Distance, closing
speed, course observability, response deficit, and side conflict are all
normalized body-frame/state-feedback gates. Agreement, far travel,
redirect-dominated motion, and the existing terminal posterior channel remain
unchanged. The intended effect is to alter *when* the target-line response
receives unopposed authority before the `1.75L` capture corridor, without a
gain increase or a new propulsion waveform.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and asymmetric half-cycle turning
source_mechanism: sensory direction feedback selects the useful half-cycle of an otherwise persistent propulsive rhythm
transferable_invariant: resolve competing steering requests by reallocating rhythmic half-cycle authority while preserving the carrier
nontransferable_details: published gains, robot morphology, clock phase, species kinematics, obstacle routes, and exact vortex phase
policy_translation: use normalized target distance, closing speed, course observability, inertial line-of-sight response deficit, and command-side conflict to withdraw only the opposing anterior half-cycle during middle approach
falsification: reject if capture is lost, the coherent two-view wake changes adversely, limits or loads return, or the trajectory and capture margin remain milliscale-equivalent to the sampled carrier

## Non-CFD checks after the edit

- The parameter schema is exact: all 45 returned fields are referenced and
  every `params.FIELD` reference is declared.
- Synthetic paired states produce exactly sign-reflected two-joint commands;
  finite outputs remain within the `30 rad/T^2` policy envelope. A far-field
  state is command-identical to the sampled parent, confirming that the new
  proximity gate passes the inherited controller through.
- A frozen-parent-trace calculation changes about 486 anterior commands,
  beginning near `4.01L`; the largest pre-guard difference is about
  `1.90 rad/T^2`, and the recorded peak command is unchanged. This is only a
  bounded activation audit, not evidence of hydrodynamic improvement; the
  next CFD evaluation must decide the hypothesis.
