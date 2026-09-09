# Response-released distributed-bend candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts are finite, direct-uniform still-water evaluations
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Translation and the
  visible wakes are self-generated rather than imposed advection or storage-
  window motion.
- Both rows of every combined keyframe sheet were inspected. The assigned
  prefill (`solver_adc862529891`) forms a coherent alternating top-down street
  and compact oblique Lambda2 structures, but rises to the upper margin and
  exits at `16.77T` after reaching only `5.658L`. The posterior-only LOS-rate
  controller (`solver_3b6bd84298a5`) retains that productive three-dimensional
  wake to `30.12T`, crosses the target x station near `y=12.995L`, and reaches
  `3.369L` before a left exit. The range-damped child
  (`solver_cf44a7c3b1a7`) visibly narrows the late wake and lowers closest-
  approach speed from `0.878U` to `0.820U`, but slightly worsens the minimum to
  `3.392L` and repeats the high left pass. Range-only drive relief is therefore
  not the missing route mechanism.
- The new completed positive result is the bearing-triggered distributed
  C-bend (`solver_5188c80f90a6`). It preserves a long alternating top-down
  wake and compact oblique vortices, lowers the target-station crossing to
  `y=11.465L`, and reduces minimum range to `1.897L` at `20.20T`. This is a
  material gain over posterior-only steering, so proximal mean-bend authority
  survives the visual, distance, and stability evidence. It is still not a
  capture: speed is `0.866U` at the minimum, range then grows, and the fish
  exits left at `29.10T` with final range `8.685L`.
- The distributed C-bend exposes a release/allocation defect rather than lost
  propulsion. Its anterior raw acceleration-envelope occupancy rises to
  `62.2%` from the LOS parent's `57.7%`, posterior occupancy to `76.4%` from
  `74.0%`, force RMS to `0.01573` from `0.01488`, and moment RMS to `0.00808`
  from `0.00770`; local-flow RMS remains small at `0.0208U`. More importantly,
  the anterior center follows raw yaw demand after observed response says to
  release: near `12T` the reconstructed phase-conditioned yaw residual is
  `-0.468 rad/T` while the anterior offset remains about `+4.4 deg`, and near
  `17T` the residual is only `+0.032 rad/T` while the offset remains about
  `+5.6 deg`.
- Beat-scale comparisons support opposite joint-coordinate yaw polarities. In
  the `8.8--9.9T` window the LOS parent averages `(q1,q2)=(+0.093,+0.089)` rad
  with `+0.158 rad/T` yaw, whereas the C-bend averages
  `(-0.025,+0.197)` rad with `-0.564 rad/T` yaw; the same sign separation is
  repeated over `11.0--12.1T`. Lower anterior mean and higher posterior mean
  both accompany more negative yaw. A coordinated requested yaw should
  therefore allocate opposite-signed joint centers instead of persisting the
  sampled same-signed centers.

## Policy hypothesis recorded before editing

Preserve the evaluated `28 degree`, `0.55T` state-feedback traveling bend and
the normalized body-frame bearing plus rotation-invariant LOS-rate guidance.
Preserve posterior-only response curvature for small route error. When the
same smooth large-bearing gate that produced the `1.897L` approach activates,
transition to one coordinated distributed bend driven by the phase-conditioned
yaw-rate residual: shift the anterior oscillator with the residual and shift
the posterior mean in the empirically opposite joint-coordinate direction.
Both shares then weaken, reverse, or release together when observed yaw catches
the route request; raw bearing demand cannot hold an anterior offset by itself.

Expected evidence is the sampled coherent far-field wake, target-station
crossing below `11.465L`, and minimum range below `1.897L` or capture without
increasing saturation/load histories. Reject this translation if the short
upper curl returns, the alternating wake collapses, target crossing or minimum
range does not improve, or opposite-polarity allocation increases clipping and
loads without a better termination.

bookshelf_consulted: true
source_domain: biological burst turning and robotic-fish closed-loop CPG mean-offset steering
source_mechanism: a large sensory direction error recruits a distributed body bend, while observed turn response continuously releases or reverses that bend and rhythmic propulsion persists
transferable_invariant: preserve the traveling-wave carrier; recruit coordinated curvature only for large observed route error; couple both steering shares to measured response so they release when yaw catches demand
nontransferable_details: published gains, species-specific C-start timing and shape, robot linkage geometry, dimensional frequency, clock phase, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame bearing to gate a phase-conditioned yaw-residual bend; shift the anterior oscillator center and posterior mean in empirically opposite joint-coordinate directions within the two-joint state-feedback contract
falsification: reject if the coherent far-field wake is lost, the short upper exit returns, target crossing is not below 11.465L, minimum range is not below 1.897L, or actuator and load histories worsen without better termination

## Dry validation after editing

- The required independent checker reports PASS for the material guidance
  update, Julia policy contract/schema, and solver boundary. The contract state
  returns two finite accelerations and every direct `params.FIELD` reference is
  present in `target_policy_params()`.
- A mirrored synthetic large-bearing state returns exactly sign-mirrored joint
  accelerations and steering centers. Aligned zero-error geometry returns zero
  steering and zero action, while the tested large-bearing state gives
  opposite-signed anterior/posterior centers as intended.
- Only `candidate_target_policy.jl` differs inside `solver/`. No CFD rollout
  was run, and no outcome for this candidate is claimed here.
