# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no prewarm) and terminate in capture at
  `0.7466--0.7494L` after `18.20--18.75T`. Two are exact-policy samples of the
  intercept-guarded speed-reserve baseline, one uses the posterior wave-shape
  pulse in the prefill, and one uses unsafe-terminal anterior steering
  transfer. Thus four sampled captures are not four independent confirmations
  of one new mechanism.
- In the highest-score baseline capture (`solver_6b0e320e2f55`) and the
  lowest-score baseline capture (`solver_2d0a4a628957`), the top-down rows show
  sustained alternating signed vortices from release through capture. The
  oblique rows show a continuous bilateral Lambda2 wake and continuing body
  undulation at the terminal frame. The fish is self-propelled rather than
  advected: the initialized water is stationary, while inertial fish speed is
  about `0.89--0.91L/T` at the first `3L` crossing. Neither view shows wake
  collapse, collision, or instability. The remaining posterior-pulse and
  anterior-transfer sheets have the same qualitative active-wake topology.
- Trace checks agree with the images but show no actuator benefit from the
  sampled variants. Across all four captures, head/tail action clamp fractions
  remain about `68.2--68.8% / 70.6--70.9%`, exact speed-limit residence about
  `10.4--10.7% / 11.3--11.6%`, maximum planar force coefficients about
  `0.015 / 0.030`, and maximum yaw-moment coefficient about `0.0167`. The
  anterior-transfer capture is later (`18.7495T`) than both sampled baseline
  captures (`18.3205T`, `18.6010T`), and the posterior pulse already has a
  `2/3` inherited exact-policy record after its lower-exit repeat.
- No sampled keyframe sheet is a failure. The informative failure topology is
  therefore taken only from inherited guidance and parent logs, not claimed as
  a new visual observation: the assigned parent's completed step-30 and
  step-31 policies exit the lower boundary after minima `1.5629L` and
  `1.8544L`, and inherited exact-baseline failures retain coherent propulsion
  but show an outer-terminal target/course disagreement. At the first `3L`
  crossing, sampled baseline captures have negative target bearing and
  same-signed course error, whereas an inherited baseline failure has target
  bearing near `+0.171 rad` and course error near `-0.008 rad` before projected
  miss opens.

## Policy hypothesis

Restore the exact intercept-guarded speed-reserve carrier and steering
allocation, removing the falsified posterior wave-shape pulse. Add one bounded
outer-terminal target-bearing qualifier to the existing achieved-course route
error. The qualifier extracts only the part of signed body-frame target
bearing not already supported by a same-signed achieved-course error. It is
zero outside the existing terminal-response region, fades to zero through the
existing inner intercept gate, and cannot change the traveling-bend carrier,
joint allocation, or inner release geometry. This should supply a small
correct-sign curvature request for the inherited `bearing != 0` / near-zero
course-error branch without perturbing sampled passes whose course error
already supports the target side.

Falsify the candidate if it changes far-field closure, weakens either wake
view, loses repeated capture, retains the lower-pass topology, or moves action
clipping, speed residence, planar loads, or yaw moment outside the sampled
speed-reserve envelope. A single threshold capture is not confirmation.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking over a rhythmic CPG carrier
source_mechanism: target-vector-to-bounded-curvature feedback layered on, rather than substituted for, the propulsive oscillator
transferable_invariant: a persistent target-side cue should remain available when achieved-course error alone is momentarily uninformative, while propulsion stays with the traveling bend
nontransferable_details: published gains, CPG phase equations, robot morphology, dimensional cadence, route geometry, and exact terminal timing
policy_translation: add a bounded reflection-equivariant unsupported-bearing residual from normalized body-frame target and velocity geometry only in the outer terminal annulus; preserve the existing two-joint carrier, allocation, and inner intercept guard
falsification: reject if exact repeats do not improve semantic capture reliability or if far-field closure, coherent top-down/oblique wakes, actuator use, force, or moment leaves the repeat-backed baseline envelope
```

## Dry checks after editing

- The course-error gate is fully active below `0.03 rad` and off by `0.10 rad`.
  Those bounds separate the inherited `-0.008 rad` disagreement signature from
  the sampled baseline capture errors (`-0.128` and `-0.318 rad`) at their
  first `3L` crossings; they are evidence-derived controller parameters, not
  bookshelf gains.
- Counterfactual replay on the four recorded traces leaves every sampled first
  `3L` and `2.75L` crossing route command unchanged and activates on only
  `1.62--1.98%` of all recorded rows. This is a locality check, not a predicted
  closed-loop outcome.
- A direct Julia contract probe for the inherited disagreement signature moves
  route error from `-0.0075` to `+0.0392`, is exactly baseline-equivalent at
  `5L` and inside the `1.5L` capture corridor, returns finite actions, and
  produces sign-mirrored actions under a reflected observation. No CFD was
  run; formal evaluation remains future evidence.
