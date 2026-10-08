# Joint-speed-envelope candidate

## Visual and quantitative diagnosis before editing

- The assigned parent guidance, all four sampled solver results, the parent
  optimization note, and the completed inherited parent evaluation were read
  before proposing this edit. Every inspected rollout used direct uniform still
  water (`U_infinity=(0,0,0)`), no cylinders, and no prewarm snapshot.
- Both rows of the combined keyframe sheets were inspected. The sampled v24
  progress baseline and the inherited v27 pressure-gated result are visually
  almost coincident: the top-down row shows a self-propelled, target-directed
  arc behind a strong alternating wake, and the oblique row shows coherent
  paired three-dimensional Lambda2 structures through capture. There is no
  visible carrier collapse or passive background advection. Their small
  terminal differences are below keyframe resolution, so the trajectory,
  action, and load histories must decide the next mechanism.
- The direct v24 phase-demodulated course brake is the sampled progress
  baseline: it captured at `23.8315T` with mean distance `2.434073L`. Hard
  course/yaw consensus and yaw-selected direction captured later at
  `23.8590T` and `23.8535T` without materially reducing near-target yaw,
  cross-track motion, or loads. Applying the course bend only on a nominally
  supporting half-cycle reduced peak and inside-`3L` yaw but regressed capture
  to `23.9085T`, mean distance to `2.434609L`, and score to `-0.536251`.
- The assigned parent's v27 command-pressure-gated residual allocator also
  retained capture and the coherent wake, but falsified its improvement
  hypothesis: score regressed to `-0.537642` and mean distance to `2.435590L`.
  Although its within-`95%` acceleration exposure fell from v24's
  `55.11/39.90%` to `53.15/37.42%` (anterior/posterior), inside-`3L` mean
  absolute yaw and target-transverse speed increased from `1.684 rad/T` and
  `0.229U` to `1.704 rad/T` and `0.233U` under the same trace calculation.
  Command pressure therefore did not isolate useful steering/propulsion
  conflict, and another terminal residual-sharing variant is not supported.
- A different constraint symptom survives all sampled semantic variants: v24
  spends `19.76%` and `9.37%` of recorded steps within `95%` of the anterior
  and posterior joint-speed limits, and both joints reach the exact physical
  cap. Component-wise acceleration projection bounds the command but cannot
  prevent it from continuing to push an already fast joint outward. That is a
  distinct state-feasibility problem rather than evidence for another steering
  gain or route cue.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and low-dimensional robotic-fish CPG control
source_mechanism: preserve the state-derived rhythmic carrier while enforcing physical feasibility continuously from observed actuator state
transferable_invariant: keep the traveling bend and full inward braking authority, but do not command an already-near-limit joint farther outward
nontransferable_details: published oscillator gains, dimensional frequencies, species-specific envelopes, exact vortex phases, duty ratios, and task-specific routes
policy_translation: restore the evaluated v24 body-frame course controller; after composing each joint's carrier and steering acceleration, smoothly fade only the outward component between a parameter-owned soft speed boundary and the unchanged hard speed limit, then retain the existing acceleration projection
falsification: reject if capture or coherent wake topology is lost, if arrival or mean distance materially regresses, or if joint-speed exposure fails to fall without a compensating improvement in distance, yaw, load, and command histories
```

## Candidate hypothesis recorded before policy edit

Use v24 as the sole carrier and route controller, preserving its state-feedback
traveling wave, successful same-sign C-bend, response-triggered release,
carrier-rejected terminal course direction, and smooth acceleration bound.
Add one component-wise speed-viability projection after carrier and steering
commands are combined. Below a parameter-owned fraction of the known joint
speed envelope, output is exactly v24. Above it, acceleration aligned with the
current joint velocity is smoothly reduced to zero at the hard limit;
acceleration opposing velocity is unchanged so the controller can always
brake and re-enter the interior.

This mechanism uses only normalized joint speed and the existing body-frame
target feedback. It adds no time, mutable phase, world coordinates, route,
case identity, or altered actuator limit. The expected useful signature is
less joint-speed clipping with the same broad capture path and coherent wake;
the formal CFD result will occur only after this worker exits and is not
claimed here.

## Non-CFD verification

- The guidance materiality/notes check and solver boundary/schema guard pass.
- The lightweight Julia policy contract passes through the available
  `julia-vanda` wrapper; the literal `julia` executable requested by the
  checker is not installed on this shell.
- Direct comparison with sampled v24 confirms identical policy output below
  the soft speed boundary. Unit probes confirm continuous outward attenuation,
  unchanged inward braking, finite fallback behavior, and reflection
  equivariance of the component-wise speed projection.
- The independent fallback audit reports PASS for guidance materiality, Julia
  contract, boundary/schema, parameter ownership, and the one-candidate rule.
  No CFD was run.
