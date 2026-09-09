# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The common prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting vortex streets. It is shared initial-condition
  evidence, not evidence for any candidate. No failed released sheet is
  available in the current sample, so failure-topology claims remain limited
  to inherited logs rather than a new visual comparison.
- Three sampled copies of the ungated posterior half-cycle policy reproduce the
  same compact diagonal, self-propelled route and target capture at `32.472`
  release time with `1.64761L` mean distance. The visible body-generated wake
  persists through the developed cylinder wakes, and the fish neither coasts
  with the inflow nor approaches a cylinder. Diagnostics show that this fast
  capture touches both joint velocity and acceleration ceilings and carries
  `68.70/931.60` force/moment RMS.
- The sampled response-gated extra burst retains capture but is worse on every
  relevant trade axis: `32.824` arrival, `1.66402L` mean distance, and
  `70.97/945.05` force/moment RMS. Its released sheet has a visibly wider late
  body wake. This supports the inherited warning against adding target-bearing
  trend to obtain more posterior authority.
- In the assigned parent's inherited logs, the posterior state-headroom gate
  repeats exactly across two completed evaluations. It retains the direct
  capture at `32.7305`, `1.64927L` mean distance, and nearly unchanged mean
  velocity/crossflow while reducing force RMS to `56.29`, moment RMS to
  `800.58`, and peak posterior angle from `0.5834` to `0.5684` rad relative to
  the ungated policy. Both joint speed and acceleration maxima still equal the
  hard limits, so the evidence supports lower aggregate loads but not reduced
  saturation residence. The headroom sheet shows the same productive diagonal
  trajectory without the response-gated candidate's enlarged late wake.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation interpreted through elongated-body posterior reactive propulsion
source_mechanism: regulate a turn-congruent posterior half-cycle using observed joint-state headroom while retaining the underlying lagged propulsive wave
transferable_invariant: sensor feedback may withdraw only an incremental rhythmic asymmetry when observed posterior motion already reinforces it near the gait's own speed or acceleration scale; the symmetric traveling wave and target-signed mean curvature remain available
nontransferable_details: published gains, duty ratios, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator allocations, and source-task routes
policy_translation: normalize posterior speed and prior applied posterior acceleration by oscillator-owned amplitude-frequency scales, detect reinforcement by command-motion sign agreement, and smoothly gate only the extra target-helping half-cycle gain
falsification: reject the gate if a repeat or held-out wake loses direct capture, arrival degrades materially beyond the observed 0.80 percent trade, the route topology changes adversely, or force and moment fail to retain a meaningful reduction relative to the ungated half-cycle controller

## Candidate hypothesis

Produce exactly one evidence-selected candidate by promoting the inherited,
twice-reproduced posterior state-headroom mechanism. Preserve the filtered
body-frame bearing, bounded total-curvature request, smooth anterior/posterior
allocation, anterior state-feedback oscillator, posterior lag, damping, and
maximum target-helping half-cycle asymmetry.

The gate uses only joint state and the previous applied posterior acceleration,
normalized by the policy's own gait scales. It continuously yields the optional
posterior amplification when motion already reinforces that increment, but it
cannot suppress the base traveling wave or mean target steering. The existing
CFD evidence supports a substantially lower-load direct capture with a small
arrival trade; the next rollout is a reproducibility test, not evidence of wake-
phase robustness or reduced saturation residence.
