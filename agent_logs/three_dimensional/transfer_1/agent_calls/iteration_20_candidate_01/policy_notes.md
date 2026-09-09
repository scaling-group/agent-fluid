# Wake-policy candidate diagnosis

## Evidence read before policy edit

- All four sampled rollouts and the inherited failure rollouts report direct
  uniform initialization at `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. Their translation and wake formation are released-swimmer behavior,
  not ambient advection.
- I inspected both the top-down vorticity row and oblique 3D Lambda2 row in
  every sampled combined keyframe sheet, then compared the highest-scoring
  finite baseline (`solver_6b0e320e2f55`) with the informative ungated
  half-cycle failure inherited at step 18. The three exact speed-reserve
  baseline samples sustain an alternating planar wake and compact paired 3D
  structures through captures at `0.7466--0.7494L`. The failure also keeps an
  active wake, but its whole-route steering change bends the trajectory below
  the target, reaches only `3.7595L`, and exits. This isolates path/control
  allocation rather than weak propulsion, wake collapse, or instability.
- The assigned parent's posterior wave-shape policy is the only sampled new
  mechanism. It also captures (`0.7492L` at `18.4690T`) while preserving the
  alternating top-down and oblique wakes. Relative to the three exact baseline
  samples, its head action-clamp fraction is `68.40%` versus
  `68.48--68.66%`, head speed-limit residence is `10.51%` versus
  `10.41--10.63%`, and peak lateral-force/yaw-moment coefficients remain
  inside the baseline ranges (`0.0286/0.0161`). Tail clamping and effort do not
  improve, and its mean distance (`2.04564L`) does not beat the best baseline
  (`2.03873L`). The evidence therefore supports mechanism compatibility, not
  a score or saturation improvement.
- Inherited logs show that a single threshold capture is not enough to call a
  terminal mechanism robust: the earlier response-conditioned policy captured
  once and then failed on an exact-policy repeat. The posterior mechanism has
  only one completed rollout. An exact repeat is more informative than gain
  tuning or stacking another terminal residual at this point.

## One candidate hypothesis

Repeat the assigned parent's exact posterior-wave-shape policy bytes. Preserve
the repeat-supported achieved-course/intercept servo, traveling carrier, and
sparse speed reserve, and add only its small posterior target-bias pulse inside
the existing `2.75L` intercept gate. The pulse uses normalized anterior joint
speed as a clock-free phase cue, is proportional to the existing body-frame
turn request, fades under the proven response release, and is algebraically
zero in the far field.

Expected test: a second capture with the same coherent two-view wake and loads
inside the baseline envelope would promote posterior wave shaping from a
one-run compatibility result to a repeat-supported terminal mechanism. Formal
CFD occurs only after this worker exits, so this candidate makes no same-worker
performance claim.

Falsification: reject or redesign the posterior pulse if this exact repeat
loses capture, changes broad distance closure, weakens the alternating wake,
or raises action/speed saturation, lateral force, or yaw moment outside the
repeat-supported baseline envelope. Even another capture does not establish a
score benefit unless later evidence improves arrival or mean distance.

bookshelf_consulted: true
source_domain: fish and robotic-fish turning by posterior phase-lag or wave-shape modulation
source_mechanism: embed a bounded target-directed curvature pulse in the posterior traveling wave while retaining the propulsive carrier
transferable_invariant: a small state-synchronous posterior wave-shape change can realize turning without replacing the active traveling bend
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, oscillator clocks, exact vortex phases, prescribed routes, and task coordinates
policy_translation: use normalized anterior joint speed and the existing body-frame turn, response, and intercept gates to apply a bounded posterior target bias that is exactly zero outside the terminal region
falsification: reject if exact-repeat capture, far-field closure, wake coherence, or the baseline saturation and load envelope is lost

## Non-CFD verification

- The required guidance-semantic check passes after removing the duplicated
  assigned-parent marker from the rendered workspace `README.md`.
- The solver editable-boundary check passes, and a static schema comparison
  finds no `params.FIELD` reference missing from `target_policy_params()`.
- The candidate SHA-256 is `393aac051dfa5d938ff7d56c3f86df355a494b578710d007bc9954ab3bfc265a`,
  byte-identical to the sampled direct-uniform posterior-wave-shape policy.
- The mandated Julia smoke-test command could not run because this worker
  container has no `julia` executable. This is an environment limitation, not
  a passing runtime assertion; the exact candidate bytes were nevertheless
  already exercised by the sampled finite capture. No CFD rollout was run.
