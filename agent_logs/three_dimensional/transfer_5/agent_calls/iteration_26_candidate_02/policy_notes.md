# Candidate wake-policy notes

## Evidence diagnosis

- The assigned parent (`solver_2546ece173ab`, v33) and the best sampled
  role-separated observer (`solver_3cb46b9057a1`, duplicated exactly by
  `solver_8ae803ceeb4c` and `solver_f5ac4c378d79`) are all direct-uniform
  still-water captures. No sampled rollout is a failure, so the most
  informative contrast is the assigned parent rather than an invented failure
  case.
- Both combined keyframe sheets show self-propelled target approach with a
  coherent alternating mid-plane wake and compact three-dimensional Lambda2
  structures. The trajectory bends smoothly onto the target and does not show
  advection, wake breakup, boundary contact, or a terminal instability. The
  sampled observer sheet is visually indistinguishable from the parent, so the
  image evidence supports preserving the carrier rather than changing gait,
  cadence, or posterior lag.
- v33 captured at `23.84252T`, with score `-0.535091`, mean/final distance
  `2.433543/0.746165L`, and inside-`3L` mean/peak absolute yaw
  `1.67999/3.18484 rad/T`. Its inside-`3L` peak moment was `0.013730`.
  The role-separated distributed-rate observer captured at `23.83702T`, with
  score `-0.535013`, mean/final distance `2.433468/0.746096L`, and inside-`3L`
  mean/peak yaw `1.67938/3.19386 rad/T`; peak moment fell narrowly to
  `0.013581`. Joint-speed and smooth-command peaks were unchanged. Thus the
  distributed cue is a narrowly useful phase classifier, not evidence for
  feeding it into the continuous course brake or increasing its gain.
- The remaining defect is mixed: the sampled observer retains capture and
  slightly improves progress and peak moment, but it does not suppress peak
  terminal yaw. Repeated static allocation, posterior damping, moment lead,
  and stronger posterior counter-tangent variants already regressed progress
  or loads in inherited evidence. The next test should therefore alter only
  the energy injected on the yaw-supporting anterior half-cycle, leaving route
  feedback and posterior traveling-wave geometry untouched.

## Policy hypothesis

Use the sampled split observer as the baseline. Keep its anterior-only
carrier rejection for continuous target-course curvature and its distributed
two-joint tangent-rate residual for phase classification. When that residual
and observed tail side identify the half-cycle supporting excess terminal yaw,
continuously reduce the anterior oscillator envelope by at most a small bounded
fraction. This is half-cycle envelope shaping, not a cadence or global gain
retune. It should trim the peak-yaw/load-producing impulse without suppressing
the opposite half-cycle or disturbing posterior lag.

Falsify the hypothesis if CFD loses capture, worsens split-observer-scale
arrival or mean/final distance materially, disrupts the coherent alternating
wake, increases joint/command limit exposure, or fails to improve the mixed
terminal yaw/moment balance. In particular, offline carrier decorrelation or a
smaller commanded anterior amplitude is not itself success.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: state-conditioned half-cycle envelope shaping around a propulsive rhythm
transferable_invariant: alter only the beat side that supports unwanted turning while retaining the opposite half-cycle and the traveling-wave carrier
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, exact duty ratios, and task-specific paths
policy_translation: use normalized terminal distance/speed gates, distributed body-intrinsic joint-rate yaw residual, and observed tail-tangent side to apply bounded anterior oscillator-envelope relief; preserve anterior course curvature and posterior lag
falsification: reject if capture/progress or wake coherence regresses, actuator exposure rises, or peak yaw and moment do not improve together enough to justify the added mechanism
