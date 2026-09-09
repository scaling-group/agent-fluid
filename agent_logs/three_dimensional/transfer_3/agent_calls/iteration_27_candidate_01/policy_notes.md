# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations are valid direct-uniform still-water runs
  (`U_infinity=(0,0,0)`, no prewarm) and terminate by capture at
  `18.6560--18.7385T`; there is no sampled collision, exit, instability, or
  non-capture to use as a failure comparator. The best-score/fastest finite
  example is `solver_0288c0d51d57` (`-0.13321`, `18.6560T`), while the slower
  same-hash replicate `solver_e6174a15bb9d` (`-0.13693`, `18.7385T`) is the
  most informative weaker comparator.
- In both combined sheets, the top-down row develops a persistent alternating
  reverse-street-like lateral wake behind a steadily translating body, and the
  oblique Lambda2 row shows paired three-dimensional structures released from
  the posterior body/fin through target closure. The centerline bends smoothly
  toward the target without a terminal loop, collision, or wake collapse.
  Together with zero imposed flow and `0.01807--0.01815U` local-flow RMS in the
  inherited diagnosis, this is self-propulsion, not passive advection. The
  demodulated-moment example `solver_e85ca9b86253` preserves the same visible
  topology and capture.
- Scalar ordering within this narrow arrival band is unresolved: the assigned
  parent's actuator-consistent hash spans `18.6725--19.0080T` in sampled and
  inherited results. What does separate is effort. Carrier-demodulated moment
  modulation of primary phase captures at `18.7165T` while reducing posterior
  acceleration-limit occupancy to `74.14%` and force/moment RMS to
  `0.01309/0.00682`, versus `75.74%` and `0.01328/0.00691` for the fastest raw
  helpful-moment amplitude relief. Its mean distance `2.02337L` is slightly
  worse than `2.02115--2.02198L`, so the positive evidence is load shedding,
  not route improvement.
- The inherited step-26 score logs remain captures but regress to `-0.14551`
  and `-0.16256`; because those compact logs do not expose policy semantics or
  effort histories, they are negative selection evidence only. They reinforce
  preserving the proven route rather than attributing a mechanism from capture
  alone.

## Policy hypothesis

Keep the normalized bearing-plus-LOS route, C-bend recruitment, persistent
same-side phase actuator, oscillator, and hard feasibility projection exactly
as in the assigned parent. Estimate and subtract the sampled joint-phase
carrier from observed yaw moment, but do not let the residual own primary
phase. When the demodulated fluid residual helps the requested yaw response
and yaw error is already near closure, smoothly release only a small fraction
of response-reversing half-cycle amplitude. This tests whether the physical
response can remove redundant effort without erasing the coherent carrier or
continuous route closure.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and wake-adaptive swimming
source_mechanism: preserve the traveling propulsive rhythm while using sensed hydrodynamic response to adjust only bounded half-cycle asymmetry
transferable_invariant: separate slow body-frame route demand from carrier-demodulated fluid response, and relieve only redundant actuation when the response already helps
nontransferable_details: published gains, dimensional beat frequencies, species envelopes, exact vortex phase, full-body waveforms, and task-specific routes
policy_translation: use normalized target bearing and LOS rate for route demand; estimate yaw-moment carrier from normalized two-joint state; use the reflection-invariant alignment of residual moment and yaw-error direction to reduce half-cycle amplitude after response closure while retaining primary phase recruitment
falsification: reject if capture is lost or later than 19.052T, mean distance exceeds 2.02337L, posterior limit occupancy is not below 75.74%, force/moment RMS is not below 0.01328/0.00691, or either top-down or oblique wake loses coherence
