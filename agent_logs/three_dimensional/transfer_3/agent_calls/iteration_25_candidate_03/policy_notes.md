# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent guidance preserves v33's coordinated outer limiter and
  the quiet intercept-supported terminal glide. Its inherited evaluation logs
  progress from reproduced v33 capture at `23.43552 T` and score
  `-0.40797361` through the current sampled candidates.
- All four sampled rollouts report direct uniform quiescent initialization,
  zero background velocity, and capture. The duplicated v34
  direction-conditioned policy captures at `21.912008 T`, score
  `-0.32465929`, and final distance `0.74768060 L`. The saturation-separated
  target-residual policy is only modestly faster at `21.735992 T`, score
  `-0.30126617`, and final distance `0.74940461 L`. The assigned v36
  posterior-response-conditioned policy is best at `20.096998 T`, score
  `-0.29756859`, and final distance `0.74725485 L`.
- In the top-down sheets, v34 self-propels with a coherent alternating wake but
  makes a broad lower-side loop before its quiet terminal glide. V36 retains
  coherent alternating shedding while taking a shorter approach above the
  target and continues a productive bend through capture. In both oblique
  sheets the wake consists of finite three-dimensional Lambda2 structures;
  neither image shows passive advection, wake blow-up, or a prewarm artifact.
- The trajectories agree with the images. V36 shortens sampled center path
  length from about `13.404 L` to `12.741 L` and never crosses below
  `y=10.1816 L`, whereas v34 reaches `y=8.8683 L`. Peak lateral force and yaw
  moment remain comparable (`0.02758/0.01586` for v36 versus
  `0.02679/0.01558` for v34). However, v36 reaches the software acceleration
  cap more often (about `38.6%/58.8%` versus `26.7%/40.8%`) and the joint-rate
  cap more often (about `9.8%/12.3%` versus `7.3%/8.5%`). The target-residual
  candidate reduces acceleration-cap incidence but does not match v36's
  capture time. Thus lower envelope contact is not itself the improvement.
- A sampled inherited side-branch result also rejects a `5%` common
  rate-headroom attenuation: it slowed v34-like capture from `21.912008 T` to
  `22.038506 T` and increased posterior rate-cap incidence despite reducing
  posterior acceleration-cap incidence. That rules out rate magnitude alone
  as the next gate.

## Control diagnosis

The positive semantic change is preservation of the traveling-bend command
direction when component clipping coincides with posterior lag error. It
changes the outer trajectory usefully and is stronger evidence than either
generic cap reduction or prioritizing the target residual after saturation.
The current response term nevertheless uses only absolute posterior position
error, so it cannot distinguish a tail command that restores the lag target
from one that pushes away from it, nor whether the posterior command is the
overloaded component. Preserve v36 exactly and test that missing signed
actuator-response distinction as one bounded extra contribution.

bookshelf_consulted: true
source_domain: Lighthill elongated-body theory and two-joint traveling-bend control
source_mechanism: reactive propulsion depends strongly on coherent tail-end kinematics rather than reciprocal or independently clipped joint motion
transferable_invariant: preserve the posterior part of a directed body wave when the observed two-joint command is distorted, but condition extra authority on current posterior tracking response
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body waveforms, exact vortex phases, and task routes
policy_translation: outside `4 L`, retain v36 and add a small common-scale blend only when clipping rotates the command, posterior lag error is present, the posterior raw command exceeds its envelope, and its acceleration sign points toward the current lag target
falsification: reject if capture is delayed or lost, the shorter upper approach or coherent two-view wake regresses, terminal commands change, force or moment peaks grow materially, or envelope contact increases without better distance progress

## Candidate hypothesis

The posterior-restorative support should exclude non-restorative or
anterior-limited cases from the new increment while preserving every evaluated
v36 command otherwise. If the tail-end invariant is useful here, the candidate
will retain capture and the short upper approach while improving arrival or
distance integral without materially increasing loads. Because the new gate
is multiplied by the existing normalized outer-distance gate, it must make no
algebraic change at or below the validated `4 L` terminal boundary.
