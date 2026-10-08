# Evidence-constrained carrier selection after duplicate-sample plateau

## Visual and metric diagnosis before candidate selection

- The assigned parent and all four sampled solvers contain the same policy
  (`452903db...`). Their trajectories (`84ec5c93...`) and combined two-view
  keyframe sheets (`6d2c1aa2...`) are also byte-identical, so the samples are
  one deterministic nominal result rather than four independent controller
  mechanisms.
- Every sampled episode starts by direct uniform initialization in still water
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm artifact. Each is
  finite and captures at `16.604496T`, with score `-0.1137286`, scored distance
  integral `1.998146L`, and crossing distance `0.743958L` after 237 moving-
  window shifts.
- I inspected the combined sheet from release through capture. In the top-down
  vorticity row the fish accelerates from rest, moves left/down on a shallow
  target-crossing arc, and leaves a persistent alternating wake; it is self-
  propelled rather than passively advected. In the oblique Lambda2 row,
  compact three-dimensional structures remain connected to the posterior body
  and traveled path through termination. Neither view shows inherited wake,
  collision, virtual-boundary exit, wake breakup, or numerical instability.
- The trajectory and diagnostics support the visual reading. Distance falls
  from `12.3277L` to capture, despite only 56 locally receding samples among
  3019 logged rows. The peak planar force norm and yaw moment are about
  `0.03716` and `0.01836`; peak joint speed reaches the released
  `4.537856 rad/T` envelope while peak joint angle remains about `0.5473 rad`.
  This supports the incumbent's narrow outward-only speed guard and does not
  expose joint-position contact, load growth, or a late loss of target closure
  that a new terminal channel must repair.
- No distinct failure sheet is available in this workspace: the four current
  and five inherited combined sheets have the same hash. I therefore do not
  fabricate a visual failure comparison. The assigned-parent guidance and
  inherited notes provide the relevant completed negative controls. A
  closure-qualified yaw release retained capture but regressed
  score/integral/crossing depth to
  `-0.1140375/1.998380L/0.744276L`; carrier-synchronous local-flow subtraction
  also retained capture but regressed them to
  `-0.115121/1.999280L/0.745252L` without a feasibility or load benefit.
  Line-of-sight-rate feedforward, bearing and moment residualization, posterior
  terminal relief, and projected-corridor gating likewise failed to improve
  the incumbent in completed inherited evidence.
- Five consecutive inherited selections and the current sample set add no new
  mechanism, semantic outcome, or useful trajectory class. This activates the
  structured bookshelf review. Its traveling-wave and closed-loop CPG sources
  reinforce separating productive rhythm from bounded route/disturbance
  feedback, but current evidence identifies no independent disturbance or
  response deficit that can select another primitive.

## Sole candidate and falsifiable policy hypothesis

Select the prefilled joint-phase-demodulated yaw/lateral-response policy as
the sole multi-wake candidate, byte-for-byte. It preserves the evidenced full
traveling-wave carrier, raw body-frame target geometry, mean-preserving yaw
and lateral-response demodulation, unmodified relative-crossflow feedback,
posterior phase-compatible steering, acceleration bounding, and the final-one-
percent outward speed guard. No sibling candidate is created, no scalar-only
gain tuning is made, and no failed terminal or carrier-residual mechanism is
recombined.

The expected evaluation is another finite capture with a connected wake in
both views and the sampled arrival, route cost, crossing depth, joint/action,
force, and moment envelope. Falsify this preservation decision if the nominal
rollout loses capture or materially fails to reproduce those quantities.
Reopen one compact feedback mechanism only when a completed nonduplicate or
held-out trace identifies a repeatable directional, disturbance, or actuator-
feasibility deficit that the current controller does not handle.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve productive rhythmic locomotion as a carrier and recruit a separate bounded route or disturbance channel only for an independently observed response deficit
transferable_invariant: carrier-correlated lateral motion is not itself a control error; retain an evidenced traveling wave when completed perturbations keep the wake finite but worsen target cost without improving feasibility or loads
nontransferable_details: published gains, dimensional frequencies and speeds, species or robot kinematics, exact vortex phases, capture thresholds, fitted coefficients from other gaits, and source-task routes
policy_translation: retain the normalized body-frame two-joint carrier and its evidenced response separation; decline scalar tuning and new terminal or residual channels because duplicate nominal samples expose no deficit and completed mechanism tests regress target cost
falsification: reopen one bounded state-feedback primitive only after nonduplicate or held-out evidence isolates a deficit, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

No CFD result is claimed for this workspace's candidate. Favorable values
belong to completed sampled and inherited rollouts; the changed-controller
negative values belong to completed inherited evidence. Exact repeats establish
nominal determinism only and cannot establish robustness to a different pose,
target, or flow.
