# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common upper-right held release and four
  fully developed, interacting cylinder streets. The release state is common
  across the samples, so the repeated trajectory is controller evidence rather
  than a change in wake maturity.
- All four sampled solver sheets and metrics are identical finite successes.
  They show an active traveling body wake, a continuous diagonal down-left
  traversal of the merged streets, and first target crossing at `51.47`. The
  metrics agree: final/minimum distance `0.748L`, mean distance `1.82L`, head
  displacement `-11.28/-4.94L`, and no collision, exit, or instability. Three
  independently materialized files are functionally the same controller, so
  the repetition establishes deterministic materialization but contributes no
  new controller mechanism or held-out robustness evidence.
- The most informative inherited failures bracket this route. Ungated
  distributed heading-response steering approached to `1.65L` but amplified a
  downward fold and exited at `75.09` with force/moment RMS `487/4680`; the
  lower-load posterior-curvature policy passed above the target and exited
  upward after approaching only `2.43L`. The successful moment-magnitude gate
  changed the termination to capture while retaining the distributed
  half-cycle scaffold.
- The successful result is still effort- and load-heavy: command-energy mean
  is `995`, force/moment RMS is `426/4084`, maximum joint accelerations are
  `28.79/28.14` against the candidate's `29` soft limit, and both joint rates
  reach the `4.538` (`260 deg/time`) hard cap. The keyframes show that the
  propulsive wave is useful, so the next test should not weaken it globally or
  add an unevidenced signed wake residual. The remaining structural issue is
  that propulsion and steering are summed before one limiter, allowing the
  steering residual to consume the same acceleration envelope as propulsion.

## Candidate hypothesis

Preserve the successful zero-centered anterior oscillator, lagged posterior
wave, predicted body-frame bearing, and yaw-moment-magnitude steering gate.
Introduce propulsive-priority residual allocation at both joints: soft-limit
the symmetric traveling-wave acceleration first, then admit the gated
half-cycle steering residual fully when it reduces the base magnitude and only
within a reserved fraction of the remaining same-direction acceleration
headroom when it reinforces the base. This is an actuator-composition
mechanism, not a scalar gain sweep; all active values remain candidate-owned.

The expected effect is to retain the successful diagonal topology while
preventing route correction from flattening the propulsive waveform against
the acceleration envelope. The next CFD rollout falsifies it if target capture
or strong upstream/downward displacement is lost, if closest or mean distance
regresses materially, if the prior upper/lower exit returns, or if command and
load metrics do not improve enough to justify the new allocator. Same-seed
success would establish only this lane's result, not wake-phase or geometry
robustness.

bookshelf_consulted: true
source_domain: robotic-fish CPG residual control under bounded actuation
source_mechanism: preserve the rhythmic locomotion generator while a slower route residual uses only available actuation authority
transferable_invariant: propulsion and route correction should be composed with explicit priority so saturation of the residual does not erase or distort the traveling propulsive wave
nontransferable_details: published gains, dimensional actuator limits, robotic linkage geometry, learned routes, exact vortex phases, and species-specific kinematics
policy_translation: soft-limit each normalized joint-state traveling-wave command first, then allocate body-frame gated half-cycle steering within same-direction acceleration headroom while allowing magnitude-reducing correction
falsification: reject if capture, approach, or useful displacement regresses, a boundary exit returns, or effort and load show no compensating improvement
