# Course-observed redirect candidate

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, and inertial
  moving-window transport. All capture, so the useful comparison is route,
  arrival, actuator feasibility, and loads rather than the milliscale terminal
  distance alone.
- I inspected both rows of the combined sheets for the strongest sampled run
  (`solver_fb7bddf12f80`) and the assigned prefill
  (`solver_c526bc14a636`). Their top-down rows show genuine self-propulsion,
  regular alternating vortex shedding, and the same late upward hook into the
  target. Their oblique Lambda2 rows show a compact coherent three-dimensional
  wake through capture, without breakup, passive advection, a boundary event,
  or moving-window-induced rotation. The stronger run changes progress and
  timing, not the visible terminal topology.
- Metrics sharpen that comparison. The sampled upstream posterior-vectoring
  run captures at `0.748361L` and `26.1635T` with score `-0.607211`, versus
  the assigned prefill's `0.748591L`, `26.2405T`, and `-0.616154`. Its raw
  trajectory-row mean distance falls from `7.49392L` to `7.47982L`, but peak
  planar force rises from `0.018834` to `0.019441`; both retain zero joint
  angle, speed, and acceleration contacts. This supports acting earlier on
  translational route error, but the shared shallow hook and higher load do
  not support scalar-strengthening that posterior shift.
- The assigned artifact is byte-identical to the separately evaluated
  `solver_e07c5232a21a` policy and trajectory. It still enters the strong
  same-sign redirect only through folded body bearing. The inherited assigned-
  parent note proposes a course-gated early redirect, but that mechanism is
  absent from the evaluated policy. Therefore it remains an untested
  hypothesis, not a completed negative or positive result.
- On the assigned trace, inherited diagnostics report normalized
  velocity-to-target course error near `+0.690` at `8T` and `+0.514` at
  `16T`, with projected misses near `7.22L` and `3.21L`, while folded bearing
  is only about `-0.061` and `-0.181 rad`. The bearing-only redirect therefore
  stays weak while measured translation exposes the largest route error. By
  `22T`, projected miss is about `1.09L`, so the coherent middle/terminal
  carrier should pass through rather than receive another capture-scale edit.

## Policy hypothesis

Add one course-acquisition mechanism to the assigned prefill. When body-frame
translation is observable, closing is positive, normalized velocity-to-target
course error is large, and velocity-projected miss remains outside the sampled
middle/capture corridor, smoothly admit the existing same-sign two-joint
redirect even if folded bearing is small. Course/bearing blending continues to
select side, and the existing yaw/bend response gates release the redirect
back into the traveling carrier. Startup, low-speed motion, non-closing motion,
small course error, and the established middle/terminal corridor pass through
exactly. No propulsion gain, redirect target, terminal waveform, command
envelope, or route coordinate changes.

The falsifiable expectation is earlier target-directed translation and visible
pre-`4.5L` separation from the common route, followed by re-entry into the
coherent carrier before the terminal corridor. Reject the mechanism if capture
or wake coherence is lost, early distance progress does not improve, the
redirect persists into small projected miss, any actuator contact returns, or
peak planar force/yaw moment exceeds the sampled envelope.

bookshelf_consulted: true
source_domain: biological C-start turning and sensor-modulated robotic-fish direction control
source_mechanism: large observed route error engages bounded curvature and measured turn response releases back into the propulsive rhythm
transferable_invariant: use observed geometric error to engage a temporary redirect and observed response rather than elapsed time to release it
nontransferable_details: species kinematics, published gains, dimensional burst duration, robot linkage geometry, clock phase, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame course error, projected miss, closing speed, and translation confidence admit the existing two-joint redirect while its joint-state and phase-rejected yaw gates retain release authority
falsification: reject on no earlier target-directed progress, lost capture or coherent three-dimensional wake, redirect persistence in the middle/capture corridor, new actuator contact, or greater force and yaw-moment exposure

## Non-CFD audit after editing

- Reconstructing the new gate on the assigned parent's completed trace makes
  it materially active in `1781` rows above a `0.001` weight, from about
  `0.49T/12.33L` through `18.93T/4.62L`. Its weight is about `0.724` at `5T`
  and `0.797` at `8T`, when the reported route error is largest, and no row at
  or inside `4.5L` changes through this mechanism. This verifies upstream
  activation and exact middle/terminal containment only; it is not a CFD
  outcome.
- A synthetic active state changes the guarded two-joint command by up to
  `5.58 rad/T^2` relative to the assigned parent, while the later `4.0L`
  version of the same state is exactly command-identical. Paired lateral
  reflections have zero numerical command-reflection error, outputs are
  finite, and the `30 rad/T^2` policy envelope is retained.
- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account. Running its exact non-CFD checks separately
  exposed a duplicated assigned-parent marker in the rendered `README.md`;
  after removing that duplicate, the guidance semantic check, Julia public
  contract/parameter-schema check, and solver editable-boundary check all
  pass. Formal CFD was not run in this worker.
