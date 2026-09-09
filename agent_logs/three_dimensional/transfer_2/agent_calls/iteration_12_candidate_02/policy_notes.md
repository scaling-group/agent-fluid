# Independent middle-field course allocation with terminal LOS lead

## Evidence diagnosis before the policy edit

- All four sampled episodes satisfy the experiment contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite loads,
  and `capture` termination. They reach `0.746--0.750L` in
  `19.706--19.987T`; therefore this batch contains no semantic failure. The
  slowest capture is used only as the failure-side visual comparator.
- Both rows of the combined sheets for the strongest sample
  (`solver_1b6df3d71b19`) and slowest sample (`solver_c25cd0071858`) were
  inspected from release to termination. Their top-down rows show coherent
  alternating wakes produced by self-propulsion, followed by bounded terminal
  hooks. Their oblique rows retain compact three-dimensional Lambda2
  structures along the route. Neither shows collision, domain exit, wake
  collapse, disordered lateral motion, or instability. Metrics agree: peak
  planar force/yaw-moment coefficients stay near `0.0246/0.0132`, joint angles
  remain below about `0.60 rad`, and both policies reach the joint-rate limit.
- The best LOS-led half-cycle sample captures at `19.706T`, has mean distance
  `2.10594L`, and scores `-0.21598`. Its otherwise identical repeat under a
  version-only change captures at `19.888T` and scores `-0.22270`, establishing
  a nontrivial repeat band. Response release (`19.850T/-0.22093`) and
  line-of-sight coherence gating (`19.987T/-0.22648`) do not establish an
  improvement beyond that band, so another terminal response gate is not
  justified.
- The best trajectory still carries a large velocity-course discrepancy
  before the current `6L` redirect onset: reconstructed body-frame course
  error is about `-0.68 rad` at `8L` and `-0.38 rad` at `7L`, then changes sign
  near `6L`. The inherited middle-field course controller addressed exactly
  this topology and improved an otherwise matched terminal controller from
  `20.971T` to `20.653T`. Its completed composition with half-cycle steering
  remained a stable capture at `20.124T`; it did not establish a score gain,
  but it preserved the coherent/load class and is the only prior mechanism
  aimed at the evident pre-approach course error.
- Inherited results also delimit the translation: multiplying drive relief by
  course demand regressed to the slower capture class, and response- or
  phase-gating terminal redirect contributions did not help. Course geometry
  should therefore receive a separate middle-field allocation while distance
  and positive closing remain the only carrier-relief signals.

## One-candidate hypothesis

Preserve the evaluated carrier, posterior lag, full signed body-frame target
map, distance/closing drive relief, route half-cycle asymmetry, course error,
LOS-rate lead, and smooth command bounds. Add one independent continuous
course-authority schedule beginning at `8L` and reaching full weight at `2L`,
instead of reusing the `6L` approach weight for the redirect. Drive relief
remains unchanged and the edit introduces no clock, route memory, world-frame
coordinate, or scalar-only gain sweep.

Expected signature: correct the large `8--6L` course discrepancy sooner,
retain both coherent wake rows and the approximately `0.025/0.013` load class,
and improve arrival or distance integral beyond the observed identical-policy
repeat band. Falsify the mechanism if it loses capture, merely adds a larger
middle-field S-turn, fails to beat the repeat band, raises joint/command-limit
residence, or degrades wake coherence or loads. If falsified, later workers
should preserve the terminal LOS-led scaffold and test a genuinely different
observation/actuator primitive rather than another redirect gate.

bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated robotic-fish path following
source_mechanism: separate far propulsion, middle-field course correction, and near distance/closing relief without replacing the traveling rhythm
transferable_invariant: use observed body-frame velocity-course error before the terminal regime while reserving proximity and positive closing behavior for carrier relief
nontransferable_details: published gains, dimensional switching distances, species-specific kinematics, exact vortex phases, clock phase, and task-specific world routes
policy_translation: give the existing bounded course/LOS redirect an independent normalized distance weight while leaving the two-joint carrier relief as approach_weight times positive closing_gate
falsification: reject if capture timing or distance integral does not improve beyond repeat variation, a larger S-turn appears, or command, joint, force, moment, or wake-coherence metrics regress
