# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is the common initial condition,
  not evidence for any candidate-specific wake phase. All four sampled released
  sheets show self-propelled targetward rotation followed by a compact diagonal
  crossing and direct first entry into the `0.75L` capture circle; none supplies
  a current collision, domain-exit, instability, or near-miss topology.
- The assigned parent is the strongest sampled controller. Relative to the
  symmetric bearing-scheduled posterior-allocation policy, its state-inferred
  one-sided posterior half-cycle gain improves capture from `35.0625` to
  `32.472` released time, mean distance from `1.73388L` to `1.64761L`, and score
  from `0.140088` to `0.224538`. Total command energy falls from `50,175` to
  `46,288` because the episode is shorter, while mean command energy and mean
  power remain similar (`1431.01 -> 1425.46` and `109.66 -> 109.19`). The
  released sheet preserves the direct route and shows the earlier redirect,
  so the half-cycle response is a positive navigation mechanism rather than a
  scalar-only improvement.
- The gain also raises lateral-force RMS from `56.57` to `68.70` and moment RMS
  from `793.76` to `931.60`, about `21%` and `17%`. A distinct sampled controller
  that phase-modulates only the fixed curvature allocation reaches later at
  `35.431` and `1.75151L` mean distance but lowers force/moment RMS to
  `50.01/741.22`. Thus current evidence supports half-cycle asymmetry for rapid
  navigation but does not support unbounded one-sided wave amplification or an
  efficiency claim.
- The inherited additive bearing-trend failure remains a boundary rather than
  a current visual comparison: its logged rollout collapsed the traveling bend,
  moved downstream, and exited at `16.956` with only `0.140/0.163 rad` joint
  excursions and a `12.424L` closest approach. This candidate preserves the
  filtered bearing, oscillator, posterior lag, and state-inferred phase, and
  adds no route derivative or uncalibrated flow/load cancellation.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping, interpreted through elongated-body posterior reactive propulsion
source_mechanism: create a turning moment by strengthening the target-helping half-cycle while complementarily weakening the opposing half-cycle around the unchanged propulsive wave
transferable_invariant: observed joint phase and persistent body-frame turn demand can impose bounded, approximately cycle-balanced posterior amplitude asymmetry without adding an external clock or increasing both half-cycles
nontransferable_details: published gains, duty ratios, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator limits, and source-task routes
policy_translation: preserve the completed filtered-bearing curvature schedule and posterior traveling wave, then replace one-sided posterior amplification with equal-and-opposite bounded gain on the two state-inferred half-cycles using the inherited evidenced `0.08` envelope
falsification: reject the balanced asymmetry if target capture is lost or later than `32.472`, mean distance exceeds `1.64761L`, the direct diagonal route changes adversely, or force/moment RMS do not fall from `68.70/931.60`; also reject it if weaker opposing motion collapses propulsion despite lower loads

## Candidate hypothesis

Produce exactly one candidate by refining the completed posterior half-cycle
mechanism, not by changing its scalar envelope. The parent multiplies the
target-helping posterior wave by as much as `1.08` but leaves the opposing
half-cycle at `1.00`. The candidate instead uses a smooth signed phase gate so
the two extremes are `1.08` and `0.92`, with the modulation shrinking
continuously to zero as filtered body-frame bearing aligns. This retains the
same maximum helpful impulse while removing the positive cycle-average gain
that is the most direct unevaluated explanation for the higher force and moment
loads.

The `0.55`-period, `28 deg` state-feedback oscillator, circular bearing filter,
bounded `12 deg` total curvature, smooth `40/60 -> 35/65` allocation, posterior
lag, damping, and transition width remain unchanged. The expected evaluation is
the same compact target capture with lower loads and no loss of arrival time;
the new balanced response is unevaluated, and no same-worker CFD result is
claimed.
