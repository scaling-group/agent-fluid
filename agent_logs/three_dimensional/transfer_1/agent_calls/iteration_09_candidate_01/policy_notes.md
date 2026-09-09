# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled episodes use direct uniform still-water initialization with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Their translation is
  self-propulsion rather than imposed-flow advection, and all remain finite.
- Both rows of the assigned parent's combined sheet
  (`solver_29faa601686c`) show an alternating top-down vortex street and
  compact oblique Lambda2 structures from release through its terminal
  approach. The metrics and diagnostics agree with the visual evidence: it is
  the only sampled semantic success, capturing at `0.7493448L` and
  `18.6065T`, with `0.8471L/T` inertial speed at the crossing.
- The informative carrier-attenuation failure (`solver_a8af0d71b0de`) reaches
  `1.2669472L` but both visual rows show little new terminal wake after the
  pass. Its trace agrees: joint motion and action collapse while the fish
  retains `0.7766L/T` at closest approach, then coasts below the target and
  exits the lower boundary at `9.6564L`. The two rate/cascade failures retain
  coherent wakes but miss more broadly at `3.0031L` and `3.1135L`; neither
  supports changing cadence or adding route gain.
- The parent's inherited notes identify the last pre-capture failure as a
  `0.9312L` response-release near miss: joint-compensated yaw released shared
  steering while inertial line-of-sight geometry was still worsening. Its
  added LOS-rate guard re-engaged the existing course steering without
  suppressing the carrier or adding authority, and the completed CFD result
  crosses the capture boundary. This is a semantic improvement, not merely a
  scalar change.
- The success is close to the `0.75L` boundary and is not evidence for more
  authority: head/tail action reaches the acceleration clamp on about
  `68.8%/71.0%` of rows, both joints touch the `260 deg/T` speed limit, and
  the terminal head action is clamped. A new gain or duty-phase change would
  discard the only completed capture without a supporting rollout.

## One candidate policy

Adopt the assigned parent's completed LOS-guarded response-release controller
unchanged in executable structure and owned parameters. It preserves the
joint-state traveling-bend carrier and achieved-course steering, releases
shared steering only after a compatible phase-compensated yaw response, and
smoothly re-engages that same steering when body-frame target/velocity
geometry indicates a growing inertial line-of-sight miss. This replaces the
prefilled `3.1135L` cascade failure with the only sampled capture mechanism
without introducing a clock, world-frame route, mutable state, carrier
attenuation, or additional acceleration demand.

Expected signature: the new evaluation should reproduce broad target closure,
retain the alternating wake through the terminal approach, and terminate by
capture near `18.6T`. Falsify this retention decision if it loses capture,
changes the far-field route, weakens the terminal wake, or materially worsens
joint saturation or load histories. Because the sampled success is already
envelope-limited, later robustness work should first test whether capture and
LOS-rate reduction survive held-out conditions before changing gains.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish direction tracking
source_mechanism: release target-directed turning into a propulsive rhythm only when observed response and approach geometry agree
transferable_invariant: preserve the traveling carrier while normalized geometric response, rather than elapsed phase or route memory, decides whether bounded steering may be released or restored
nontransferable_details: species-specific C-start shapes, published CPG gains, robot geometry, dimensional cadence, prescribed beat or vortex phase, and task-specific routes
policy_translation: use body-frame target and velocity to guard joint-compensated yaw release, restoring the existing two-joint course-steering acceleration when signed inertial line-of-sight rate predicts a miss
falsification: reject if capture is lost, terminal line-of-sight error is not reduced, the coherent wake weakens, saturation or loads worsen materially, or the lower-exit topology returns
