# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures under the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported numerical instability. The two prefilled
  inertial-axial-recovery variants reproduce `23.864521T`, `2.192138L`
  score-metric mean distance, and score `-0.294271`. The two variants that
  change only the locomotor observation to forward body-minus-local-water
  speed reproduce the stronger `23.424515T`, `2.184349L`, and `-0.287480`
  result. The one-line observation contrast is therefore evidence for the
  water-relative recovery path, not for changing its thresholds or gain.
- Both sampled behavior classes show continuous self-propelled translation on
  the established S-shaped approach in their top-down sheets, with an
  alternating red/blue mid-plane street attached from wake formation through
  capture. Every sampled oblique sheet is black, so these four runs supply no
  new independent three-dimensional Lambda2 evidence. The inherited
  assigned-parent adverse-moment composition has a complete oblique sheet: it
  retains discrete three-dimensional structures through capture and the same
  visible route class, but that is not a performance improvement.
- The completed assigned-parent composition is the informative regression.
  Adding the previously positive adverse-yaw-moment posterior residual to the
  water-relative recovery policy delays capture to `23.853519T`, increases
  score-metric mean distance to `2.194872L`, and worsens score to `-0.297049`.
  Mean/near-target action fall to about `57.42/41.48`, but peak normalized
  force/moment rise slightly to `0.03034/0.01551`; lower effort and a coherent
  wake therefore do not rescue its worse target progress. Three inherited
  evaluations reproduce this exact regression. Do not carry the moment
  residual into another composition or interpret an independently positive
  residual as automatically compatible with changed carrier dynamics.
- In the strongest sampled trajectory, the existing steering-side signal
  `tanh(target_body_L[2] / 0.25L)` is above `0.99` in magnitude for `98.6%` of
  samples where the distance/error-gated rudder is active. Its magnitude is
  therefore almost only a sign and depends on absolute target distance. The
  full `atan2` target error already preserves front-versus-behind geometry for
  gating; the remaining continuous steering magnitude can instead use the
  normalized body-frame target-side direction. Offline substitution lowers
  strict active-rudder saturation to about `42.2%` while retaining mean active
  magnitude near `0.979`, so it is a bounded semantic change rather than a
  wholesale loss of steering authority.

## One candidate hypothesis

Start from the twice-reproduced water-relative axial-recovery policy and omit
the falsified adverse-moment residual. Preserve its joint-state traveling
carrier, water-relative lateral route feedback, full target error, anterior
redirect, phase-selective posterior carrier, calibrated reactive-rudder sign,
and phase-qualified terminal relief. Change only the continuous target-side
steering magnitude: divide `target_body_L[2]` by measured `distance_L` before
the bounded `tanh`, with a small denominator floor, and make the corresponding
scale explicitly dimensionless. This translates target geometry into a
direction cosine, so the same angular misalignment requests comparable
steering across target distances while full `atan2` error continues to govern
recovery behind the head.

Falsify the candidate if it loses capture, arrives later than the reproduced
`23.424515T` reference, raises score-metric mean distance above `2.184349L`,
changes the useful top-down route adversely, or materially exceeds mean/near
action `58.29/45.01`, anterior/posterior rate-cap occupancy `11.74/6.64%`, or
peak normalized force/moment `0.02978/0.01529`. A fixed-pose still-water
improvement establishes neither held-out pose/flow robustness nor a new 3D
wake result; that requires a changed condition and a valid oblique render.

bookshelf_consulted: true
source_domain: robotic-fish target-vector steering and bounded mean-curvature or phase-asymmetry control
source_mechanism: map observed body-frame target direction to bounded steering while preserving a separate rhythmic traveling carrier
transferable_invariant: steering magnitude should depend on normalized target-side direction and full relative geometry rather than unnormalized lateral displacement or a world-frame route
nontransferable_details: published steering gains, robot geometry, species-specific kinematics, dimensional distances, prescribed timing, exact vortex phases, and task-specific routes
policy_translation: retain the evidenced water-relative carrier and replace the raw lateral-displacement steering input with `target_body_L[2] / max(distance_L, floor)` before the bounded target-side command, while retaining full `atan2` error gates
falsification: reject if capture is lost or later than 23.424515T, mean distance exceeds 2.184349L, or route, wake, action, saturation, force, or moment envelopes worsen
