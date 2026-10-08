# Carrier-centered half-cycle steering candidate

## Evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the Phase-2 contract: they use direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and semantic `capture`.  Three independently
  sampled v29 controllers reproduce capture at `19.3105 T`, score `-0.21058`,
  and distance integral `2.09959 L`.  The assigned-parent v30 whole-wave
  gait-frame projection improves those results to `18.9970 T`, `-0.18597`, and
  `2.07455 L`.
- I inspected both rows of the combined keyframe sheets for the strongest v30
  rollout and a reproduced v29 comparator from release through capture.  In
  the top-down row, both fish leave a compact startup disturbance followed by
  an orderly alternating mid-plane vortex street while following a continuous
  target-directed arc; v30 is visibly farther along the arc at the matched
  middle and late frames.  In the oblique row, both form compact alternating
  posterior Lambda2 structures rather than drifting with background flow or
  showing a collision, domain-exit, or instability precursor.  The image
  diagnosis is therefore productive self-propulsion with coherent 3D wake
  structure, not passive advection or a propulsion failure.
- Metrics and diagnostics agree with the visual comparison.  Relative to the
  reproduced v29 route, v30 leads in distance by `0.024/0.154/0.149/0.174 L`
  at `4/8/12/16 T`; mean speed rises from `0.665` to `0.676 L/T`, while max
  speed stays within the prior envelope (`0.927` versus `0.931 L/T`) and peak
  normalized force/moment remain `0.03068/0.01541`.  The cost is a small rise
  in any-joint acceleration-limit residence from `42.35%` to `43.43%`.  This
  supports the inherited hypothesis that mean-preserving rejection of the
  complete two-joint carrier phase cleans route sensing, but not a claim of
  effort relief.
- No current sampled rollout has a failure termination.  The most informative
  negative boundary remains the inherited uncentered full-frame projection:
  it passed just outside capture at about `0.8006 L`, curled away, and exited
  left.  Therefore raw body-frame target geometry must continue to select and
  release the completion-gated redirect; only a carrier-phase detector may be
  centered around commanded mean curvature.
- One downstream inconsistency remains after the successful v30 observation
  change.  Half-cycle steering still classifies beat side from raw
  `phi[1]+phi[2]`, even though this signal contains the deliberate route and
  redirect tangent that v30 explicitly subtracts from target sensing.  On the
  completed v30 states, subtracting `drive.mean_tail_tangent` changes the
  half-cycle gate by mean absolute `0.0213` and at most `0.241`; the resulting
  steering changes by mean absolute `0.0515` and at most `0.654`, with a change
  above `0.05` on `24.6%` of states.  The effect is strongest after `16 T`
  (mean absolute steering change `0.114`), so it is a material actuator-phase
  hypothesis rather than a scalar-only gain adjustment.

## One-candidate policy hypothesis

Preserve v30's state-feedback oscillator, posterior lag, whole-wave
gait-frame target projection, raw completion-gated redirect, response and
approach scheduling, carrier-first projection, rejected-steering spillover,
and physical acceleration bound.  Change only the half-cycle phase detector:
infer bend side from `phi[1]+phi[2]-drive.mean_tail_tangent`, while retaining
the observed joint-velocity phase term.  This prevents deliberately commanded
mean curvature from being counted a second time as propulsive half-cycle
asymmetry; it does not alter the mean-curvature command itself.

The expected outcome is to preserve capture and the coherent v30 wake while
making late steering less biased by the active redirect bend, reducing wasted
limit residence and improving or retaining the middle/late route.  Falsify
the mechanism if capture is lost or later than `18.9970 T`, the distance
integral exceeds `2.07455 L`, the established lead after `8 T` disappears,
the route curls away toward the inherited left exit, the alternating wake
loses coherence, or saturation, max speed, normalized force, or yaw moment
materially exceed `43.43%/0.927/0.03068/0.01541`.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG turning
source_mechanism: use observed oscillatory bend phase to strengthen the target-useful half-cycle while carrying route steering in a separate bounded mean-curvature channel
transferable_invariant: a half-cycle detector should classify carrier phase after removing deliberately commanded mean bend, so persistent target curvature is not mistaken for oscillatory beat side
nontransferable_details: published gains, duty ratios, clocked CPG phases, robot linkage geometry, species-specific kinematics, dimensional cadence, exact vortex phases, and prescribed task routes
policy_translation: subtract the controller's bounded route-plus-redirect tail tangent from the observed two-joint tail tangent before the existing state-feedback half-cycle gate; retain raw body-frame redirect geometry and the two-joint acceleration contract
falsification: reject if centering loses or delays capture, worsens the distance integral or late closure, reverses the target-signed arc, disrupts the coherent alternating wake, or materially raises acceleration saturation, speed, normalized force, yaw moment, or left-exit risk

## Evidence boundary

All numerical and visual claims above come from completed sampled CFD and the
assigned parent's inherited logs.  This candidate receives formal CFD
evaluation only after worker exit; no same-worker performance is claimed.
