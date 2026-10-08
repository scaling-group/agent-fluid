# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The common prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. The released sheet for the
  assigned posterior-half-cycle controller shows immediate targetward
  redirection, a sustained body-generated traveling wake, and a compact
  diagonal crossing into the `0.75L` capture circle. The fish is self-propelled
  rather than passively advected, does not approach a cylinder, and enters the
  strongest merged wake only on its final target approach.
- All four current solver samples reach the target with identical metrics and
  byte-identical released sheets: capture at `32.472`, mean distance
  `1.64761L`, score `0.224538`, lateral-force RMS `68.70`, and yaw-moment RMS
  `931.60`. Their different source hashes do not make them independent wake
  conditions; they establish deterministic fixed-snapshot reproducibility of
  the direct route and its load cost.
- The inherited headroom-gated rollout preserves the same visible trajectory
  topology and capture while moving arrival only from `32.472` to `32.7305`
  (`0.80%`) and mean distance from `1.64761L` to `1.64927L`. In exchange it
  lowers lateral-force RMS from `68.70` to `56.29` (`18.1%`), yaw-moment RMS
  from `931.60` to `800.58` (`14.1%`), mean command energy from `1425.46` to
  `1419.87`, mean power proxy from `109.19` to `108.54`, and posterior peak
  excursion from `0.5834` to `0.5684 rad`. This is a useful load/navigation
  trade rather than propulsion collapse: it still arrives `2.33` time units
  before the low-load symmetric-half-cycle parent (`35.0625`).
- The competing response-gated extra burst is an informative negative result.
  It arrives later at `32.824`, raises mean distance to `1.66402L`, and raises
  force/moment RMS to `70.97/945.05`; its released sheet also shows a visibly
  wider late body wake. Do not add target-bearing trend to increase posterior
  authority. The parent guidance's downstream-exit result further bounds this:
  an unrestricted signed bearing-rate path upstream of oscillator centers
  erased the traveling bend, so the selected gate acts only on the optional
  posterior increment.
- No failed released keyframe is present in the current sampled set. Failure-
  topology claims above therefore remain limited to the assigned parent's
  inherited metrics and diagnosis rather than being treated as a new visual
  comparison.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation interpreted through elongated-body posterior reactive propulsion
source_mechanism: regulate a turn-congruent posterior half-cycle using observed joint-state headroom while retaining the underlying lagged propulsive wave
transferable_invariant: sensor feedback may release only an incremental rhythmic asymmetry when posterior motion already reinforces it at a large fraction of the gait's own speed or acceleration scale; target-signed mean curvature and the symmetric traveling wave remain available
nontransferable_details: published gains, duty ratios, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator allocations, and source-task routes
policy_translation: normalize posterior speed and prior applied acceleration by oscillator-owned gait scales, infer whether either is aligned with the proposed posterior-wave increment, and smoothly gate only the extra bearing-conditioned half-cycle gain
falsification: reject the gate if a repeat or held-out wake loses direct capture, arrival degrades materially beyond the observed 0.80 percent trade, or force and moment do not retain a meaningful reduction relative to the ungated half-cycle controller

## Candidate hypothesis

Produce exactly one evidence-selected candidate by promoting the completed
posterior-state headroom gate. Preserve the assigned controller's filtered
body-frame bearing, bounded `12 deg` mean-curvature request, smooth
`40/60 -> 35/65` allocation, anterior state-feedback oscillator, posterior
lag, damping, and `8%` maximum target-helping half-cycle asymmetry.

The selected mechanism normalizes posterior speed and the previous applied
posterior acceleration by `amplitude * frequency` and `amplitude * frequency^2`.
It withdraws only the incremental half-cycle amplification when either state
already reinforces that increment near the gait-scale envelope. The symmetric
traveling wave is the lower bound, so propulsion and mean steering cannot be
cancelled by the gate. The inherited rollout already supports direct capture
with substantially lower aggregate loads; downstream evaluation must test
reproducibility and must not be interpreted as wake-phase robustness or proof
of reduced saturation residence because both joints still touch their hard
velocity and acceleration limits.
