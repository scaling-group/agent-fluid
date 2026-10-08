# Terminal turn-response equilibrium candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the experiment contract: direct uniform
  initialization, `U_infinity=(0,0,0)`, no cylinders, and capture rather than
  boundary exit or instability.
- The combined top-down sheets show self-propulsion along the same compact,
  target-directed curved path, with a coherent alternating vorticity wake from
  release through the outer approach. The body is not passively advected. The
  late frames show the broad tail beat giving way to a smooth held bend as the
  head closes on the capture sphere, rather than wasteful terminal flailing.
- The strongest finite sample (`solver_89a97c83567b`) has visible oblique
  Lambda2 structures at the mid-approach and a stable body trajectory through
  capture. The phase-selective contrast (`solver_6a46e49f8216`) has incomplete
  black oblique frames, so its 3D wake cannot support a visual superiority
  claim; its top-down row and numeric diagnostics nevertheless support a
  like-for-like terminal-allocation comparison.
- Three byte-identical coordinated-release samples capture at `25.118522 T`
  with score `-0.528339`, mean distance `2.429294 L`, final distance
  `0.746410 L`, no inside-`4 L` command above `30 rad/T^2`, and inside-band
  force/moment maxima about `0.01548/0.00800`. The phase-selective allocator
  crosses one solver step earlier but is slightly worse in score and mean
  distance (`-0.528376`, `2.429298 L`), so it does not justify another
  phase-based joint-role split.
- Reconstructing the current policy's normalized body-frame geometry from the
  coordinated-release trace shows a separate response deficit. Between the
  first `4 L` crossing and capture, bearing/vector angle falls only from about
  `1.0/1.17` to `0.713/0.713 rad`. The geometry-derived target turn rate stays
  near `-0.75` to `-0.71 rad/T`, while measured recent turn rate ranges from
  `-0.40` through the wrong-sign `+0.07` near `3 L` and reaches only
  `-0.31 rad/T` at capture. Thus target-relative turn-rate error is materially
  active (roughly `-0.34` to `-0.82 rad/T`) while the existing terminal
  replacement tracks only the geometry-set curvature and eventually issues
  tiny commands inside `2.4 L`.
- The inherited logs bound the change: carrier restoration, velocity-course
  residuals, anterior-hold/posterior-only release, and stacked phase allocators
  all regressed the compact capture. The outer carrier, closure preview, and
  amplitude-normalized paired release therefore remain unchanged.

## Policy hypothesis

Add one bounded terminal body-response residual to the *shared* curvature
equilibrium: map geometry-derived target-turn-rate error through a soft
saturation to at most three degrees of additional mean bend, split evenly
between the two joint targets. Because the residual enters only the already
gated terminal replacement, pre-terminal propulsion and wake topology are
identical by construction. Because both joint targets move together and the
existing response-conditioned carrier handoff is retained, this is not a
posterior-only allocator or another phase gate.

Expected result: during the active `4 L` terminal band, the equilibrium should
continue turning in the target-requested direction when body yaw lags, reducing
bearing sooner and improving capture time or distance integral without
restoring high-frequency carrier load. Reject the mechanism if the outer path
changes, capture is lost or delayed, mean distance/score regress beyond solver
step noise, the turn-rate error does not shrink, or terminal joint-stop dwell,
`|action|>30`, force, or moment spikes return.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking
source_mechanism: sensor feedback modulates a rhythmic controller's mean turning offset according to measured directional response
transferable_invariant: preserve the proven propulsive rhythm while a bounded response error adjusts the mean bend shared by the available joints
nontransferable_details: published CPG gains, oscillator phases, robot geometry, sensor suite, dimensional rates, and task routes
policy_translation: in the terminal allocation only, soft-saturate normalized target-turn-rate minus measured recent body turn rate into a small shared two-joint curvature-equilibrium residual
falsification: reject if pre-terminal motion changes, the compact capture or low loads regress, measured target-relative turn response fails to improve, or saturation and joint-stop dwell return
