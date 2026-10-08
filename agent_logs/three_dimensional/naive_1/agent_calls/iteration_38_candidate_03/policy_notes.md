# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled episodes satisfy the direct-uniform still-water contract
  (`U_infinity=0`, no prewarm) and terminate in capture, so the informative
  comparison is a mechanism-level negative control rather than a termination
  failure. The prefilled policy is reproduced exactly by
  `solver_d1fa01b2365d` and `solver_e00ec3b50664`: capture at `22.154001T`,
  mean distance `2.105583L`, final distance `0.748384L`, and score
  `-0.210952`. The slower `solver_fb6f1126a48d` captures at `22.159500T`,
  mean distance `2.105808L`, and score `-0.211168`.
- In both combined sheets, the top-down row shows self-propelled progress along
  the same smooth S-route with an attached alternating mid-plane street from
  startup through capture. The oblique row shows discrete three-dimensional
  Lambda2 structures behind the traveling body wave; neither comparison shows
  wake collapse, boundary contact, or instability before the head crosses the
  capture circle. Because the background is quiescent and the storage window
  merely follows the fish, the motion is propulsion rather than advection.
- The only executable difference between the slower comparison and the parent
  is that the parent uses the proximity-led target-line error for the envelope
  of posterior half-cycle steering. The resulting trajectory first separates
  after proximity opens near `9.08T` and is ahead by as much as `0.00665L`
  around `16.67T`; it saves one control step while leaving peak normalized
  force/moment unchanged at `0.030897/0.015839`. Mean action rises modestly
  from `59.830` to `59.932`, and anterior/posterior exact-rate-cap occupancy
  remains bounded at about `11.49/6.41%`.
- A sampled recovery-preview extension is trajectory-identical to the parent,
  so that path has no semantic authority on the encountered route. Inherited
  score-only descendants regress, and inherited detailed guidance reports that
  releasing target-signed anterior redirect from instantaneous moment lowers
  effort but worsens route and score without lowering peak loads. These results
  support preserving recovery and load paths while testing earlier recruitment
  of the bounded anterior steering transient.

## Policy hypothesis

Use the existing proximity-led full target error to gate the anterior redirect
as well as the successful posterior half-cycle envelope. Keep instantaneous
body-frame target lateral displacement as the turn sign, keep joint-state
phase speed as the redirect qualification, and leave all carrier, recovery,
rudder, terminal-relief, and authority parameters unchanged. On the recorded
parent trace this changes only the redirect envelope after the `8L--5.5L`
proximity gate opens; it never decreases the gate, with the largest additional
recruitment occurring on the final approach where target-line error is growing.
The falsifiable expectation is capture before `22.154001T` and mean distance
below `2.105583L` without changing the launch/S-route topology, losing the
coherent two-view wake, or exceeding the established action, rate-cap, force,
or moment envelopes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and burst turning
source_mechanism: preserve a rhythmic carrier while sensed route error recruits a bounded steering transient
transferable_invariant: steering-envelope timing can respond to measured body-frame route demand without changing carrier phase or peak authority
nontransferable_details: published gains, oscillator frequencies, species kinematics, duty ratios, exact wake phase, and task-specific routes
policy_translation: feed the bounded proximity-led full target error into the anterior redirect envelope while retaining target-lateral sign and joint-state phase qualification
falsification: reject if capture is not earlier than 22.154001T, mean distance exceeds 2.105583L, or route, wake, saturation, effort, force, or moment exceeds the sampled parent envelope
