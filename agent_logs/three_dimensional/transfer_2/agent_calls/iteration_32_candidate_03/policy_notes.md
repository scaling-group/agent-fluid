# Approach-restored carrier-coupling candidate

## Evidence and visual diagnosis written before editing

- All four sampled episodes satisfy the frozen rollout contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  moving-window transport, stable dynamics, and `capture`. There is no failed
  termination in this cohort, so the useful contrast is trajectory topology,
  distance integral, actuator residence, loads, and wake structure rather than
  capture status or the terminal-radius sample.
- I inspected the top-down vorticity and oblique body/Lambda2 rows of every
  sampled combined keyframe sheet from release through capture, using the
  highest-scoring `solver_1d05d22ea1fe` as the strongest finite example and
  the lowest-scoring `solver_3fdd63b3fbda` as the informative contrasting
  architecture because no failure example is present. Each fish starts in
  blank still water, develops a compact alternating caudal wake, and follows a
  continuous shallow target-directed arc. The oblique rows retain discrete
  coherent three-dimensional wake structures behind the caudal region. The
  motion is self-propelled rather than advected; no sheet shows collision,
  domain exit, wake collapse, wasteful unproductive flailing, or instability.
- Metrics separate a range-dependent controller effect that the nearly
  identical wake sheets cannot. The globally response-released carrier reaches
  `10/8/6L` at `5.808/7.761/9.724T`, ahead of the plain redirect-priority
  carrier at `5.863/7.838/9.779T`, but falls behind by `4L` and captures at
  `16.088T/1.82203L` rather than `16.044T/1.82409L`. Smoothly restoring full
  carrier coupling across the existing normalized `6--4L` handoff retains the
  early class (`5.825/7.788/9.718T`) and advances `4/3/2/1L` to
  `11.688/12.909/14.185/15.549T`, capturing at `15.939T` with the best sampled
  distance integral, `1.82008L`.
- The handoff improvement is not purchased with a longer hook or larger load.
  Its head path is `13.107L`, below the plain carrier's `13.178L` and the
  globally released carrier's `13.129L`; peak planar-force/yaw-moment
  coefficients are `0.03477/0.01715`, also below `0.03579/0.01770` and
  `0.03575/0.01781`. It keeps zero residence above 90% of either angle limit,
  terminal body-frame lateral speed near zero, and coherent wakes. Anterior
  and posterior residence above 90% rate remains material at `17.70/8.25%`,
  so this is a retained falsification boundary, not evidence that actuator
  cost is solved.
- The assigned parent and inherited step-30 notes warn that releasing added
  course curvature merely from same-sign yaw produces a `13.363L` terminal
  hook, `0.269 rad/T` sub-`2L` yaw, and `16.247T` capture. The inherited
  error-confirmed refinement repairs path/yaw to `13.169L/0.113 rad/T` but
  still captures at `16.082T/1.82621L`. Those results reject another redirect
  residual or scalar release-gain tune; the sampled improvement instead comes
  from preserving target-conditioned steering and changing only the
  range-specific rhythmic carrier coupling.

## Single-candidate policy hypothesis

Materialize the sampled approach-restored carrier controller as this
workspace's one candidate. Preserve its corrected-sign body-frame target
vector, distance/closing drive relief, velocity-course redirect, phase-aware
steering, posterior wave allocation, common carrier governor, bounds, and
public two-joint contract. Its one selected mechanism passes response-aligned
negative-work reversal while far, then multiplies that release by the
complement of the normalized `6--4L` handoff so the evaluated full
redirect-priority carrier is restored at and inside `4L`. This is architecture
selection from completed evidence, not scalar-only gain tuning.

Expected signature: reproduce the sampled early progress and coherent wake,
retain the shorter `4L`-to-capture trajectory and best timing/integral class,
and remain inside the sampled joint, command, force, moment, path, terminal
yaw/slip, and finite-action envelope. Falsify or replace it if a repeat loses
capture; timing/integral regress beyond the sampled repeat spread; the handoff
breaks the alternating traveling wake; or rate residence, joint margin, path,
load, terminal course, or either visual view worsens materially.

bookshelf_consulted: true
source_domain: biological C-start redirection, sensor-modulated robotic-fish CPG tracking, and terminal pursuit control
source_mechanism: release a bounded direction-priority maneuver from measured response into a phase-coupled propulsive rhythm, with a distinct continuous near-target regime
transferable_invariant: retain response-conditioned rhythmic release only over the normalized range where measured progress supports it, then restore coupled carrier authority before terminal capture
nontransferable_details: published gains and duty ratios, species-specific burst stages and kinematics, dimensional cadence, full-body waveforms, exact vortex phases, and task-specific coordinates or routes
policy_translation: use body-frame target/course error, normalized signed-yaw response, joint-state carrier work, and normalized distance to pass reversal while far and continuously restore the common two-joint carrier through approach without changing target steering
falsification: reject if far milestones regress, the 4L-to-capture timing and integral class is not retained, or path, rate residence, command, joint margin, load, terminal yaw/slip, finite action, or either coherent wake view deteriorates
