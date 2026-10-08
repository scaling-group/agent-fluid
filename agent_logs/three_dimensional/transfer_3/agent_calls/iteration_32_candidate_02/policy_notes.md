# Reproduced intercept-supported terminal posture candidate

## Evidence and visual diagnosis before the policy edit

- All sampled and inherited comparison rollouts satisfy the Phase-2 flow
  contract: direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  dynamics, and `capture` termination. There is no failed termination class,
  so the lower-quality captured trajectories are the informative failures.
- Three sampled solver evaluations reproduce the strongest result exactly:
  capture at `19.684490 T`, score `-0.261384287`, mean/final distance
  `2.151092787 L`/`0.748302400 L`, path length `12.951133 L`, and no joint
  stops. Two policies are byte-identical `v40` controllers; the nominally
  different course/yaw allocation produces the same trajectory because its
  new branch is dormant. Reproduction supports the underlying
  intercept-posture mechanism but supplies no evidence for the dormant branch.
- The assigned `v42_response_permissive_intercept_posture` parent has an
  identical outer rollout through the `4 L` crossing at `15.444014 T`, but
  retaining up to four percentage points more carrier during outward posture
  response delays capture by five solver steps to `19.711988 T`. It regresses
  score to `-0.261822240`, mean/final distance to
  `2.151500419 L`/`0.748728991 L`, and lengthens the path to `12.984927 L`.
  Lower terminal load maxima do not compensate for the worse course and
  distance integral.
- Inherited optimizer logs and completed evaluations close both remaining
  response hypotheses. Adding posture allocation while the coupled squared
  posture error is already decreasing captures one step later at
  `19.689989 T` and regresses to score `-0.261806754`; therefore response
  alignment is not a useful selector either. The outer phase-lag feasibility
  governor is the most informative failure: despite finite dynamics and
  eventual capture, it delays the `4/3/2 L` crossings, misses the direct
  terminal approach, loops, and captures only at `46.145020 T`. Its score is
  `-0.915605503`, mean distance is `2.857986094 L`, path length is
  `31.012702 L`, and moving-window shifts rise from `243` to `607`.
- I inspected the complete combined sheets for the reproduced `v40` winner,
  assigned `v42` parent, response-energy regression, and phase-lag failure,
  including every top-down mid-plane-vorticity and oblique body/Lambda2 view
  from release through capture. The `v40`, `v42`, and response-energy fish
  visibly self-propel from quiescent water on the same compact arc, shed a
  coherent alternating posterior wake, and retain finite localized 3D
  structures. The phase-lag governor initially sheds a similar wake but then
  turns away: the top-down train becomes long curved paired bands around a
  large loop, while the late oblique structures are sparse and spatially
  separated. Metrics confirm this is neither passive advection nor numerical
  instability; it is a stable but inefficient control-topology failure.
- The visual and numerical evidence therefore supports neither a new
  propulsion mode nor another response-conditioned terminal allocator. The
  only positive mechanism that survives is `v40`'s small actual-distance-,
  closure-, and center-intercept-supported handoff toward the existing damped
  two-joint mean-bend posture. Its outer traveling bend and wake should remain
  untouched.

## Policy hypothesis

Use the evaluated `v40_intercept_supported_terminal_posture` exactly as the
single candidate. Relative to the assigned parent, remove only the regressive
outward-response carrier-retention branch and retain the reproduced
state-feedback oscillator, target-angle redirect, geometry/course-agreed outer
allocator, center-course intercept corridor, closure preview, bounded
mean-curvature equilibrium, carrier floor, and actuator limit. Do not adopt
the inherited outer phase-lag governor or response-energy handoff: their
completed CFD results falsify those mechanisms in this topology.

This is evidence-backed mechanism selection rather than scalar-only gain
tuning. The expected result is reproduction of the compact `v40` path,
coherent two-view wake, capture near `19.6845 T`, score near `-0.2613843`, and
absence of joint-stop dwell. Falsify the candidate if exact policy
reproduction does not reproduce materially, capture is delayed or lost, the
distance integral or terminal command/load history regresses, a loop or exit
appears, the rollout becomes unstable, or either wake view degrades. The new
CFD evaluation occurs only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: continuous terminal approach-hold control and closed-loop CPG robotic-fish direction tracking
source_mechanism: hand off continuously from rhythmic propulsion toward a bounded posture only when observed target-relative approach state supports it
transferable_invariant: when rhythmic propulsion and posture control share actuators, keep the handoff small, continuous, and supported by normalized range, positive closure, and body-frame intercept geometry; reject added response or lag logic when completed rollouts worsen the useful trajectory
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: retain the reproduced two-joint center-intercept-supported posture allocation and remove the parent's regressive outward-response carrier retention without changing the outer traveling-bend law
falsification: reject on non-reproduction, slower or lost capture, worse distance integral, changed compact topology, renewed joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- The candidate is byte-identical to the strongest evaluated `v40` sample;
  both have SHA-256
  `624f4cec48f1a4c8d2eada4f72269efd16c22d4785955a09cd208447208cd659`.
  This preserves one candidate in the designated solver surface and removes
  only the assigned parent's falsified response-permissive branch.
- The material-guidance check initially exposed two identical copied-parent
  markers in the rendered workspace `README.md`. Removing only one duplicate
  marker repaired unambiguous parent resolution; notes and the materially
  revised evidence-backed lesson then pass the check.
- The lightweight Julia public-contract check returns exactly two finite
  accelerations. The deterministic schema audit resolves all `88` direct
  `params.FIELD` references against the `89` returned fields; only the version
  label is intentionally unused. The solver edit-boundary check passes.
- The prescribed `check-runner` was invoked after the required files were
  updated, but its pinned `gpt-5.4-mini` model is unsupported on this ChatGPT
  account and failed before executing a command. Its three configured checks
  were run directly and separately and all pass. No formal CFD was run in this
  workspace.
