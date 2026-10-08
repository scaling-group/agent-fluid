# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent is `dogfish_3d_course_consensus_posterior_duty_ratio_v31`.
  Three sampled rollouts are byte-identical policy reruns and reproduce the same
  direct-uniform still-water capture at `18.0125T`, score `-0.064000`, mean
  distance `1.950346L`, and final distance `0.748395L`; they are determinism
  evidence, not three mechanisms. The inherited score logs from steps 28--35
  remain in the same capture class (`-0.064778` through `-0.064000`).
- Both the top-down and oblique rows were inspected for the parent and the only
  distinct sampled comparison, v26 slip-synchronous posterior feathering. In
  each view the fish self-propels from a quiescent release and retains a
  coherent alternating mid-plane street and compact paired 3D wake structures
  through capture. There is no visible advection artifact, prewarm wake, wake
  collapse, collision, or instability to repair.
- The policies are trajectory-identical until `15.9555T` (about `2.0L` from
  the target), so the evidence isolates the approach controller. Relative to
  v26, v31 improves score by only `0.000149` and mean score distance by
  `0.000123L`, but lengthens center path from `13.2064L` to `13.2149L`, widens
  maximum head cross-track from `0.7265L` to `0.7327L`, lowers final course
  alignment from `0.1728` to `0.1297`, raises final absolute yaw from `0.6545`
  to `0.8077 rad/T`, and raises near posterior acceleration-ceiling residence
  from `74.11%` to `75.89%`. The parent therefore preserves fast capture but
  still carries excessive oscillatory energy across the terminal circle.
- Sampled optimizer guidance additionally records that balanced slip duty,
  posterior phase reset, response-triggered extra mean-bend allocation,
  steering-headroom transfer, and a posterior phase-energy clamp all retained
  capture but regressed score and/or terminal state. Those negatives rule out
  another duty/sign, phase reset, short-window bearing, mean-share, headroom,
  or saturation-threshold variant.

## Policy hypothesis

Preserve v31 transit and steering exactly. Once normalized head distance enters
the established `2.10L` approach region, continuously lower the phase-plane
energy setpoint of the anterior state-feedback carrier. The schedule depends
only on normalized target distance, is exactly zero before approach, and does
not select a beat side. Posterior lag then inherits the reduced carrier
excursion without changing cadence, signed mean tangent, duty-ratio steering,
or reversal authority. Expected result: retain capture and the coherent wake
while reducing late path/cross-track, yaw, and posterior limit residence. Reject
the mechanism if capture is lost or materially delayed, observed closure or
score regresses materially, or terminal alignment/yaw and non-migrating joint
limit residence do not improve together.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture scheduling
source_mechanism: sensor-conditioned oscillator amplitude or energy envelope near a target
transferable_invariant: preserve the traveling-wave phase and cadence during transit, then continuously reduce carrier energy from normalized target-relative state when terminal excess motion dominates
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, Strouhal targets, exact wake phase, and task-specific routes
policy_translation: retain the body-frame v31 guidance and two-joint posterior lag; replace the fixed anterior phase-plane energy target of one with a bounded distance-scheduled target that is exactly one outside the approach region
falsification: reject if transit changes before 2.10L, capture or observed closure degrades materially, the two-view wake loses coherence, or alignment, yaw, path, and joint-limit residence fail to improve together
