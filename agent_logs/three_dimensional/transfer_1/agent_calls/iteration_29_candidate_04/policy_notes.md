# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled rollouts and the assigned-parent rollout satisfy the frozen
  experiment contract: direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, stable finite dynamics, and
  active moving-window shifts. Their translation is released self-propulsion,
  not ambient advection or reused-flow contamination.
- I inspected both rows of all four sampled combined wake sheets and the
  assigned parent's failure sheet. The best-scoring sampled capture develops a
  persistent alternating red/blue mid-plane street and compact bilateral
  oblique Lambda2 structures through arrival. The parent burden-allocation
  failure retains the same active traveling bend and organized wake through a
  `1.4369L` closest pass, then continues below the target and exits the lower
  boundary. The failure is path control, not carrier collapse or instability.
- The current samples all cross the threshold: the two exact speed-reserve
  samples capture at `0.7485--0.7494L`, the posterior-wave sample at
  `0.7480L`, and the fixed anterior-transfer sample at `0.7492L`. Inherited
  exact repeats are the necessary negative evidence: the posterior pulse is
  only `2/3`, the fixed transfer's replay misses at `1.9385L`, and the assigned
  parent's burden-conditioned transfer misses at `1.4369L`. Both allocation
  failures preserve propulsion and leave below, so another transfer fraction,
  envelope gate, or allocation threshold is not supported.
- The parent failure is already on the lower branch at the first `4L`
  crossing: head `y=10.637L` and body-frame target angle `0.496 rad`, versus
  `y=10.897--11.056L` and `0.324--0.392 rad` for three sampled captures. At
  the first `2.75L` crossing its inertial line-of-sight rate is about
  `-0.236 rad/T`, compared with roughly `-0.077` to `-0.123 rad/T` in the
  sampled captures; the achieved-course command is already nearly saturated
  in the correct direction. The fixed-transfer repeat and full-band-release
  failures show the same excessive negative LOS rotation (`-0.159` and
  `-0.179 rad/T`) while retaining `0.83--0.88L/T` speed. This supports testing
  a dynamic intercept residual rather than more scalar route gain, propulsion,
  response-release veto, or spatial allocation.
- Local flow at the head remains near zero, and force/moment signs alternate
  with the carrier in captures and failures. The evidence does not justify a
  wake-load cancellation term in this still-water episode. The target/velocity
  cross product is instead an inertially meaningful, normalized body-frame
  observation already available to the controller.

## One candidate hypothesis

Restore the exact intercept-guarded speed-reserve scaffold and remove the
falsified posterior wave pulse. Add one bounded proportional-navigation
residual: convert signed inertial LOS angular rate into a soft steering command
that opposes LOS rotation, enable it only while measured projected miss and
approach are not jointly capture-compatible, and combine it with the existing
response-conditioned course command before a unit clamp. Apply the resulting
command through the unchanged `0.45/1.00` steering shares. Preserve the
traveling-bend carrier, posterior lag, cadence, route observation, response
release, sparse carrier reserve, steering acceleration limit, and final hard
clamp.

Expected test: keep the established far-field gait and both coherent wake
views while reducing the excessive terminal LOS rotation seen in all three
informative lower misses. Unlike the failed release veto, the residual supplies
a signed correction; unlike the failed allocators, it does not move effort
between joints; unlike scalar route gain, it vanishes with LOS rate and with a
capture-compatible projected intercept.

Falsification: reject proportional-navigation blending if capture is lost, the
same lower-pass topology remains, a new upper miss appears, either wake row
weakens, far-field closure materially changes, or speed, clipping, force, or
yaw moment leaves the evaluated speed-reserve envelope. Do not answer failure
by increasing its weight or stacking the rejected posterior pulse, allocation,
release-veto, bearing, yaw-brake, cadence-relief, governor, or carrier-
suppression mechanisms.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and target-vector feedback
source_mechanism: preserve rhythmic propulsion while a bounded measured-path residual corrects target-relative direction
transferable_invariant: target bearing and achieved course alone need not arrest a rotating line of sight, so a bounded target-relative velocity cross product may correct interception without suppressing the traveling bend
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator phase, exact vortex phase, world-frame routes, task coordinates, and memorized trajectories
policy_translation: use normalized body-frame target and velocity to form inertial LOS angular rate, oppose it only while projected closest-pass geometry is not capture-compatible, and blend through the unchanged two-joint steering shares within the existing acceleration envelope
falsification: reject if exact evaluation retains the lower miss, flips the miss side, changes far-field closure, weakens either wake view, or moves actuator and load metrics outside the speed-reserve envelope

## Offline selectivity check

The residual's trigger is based only on normalized body-frame observations and
requires no case coordinates in the policy. Recorded-trace comparison shows
the signal is strongest on the inherited misses at the first `2.75L` crossing,
while its total steering command remains capped at the already evaluated unit
authority. This is a selectivity check, not a claim about the unevaluated
closed-loop CFD outcome.
