# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent and all three sampled comparisons satisfy the frozen
  experiment contract: direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, and inertial moving-window
  transport. All four capture without angle, rate, or applied-acceleration
  contact. The assigned force-qualified parent reaches `0.748308L` at
  `25.8115T`, with mean distance `2.496011L` and peak planar force/yaw moment
  `0.01896/0.01010`.
- I inspected every combined keyframe sheet from release through capture in
  both the top-down mid-plane vorticity/body row and the oblique body/Lambda2
  row. Every fish visibly self-propels, sheds an orderly alternating wake, and
  retains compact three-dimensional vortices through a shallow target-side
  hook. There is no imposed advection, boundary interaction, wake breakup,
  numerical instability, or moving-window-induced rotation. The sheets
  support retaining the traveling-bend carrier; they do not support more
  oscillator drive or another terminal pulse.
- The sampled upstream anterior duty-ratio descendant is the only semantic
  trajectory improvement in this batch. Relative to the assigned parent, it
  lowers mean distance from `2.496011L` to `2.457773L`, improves score from
  `-0.594050` to `-0.556475`, and captures `0.3025T` sooner at `25.5090T`.
  At `8T`, distance/course error/projected miss improve from
  `10.4307L/0.7529/7.8534L` to `10.3083L/0.6454/6.6526L`. Thus changing
  half-cycle residence is supported where prior additive middle residuals
  merely preserved one route family.
- That improvement is not evidence for scalar-strengthening the anterior duty
  term. Its course error rebounds above the parent at `16T`
  (`0.6672` versus `0.5253`) and `20T` (`0.8205` versus `0.7296`), while peak
  planar force/yaw moment rise to `0.02063/0.01065`, maximum joint angle rises
  from `0.76352` to `0.77093 rad`, and maximum requested acceleration rises
  from `29.6581` to `29.8680 rad/T^2`. Both visual rows still end in the same
  shallow hook. The evidence supports retaining the new anterior residence
  mechanism while testing whether its asymmetry is transmitted through the
  posterior traveling wave, not increasing its gain or extending a distance
  threshold.
- The other sampled force-, moment-, and response-yield variants remain
  byte-identical to the parent through the upstream corridor and capture in
  `25.8115--25.9160T` with mean distance `2.4960--2.4969L`. Their unchanged
  visual topology and inherited negative logs keep the middle load-residual,
  instantaneous sideslip, arbitration, and terminal-waveform branches closed.

## Policy hypothesis

Start from the evidenced anterior duty-ratio descendant and add one small
compatible actuator-allocation mechanism. While the same normalized
body-frame course-slip, closing-response, distance, and redirect-release gates
are active, give joint 2 a weaker opposite-side duty change: joint 1 dwells on
the requested bend side while joint 2 dwells on the opposing bend side. Joint
angles supply phase, and the posterior addition is suppressed as joint-2 angle
headroom closes. This preserves an alternating S-shaped traveling bend rather
than adding shared mean curvature, a clock phase, or a global route.

The falsifiable expectation is to retain the sampled descendant's early
separation and capture while reducing its `16--24T` course rebound or projected
miss through better posterior reactive-thrust alignment. Reject the mechanism
if `8T` progress is erased, arrival is slower than `25.5090T`, capture or wake
coherence is lost, the terminal hook is unchanged without a trajectory-metric
gain, any actuator contact appears, or peak planar force/yaw moment materially
exceeds `0.02063/0.01065`.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish CPG steering
source_mechanism: retain a directed anterior-to-posterior traveling bend while applying target-conditioned asymmetric half-cycle residence
transferable_invariant: steering residence should propagate through a phase-separated posterior response so lateral tail momentum redirects thrust without replacing the propulsive rhythm with shared static curvature
nontransferable_details: published gains, dimensional frequencies, species envelopes, full-body waveforms, robot linkage geometry, clock phase, exact vortex phase, and task-specific routes
policy_translation: normalized body-frame course-slip and closing response gate joint-angle-derived duty changes of opposite bend side in the two joints; posterior authority is smaller and fades with its angle headroom
falsification: reject on erased early separation, unchanged or worse middle projected miss, slower or lost capture, incoherent three-dimensional wake, actuator contact, or loads above the sampled anterior-duty regime

## Non-CFD audit after the policy edit

- All 66 direct `params.FIELD` references are owned by the returned 66-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations, and the candidate remained non-empty throughout the edit.
- A deterministic 17,496-state grid spanning both lateral reflections,
  negative/zero/positive closing response, zero and finite translation,
  helpful/adverse loads, and beyond-limit joint angles and rates remains finite
  and inside the `30 rad/T^2` policy envelope. Paired reflected commands have
  zero numerical error.
- Re-evaluating the sampled anterior-duty policy and this candidate on all
  4,638 reconstructed duty-policy trace states changes 1,042 post-guard command
  pairs, including 611 by more than `0.05 rad/T^2`; maximum separation is
  `1.17349 rad/T^2`. Every changed row remains outside the established
  `4.5L` middle boundary, and the maximum frozen-state command is unchanged at
  `29.86795 rad/T^2`. This establishes a material, bounded posterior
  allocation test, not CFD evidence of improvement.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this ChatGPT account. Its three prescribed checks were run
  directly after removing a duplicated assigned-parent marker from the rendered
  `README.md`; material guidance, the Julia contract/schema, and the solver
  editable-boundary check all pass. No formal CFD was run.
