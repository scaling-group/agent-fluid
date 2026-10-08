# Target-drift-gated phase-correction candidate

## Evidence and visual diagnosis before editing

- I read the assigned-parent guidance, all four sampled solver results, and the
  inherited v34, v37, and v38 optimizer notes and completed scores before
  selecting this candidate. Every compared rollout used direct uniform still
  water at `U_infinity=(0,0,0)`, without cylinders or prewarm, remained finite,
  and terminated in capture.
- The samples reduce to two trajectories. Three exact v37 replicas capture at
  `23.837021T`, score `-0.53501328`, and have scoring mean/final distance
  `2.433468/0.746096L`. The distinct v33 sample captures at `23.842522T`, score
  `-0.53509095`, and has mean/final distance `2.433543/0.746165L`. This confirms
  the split course/phase observer as a small, deterministic semantic
  improvement rather than treating repeated captures as independent evidence.
- I inspected both the top-down vorticity and oblique three-dimensional
  Lambda2 rows for sampled v33 and v37 and for inherited v38, from release to
  capture. All start in empty water, visibly self-propel along nearly the same
  target-directed arc, and retain an ordered alternating red/blue vortex street
  and compact three-dimensional wake structures through the terminal bend.
  None shows passive advection, wake breakup, collision, boundary exit, or
  instability. The visual sheets cannot resolve the terminal controller
  difference, so target-line kinematics and load histories decide it.
- Inherited v38 is the informative regression. Replacing v37's distributed
  phase-response magnitude with the anterior course-response magnitude keeps
  the same `23.837021T` capture step and lowers inside-`3L` mean absolute yaw
  from `1.6794` to `1.6657 rad/T`, but worsens score to `-0.53521221`, scoring
  mean/final distance to `2.433604/0.746410L`, and peak absolute moment from
  `0.013581` to `0.014081`. Inside `1L`, mean radial closing speed falls from
  `0.6687` to `0.6508U` while mean absolute target-cross-track speed rises from
  `0.3724` to `0.3773U`. Lower yaw alone therefore is not a valid terminal
  objective; correction must remain conditional on target-relevant motion.

## Single policy hypothesis

Preserve v37's normalized body-frame target guidance, response-released C-bend,
posterior traveling wave, continuous anterior-only course brake, distributed
phase-yaw observer, cadence, and smooth component-wise acceleration projection.
Change only the small phase-selected anterior counter-curvature: multiply it by
a continuous gate derived from the magnitude of the already normalized,
carrier-adjusted target-cross-track response. The gate retains a parameter-owned
floor, so phase regulation never disappears, and approaches full strength only
when measured target-orthogonal translation supports intervention.

This tests a distinct goal-relevance mechanism rather than another observer
coefficient or categorical sign gate. The expected effect is to preserve useful
radial closure when oscillatory yaw is not producing much target drift, while
retaining v37's phase correction when cross-track motion is substantial. Reject
the candidate if capture is lost or delayed, scoring mean/final distance does
not hold v37 scale, the coherent alternating wake changes, terminal radial
closing or cross-track motion worsens, peak yaw/moment grows materially, or
joint/command-limit exposure increases. The candidate remains unevaluated until
the post-worker CFD run.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal target capture
source_mechanism: keep the thrust-producing rhythmic carrier intact while slow target-relevant motion conditions the smallest bounded fast correction
transferable_invariant: separate propulsion, persistent route authority, and fast phase regulation, and apply the latter strongly only when normalized body-frame target-orthogonal drift shows it is goal-relevant
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, hardware duty ratios, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: preserve v37's two-joint carrier and course brake; softly gate only its anterior half-cycle counter-curvature with the magnitude of the normalized carrier-adjusted target-cross-track response
falsification: reject unless CFD preserves v37-scale capture, distance progress, radial closing, wake coherence, and actuator behavior while holding or improving target-cross-track motion, terminal yaw, and moment

## Validation boundary

- The guidance-materiality check and solver boundary check pass. Exactly one
  nonempty `candidate_target_policy.jl` exists under `solver/`.
- The deterministic schema audit finds all `70` direct `params.FIELD`
  references among the `72` fields returned by `target_policy_params()`, with
  no missing declaration; only metadata fields `version` and `control_period`
  are unreferenced. Static guards find no executable clock, step, randomness,
  file I/O, cylinder/task identity, mutable global state, or memorized route.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this ChatGPT account. Its Julia smoke command also cannot
  start because no Julia executable is installed. No formal CFD was run; this
  candidate remains a falsifiable hypothesis for the post-worker evaluator.
