# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. This is a common initial
  condition, not candidate-specific evidence. All four sampled released sheets
  show an immediate targetward redirect, a body-generated posterior traveling
  wave, a compact diagonal wake crossing, and direct first entry into the
  `0.75L` capture circle. No sampled sheet shows passive downstream advection,
  collision approach, terminal overshoot, or wake-driven turn reversal.
- Two samples are deterministic replays of the assigned bearing-conditioned
  curvature-allocation parent: both capture at `35.0625` released time with
  `1.73388L` mean distance, `50,175` total command energy, `56.57` lateral-force
  RMS, and `793.76` moment RMS. These duplicates establish repeatability for the
  common wake snapshot rather than independent mechanisms.
- The strongest distinct sample preserves the parent's filtered bearing,
  bounded `12 deg` total curvature, smooth `40/60 -> 35/65` curvature
  allocation, and anterior state-feedback oscillator. It changes the posterior
  wave only: current joint state identifies the turn-helping half-cycle and
  smoothly strengthens it by at most `8%` while target-bearing error persists.
  It retains the direct visual trajectory while improving capture to `32.472`,
  mean distance to `1.64761L`, and score from `0.140088` to `0.224538`.
- The improvement is not actuator headroom or load relief. Both the parent and
  half-cycle policy touch the `260 deg/time` joint-speed and `1800 deg/time^2`
  acceleration envelopes. The shorter rollout lowers total command energy to
  `46,288`, but mean command energy and power are nearly unchanged
  (`1425.46` and `109.19` versus `1431.01` and `109.66`), while force RMS rises
  from `56.57` to `68.70` and moment RMS from `793.76` to `931.60`.
- A second half-cycle implementation modulates curvature allocation instead of
  posterior wave amplitude. It also captures, but later than the parent at
  `35.431`, with `1.75151L` mean distance and score `0.122481`; its lower
  `50.01/741.22` force/moment RMS therefore does not make the two phase-based
  mechanisms interchangeable. The current objective and evidence favor the
  faster posterior-wave asymmetry while requiring that its load cost remain an
  explicit falsification boundary.
- No failed rollout is present among the current four sampled solvers. The most
  informative failure in the inherited optimizer notes is the additive
  bearing-trend candidate: it failed to develop the traveling bend, moved
  downstream, made negative progress, and exited at `16.956`, with only
  `0.140/0.163 rad` peak joint excursions and `12.424L` closest approach. The
  selected candidate therefore adds no route derivative, crossflow, force, or
  moment path upstream of the oscillator centers.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping, interpreted through elongated-body posterior reactive propulsion
source_mechanism: apply a small turn-congruent half-cycle asymmetry to a posteriorly lagged traveling wave while persistent target geometry owns the mean turn
transferable_invariant: infer rhythmic side from current joint state and continuously gate bounded asymmetry by normalized body-frame direction error so it vanishes at alignment without replacing the traveling wave
nontransferable_details: published gains, duty ratios, dimensional frequencies, species-specific kinematics, exact vortex phases, actuator shares, and source-task routes
policy_translation: promote the completed sampled controller that retains filtered body-frame bearing and shared bounded curvature, derives posterior wave phase from anterior angle and velocity, and strengthens only the target-helping posterior half-cycle by an owned bounded factor
falsification: reject or reduce this mechanism if a repeated or held-out wake loses capture or the direct diagonal topology, capture is not earlier than `35.0625`, mean distance is not below `1.73388L`, or higher force, moment, or saturation residence outweighs the navigation gain

## Candidate hypothesis

Produce exactly one evidence-selected candidate by promoting the completed
posterior-wave half-cycle controller. This is a structural selection, not a new
gain extrapolation. The candidate keeps the parent's `0.55`-period, `28 deg`
state-feedback oscillator, bearing-history filter, bounded mean-curvature
request, bearing-conditioned allocation, posterior lag, and damping. The only
additional mechanism is the sampled `8%` maximum state-inferred amplification
of the turn-helping posterior half-cycle, continuously gated to recover the
parent wave at zero bearing.

The downstream evaluation should reproduce the compact direct capture near
`32.47` released time and `1.648L` mean distance. Its higher lateral-force and
yaw-moment RMS are accepted only as an evidenced arrival/load tradeoff, not an
efficiency or robustness claim. The current worker does not claim a new CFD
result; later evaluation must test this materialized candidate.
