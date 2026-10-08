# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen rollout contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, and inertial moving-window transport. All terminate in capture
  without angle, rate, or applied-acceleration contact, so trajectory progress,
  capture timing, wake organization, and loads distinguish the candidates.
- I inspected the combined sheets from release through capture for the
  duplicated strongest finite policy (`solver_b3cc38ade37a` and
  `solver_7e2b89182e53`) and the informative weaker prefill
  (`solver_2f617353199f`) in both the top-down vorticity/body row and oblique
  body/Lambda2 row. Each fish visibly self-propels from rest and leaves an
  orderly alternating wake with compact three-dimensional vortices through a
  smooth target-side hook. There is no passive advection, boundary precursor,
  wake breakup, numerical instability, or moving-window-induced rotation. The
  prefill remains in the same useful route family, so its scalar regression is
  a controller-response result rather than loss of propulsion or stability.
- The paired policy diff isolates one mechanism. The duplicated best policy
  uses upstream anterior restoring-phase duty asymmetry and captures at
  `0.748598L` and `25.5090T`, with score `-0.556475`, mean distance
  `2.457773L`, and distances `10.308/3.658/2.556/1.475L` at
  `8/20/22/24T`. The prefill adds only a weaker, opposite-bend posterior duty
  term under the same gate. It captures later at `0.749956L` and `25.6080T`,
  worsens score and mean distance to `-0.560723/2.461948L`, and reaches
  `10.326/3.674/2.583/1.513L` at those checkpoints. Its lower peak speed and
  planar force/yaw moment (`0.6977U`, `0.02023/0.01043`, versus
  `0.7089U`, `0.02063/0.01065`) do not compensate for uniformly weaker
  progress, shallower capture, or the absence of a distinct visual response.
  The posterior duty propagation is therefore a concrete negative result, not
  evidence that two-joint duty coordination is safer or more effective.
- The anterior-duty policy is independently reproduced byte-for-byte in two
  solver examples, including its trajectory and visual sheet. This establishes
  deterministic fixed-pose evidence for retaining that mechanism, while the
  anterior-only sampled variant (`solver_ab218bebf730`) also confirms that
  posterior duty propagation is unnecessary for capture. None of these fixed
  initial-condition runs establishes held-out geometric robustness.

## One-candidate policy hypothesis

Remove only the unevidenced posterior duty-ratio parameter and acceleration
term from the prefill. Preserve the sampled anterior state-derived duty
asymmetry, the posterior joint's original damped traveling-wave lag, the
course/miss redirect, target-line response, bounded middle residuals, capture
modulation, coupled command projection, and angle/rate viability guards. This
restores the independently reproduced best finite policy exactly and tests
whether eliminating posterior residence distortion reproduces its earlier,
deeper capture without weakening the coherent carrier.

The falsifiable expectation is the duplicated route: lower `8/20/22/24T`
distance, capture near `25.509T`, zero actuator contacts, and the same coherent
two-view wake, with peak planar force/yaw moment remaining near
`0.02063/0.01065`. Reject the hypothesis if the evaluation fails to reproduce
capture and progress, loses wake coherence or viability, or if a later
controlled comparison shows a posterior phase/residence mechanism that
improves trajectory response rather than merely reducing peak speed and load.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG asymmetric steering and classical traveling-wave propulsion
source_mechanism: alter one target-side half-cycle while preserving a phase-separated posterior propulsive wave
transferable_invariant: state-derived duty asymmetry should change route response without erasing posterior lag or mechanically duplicating the anterior residence change at the tail
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain the normalized body-frame course-gated anterior restoring-phase skew and restore joint 2 to its measured-state lag plus independently evidenced bounded residuals
falsification: reject if fixed-condition progress and capture do not reproduce, the coherent three-dimensional wake or actuator clearance is lost, or a controlled posterior-duty test yields a distinct beneficial trajectory with commensurate load reduction
```

## Non-CFD audit after the policy edit

- The candidate byte-matches both duplicated strongest solver artifacts at
  SHA-256 `4fa0470d42c3a6a60c9286aa9b4a3a1d957e53fb1478686b1d7ff746ee4d43ac`.
  The next CFD evaluation is therefore a fixed-condition replication, not
  same-worker evidence or a held-out robustness test.
- The prescribed Julia state returns two finite accelerations. All 65 direct
  `params.FIELD` references are owned by the 65-field object returned from
  `target_policy_params()`.
- The material-guidance check and solver editable-boundary check pass. The
  guidance check first found two identical copied-parent markers in the
  rendered workspace `README.md`; removing only the duplicate restored an
  unambiguous assigned parent. The required independent check runner was
  invoked, but its pinned `gpt-5.4-mini` model is unavailable on this account,
  so its three commands were run directly as in the inherited fallback. No
  formal CFD was run.
