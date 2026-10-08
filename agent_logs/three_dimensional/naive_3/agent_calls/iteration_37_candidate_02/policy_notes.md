# Point-consistent terminal slip carrier-relief candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled solver evaluations satisfy the frozen contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite traces, and capture termination. They have the
  same policy hash, trajectory, keyframe hash, `16.93205T` arrival,
  `-0.20004481` score, `2.08513L` mean distance, and `0.74389L` crossing
  distance. The current prefill is therefore a four-sample replicated strong
  reference rather than an informative policy contrast.
- I inspected the combined strong-reference sheet and both rows of the two
  inherited terminal variants from release through capture. Their top-down
  rows show continuous target-directed self-propulsion and a coherent
  alternating red/blue wake; their oblique rows show compact caudal Lambda2
  structures through the capture neighborhood. There is no passive drift,
  held-joint coast, collision, boundary exit, numerical instability, or
  visible wake collapse. The reference trace supports that reading: peak fish
  speed is `1.39123U` while peak sampled local flow is only `0.03270U`.
- The inherited agreement-gated yaw amplifier preserves arrival to within
  `0.00001T` and leaves whole-trace joint, action, force, moment, speed, and
  yaw-rate maxima unchanged, but worsens score/mean/final distance to
  `-0.200362/2.08539L/0.74420L`. The later target-ray-rate feedforward arrives
  `0.00583T` earlier yet regresses more strongly to
  `-0.204430/2.08866L/0.74814L`, again with the same whole-trace mechanical
  maxima and a visually indistinguishable wake. Together with the two earlier
  collision-corridor releases, these completed outcomes reject both
  unconditional terminal steering relief and additive terminal steering from
  either beat-scale yaw or sightline rate.
- A point-consistent replay of the replicated trace separates head motion from
  the center-velocity course used by the controller. Below `2.25L`, all 222
  samples close faster than `0.75L/T`, while reconstructed head-course error
  has mean magnitude about `0.330 rad` and is below `0.15 rad` in only 53
  samples. Meanwhile, the existing center-course signal opposes measured yaw
  in 207 of 222 samples. Thus the inherited steering is already active yaw
  braking; the untested question is whether full posterior carrier work
  competes with it during the large-slip portions of the terminal beat.

## Single-candidate policy hypothesis

Preserve the replicated zero-centered anterior oscillator, lagged posterior
traveling carrier, full body-frame velocity-course steering, posterior
acceleration reserve, soft acceleration envelope, high-onset positive-power
speed guards, target-signed adverse-yaw work allocation, and posterior
stopping-risk projection. Add one continuous terminal carrier-relief
mechanism before the existing reserve allocator. Reconstruct the head's
point-consistent course error from normalized range closing speed and the
matched-window inertial target-ray rate. Only near the target, only while
closing reliably, and only as head-course error grows, reduce a bounded part
of posterior carrier acceleration; do not change the steering request or the
anterior oscillator. The carrier retains a nonzero floor, and all existing
mechanical projections remain downstream.

This tests a different actuator channel from the four failed steering
overlays: sensor-modulated propulsive work allocation during measured slip.
Expect the broad route and wake to remain inherited, with lower terminal
course oscillation and an equal or deeper capture crossing. Falsify the
mechanism if capture is lost, arrival is later than `16.932T`, score or mean
distance is worse than `-0.200045/2.08513L`, the alternating wake weakens,
head-course error does not fall, or any joint limit, posterior excursion above
`0.5993 rad`, force above `0.0370`, or yaw moment above `0.0184` appears
without a semantic gain.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and biological terminal approach
source_mechanism: retain a coupled propulsive rhythm while measured approach error continuously schedules bounded carrier authority
transferable_invariant: preserve target-relative steering and the traveling bend, but reduce competing propulsive work during a measured large-slip terminal approach without coasting
nontransferable_details: published gains, dimensional beat frequencies, species-specific amplitude envelopes, full-body oscillator networks, prescribed approach stages, exact vortex phases, capture radius, and task-specific routes
policy_translation: reconstruct normalized head-course error from `distance_L`, `closing_speed_L`, `turn_rate_recent`, and `bearing_window_rate`; use smooth distance, closing, and slip gates to reduce only posterior carrier acceleration before the inherited reserve and safety layers
falsification: reject if the broad route changes, capture or alternating three-dimensional shedding is lost, terminal head-course error does not fall, arrival or distance integral regresses, or joint and load bounds worsen relative to the replicated parent
```

No formal CFD is run in this worker. The candidate's rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Replaying the new observation and relief gates over all 3,079 states of the
replicated parent changes 222 samples, beginning at `15.718T/2.243L` and
ending at capture. The gate is zero over the entire broad route, averages
`0.457` while active, and reaches one; the carrier scale therefore remains in
`[0.85,1.0]`. The largest pre-allocation carrier change is
`18.432 rad/T^2`, after which the inherited reserve allocator, soft envelope,
speed guards, transfer rules, and stopping projection still apply. This
establishes a localized and behaviorally non-inert mechanism; it does not
predict the coupled body or fluid outcome.
