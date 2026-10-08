# Arrival-committed terminal response-release candidate

## Evidence and visual diagnosis before the policy edit

- All four current solver samples satisfy the frozen physical contract:
  direct uniform still-water initialization at `U_infinity=(0,0,0)`, no
  cylinders or prewarm snapshot, finite moving-window dynamics, and capture.
  Three contain the byte-identical assigned v26 parent and reproduce score
  `-0.5281078349`, mean distance `2.4291113720 L`, final distance
  `0.7461675406 L`, and capture at `25.1185226 T`. They are repeatability
  evidence for one behavior, not three independent controller mechanisms.
- The distinct sampled v28 course-supported paired release is the strongest
  finite example. It retains the same capture step while improving score to
  `-0.5281032175`, mean distance to `2.4291077322 L`, and final distance to
  `0.7461626530 L`. This is a real but very small terminal-only effect: below
  `1.6 L`, its speed and target-course angle are marginally worse than v26,
  and its peak force rises from about `0.002135` to `0.002237`. It supports the
  paired allocation locus, but not a claim of broad performance improvement.
- No current sample has a non-capture termination. I therefore compared both
  visual views of v28 against the inherited v27 mean-bend regression, the most
  informative completed negative available. The top-down sheets show the fish
  self-propelling along the same compact target-directed arc and shedding a
  coherent alternating wake through `20 T`; the oblique sheets confirm finite
  three-dimensional Lambda2 structures near `8 T` and `16 T`, followed by a
  quiet mean-bend handoff near `24 T`. Neither has advection-only motion,
  collision, boundary-exit precursors, wasteful terminal flailing, or
  instability. The coarse visual distinction is too small to rank, so the
  trajectory and load histories decide the comparison.
- The inherited v27 attempt moved the helpful-crossflow cue from paired
  allocation to the shared redirect mean. It retained capture but regressed to
  score `-0.5295582789`, mean distance `2.4302567953 L`, final distance
  `0.7476926446 L`, final speed `0.652354 L/T`, and final target-course error
  `0.31938 rad`. The inherited v28 half-cycle course correction also retained
  the capture step but regressed to score `-0.5281232687` and mean distance
  `2.4291235633 L`, despite slightly improving final course error and speed.
  Residual bearing is therefore not evidence for mean-bend or phase-asymmetry
  steering in this settled terminal crab.
- On the best v28 trajectory, all 226 samples below `1.6 L` retain positive
  seven-sample closure (`0.674--0.712 L/T`) while course error falls from
  `0.443` to `0.310 rad`. The dimensionless range fraction projected closed
  over one inherited control period, `0.55*closing_speed/distance`, grows
  monotonically in scale from about `0.236` at late-band entry to `0.525` at
  capture. This supplies an independently varying, normalized arrival cue; it
  is not an elapsed-time or capture-radius proxy.

## Policy hypothesis

Promote the evaluated v28 course-supported paired response release while
preserving v26's complete outer oscillator, traveling posterior lag,
target-angle redirect, closure preview, two-joint mean-curvature equilibrium,
and validated crossflow-supported allocation relief. Add one bounded approach
mechanism at the same safe actuator locus: estimate the fraction of current
range that positive closure would remove over a small declared number of
control periods. Smoothly raise the existing course-supported release from its
evaluated floor only when that dimensionless arrival commitment grows, while
still requiring the inherited late proximity, target-helpful crossflow,
positive closure, settled two-joint response, and course alignment gates.

The controller does not change the redirect mean, select beat phase, split
joint roles, infer a route, use elapsed time, or add steering authority. It is
exactly inherited outside `1.6 L`; within that band it tests whether a modest
nonsteady release into the already mean-centered carrier can preserve terminal
momentum without the broad `22%` release regression. Reject it if the logged
gate is dormant or unbounded, any outer command changes, capture is delayed or
lost, mean/final distance regresses, the path loops, or carrier oscillation,
joint stops, clipping, force/moment growth, instability, or wake degradation
returns. The pending CFD result is not claimed here.

bookshelf_consulted: true
source_domain: biological burst-redirect response release and sensor-modulated robotic-fish rhythmic control
source_mechanism: release corrective curvature into an established propulsive rhythm only after observed target response indicates a committed approach
transferable_invariant: gate a bounded nonsteady carrier release by normalized target-relative response and closure rather than elapsed time or a prescribed route
nontransferable_details: species escape kinematics, published gains and timing, dimensional cadence, full-body waves, exact vortex phase, capture radius, cylinder geometry, and task-specific routes
policy_translation: body-frame target/velocity course alignment, helpful relative crossflow, settled joint tracking, and the dimensionless range fraction projected closed over declared control periods schedule one coupled two-joint allocation release inside the inherited late band
falsification: reject if the gate is inactive, affects commands outside the late band, acts without positive closure and course support, delays or loses capture, worsens distance or load histories, or restores oscillation, saturation, joint stops, instability, or wake loss

## Non-CFD implementation audit after editing

The configured lightweight Julia contract check returns two finite commands,
and the deterministic schema and solver-boundary checks pass. Replaying the
candidate and evaluated v28 algebra on all 4,567 stored v28 states gives exactly
zero command difference for `distance_L >= 1.6`. All 226 stored states below
that band have nonzero arrival support; its mean/max is `0.6813/1.0`, while the
course support remains `0.4002/0.9245`. Relative to v28, the late mean/max
per-state command difference is `0.00408/0.01868 rad/T^2`, and candidate late
commands remain below `0.108/0.268 rad/T^2`, far inside the actuator envelope.
This establishes gate activity, boundedness, exact outer noninterference, and
schema validity only; it is not a coupled-flow performance claim.
