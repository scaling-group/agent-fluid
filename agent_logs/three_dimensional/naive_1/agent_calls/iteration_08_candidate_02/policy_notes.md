# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are valid direct-uniform still-water rollouts
  (`U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot) and are
  self-propelled rather than advected. In every combined sheet, the top-down
  row retains an alternating caudal vortex street and the oblique row retains
  compact three-dimensional Lambda2 structures through the approach. None is
  numerically unstable, but every trajectory continues southwest past the
  target and exits the lower virtual boundary at about `32--33T`.
- The assigned parent's mechanism sequence is informative despite the common
  termination. Symmetric large-bearing tail relief reaches `4.233L`; adding
  an anterior phase-selective residual reaches `4.018L`; posterior
  half-stroke redistribution reaches `3.909L`; and the prefilled combination
  of both phase-selective actions reaches the best sampled minimum,
  `3.691L` at `20.46T`. Thus the combined gait contains useful redirect
  authority and is the base to preserve.
- The best trace still has folded/full target bearing `1.364 rad` at closest
  approach and then exits at `9.294L`. Its mean heading over `18--22T` is
  `0.479 rad`, a modest desired-sign change from the initial `0.506 rad`, but
  not enough to bend the visible trajectory into a capture arc. The full
  rear-target angle variant independently preserves the same topology and
  reaches only `3.909L` before exiting at `9.320L`; correcting the post-pass
  angle semantics alone therefore does not supply the missing yaw authority.
- Joint 1 is at the `1800 deg/T^2` acceleration cap for about
  `67.7%, 67.6%, 67.6%, and 67.8%` of the symmetric-relief, anterior-residual,
  full-angle/posterior-asymmetry, and combined traces respectively. The
  anterior residual did not create actuator headroom: it is added to a carrier
  whose nominal restoring acceleration already exceeds the cap, so both the
  useful and cancelling sides are often clipped to the same magnitude.
- Replaying only the command algebra on the best recorded state trace shows
  that reserving the target-signed residual inside the fixed acceleration
  envelope would materially change about `44%` of large-bearing samples and
  reduce their cap occupancy from about `69%` to `36%`. This is not claimed as
  a CFD outcome; it establishes that priority allocation is a distinct,
  testable command mechanism rather than another scalar gain change.

## One candidate hypothesis

Preserve the best sampled controller's slip-aware anterior center, joint-state
oscillator, large-bearing phase-selective anterior redirect, and posterior
half-stroke relief. Make one structural change at joint 1: reserve room inside
the known acceleration envelope for the bounded redirect, clamp only the
propulsive carrier to the remaining budget, and then add the redirect. At
small bearing the reserve vanishes and the released command is identical to
the runtime-clipped carrier; at large bearing the target-signed component can
no longer be erased by carrier saturation.

The falsifiable expectation is an earlier and larger desired-sign heading
change while retaining the coherent wake and the sampled `3.691L` approach.
Reject the mechanism if closest approach regresses materially, target bearing
does not fall below `1.364 rad` before the pass, the lower-exit topology
survives without a stronger turn, the staggered three-dimensional wake
collapses, or rate/load histories worsen despite the explicitly bounded
command.

bookshelf_consulted: true
source_domain: biological burst redirection and closed-loop robotic-fish gait modulation
source_mechanism: large target error temporarily prioritizes a bounded redirect over the cruise rhythm, then observed alignment restores the propulsive gait
transferable_invariant: redirect authority must remain available inside the actuator envelope instead of being additively hidden by a saturated carrier
nontransferable_details: published gains, species-specific C-start shapes, dimensional beat frequencies, exact vortex phases, robot linkage geometry, and task-specific routes
policy_translation: normalized body-frame bearing gates a joint-state-demodulated anterior redirect; its magnitude is reserved first inside the joint-1 acceleration budget and only the carrier is clipped to the remainder
falsification: reject if wake coherence or the 3.691L approach is lost, closest-approach bearing fails to improve, loads or rate saturation worsen, or the same lower-boundary exit persists without earlier desired-sign yaw
