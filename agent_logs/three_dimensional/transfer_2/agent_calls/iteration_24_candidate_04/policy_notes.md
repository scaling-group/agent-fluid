# Evidence-selected predicted-miss corridor candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment: direct uniform
  still-water initialization (`U_infinity=[0,0,0]`), no cylinders, no prewarm,
  and the L64 inertial moving window.  Three v39 samples have byte-identical
  policies, `4487`-row trajectories, and combined keyframe sheets; they capture
  at `24.6785T`, minimum/final distance `0.748602L`, mean distance
  `2.348208L`, and score `-0.448571249`.
- Both the top-down mid-plane-vorticity and oblique Lambda2 rows of a replicated
  v39 capture and the distinct v40 capture were inspected from release through
  termination.  Both start wake-free, then show self-propelled diagonal
  progress with a coherent alternating wake and compact three-dimensional
  structures through the same bounded final hook.  Neither sheet suggests
  passive advection, wake breakup, instability, out-of-plane escape, or a
  moving-window artifact.  The two routes are visually indistinguishable at
  sheet resolution, so the v40 judgment below is anchored to trajectories and
  diagnostics rather than vortex appearance alone.
- V40 replaces the terminal objective of reducing velocity-course angle with a
  normalized body-frame constant-velocity lateral-miss corridor.  Relative to
  replicated v39, it retains capture but arrives `0.01650T` and three samples
  earlier (`24.6620T`, `4484` rows), improves mean distance from
  `2.34820783L` to `2.34817347L`, and improves score from `-0.448571249` to
  `-0.448570730`.  Final distance changes only from `0.748602L` to
  `0.748606L`.  This is a small semantic allocation improvement, not a new
  route or wake class.
- The completed rollout supports the corridor's error definition more than
  terminal alignment: final absolute course angle changes slightly adversely
  from `58.221` to `58.415 deg`, but the projected lateral miss remains inside
  capture at about `0.638L`.  Peak absolute body-frame planar force and yaw
  moment remain in the same low class (`0.0229/0.0318/0.0157` for v40 versus
  `0.0233/0.0320/0.0156` for v39), both have zero sampled joint hard-stop
  occupancy, and any-joint exact-rate exposure remains about `13.9%`.
- No boundary-exit keyframe is present in the current sampled workspace.  The
  informative failure contrast is therefore the inherited audited evidence,
  not an invented visual claim: dual-joint velocity barriers reduced rate-limit
  occupancy but missed at `0.933/0.848L` and exited left, terminal carrier
  holds worsened distance/load metrics, and v38's posterior course-continuity
  bridge failed to improve terminal alignment.  These failures bound the safe
  selection: preserve the anterior phase anchor, posterior traveling wave,
  stroke reserve, posterior coast, and far route.

## Policy hypothesis

Replace the v39 prefill with the byte-identical completed v40 predicted-miss
corridor policy.  Preserve every carrier and safety layer.  After body-axis
passage, use the already normalized target direction and body-frame velocity to
continue the established bounded course steering only while constant-velocity
lateral projection predicts a miss outside a smooth owned corridor.  Once the
projection is capture-directed, release only that additional terminal course
support; do not slow the oscillator, change the far path, or add a new
acceleration source.

Expected post-exit evidence is deterministic reproduction of the v40 family:
capture near `24.662T`, mean distance no worse than `2.348174L`, the established
coherent three-dimensional wake, zero posterior hard-stop occupancy, and the
same low force/moment class.  Falsify the selection if replication loses
capture or the score/arrival advantage, changes the route outside the existing
`2.10L` approach neighborhood, allows projected miss to leave the capture
corridor after entry, or regresses hard-stop, rate, acceleration, force, or
moment behavior.  The current candidate's CFD result is not available to this
worker and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish coupled oscillators and terminal capture control
source_mechanism: retain a stable traveling-bend rhythm while bounded sensory direction feedback remains active only until the task-relevant intercept is achieved
transferable_invariant: preserve the anterior phase anchor and posterior traveling wave, and release extra course correction when normalized body-frame velocity projection indicates a safe intercept rather than demanding body-axis alignment
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, robot morphology, exact corridor thresholds, prescribed paths, vortex phases, Strouhal targets, and task-specific routes
policy_translation: select the evaluated policy that gates only post-passage course support with normalized range and target-relative body-frame velocity projection while preserving all carrier and safety feedback
falsification: reject if capture, the established far route, coherent wake, zero posterior hard-stop occupancy, or low-load class is lost, or if the corridor fails to release terminal course support while projected miss is safe

## Pre-evaluation validation

- The single candidate is byte-identical to the positively evaluated v40
  sample (LF SHA-256
  `8122d88611c32f23241b9fe8c1f8f9e6f6e9430f3f014598a8f2f179d09efbeb`).
  This is evidence selection from completed sampled CFD, not a same-worker CFD
  claim.
- The public Julia contract returns exactly two finite accelerations.  The
  deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
- The required check runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account.  Its three exact no-CFD checks were then run
  locally and separately.  After removing the duplicated marker for the same
  assigned parent in the rendered workspace README, reusable-guidance
  semantics, the Julia policy contract, and the solver editable-boundary check
  all pass.  No formal CFD was run.
