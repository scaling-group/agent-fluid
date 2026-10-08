# Exact carrier selection after a fifth plateau result

## Visual and metric diagnosis before candidate selection

- The four sampled solver examples collapse to one completed nominal result:
  their policy (`452903db...`), trajectory (`84ec5c93...`), and combined
  keyframe (`6d2c1aa2...`) hashes are identical. Each begins from direct
  uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm,
  then captures after 237 moving-window shifts at `16.604496T`. The shared
  score is `-0.1137286`, the scored distance integral is `1.998146L`, and the
  final/minimum head distance is `0.743958L`. These copies demonstrate nominal
  determinism, not four mechanisms or held-out robustness.
- I inspected both rows of the shared combined keyframe sheet from release to
  capture. The top-down row shows acceleration from rest, a shallow left/down
  target-crossing arc, and a coherent alternating vorticity street. The
  oblique row shows compact three-dimensional Lambda2 structures attached to
  the posterior body and traveled path. Together with the zero background
  flow, this is self-propulsion rather than advection; neither view shows an
  inherited wake, collision, boundary exit, wake breakup, or instability.
- The trajectory supports the visual diagnosis: distance falls from
  `12.327720L` to capture in 3019 steps, the final head is at
  `(9.691019,9.775620)L`, final inertial velocity remains targetward at
  `(-1.10010,-0.27006)U`, and the released joint-speed envelope is reached.
  The productive closure therefore coexists with a connected wake and the
  incumbent's narrow one-sided speed guard; it is not evidence for removing
  carrier energy.
- No informative failed visual example exists in the supplied workspace. All
  eleven current and inherited combined-sheet file instances have the same
  hash, so a failed wake topology cannot be inferred from them. The most
  informative failure comparison is instead completed inherited metric
  evidence. Closure-qualified yaw release retained capture and arrived one
  `0.0055T` step earlier but regressed crossing/integral/score to
  `0.744276L/1.998380L/-0.114037`; carrier-synchronous local-flow subtraction
  retained arrival and wake class but regressed them to
  `0.745252L/1.999280L/-0.115121` without a feasibility or load benefit.
  Line-of-sight-rate, bearing, moment, half-cycle, and projected-corridor
  descendants likewise failed to improve the capture.
- The assigned parent and at least five consecutive completed inherited
  selections preserve the same controller without a new mechanism, semantic
  improvement, or useful trajectory class. This triggers the structured
  bookshelf consultation. Its traveling-wave, direction-tracking,
  asymmetry, disturbance-residual, and terminal-hold primitives are already
  implemented, already falsified in this nominal regime, or require a
  disturbance/deficit absent from the evidence.

## Sole candidate and falsifiable policy hypothesis

Select the prefilled normalized body-frame controller byte-for-byte as the one
multi-wake candidate in `solver/`. Preserve its full traveling-wave carrier,
raw target geometry and anterior course center, mean-preserving joint-phase
demodulation of yaw and lateral response, unmodified relative-crossflow cue,
posterior phase-compatible steering, smooth acceleration bound, and one-sided
final-one-percent speed guard. There is no evidence-isolated nominal deficit
for a new primitive, and the bookshelf does not justify scalar-only tuning.

Expected test: reproduce capture, the connected two-view wake,
`16.604496T` arrival, `1.998146L` distance integral, `0.743958L` crossing,
and the sampled joint/action/load envelope. Falsify exact preservation if the
nominal rollout loses capture or materially changes those quantities. Reopen
one compact bounded mechanism only after a completed nonduplicate or held-out
pose, target, or flow isolates a repeatable directional, disturbance, or
actuator-feasibility deficit.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion, sensor-modulated robotic-fish CPG direction tracking, asymmetric flapping, wake-interaction control, and terminal capture control
source_mechanism: preserve productive rhythmic propulsion while separating bounded route, disturbance, or terminal feedback and recruiting a new channel only for an independently observed response deficit
transferable_invariant: carrier-correlated oscillation is not itself an error; retain an evidenced traveling carrier when completed feedback perturbations preserve wake class but worsen target cost without improving feasibility or loads
nontransferable_details: published gains, dimensional frequencies and speeds, species or robot kinematics, exact vortex phases, fitted coefficients from other gaits, capture thresholds, prescribed wake geometry, and source-task routes
policy_translation: retain the evaluated two-joint body-frame carrier and its demonstrated response separation exactly; decline a new primitive and scalar tuning because the current samples are one successful nominal trace and the inherited mechanism tests regress it
falsification: reopen one bounded state-feedback primitive only when completed nonduplicate or held-out evidence isolates a deficit, and reject the translation if it loses capture or worsens route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment

## Evidence boundary

No CFD outcome is claimed for this workspace's candidate. Favorable values
belong to completed sampled rollouts, while changed-controller negative values
belong to inherited completed logs. Exact nominal repetitions establish
determinism only and cannot establish robustness to another pose, target, or
flow.
