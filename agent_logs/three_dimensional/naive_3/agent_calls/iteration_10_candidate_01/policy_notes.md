# Wake-policy candidate notes

## Evidence and visual diagnosis

- Every sampled and inherited evaluation used direct uniform still-water
  initialization (`U_infinity=(0,0,0)`), no cylinders, and no prewarm. The
  top-down vorticity and oblique Lambda2 rows therefore show policy-generated
  self-propulsion, not advection.
- The sampled half-cycle controller has the best scalar score (`-7.690`) but
  only reaches `4.859L`. Its alternating 3D wake survives, while its raw
  acceleration demand exceeds the envelope on either joint in about `87.2%`
  of samples. The full-quadrant static redirect gets closer (`2.999L`) but its
  joints settle near `(-10,-12) deg`; the visible wake weakens as the fish
  coasts into the upper boundary. Together these samples reject stronger
  phase asymmetry, static C-bends, and score-only selection.
- The latest inherited course-angle controller is the first semantic
  improvement. Its combined sheet shows a coherent alternating mid-plane wake
  and persistent three-dimensional structures throughout the useful approach.
  It crosses inside `2L` at `17.04T`, reaches `0.857L` at `19.06T` (only
  `0.107L` outside capture), and misses high before continuing to the left
  boundary. At closest approach the head is `(8.847,10.343)L`, its world speed
  is about `0.845U`, and its course error remains strongly corrective. This is
  a fast final-approach overshoot, not loss of target information or thrust.
- That near-miss controller requests acceleration beyond the envelope on the
  anterior and posterior joints in about `58.0%` and `67.5%` of samples, with
  their rate limits occupied about `5.6%` and `7.3%`. More peak curvature is
  not supported. Earlier distance-only holds activated around `5L`, weakened
  the useful approach, and reached only `3.162--3.592L`; their negative result
  does not establish what happens if allocation is both closing-dependent and
  confined to the final roughly `2T` before capture.

## Policy hypothesis

Start from the inherited speed-gated body-frame course controller, preserving
its zero-centered anterior oscillator, full-quadrant target geometry, and
posterior course-error curvature. Add one final-approach allocation mechanism:
estimate time to the capture boundary from normalized clearance and observed
windowed closing speed. Only while that time is short and positive, smoothly
damp the anterior carrier and reduce the oscillatory posterior share to a
nonzero floor, while leaving the bounded course-error mean curvature intact.
The gate is exactly zero during broad travel and immediately releases if the
fish is no longer closing.

This should retain the trajectory mechanism that reduced the miss from about
`3L` to `0.857L`, but trade late carrier demand for corrective authority during
the final crossing. Falsify it if far-field motion or the alternating 3D wake
changes, the gate activates without positive closing speed, the closest
approach does not cross `0.75L`, actuator occupancy increases materially, or
the rollout repeats a boundary exit without a distinct slower/recoverable
near-target arc.

bookshelf_consulted: true
source_domain: terminal target capture and sensor-modulated robotic-fish direction tracking
source_mechanism: continuous near-target allocation from rhythmic propulsion toward damping and steering as measured time to arrival contracts
transferable_invariant: preserve the demonstrated traveling carrier during broad approach, then reduce excess rhythmic drive only when normalized target clearance and positive closing speed predict an imminent pass while retaining target-relative corrective curvature
nontransferable_details: published gains, dimensional approach distances, species-specific braking kinematics, clocked gait stages, exact vortex phases, and task-specific routes
policy_translation: compute a bounded time-to-capture gate from `distance_L` and `window_closing_speed_L`; use it to damp the joint-state anterior oscillator and reduce only the lagged posterior carrier to a nonzero floor while full-quadrant body-frame course error continues to set mean curvature
falsification: reject if broad-approach propulsion changes, carrier relief occurs while receding, wake coherence collapses, joint-limit occupancy rises, or the `0.857L` miss and boundary-exit topology do not improve
