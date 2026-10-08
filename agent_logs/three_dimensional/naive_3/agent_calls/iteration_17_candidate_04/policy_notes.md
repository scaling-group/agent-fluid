# Response-released terminal phase-allocation candidate

## Visual diagnosis and completed evidence

- Every sampled and inherited rollout reports direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  Peak local flow in the useful lineages is only about `0.03U`, so the visible
  translation and wake are controller-generated rather than ambient or
  moving-window advection.
- The sampled `2.989L` response-released redirect is the strongest broad
  approach among the four solver examples. Its top-down sheet shows a coherent
  alternating vorticity street through approach, and its oblique sheet shows
  persistent three-dimensional Lambda2 structures while speed reaches about
  `1.03U`. It then hooks away and exits without active terminal recovery.
- The assigned parent's phase-sway-compensated velocity-course policy is the
  informative failure. Both visual rows still show self-propulsion and an
  alternating wake, but the trajectory stays above the target, reaches only
  `4.459L`, peaks near `0.90U`, and crosses the upper virtual boundary at
  `22.48T` (reported termination class `left_domain`). Raw acceleration
  commands still exceed the envelope in roughly `54/66%` of samples. Thus
  the offline `velocity_body_y`/`phi_dot1` correlation did not isolate a
  causal slow course: adding `0.11*phi_dot1` destroyed the inherited sub-`1L`
  approach instead of denoising it.
- The best inherited completed candidate is the correctly signed terminal
  anterior half-cycle allocation. Its top-down and oblique sheets preserve the
  coherent traveling wake, it reaches `0.834L`, and it keeps posterior
  excursion below about `39.9 deg`. This is a small improvement over the
  unmodified velocity-course near miss (`0.857L`) and over posterior relief
  (`0.867L`), but it still crosses the target x-coordinate about `0.867L`
  above the target and exits left. Near closest approach, wrapped course error
  remains about `-1.37 rad`; yaw rate changes from correct-sign values above
  `+2 rad/T` to a wrong-sign value near `-0.50 rad/T` as the anterior joint
  enters its counter-moment side. The mechanism has the right sign but lacks a
  response-dependent terminal authority increment.

## Policy hypothesis written before the solver edit

Start from the completed `0.834L` moment-aligned velocity-course controller.
Preserve its unmodified normalized body-frame velocity course, full-quadrant
target ray, zero-centered anterior oscillator, complete posterior lagged
carrier, `12 deg` posterior mean-curvature cap, and baseline correctly signed
half-cycle stiffness allocation. Add one response-release channel: inside the
same terminal distance/error gate, measure bounded body yaw rate and increase
the anterior phase allocation only while yaw is weak or has the sign opposite
the requested turn. As soon as target-signed yaw develops, the boost vanishes
continuously back to the already evaluated baseline allocation.

The expected signature is an unchanged broad approach and alternating 3D
wake, followed by a shorter counter-yaw portion of the final beats and a
target-x crossing at least `0.12L` lower, enough to enter the `0.75L` capture
circle. Reject the mechanism if it loses the sub-`1L` approach, increases
joint-angle or acceleration-limit occupancy materially, suppresses the
traveling wake, or repeats the left exit without capture or a distinct tighter
terminal arc.

```text
bookshelf_consulted: true
source_domain: biological fast-start turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: recruit extra bounded turning asymmetry for a large course error and release it when measured yaw response appears
transferable_invariant: preserve the rhythmic traveling carrier, add corrective phase allocation only while target-relative error is large and yaw response is insufficient, and remove the extra allocation continuously when target-signed yaw develops
nontransferable_details: species-specific C-start shapes and timing, published CPG gains or duty ratios, robot linkage geometry, dimensional yaw rates, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame target-ray versus measured-course feedback and observed anterior joint phase; within a normalized distance/error gate, use bounded heading rate to boost the evidenced moment-aligned stiffness allocation only during weak or wrong-way yaw, while leaving both joint centers and the posterior carrier unchanged
falsification: reject if the inherited sub-1L approach or alternating 3D wake is lost, actuator occupancy rises materially, or capture and terminal trajectory topology do not improve beyond the completed 0.834L left-exit miss
```
