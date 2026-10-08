# Evidence-selected course-preview candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still-water initialization with `U_infinity=[0,0,0]`, no cylinders
  or prewarm, finite dynamics, and moving-window transport. Their motion and
  wakes are self-generated rather than imposed advection.
- Both rows of all four combined keyframe sheets were inspected. The prefilled
  steering-priority policy and its two terminal-allocation siblings retain a
  coherent alternating top-down wake and compact oblique Lambda2 structures,
  but pass outside the `0.75L` capture circle at `1.076--1.148L` and continue
  into the same upper/left runout. The inherited terminal-priority bridge and
  terminal carrier-allocation hypotheses therefore do not repair the route.
- The course-preview sibling is the semantic discriminator. It preserves the
  coherent three-dimensional propulsive wake, redirects earlier instead of
  waiting for posterior passage, and captures at `24.580T` with final distance
  `0.74697L` and mean distance `2.360L`. Its other sampled siblings remain
  finite left-domain failures with mean distance `6.178--6.289L`.
- The capture is not load-free. Relative to the prefill, exact trace replay
  shows any raw acceleration-envelope exposure falls from `74.65%` to
  `72.84%`, but posterior raw-command exposure rises from `32.11%` to
  `47.33%`, joint-rate-limit exposure rises from `13.09%` to `15.15%`, and
  posterior hard-angle occupancy rises from `13.60%` to `23.38%`. Peak force
  magnitude/yaw moment are nevertheless lower (`0.323/0.143` versus
  `0.466/0.211`), and capture terminates before the failure runout. This
  supports preserving the bounded course branch exactly while treating its
  posterior saturation as the boundary for later safety work.

## Policy hypothesis

Materialize the evaluated course-preview sibling unchanged as this workspace's
single candidate. Preserve the inherited traveling-wave carrier, closing-sector
steering-priority allocator, and posterior recapture, while adding the one
validated preview branch that compares normalized body-frame translational
course with normalized body-frame target direction. Gate it continuously by
speed, closing progress, and target distance, and blend it only through unused
signed steering-request headroom. This keeps the branch rotation-invariant,
mirror-equivariant, bounded, and dormant outside the evidenced preview region.

The falsifiable expectation is a repeated capture-class trajectory with no
far-field command change, coherent wake formation, and no increase beyond the
sampled load/saturation class. Reject the transfer if the new CFD loses
capture, changes the far approach, recreates the `1.076--1.148L` passage and
upper/left runout, or materially exceeds the sampled posterior angle/rate
occupancy. Do not infer the unevaluated rollout outcome from same-state replay.

bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: observed route error modulates bounded rhythmic steering before passage, with continuous release as the measured course aligns
transferable_invariant: separate target-relative translational course error from oscillating body-heading error, prioritize bounded redirect only while the predicted route misses, and return unused authority continuously to the traveling-wave carrier
nontransferable_details: species-specific C-start shapes, published gains, motor timing, dimensional cadence, exact vortex phase, full-body kinematics, turning radius, and any task-specific route
policy_translation: use the signed cross product of normalized body-frame velocity and target direction, gated by normalized speed, distance, and closing progress, as a bounded addition to the existing two-joint steering-priority request without a clock or stored mode
falsification: reject if far commands change, target-course alignment does not release the branch, capture is lost, wake coherence fails, or posterior joint saturation/load rises materially above the sampled capture

## Pre-evaluation checks

- The materialized policy has SHA-256
  `8eb190fa0e15fd9c84bd18439ba75b37338dba0742c19850d2d3fb9e57a126b0`,
  byte-identical to the sampled capture controller. All `78` direct
  `params.FIELD` references resolve among the `80` fields returned by
  `target_policy_params()`, and the source has no clock, random, cylinder, or
  world-target state dependency.
- The required reusable-guidance check, lightweight Julia public-contract
  check, and solver editable-boundary audit pass. The configured check-runner
  was invoked, but its pinned `gpt-5.4-mini` model is unavailable for this
  ChatGPT account, so the three prescribed no-CFD commands were also executed
  directly and separately.
- No formal CFD was run. The sampled capture is evidence for selecting this
  candidate, not a claim about the post-worker evaluation.
