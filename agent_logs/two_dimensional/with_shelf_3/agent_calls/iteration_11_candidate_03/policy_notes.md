# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the common held fish above and downstream of
  four developed, interacting vortex streets. It is identical across the
  sampled candidates and is only initial-condition evidence.
- All four sampled solver sheets show a self-propelled traveling bend, an
  immediate target-signed turn, a compact diagonal route clear of the
  cylinders, and capture on entering the merged second-row wake. Their
  byte-identical released sheets and metrics (`32.472` arrival, `1.64761L`
  mean distance, `68.70/931.60` force/moment RMS) establish deterministic
  fixed-snapshot reproduction of the ungated posterior half-cycle policy, not
  robustness to release phase.
- The assigned parent's actuator-headroom gate preserves that topology and
  capture. It changes arrival by only `0.80%` (`32.7305`) while lowering
  force RMS by `18.1%` (`56.29`), moment RMS by `14.1%` (`800.58`), and
  posterior peak excursion from `0.5834` to `0.5684 rad`. Both variants still
  touch the velocity and acceleration ceilings, so the aggregates do not prove
  shorter saturation residence.
- The ungated and headroom-gated captures see almost the same local/relative
  crossflow RMS (`0.29554/0.24511` versus `0.29506/0.24306`). Conversely, the
  inherited immediate downstream-exit failure saw only `0.045` relative
  crossflow. Crossflow magnitude therefore neither explains the successful
  route nor the load reduction. The inherited response-gated posterior burst
  also arrived later and raised loads. A flow-, force-, or response-driven
  extra burst is not supported by the available event-level evidence.
- No failed released keyframe is present in the current samples. Failure
  topology is therefore limited to inherited notes and metrics rather than a
  new visual comparison.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation interpreted with elongated-body posterior reactive propulsion
source_mechanism: retain a persistent traveling wave while sensor feedback regulates only an incremental turn-congruent posterior asymmetry
transferable_invariant: optional rhythmic steering should yield when normalized posterior state indicates little actuator headroom, while target-signed mean curvature and the unit-gain lagged wave remain continuously available
nontransferable_details: published gains, dimensional frequencies, duty ratios, species or robot kinematics, exact vortex phases, physical actuator ratings, and source-task routes
policy_translation: normalize posterior speed and the previous applied acceleration by oscillator-owned gait scales, infer directionally reinforcing state, and smoothly gate only the extra bearing-conditioned half-cycle gain
falsification: reject if a repeat or held-out wake loses the compact direct capture, arrival regresses materially beyond the observed 0.80 percent trade, or force and moment fail to remain meaningfully below the ungated benchmark

The wake-disturbance-residual shelf primitive was consulted but not adopted.
The current sheets show no repeated wake-induced yaw reversal or loss of the
target-directed route, and aggregate crossflow is nearly unchanged by the
successful load reduction. A scalar crossflow threshold would therefore be an
unevidenced gain edit rather than a mechanism-level transfer.

## Candidate hypothesis

Produce exactly one candidate by applying the completed posterior-state
headroom gate to the sampled ungated controller. Preserve the filtered
body-frame bearing, bounded `12 deg` total-curvature request, smooth
`40/60 -> 35/65` allocation, anterior state-feedback oscillator, posterior
lag and damping, and maximum `8%` target-helping half-cycle asymmetry.

The added mechanism uses posterior velocity and previous posterior
acceleration normalized by `amplitude * frequency` and
`amplitude * frequency^2`. It withdraws only the optional asymmetry when the
observed state already reinforces it near the gait envelope. The base lagged
wave and target-signed centers remain active, so the gate cannot command
coasting or cancel propulsion. The inherited rollout supports this
load/navigation trade; this worker does not claim a new CFD result.
