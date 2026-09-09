# Wake-policy candidate notes

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, finite moving-window shifts, and stable dynamics. Their translation
  and wake development therefore come from self-propulsion rather than
  advection or an inherited flow field.
- Both successful sheets show the useful physical scaffold. In the top-down
  row, `solver_28bd83fceb82` develops a coherent alternating wake through the
  far approach and then assumes a strong smooth C-bend before capture; its
  oblique row shows organized three-dimensional caudal Lambda2 structures and
  a continuous target-directed trajectory rather than numerical breakup. It
  captures at `21.1695T`, with score `-0.285286`, mean distance `2.17777L`,
  and final distance `0.74928L`. The independently constructed response-gated
  redirect also captures, at `21.2245T`, confirming that a strong bounded
  middle/near-field redirect is the semantic improvement rather than a lucky
  scalar setting.
- The two failures locate the boundary. The compact prefill preserves a
  coherent alternating wake but reaches only `5.3570L` before an upper-domain
  exit. The distance/closing allocator reaches `1.7328L`, yet its top-down row
  curls into a broad miss and its oblique row shows the early organized wake
  weakening during the near-target coast before reforming on the return loop.
  At `20T` it still moves near `0.75U` with reconstructed target-to-course
  error about `-0.95 rad`; a weak static bend cannot redirect that inertia.
- The course-error capture is also the cleaner of the two successful
  mechanisms. From `16--19T` its trajectory has mean absolute joint commands
  about `(6.7,8.0) rad/T^2`, versus `(15.8,14.4)` for the stronger
  response-gated burst; after `19T` these fall to about `(0.3,0.3)` while the
  fish still captures. Thus the sampled evidence supports a course-conditioned
  equilibrium bend that can redirect and then coast, not additional burst
  gain or persistent action.

## Policy hypothesis

Adopt the successful terminal course-redirect controller and change one
observation semantic. Keep the pure-pursuit route request limited to
`+/-1.2 rad`, but compute redirect error directly as the wrapped angle from
the full normalized body-frame velocity vector to the full body-frame target
vector. The sampled version first clamps target angle for route control and
then reuses that clamped value in its course error. Decoupling the two roles
preserves the evaluated approach while retaining fore/aft and large-abeam
information for recovery under a perturbed or slightly missed trajectory.
The direct cross/dot angle is scale-free, reflection equivariant, and remains
speed-gated, so it adds neither a route, clock, nor low-speed direction noise.

Expected evidence is preservation of the coherent far-field wake and the
roughly `21.17T` capture, with the same low-action terminal static bend. The
semantic change is useful only if capture survives and no new command or joint
limit residence appears. Falsify it if capture is lost or delayed materially,
the trajectory makes a broad first-pass loop, the terminal bend becomes
bang-bang, or wake coherence deteriorates.

bookshelf_consulted: true
source_domain: biological C-start redirection and robotic-fish closed-loop direction tracking
source_mechanism: large observed course error requests a bounded mean-curvature redirect and releases continuously as the velocity course aligns
transferable_invariant: preserve the posterior-lag traveling wave while a full body-frame target-to-velocity direction error allocates bounded static curvature only where course alignment is inadequate
nontransferable_details: species-specific bend envelopes, published gains and cadence, prescribed stages, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: retain joint-state phase, distance/closing allocation, and the evaluated two-joint C-bend; derive redirect magnitude and sign from the scale-free cross/dot angle of `target_body_L` and `velocity_body_U`, independently of the limited pure-pursuit angle
falsification: reject if the known capture is lost or delayed, the first-pass miss returns, actuator-limit residence rises, or the coherent alternating and three-dimensional wake structures degrade

## Offline semantic audit after editing

Reconstructing both redirect angles from the sampled trajectories confirms the
scope of the change. On all `1,474` rows inside `6L` in the selected
course-redirect capture, the full target angle remains within the route
controller's `+/-1.2 rad` limit, so the new cross/dot course error is identical
to the evaluated expression to numerical tolerance. In the broad-loop failure,
the target exceeds that limit on `3,440` of `4,297` rows inside `6L`; there the
old reuse of the limited angle can differ from the full vector course error by
as much as `1.38 rad`. This audit supports retaining the known capture path
while making post-miss recovery semantics materially less ambiguous; it is not
a substitute for the downstream CFD evaluation.
