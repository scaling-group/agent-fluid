# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. Its byte-identical copies
  confirm the certified common initial condition, not candidate-specific wake
  selection or robustness to a changed release phase.
- Three code-identical samples of the assigned parent's progress-supervised
  posterior residual reproduce nose-first target capture at `32.340` release
  time, `1.63773L` mean distance, score `0.234663`, and force/moment RMS
  `65.12/888.56`. Their released sheet shows immediate targetward redirection,
  a persistent posterior-traveling body wake, ample cylinder clearance, and a
  compact diagonal approach through the developed wakes. Mean fish velocity
  `(-0.3362,-0.1404)` against mean local flow `(-0.1961,-0.1918)` and head
  displacement `(-10.9149,-4.2375)L` confirm active upstream propulsion rather
  than passive advection.
- The one distinct sample adds gait-qualified, correct-sign heading and bearing
  response as a second confidence signal at the same optional posterior-
  residual gate. It preserves the visible route and capture topology while
  improving release time to `32.318`, mean distance to `1.63741L`, score to
  `0.234705`, posterior excursion from `0.57530` to `0.57481 rad`, and yaw-
  moment RMS from `888.56` to `881.45`. Lateral-force RMS rises slightly from
  `65.12` to `65.52`; velocity and acceleration still reach their hard limits.
  The navigation change is real but marginal and comes from one fixed-snapshot
  rollout, so it does not establish a new trajectory class, load efficiency,
  or wake-phase robustness.
- No sampled released failure sheet exists. The assigned parent's successful
  sheet is therefore the visual comparison, while inherited failures remain
  textual boundaries: unrestricted bearing-rate recentering erased the
  traveling bend and exited downstream; blanket limit damping delayed capture;
  a positive response burst increased arrival time and loads; and a separate
  response-confirmed mean-curvature release stacked with the progress
  supervisor regressed arrival, distance, force, and moment without a useful
  route change. These results support promoting the measured single-locus
  response supervisor rather than adding authority or another controller
  layer.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG sensory modulation combined with biological redirect-and-release turning and posterior reactive propulsion
source_mechanism: preserve a persistent traveling gait while verified goal-directed turning may withdraw one optional rhythmic steering residual
transferable_invariant: slow body-frame target geometry owns mean turn direction, and observed correct-sign response may reduce only incremental steering authority without weakening distributed mean curvature or the base traveling wave
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, prescribed maneuver timing, exact vortex phases, actuator ratings, fixed approach distances, and source-task routes
policy_translation: promote the sampled controller that combines normalized gait activity, recent turn rate, and bearing-window rate with trajectory efficiency inside the same one-sided posterior-headroom gate; leave oscillator centers, distributed mean curvature, and the unit-gain lagged wave unchanged
falsification: reject if the immediate redirect, narrow traveling bend, direct capture, or score fails to reproduce; if arrival or mean distance exceeds the assigned parent without repeatable load relief; if force or moment increases without better navigation; or if a held-out wake exposes switching or propulsion loss

## Candidate hypothesis

Produce exactly one candidate by promoting the best sampled single-locus
response supervisor without further gain changes. Retain the filtered
body-frame bearing, bounded `12 deg` total curvature, bearing-conditioned
`40/60 -> 35/65` allocation, anterior state-feedback oscillator, posterior
lag and damping, direction-selective speed/previous-acceleration pressure, and
maximum `8%` target-helping posterior half-cycle residual.

The added confidence path is enabled only after the anterior gait is active
and both recent heading rotation and bearing motion agree with the persistent
target direction. Taking the larger of that response confidence and the
existing trajectory-efficiency confidence permits actuator-state yielding
during either a verified redirect or coherent closure. It cannot add authority,
move an oscillator center, release mean curvature, or suppress the base
traveling wave. The downstream evaluation should first test fixed-snapshot
reproducibility of the measured small gain before later workers generalize it.
