# History-consistent closing-response candidate

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. All capture stably, so there is no sampled termination failure;
  the assigned common-envelope parent is instead the informative baseline for
  route cost and feedback semantics.
- Both the assigned parent's and the best finite sample's combined sheets were
  inspected from release through capture. Their top-down rows show genuine
  self-propulsion from rest, an organized alternating wake, monotone approach,
  and a smooth late hook into the capture disk. Their oblique rows retain a
  connected three-dimensional Lambda2 wake through the same maneuver. The
  wake trails the fish in both views, so neither translation nor yaw is
  imposed advection or a moving-window artifact.
- The assigned parent captures at `0.749241710L` and `26.295521T`, with zero
  angle, speed, and acceleration contacts, maximum joint angle/speed
  `0.772361 rad`/`4.512809 rad/T`, and peak planar force/yaw moment
  `0.0188344/0.00978884`. The coordinated command envelope and downstream
  joint-viability guards therefore remain useful and are preserved.
- The duplicated anterior capture-corridor response sample captures at
  `0.749089539L` and `26.301020T`; inherited analysis found only about
  `0.0025L` maximum aligned head-path displacement. The sampled posterior
  phase-lag allocation captures at `0.748829007L` and `26.295521T`, but direct
  trajectory comparison shows only `0.000924L` maximum head displacement from
  the parent. Both variants retain the parent's exact peak load, joint-state,
  and command extrema and zero contacts. These milliscale path changes do not
  survive as semantic improvement and falsify further amplitude or allocation
  tuning inside the same terminal corridor.
- On the assigned-parent trace, the stepwise normalized closing-speed estimate
  and the existing eight-sample window estimate disagree in sign on `23/4780`
  transitions. Their smooth closing gates differ by more than `0.1` on 48
  transitions during low-speed startup, while the two estimates converge once
  sustained translation is established. Thus the current instantaneous
  derivative injects carrier-phase variation specifically when navigation
  authority is ramping up, even though the visible carrier itself is coherent.

## Policy hypothesis

Preserve the complete capture-proven traveling bend, target-line response,
redirect and release logic, coordinated acceleration envelope, and angle/rate
viability guards. Make one feedback-semantic change: form the existing closing
gate from the provided normalized `window_closing_speed_L` rather than the
single-step `closing_speed_L`. The target-line rate is already estimated over
the same observation history, so using a history-consistent closing trend
should prevent beat-phase fluctuations from switching its authority during
startup while leaving the fully saturated gate and terminal carrier nearly
unchanged.

The formal expectation is repeat capture with the same coherent two-view wake,
zero actuator contacts, and no load increase, together with smoother early
navigation modulation and no worse arrival or mean distance than the assigned
parent. Reject the mechanism if capture or wake coherence is lost, the startup
route bends away from the target, limit/load exposure returns, or the
history-based gate merely delays useful response. The new CFD result is
produced only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and separation of persistent route error from rhythmic wake-scale disturbances
source_mechanism: modulate a coordinated propulsive rhythm with bounded feedback whose navigation-scale signals are separated from fast carrier-phase variation
transferable_invariant: persistent target-line feedback should be gated by a normalized closing trend measured on a consistent observation window, while an already productive traveling carrier passes through unchanged
nontransferable_details: published gains, dimensional filter periods, robot-specific sampling rates, species kinematics, exact vortex phases, full-body waveforms, and prescribed routes
policy_translation: retain the two-joint state-feedback policy and replace only its instantaneous normalized closing-speed gate input with the supplied eight-sample normalized closing-speed history used alongside the windowed bearing rate
falsification: reject if capture, wake coherence, arrival, actuator viability, or force/moment exposure worsens, or if early navigation modulation is delayed without reducing carrier-phase switching

## Non-CFD implementation audit

- The mandated `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three declared
  commands were run directly and separately instead. After removing one
  duplicated assigned-parent marker from the rendered workspace `README.md`,
  the guidance semantic/schema check, finite Julia two-joint contract, and
  solver editable-boundary check all pass. No CFD was run.
- A deterministic grid of `6561` finite states reaches at most
  `29.877709 rad/T^2`, below the existing `30 rad/T^2` policy limit, and has
  exactly zero lateral-reflection error. It also confirms that changing only
  the deprecated instantaneous closing value cannot affect output, while the
  windowed closing observation can materially modulate the response gate.
- A frozen-state replay reconstructed from the assigned-parent trajectory
  changes `464/4781` commands only from `0.0165T` through `5.6540T`; the
  maximum per-joint difference is `0.17444 rad/T^2`, and no command from
  `24T` through capture changes. This checks mechanism locality, not the
  unevaluated coupled CFD trajectory or its performance.
