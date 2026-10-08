# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts (`U_infinity=0`) and terminate in capture at `18.0070--18.0125T`.
  Their top-down sheets show self-propelled motion on the same gently curved
  route with a coherent alternating wake; their oblique sheets show compact,
  persistent three-dimensional vortex structures without wake collapse,
  collision, advection, or instability. The missing capability is therefore
  not gross propulsion or turn polarity.
- The prefilled v31 duty-ratio parent is the best sampled scalar result
  (`-0.064000`, mean distance `1.950346L`). Against v20, its terminal
  turn-consensus duty asymmetry reduces final absolute yaw from `0.9840` to
  `0.8077 rad/T` and raises final alignment from `0.1092` to `0.1297`, but it
  arrives `0.0055T` later and slightly widens center path/head cross-track from
  `13.2108L/0.7317L` to `13.2149L/0.7327L`.
- The informative mechanism-level failure is v26's one-sided
  slip-synchronous posterior feathering. It preserves the same two-view wake
  and capture and improves final alignment/yaw to `0.1728/0.6545 rad/T`, path
  to `13.2064L`, and head cross-track to `0.7265L`; however, it has the weakest
  sampled mean distance/score (`1.950469L/-0.064149`). This suggests that its
  measured phase selector is useful, while one-sided loss of posterior work is
  not. V25's phase-free force-power allocation similarly captures but does not
  beat v31 (`-0.064035`).
- Inherited score-only captures at `-0.064451` and `-0.064554` contain no
  trajectory or policy evidence, so they establish continued semantic capture
  but cannot identify a mechanism worth transferring.

## Policy hypothesis

Replace v31's turn-request-signed posterior duty bias with a balanced,
slip-synchronous duty command. During only a moving, misaligned approach,
normalize target-normal body velocity, infer the current half-cycle from
summed joint rate, weaken the posterior wave when that half-cycle reinforces
the measured slip, and strengthen it by the same bounded factor when the
half-cycle opposes the slip. Preserve the evaluated route controller, odd mean
curvature, carrier cadence, posterior lag, v20 envelope, and conserved anterior
mean-bend allocation unchanged.

The candidate is falsified if it loses capture or the coherent two-view wake;
if mean distance, arrival, or path regresses to the v26 class; if final
alignment/yaw does not retain the directional improvement of v26 over v31; or
if posterior acceleration/rate residence rises materially rather than being
redistributed between half-cycles.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control
source_mechanism: sensor-modulated asymmetric flapping and duty-ratio turning
transferable_invariant: redistribute posterior effort between observed stroke half-cycles using directional feedback while preserving the traveling carrier
nontransferable_details: published gains, clock phase, robot linkage kinematics, species envelopes, exact vortex phase, and task-specific routes
policy_translation: use normalized target-normal body velocity and summed joint rate to apply a bounded reflection-equivariant posterior duty factor only during approach
falsification: reject if capture or wake coherence is lost, closure/path regresses to one-sided feathering, terminal alignment and yaw do not improve together, or limit residence migrates upward
