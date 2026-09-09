# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts report `uniform_direct`, direct quiescent
  initialization with `U_infinity=[0,0,0]`, no prewarm snapshot, and no
  cylinders; the evidence is valid for this still-water experiment.
- In both top-down vorticity and oblique Lambda2 rows, the two capture policies
  remain visibly self-propelled on a compact, alternating, body-connected wake
  and follow a direct targetward track through termination near `16T`. The
  prefilled full-circle policy remains propulsive but turns too late, passes
  high, sheds a wider separated wake during the redirect, and exits at
  `20.03T`; the continuous-drive hold failure develops an even larger loop and
  exits at `24.52T`. These visual diagnoses agree with closest/final distances
  of `4.650/5.706L` and `2.703/7.056L`, respectively.
- The sampled constant-course predicted-miss policy captured at `16.0105T`
  with `0.7477L` final distance. Adding carrier-separated yaw response gating
  and a posterior mid-stroke pulse retained capture at `15.9830T` with
  `0.7500L`, improved score slightly from `-0.02805` to `-0.02444`, and reduced
  terminal measured yaw rate from `1.642` to `0.694 rad/T`; force and moment
  coefficients remained small. Because both changes entered together, the
  evidence does not identify which one preserved or improved the pass.
- The assigned parent logs contain two recent noncaptures (`1.120L` and
  `0.939L` closest approaches, both followed by left-domain exits), while the
  sampled step-15 child captured. Semantic success therefore dominates another
  scalar or latent-signal cleanup of the failed full-circle prefill.

## Policy hypothesis

Use the captured constant-course predicted-miss controller as the carrier and
terminal geometry baseline. Keep its bounded terminal mean curvature, but fade
the overlapping half-cycle steering channel only after carrier-separated yaw
shows a corrective response. Omit the posterior pulse to isolate response-gated
authority as one controller mechanism. The expected result is capture with the
compact alternating wake and low loads of the sampled successes, while avoiding
premature loss of rhythmic steering during terminal interception.

Reject the mechanism if it loses capture, materially delays arrival, widens the
terminal miss, raises joint-limit occupancy or loads, or replaces the compact
body-connected wake with the wide-loop topology of the two failures. A capture
alone cannot attribute the prior score increment to response gating; comparison
with the pulse-bearing sample is the intended ablation.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and asymmetric-flapping turn control
source_mechanism: sensor feedback modulates the steering share of an ongoing propulsive rhythm after directional response appears
transferable_invariant: preserve a productive traveling bend and gate overlapping turn authority by observed response rather than elapsed time
nontransferable_details: published gains, robot linkage kinematics, clock-driven oscillator phase, species envelopes, and task-specific routes
policy_translation: use normalized body-frame target/course geometry for predicted miss and carrier-separated body yaw to release half-cycle steering while retaining bounded two-joint mean curvature
falsification: reject if capture, arrival, wake coherence, joint reserve, or low force/moment loads regress relative to the two sampled captures
