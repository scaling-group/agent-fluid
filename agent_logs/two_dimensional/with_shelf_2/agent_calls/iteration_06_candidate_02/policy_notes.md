# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The common prewarm sheet shows the fish held at the upper-right release pose
  while four developed cylinder streets merge through the target corridor. The
  released-sheet differences therefore reflect feedback structure rather than
  a different initial wake.
- The posterior-curvature failure (`solver_b2565fd6bd70`) is self-propelled
  rather than simply advected: it travels `-10.51L` upstream. Its keyframes,
  however, show a broad pass above the useful target wake followed by a nearly
  vertical turn and upper-boundary exit at `84.22`. Its `2.43L` closest and
  `6.64L` mean distances agree that its lower `116/1278` force/moment RMS does
  not compensate for missing target-directed anterior steering.
- The yaw-load-gated distributed controller is reproduced by three sampled
  target-reaching rollouts. Its keyframes show a direct diagonal trajectory,
  a posteriorly traveling body wake, entry into the interacting cylinder wake,
  and first crossing of the `0.75L` circle at `51.47`. Metrics agree:
  final/minimum distance is `0.748L`, mean distance is `1.820L`, head
  displacement is `-11.28/-4.94L`, and force/moment RMS is finite but high at
  `426/4084`. This repeated semantic success makes its propulsive and steering
  scaffold the part to preserve.
- The success diagnostics also expose the remaining control defect: both
  joints reach exactly the `4.537856` rad/time (`260 deg/time`) hard rate cap,
  while their accelerations approach the candidate's `29` rad/time^2 soft
  limit (`28.79` and `28.14`). A smooth acceleration cap alone therefore does
  not prevent rate-envelope contact. The current candidate is byte-identical
  to two of those successful samples, so this defect applies directly to the
  prefill rather than being inferred from an unrelated gait.

## Candidate hypothesis

Preserve the successful zero-centered traveling bend, posterior velocity lag,
heading-response route request, and yaw-magnitude gate without retuning their
gains. Add one joint-state mechanism after the existing acceleration soft
limit: a smooth rate-headroom governor. For each joint, normalize absolute
rate by a candidate-owned soft envelope and attenuate only the portion of the
command whose sign would increase that absolute rate; allow opposing
acceleration through so the traveling wave can reverse promptly.

This should retain the direct capture topology while preventing persistent
contact with the harder episode rate clip and reducing the associated load
risk. The next CFD rollout falsifies the candidate if target capture is lost,
mean/minimum distance or upstream displacement materially regresses, either
joint still reaches the exact hard rate cap, or reduced rate contact is merely
replaced by higher force/moment load. Command effort is diagnostic only in the
current zero-weight score and is not claimed as a same-worker improvement.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and bounded oscillatory actuation
source_mechanism: preserve a propulsive limit cycle while smoothly releasing velocity-increasing drive near an actuator-rate envelope
transferable_invariant: normalized observed joint rate can gate only acceleration that increases absolute rate while preserving deceleration and traveling-wave reversal
nontransferable_details: published CPG gains, dimensional rate limits, species-specific kinematics, oscillator topology, exact vortex phases, and task-specific routes
policy_translation: retain the successful two-joint body-frame target and yaw-load feedback; after smooth acceleration limiting, apply a candidate-owned soft rate envelope separately to each joint and suppress only rate-increasing acceleration
falsification: reject if capture or approach regresses, either joint still reaches the hard rate cap, propulsion loses its traveling-wave topology, or force/moment loads increase
