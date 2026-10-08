# Evidence-limited carrier preservation after replicated nominal capture

## Pre-edit visual and rollout diagnosis

- The four assigned solver examples collapse to one behavioral result: their
  policies, trajectories, and combined keyframe sheets are byte-identical.
  Each begins from direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm, then captures at
  `16.604496T` after 237 moving-window shifts. The common result has score
  `-0.1137286`, scored distance integral `1.998146L`, and final/minimum
  distance `0.743958L`. These repeats demonstrate deterministic nominal
  capture, not four mechanisms or held-out robustness.
- I inspected both rows of the shared combined sheet from release through
  termination. In the top-down row the fish accelerates from rest, travels
  left/down along a shallow target-crossing arc, and sheds a coherent
  alternating vorticity street. In the oblique row compact three-dimensional
  Lambda2 structures remain connected to the posterior body and traveled
  path. The motion is therefore self-propelled rather than advected, and
  neither view shows inherited flow, collision, boundary exit, wake breakup,
  or numerical instability before capture.
- The trajectory and diagnostics support that interpretation: distance falls
  from `12.3277L` to capture, the final head is at
  `(9.6910,9.7756)L`, final inertial velocity is
  `(-1.1001,-0.2701)U`, and joint 2 reaches the released
  `260 deg/T` speed envelope while its outward acceleration is removed by the
  existing narrow feasibility guard. The connected wake accompanies real
  closure, but the nominal trace does not identify a remaining route,
  disturbance, or actuator deficit.
- There is no informative failure sheet to compare in this workspace: all
  assigned and inherited sheets are artifact-identical. I therefore do not
  invent a visual failure contrast. The assigned-parent guidance and inherited
  completed logs provide the available negative controls. Terminal yaw
  release regressed score/integral/crossing depth to
  `-0.114037/1.998380L/0.744276L`; carrier-synchronous local-flow subtraction
  regressed them to `-0.115121/1.999280L/0.745252L` without a feasibility or
  load benefit. Line-of-sight feedforward, bearing and moment residualization,
  posterior terminal relief, and projected-corridor gating likewise retained
  finite or capturing wakes while worsening target cost.
- The inherited record contains more than three consecutive completed
  selections with neither a new controller mechanism nor semantic or
  trajectory improvement, so the structured bookshelf consultation is
  required. Its relevant carrier/separate-feedback invariant supports a
  falsifiable preservation test; it does not supply evidence for another
  scalar, terminal, or self-wake-cancellation edit.

## Sole candidate and falsifiable hypothesis

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-identical to the assigned, successfully evaluated controller as this
workspace's one multi-wake target-policy candidate. It preserves the full
traveling-wave carrier, raw body-frame target geometry, mean-preserving yaw
and lateral-response demodulation, unmodified relative-crossflow feedback,
posterior phase-compatible steering, smooth acceleration bound, and one-sided
final-one-percent speed guard.

This is an evidence-constrained negative selection, not a same-worker CFD
improvement claim. The next evaluation should reproduce capture, the connected
two-view wake, `16.604496T` arrival, `1.998146L` distance integral,
`0.743958L` crossing, and the sampled joint/action/load envelope. Falsify
preservation if nominal replication loses capture or materially changes those
quantities. Test one new compact mechanism only after a completed nonduplicate
or held-out pose, target, or flow rollout exposes a repeatable response deficit.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion, sensor-modulated robotic-fish CPG direction tracking, asymmetric flapping, and wake-interaction control
source_mechanism: preserve an effective rhythmic carrier and add a distinct bounded route or disturbance channel only for an independently observed response deficit
transferable_invariant: coherent carrier-correlated lateral motion is not itself an error; retain a demonstrated traveling carrier when multiple completed feedback perturbations preserve wake class but worsen target cost without improving feasibility or loads
nontransferable_details: published gains, dimensional frequencies and speeds, species or robot kinematics, exact vortex phases, fitted coefficients from other gaits, capture thresholds, and source-task routes
policy_translation: retain the evaluated two-joint normalized body-frame controller exactly; the duplicated nominal evidence and inherited negative controls do not identify a new terminal, disturbance, or phase channel that can be falsified against a specific deficit
falsification: reopen one bounded state-feedback primitive if a nonduplicate or held-out rollout isolates a deficit, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

No CFD result is claimed for this workspace's candidate. Favorable metrics
belong to the completed sampled rollouts, and changed-controller negative
results belong to inherited completed logs. Exact nominal replicas establish
repeatability only; they cannot validate robustness to another pose, target,
or flow, nor can they distinguish a new feedback mechanism.
