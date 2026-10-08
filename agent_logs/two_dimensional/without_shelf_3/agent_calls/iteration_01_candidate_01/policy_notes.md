# Wake-policy candidate notes

## Evidence read before the policy edit

- The assigned parent guidance is the fresh-lineage baseline and its sampled
  optimizer record contains only an Elo value; there are no inherited
  `logs/optimize/` policy notes in this workspace. The durable parent advice is
  therefore treated as a constraint, not as evidence of a previously successful
  steering mechanism.
- The shared prewarm sheet shows the fish held above and downstream of four
  staggered cylinders while their vortex streets develop across the target
  region. This is common initial-condition evidence, not policy evidence.
- In the only sampled released rollout, the target-blind seed pitches from its
  initial diagonal attitude to a nearly vertical descent on the right side of
  the domain. Its tight, high-frequency bending continues as it crosses the
  lower boundary; it neither enters the target-centered developed-wake region
  nor turns back toward it.
- The visual diagnosis agrees with the compact diagnostics: termination is
  `left_domain` after 50.13 released time units, head displacement is only
  -3.55 L in x but -13.30 L in y, minimum/final distance is 8.61/12.12 L, and
  progress is 0.024. Both joint accelerations reach the 31.416 rad/time^2
  (1800 deg/time^2) cap. The tailbeat/shedding estimate is 32.83, while RMS
  relative crossflow, lateral force, and moment are 0.175, 21.94, and 541.70.
  Thus the rollout demonstrates self-propelled motion, but not useful wake
  entry or bounded target-directed steering.
- This single failed rollout cannot identify an optimal gait or prove that its
  frequency caused the lateral exit. It does establish that leaving the
  oscillator target-blind and demanding capped accelerations is not a viable
  continuation for this initial condition.

## One candidate hypothesis

Retain the state-encoded oscillator and lagged posterior-joint response as the
only inherited propulsion mechanism, but center the oscillator on a bounded
body-frame target-bearing correction. Use the observation-window bearing rate
to damp correction growth without a clock, coordinates, route, target identity,
or prescribed flow signal. Slow and reduce the oscillator from the seed so its
nominal joint demands remain below the engineering acceleration cap; a simple
joint-only integration of the proposed law reaches about 977 and 644
deg/time^2 rather than 1800 deg/time^2 under the initial bearing held constant.
That calculation is only a contract/saturation check, not CFD evidence.

The expected next-rollout signature is a diagonal trajectory with materially
more negative x displacement per unit downward displacement, entry toward the
target/wake corridor, improved minimum and final distance, and less acceleration
saturation. The hypothesis is falsified if the candidate preserves the lower
domain exit or fails to improve target-distance progress; collision, unstable
dynamics, persistent cap contact, or a reversed initial turn would specifically
falsify the chosen steering sign or gain and should not be hidden by a scalar
score change.
