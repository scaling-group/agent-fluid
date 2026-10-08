# Multi-wake policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release while the four developed cylinder streets merge around the target.
  It is identical initial-condition evidence and cannot justify a fixed wake
  phase, cylinder coordinate, or memorized route.
- All four sampled released sheets are finite target captures; no sampled
  failure keyframe is available. They visibly preserve the same useful
  topology: an immediate body-generated traveling wake, active diagonal
  down-left swimming, and one broad correction through the merged wakes into
  the capture circle. For the strongest sample, mean body x velocity is
  `-0.241U` versus `-0.177U` mean local flow, confirming self-propulsion rather
  than passive advection.
- The assigned parent gates only positive course-earned posterior
  amplification by normalized yaw load. It reaches at `45.105`, with score
  `0.161024`, `1.7191L` mean distance, command-energy mean `1034.8`, and
  `416/4183` force/moment RMS. The strongest sampled candidate additionally
  requires oscillator-normalized joint-rate headroom. It preserves the visual
  topology and target capture while improving score to `0.165009`, mean
  distance to `1.7153L`, and command-energy mean to `1030.5`; arrival is
  slightly later at `45.260` and load is higher at `439/4342`, so this is a
  route/effort improvement rather than a universal load reduction.
- The broader contrasts sharpen the mechanism boundary. With neither rate nor
  yaw conditioning, positive course amplification reaches at `45.612`, with
  `1.7222L` mean distance and `453/4406` loads. Rate headroom plus a
  distance-to-capture gate but no yaw conditioning reaches at the same
  `45.611`, improves mean distance only to `1.7208L`, and raises loads to
  `475/4653`. Thus proximity scheduling is not supported as a substitute for
  yaw-response separation, whereas the combined rate-and-yaw gate improves
  score, mean distance, arrival, and loads relative to the ungated course
  residual.
- Every sampled policy still touches both `4.538` rad/time joint-rate caps and
  approaches the candidate soft acceleration limit. The rate signal is
  therefore evidence for withholding only optional tail amplification, not
  for weakening the base wave or claiming that saturation has been solved.
  The inherited below-target collision at `58.93`, `1.872L` closest approach,
  and `537/4995` loads remains a nonvisual boundary against broad propulsion
  reallocation; no unavailable failure image is inferred here.

## Policy hypothesis

Promote the sampled rate-and-yaw authority-separation mechanism into the
assigned parent's successful scaffold. Preserve the zero-centered oscillator,
posterior lag, target steering, positive normalized closure qualification, and
full negative course correction. Positive course convergence may amplify the
small progress-earned posterior residual only when both normalized yaw load
and oscillator-normalized maximum joint-rate usage leave headroom. The base
wave and negative course suppression remain ungated.

This is a state-feedback mechanism change from the assigned parent, not a gait
gain sweep. The sampled fixed-snapshot result supports preservation of capture
and route topology, but does not establish robustness. Falsify it if replay
loses capture, meaningfully worsens `1.7153L` mean distance, arrives later than
the ungated `45.612` reference without a load benefit, or changes into the
inherited low-pass collision family. Do not extend either gate onto the base
wave or negative course branch without new sign-resolved evidence.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and wake-interaction control
source_mechanism: sensor feedback modulates a bounded residual around a low-dimensional propulsive rhythm while useful wake-induced motion is preserved
transferable_invariant: preserve the established traveling wave and withdraw only optional route-conditioned tail amplification when measured yaw response or normalized actuator usage is already large
nontransferable_details: published gains, dimensional rate and moment scales, species-specific kinematics, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: multiply only positive body-frame bearing-convergence amplification by smooth gates from absolute normalized yaw moment and maximum joint rate normalized by the candidate-owned oscillator scale; retain negative course suppression and the two-joint base wave
falsification: reject if target capture or diagonal topology is lost, mean-distance benefit disappears without a compensating load reduction, or rate and load symptoms persist while arrival regresses beyond the ungated reference
