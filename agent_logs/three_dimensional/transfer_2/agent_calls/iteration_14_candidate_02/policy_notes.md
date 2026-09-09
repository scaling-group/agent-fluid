# Joint-rate-guarded LOS candidate

## Evidence diagnosis before the policy edit

- All four sampled episodes are valid direct-uniform still-water releases:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  `capture` termination. They capture in `19.701--19.723T`, with distance
  integrals `2.10438--2.10634L` and scores `-0.21449` to `-0.21675`. This is
  one successful repeat cluster, not four distinct semantic improvements.
- Both rows of the combined sheets for the best scalar sample
  (`solver_12a0e2e3745e`) and the assigned-parent sample
  (`solver_86d4118b6d89`) were inspected from direct release to capture. Their
  top-down rows show self-propelled fish, coherent alternating wakes, similar
  productive lateral beats, and a bounded late redirect into the target. The
  oblique Lambda2 rows show compact three-dimensional structures following the
  body and no wake collapse, passive advection, collision, domain exit, or
  numerical instability. Metrics agree: both arrive at `19.701T`, and the
  small score difference comes from the distance integral/final crossing, not
  a visibly different route or stability class.
- The sampled architectural changes do not justify another redirect gate.
  Plain LOS lead, range-aware projected miss, yaw-response anterior release,
  and intercept-corridor anterior release all stay within the same topology.
  The inherited phase-lag allocation result also captured but scored
  `-0.21839`, below the best sampled cluster; the earlier independent
  middle-field schedule scored `-0.22294`. These completed negatives rule out
  scalar tuning of those additions as the next useful test.
- A different limitation survives across the inherited diagnostics: both
  joints reach the `260 deg/T` (`4.538 rad/T`) hard rate limit, and the
  inherited phase-lag analysis measured about `35.3%/32.7%` of anterior/
  posterior commands above 90% of the `31 rad/T^2` smooth command bound. The
  current sheets retain a coherent wake despite that clipping, so the carrier
  should be preserved; the hypothesis is that hard rate clipping distorts its
  joint-state phase and wastes outward acceleration rather than providing
  useful extra propulsion.

## One-candidate policy hypothesis

Restore the evaluated plain LOS-led half-cycle scaffold rather than carrying
the assigned parent's unsupported yaw-response release. Add one new actuator
feedback primitive after the existing smooth acceleration limit: normalize
each observed joint rate by a policy-owned rate envelope, and smoothly
attenuate only acceleration whose sign would push that joint farther outward
once it enters the upper part of the envelope. Opposing acceleration remains
untouched so each joint can reverse promptly. Absolute normalized rate and the
acceleration-rate sign product make the guard reflection equivariant; it uses
no clock, route memory, world coordinates, or environment mutation.

Expected signature: preserve capture, route topology, and both coherent wake
views while reducing exact rate-limit residence and near-bound action. Better
phase fidelity should improve arrival or distance integral beyond repeat
variation without raising the approximately `0.025/0.013` planar force/yaw-
moment class. Falsify the mechanism if capture is lost, arrival or integral
regresses outside the repeat band, the traveling wake weakens, braking becomes
sluggish, or joint-angle, force, moment, or command margins worsen. If
falsified, later workers should revert the guard rather than tune its onset and
test a different evidenced observation/actuator primitive.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control under bounded actuation
source_mechanism: preserve the rhythmic carrier while using measured state to bound a localized corrective modulation
transferable_invariant: modulate only the state-feedback command component that drives an actuator farther into a physical envelope, while preserving the traveling bend and prompt reversal
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, clock phase, and task-specific routes
policy_translation: apply a smooth body-symmetry-preserving attenuation to each soft-limited joint acceleration only when normalized observed joint rate is near its policy-owned limit and acceleration has the same sign as rate
falsification: reject if exact rate-limit residence and command effort do not fall, or capture timing, distance integral, joint margin, loads, or either wake-coherence view regress
