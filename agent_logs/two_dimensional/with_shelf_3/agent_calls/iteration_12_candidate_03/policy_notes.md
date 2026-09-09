# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the certified held fish above and downstream
  of four developed, interacting vortex streets. It is common initial-state
  evidence, not evidence that a policy selected a favorable wake.
- All four sampled solver examples are semantically equivalent ungated
  posterior-half-cycle controllers. Their released sheets show immediate
  targetward rotation, a persistent body-generated traveling wake, clear
  cylinder separation, and one compact diagonal crossing into the `0.75L`
  capture circle. They reproduce target capture at `32.472` release time,
  `1.64761L` mean distance, and `68.70/931.60` force/moment RMS. Head motion
  `(-10.912,-4.332)L` against mean local flow `(-0.197,-0.189)` is consistent
  with self-propulsion rather than passive advection. Exact repeats at one
  fixed prewarm snapshot are not wake-phase robustness.
- Six unique inherited evaluations from completed iterations reproduce the
  direction-selective speed/previous-acceleration headroom gate at exactly
  `32.7305` arrival, `1.64927L` mean distance, and `56.29/800.58` force/moment
  RMS. Relative to the ungated benchmark, the same direct topology trades a
  `0.80%` arrival delay for `18.1%` lower force RMS and `14.1%` lower moment
  RMS. Both policies still touch both joint velocity and acceleration limits,
  and mean command energy changes by only about `0.4%`; the aggregates do not
  show whether the gate reduced saturation residence or merely changed the
  posterior tracking trajectory.
- The most informative inherited negative results are the response-triggered
  extra posterior burst (`32.824`, `1.66402L`, `70.97/945.05` loads) and the
  physical-limit blanket gate (`33.9405`, `1.69143L`). Unrestricted bearing-
  trend feedback and anterior-heavy recentering instead destroyed propulsion
  and exited downstream. No terminal-failure keyframe is present in the
  current samples, so those failure topologies are inherited metrics and notes,
  not new visual claims.
- Benchmark and headroom-gated keyframes show no repeated route loss or yaw
  reversal tied to wake events, while their relative-crossflow RMS is nearly
  unchanged (`0.24511` versus `0.24306`). Flow/force cancellation, a wake-
  response burst, and scalar crossflow gating are therefore not supported.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation interpreted through elongated-body posterior reactive propulsion
source_mechanism: preserve a persistent traveling base rhythm while joint-state feedback regulates only an incremental turn-congruent posterior asymmetry
transferable_invariant: optional rhythmic steering should yield when the posterior joint is already incoherent with its base lagged target in the same direction as the proposed residual, while target-signed mean curvature and the unit-gain traveling wave remain continuously available
nontransferable_details: published gains, dimensional frequencies, duty ratios, species or robot kinematics, exact vortex phases, physical actuator ratings, and source-task routes
policy_translation: normalize posterior base-target tracking error by oscillator amplitude, detect whether that error and the optional half-cycle increment reinforce one another, and smoothly gate only the increment
falsification: reject if direct target capture or the compact diagonal topology is lost, arrival is materially later than the inherited `32.7305` headroom trade, or force and moment do not fall meaningfully below the `68.70/931.60` ungated benchmark

The wake-disturbance residual and approach-hold primitives were consulted but
not adopted. Current evidence shows neither event-linked route loss nor a near
miss after first target entry, so either would add an unevidenced observation
path. Published numerical settings were not transferred.

## Candidate hypothesis

Produce exactly one candidate by preserving the sampled filtered body-frame
bearing, bounded `12 deg` total-curvature request, bearing-conditioned
`40/60 -> 35/65` allocation, anterior state-feedback oscillator, posterior
lag and damping, and maximum `8%` target-helping half-cycle residual. Add one
new mechanism: compute the unit-gain posterior target first, normalize its
tracking error by gait amplitude, and attenuate only the optional residual
when tracking error and residual request have the same sign at substantial
gait-scale magnitude.

Unlike the inherited speed/action headroom gate, this test observes coherence
with the base traveling-wave target directly. When the posterior joint is
caught up or the residual would reduce base tracking error, the sampled
ungated controller is recovered. At full attenuation, the unit-gain lagged
wave and both target-signed centers remain intact, so the gate cannot command
coasting or erase propulsion. The downstream CFD evaluation must establish
the navigation/load trade; this worker does not claim a same-worker rollout.
