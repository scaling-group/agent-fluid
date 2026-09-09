# Candidate diagnosis and policy hypothesis

## Evidence read before selecting the candidate

- All four sampled solver rollouts and both assigned-parent rollouts use direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. Motion in the sheets is therefore released
  self-propulsion, not background advection or stored wake transport.
- The four current samples all capture: two exact speed-reserve baselines at
  `0.7480--0.7494L`, the posterior pulse at `0.7480L`, and the prefilled
  geometry-gated anterior-transfer policy at `0.7492L` and `18.7495T`. The
  anterior-transfer trace remains in the sampled carrier envelope: mean speed
  is about `0.699L/T`, returned acceleration clamps on about `68.8%/70.8%` of
  rows, and exact joint-speed-limit residence is about `10.7%/11.6%`.
- I inspected both rows of the combined sheets for the best-scoring baseline
  capture, the anterior-transfer capture, and the assigned parent's two
  failures. Each lays down a persistent alternating red/blue top-down street
  and compact bilateral posterior Lambda2 structures. The failures remain
  active swimmers after closest pass and take the lower branch; neither
  carrier collapse nor a numerical instability precedes exit.
- The assigned parent's target-bearing recovery and geometry-gated midcourse
  reserve missed at `1.8004L` and `1.6664L` and exited below despite retaining
  those wakes. Inherited guidance also rejects posterior wave shaping at
  `2/3`, a phase-compensated observer, mean-curvature tracking, full-band
  response veto, terminal yaw damping, and carrier-phase steering allocation.
  Stacking another observation or beat-allocation mechanism is therefore less
  supported than repeating the one new spatial allocator that has captured.
- The anterior transfer is still only `1/1`. Its clamp and speed-residence
  fractions do not establish actuator relief, and the repeat history of the
  baseline and posterior pulse shows that one threshold crossing is not robust
  evidence. The most informative next result is an exact-policy repeat, not a
  coefficient change disguised as a new mechanism.

## One candidate hypothesis

Retain the prefilled `dogfish3d_unsafe_intercept_anterior_transfer_v1` policy
byte-for-byte as the single candidate. Outside the existing `4L` terminal band
it is the evaluated speed-reserve controller. Inside that band, only when raw
body-frame target/velocity projection is not capture-compatible, it transfers
a bounded share of additive steering from the posterior propulsive joint to
the anterior steering joint while keeping total steering authority constant.
The achieved-course route request, carrier, posterior lag, cadence, response
release, and sparse speed reserve remain unchanged.

Expected test: an exact replay should retain the coherent traveling wake and
capture without moving speed, clipping, force, or moment outside the sampled
speed-reserve envelope. A second capture would promote spatial role separation
from an isolated mechanism demonstration to repeat-supported evidence.
Falsify it immediately if the replay misses, changes the miss side, weakens
either wake view, or leaves the established actuator/load envelope; if that
happens, restore the repeat-backed baseline rather than increasing the transfer
or stacking a rejected observer, bearing residual, carrier-phase allocator, or
midcourse reserve.

bookshelf_consulted: true
source_domain: classical elongated-body propulsion and robotic-fish turning
source_mechanism: use anterior bending for redirection while preserving posteriorly lagged motion for reactive thrust
transferable_invariant: separate the joint role realizing bounded target redirection from the posterior joint role sustaining the traveling propulsive bend
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator phase, exact vortex phase, fixed coordinates, and task-specific routes
policy_translation: retain the evaluated normalized body-frame intercept gate that transfers unsafe-terminal additive steering anteriorly while preserving total steering authority and the state-feedback carrier
falsification: reject on any exact-repeat miss, wake weakening, miss-side change, or actuator/load excursion outside the sampled speed-reserve envelope
