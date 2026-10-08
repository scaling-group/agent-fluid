# Replicated capture carrier after a fourth plateau selection

## Visual and metric diagnosis before candidate selection

- The four sampled solver examples collapse to one completed result. Their
  candidate policies, trajectories, and combined keyframe sheets are
  byte-identical (`452903db...`, `84ec5c93...`, and `6d2c1aa2...`
  respectively). Each starts from direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm; each captures at
  `16.604496T` with score `-0.1137286`, scored distance integral
  `1.998146L`, crossing distance `0.743958L`, and 237 moving-window shifts.
  These replicas establish deterministic nominal behavior, not four
  independent mechanisms or robustness to another pose, target, or flow.
- I inspected both rows of the shared combined sheet from release through
  capture. The top-down vorticity row shows acceleration from rest, sustained
  left/down target closure on a shallow curved path, and an alternating wake;
  the fish is self-propelled rather than advected. The oblique Lambda2 row
  shows compact three-dimensional structures connected to the posterior body
  and traveled path through the target crossing. Neither view shows an
  inherited wake, collision, boundary exit, wake breakup, or instability.
- The trajectory cross-check agrees with the visual diagnosis: distance falls
  from `12.3277L` to capture, the final head is at
  `(9.6910,9.7756)L`, and the final velocity remains targetward. Joint 2
  reaches the released `260 deg/T` speed envelope on the last approach while
  its outward acceleration is projected away, which supports retaining the
  narrow one-sided speed guard rather than perturbing the carrier.
- No distinct failed visual example is present: all assigned solver sheets
  are the same artifact, and the inherited plateau notes report the same for
  the available combined sheets. The required failure contrast is therefore
  limited to completed inherited metrics, not an invented image comparison.
  A closure-qualified yaw release retained capture but regressed
  score/integral/crossing depth to
  `-0.1140375/1.998380L/0.744276L`; carrier-synchronous local-flow subtraction
  also retained capture but regressed those quantities to
  `-0.115121/1.999280L/0.745252L` without a feasibility or load benefit.
  Inherited guidance additionally records regressions from line-of-sight-rate
  feedforward, bearing and moment residualization, posterior terminal relief,
  and projected-corridor gating.
- The assigned parent and the last four completed optimizer selections all
  preserve the same successful controller, with neither a new mechanism nor
  a semantic or trajectory improvement. This activates the structured shelf
  review. The present nominal evidence still identifies no response deficit
  that could distinguish a new bounded primitive from another speculative
  perturbation.

## Sole candidate and falsifiable hypothesis

Select the prefilled normalized body-frame policy byte-for-byte as the one
multi-wake target-policy candidate in `solver/`. It retains the demonstrated
full traveling-wave carrier, raw target geometry and anterior course center,
mean-preserving joint-phase demodulation of yaw and lateral body response,
unmodified relative-crossflow feedback, posterior phase-compatible steering,
smooth acceleration bounding, and final-one-percent outward speed guard. Do
not add a terminal hold, another carrier-correlated residual, or a scalar gain
change when no completed rollout isolates a deficit for it to correct.

The expected evaluation is another nominal capture with a connected wake in
both views and the sampled arrival, route-cost, crossing-depth, joint/action,
force, and moment envelope. Falsify this selection if the nominal rollout
loses capture or materially fails to reproduce those quantities. Reopen one
compact mechanism only when a completed nonduplicate or held-out rollout
identifies a repeatable directional, disturbance, or actuator-feasibility
deficit that the incumbent does not handle.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion, sensor-modulated robotic-fish CPG direction tracking, asymmetric flapping, and wake-interaction control
source_mechanism: preserve a productive rhythmic carrier and add a distinct bounded route or disturbance channel only for an independently observed response deficit
transferable_invariant: carrier-correlated oscillation is not itself an error; retain an evidenced traveling carrier when completed feedback perturbations preserve wake class but worsen target cost without improving feasibility or loads
nontransferable_details: published gains, dimensional frequencies and speeds, species or robot kinematics, exact vortex phases, fitted coefficients from other gaits, capture thresholds, prescribed wake geometry, and source-task routes
policy_translation: retain the evaluated two-joint body-frame carrier and its demonstrated response separation; decline a new primitive and scalar tuning because the four current samples are one successful nominal trace and the inherited mechanism tests regress it
falsification: reopen one bounded state-feedback primitive only after a completed nonduplicate or held-out trajectory isolates a deficit, and reject the translation if it loses capture or worsens route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment

## Evidence boundary

No CFD result is claimed for this workspace. Favorable values belong to the
completed assigned samples, while changed-controller negative values belong
to inherited completed logs. The shelf informs the transfer boundary but is
not evidence that another mechanism would improve this nominal case.
