# Phase-coordinate half-cycle timing candidate

## Evidence diagnosis before the edit

- I read the assigned-parent guidance, all four sampled solver artifacts, the
  inherited optimizer notes, and the combined keyframe sheets before changing
  the policy. Every sampled rollout reports direct uniform still water at
  `U_infinity=(0,0,0)`, no cylinders or prewarm, 236 moving-window shifts, and
  capture. The assigned v33 parent captures at `23.842522T` with score
  `-0.535091` and final distance `0.746165L`. The v34 sample and two
  independently written split-observer samples have bit-identical trajectories
  and combined-sheet hashes: all capture at `23.837021T`, score `-0.535013`,
  and finish at `0.746096L`. Thus the distributed rate is useful only in its
  already sampled phase-classification scope; three repeated trajectories are
  not evidence for more observer gain or another algebraic rewrite.
- Both visual rows show the fish leaving an initially empty field under its own
  joint motion, following the same broad target-directed arc, and retaining an
  orderly alternating mid-plane vortex street plus compact three-dimensional
  Lambda2 structures through the terminal bend. There is no passive advection,
  wake collapse, boundary encounter, or instability. The v33 and split-
  observer differences are below image resolution, so trajectory/load evidence
  sets the next control hypothesis while the coherent carrier is preserved.
- Relative to v33, the repeated split observer narrowly improves inside-`3L`
  mean absolute yaw (`1.67999` to `1.67938 rad/T`), target-cross-track speed
  (`0.23924` to `0.23868U`), and peak absolute moment (`0.013730` to
  `0.013581`), but raises peak yaw (`3.18484` to `3.19386 rad/T`). Joint-speed
  exposure and smoothly projected acceleration peaks remain unchanged. This is
  a mixed terminal regulation result, not evidence that propulsion or command
  feasibility needs revision.
- The completed inherited half-cycle envelope-relief child is the informative
  mechanism failure. Its two visual rows preserve the same coherent capture
  topology, and it reaches the capture sample at the same `23.837021T`; however,
  score/final distance regress to `-0.535880`/`0.746981L`. Peak yaw falls to
  `3.18039 rad/T`, but peak moment rises to `0.013804`. Therefore changing the
  energy envelope on the selected beat side trades one terminal symptom for
  progress/load and should not be repeated.
- An offline observation audit of the repeated split trajectory supplies the
  scale and sign for a distinct timing test. Inside `3L`, the existing signed
  anterior correction selected by displacement-only tail side correlates
  `+0.165` with instantaneous yaw and `+0.059` with yaw `0.04T` later. Replacing
  only the side classifier by the amplitude-normalized coordinate
  `(tail_tangent - 0.50*tail_tangent_rate/omega)/sqrt(1+0.50^2)` changes those
  correlations to `-0.072` and `-0.204`, while changing mean gate weight only
  from `0.0186` to `0.0202`. This counterfactual audit motivates controller
  timing; it is not a claim of closed-loop improvement.

## Single candidate hypothesis

Retain the sampled split observer's normalized body-frame route feedback,
anterior-only continuous course brake, distributed-rate excess-yaw
classification, anterior counter-curvature magnitude, posterior traveling-wave
lag/amplitude, cadence, and smooth component-wise command projection. Change
only the joint-state phase coordinate that decides when the anterior
counter-curvature is applied: combine full-tail displacement with normalized
full-tail rate, and amplitude-normalize the combination before the existing
bounded `tanh` side map. This creates a clock-free phase-lagged classifier
rather than adding steering authority or modifying the propulsive envelope.

The expected effect is to move the existing small correction onto a beat
interval that opposes developing yaw instead of reinforcing it, reducing the
split observer's peak-yaw defect without reproducing the envelope-relief
progress/load trade. Falsify the candidate if formal CFD loses capture or the
coherent alternating wake; worsens split-observer-scale arrival, score, or
mean/final distance; raises terminal yaw, cross-track speed, moment, or
actuator-limit exposure; or merely changes offline correlation without a
physical terminal benefit.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and closed-loop phase modulation
source_mechanism: select a bounded turning residual by oscillator phase while preserving the thrust-producing traveling wave
transferable_invariant: represent beat phase with joint displacement and rate, then alter only the phase support of a small corrective residual rather than the carrier amplitude or mean route command
nontransferable_details: published gains, clocked CPG phase, dimensional cadence, species-specific envelopes, exact duty ratios, vortex phases, and task-specific routes
policy_translation: form an amplitude-normalized full-tail displacement-rate phase coordinate from the two observed joints and use it only in the existing terminal anterior half-cycle gate; preserve body-frame route feedback and posterior wave geometry
falsification: reject unless CFD preserves split-observer capture and wake coherence while improving the peak-yaw/load balance without worse distance progress, cross-track motion, or actuator exposure
