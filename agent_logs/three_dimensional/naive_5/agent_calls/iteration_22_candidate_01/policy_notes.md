# Coupled acceleration-envelope promotion

## Visual and metric diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and terminate in capture.
  Three are the same speed-guarded policy and byte-match in their combined
  visual sheet, trajectory, and `0.749366L` capture at `27.5770T`; they show
  fixed-condition determinism, not trajectory diversity or held-out
  robustness.
- In both the top-down vorticity row and oblique body/Lambda2 row, the assigned
  speed-guard parent genuinely self-propels from rest, leaves a coherent
  alternating three-dimensional wake through 255 moving-window shifts, and
  makes a late correct-sign hook into the capture circle. The wake trails the
  body while the storage window follows it, so translation is not imposed-flow
  advection or a window artifact. That controller has zero angle and exact
  speed contacts, but independently clips 1,686 of 10,028 joint commands at
  `30 rad/T^2`; peak planar force and yaw moment are `0.02218` and `0.01034`.
- The non-duplicate sampled coupled-envelope rollout preserves an organized
  wake and target-directed route in both views, but reaches capture earlier and
  along a visibly different late trajectory: `0.749242L` at `26.2955T`, with
  distance integral `2.51998L` rather than `2.61279L`. Its smooth common command
  compression removes every exact acceleration-clamp sample, retains zero
  angle and speed contacts, limits the largest action to `29.72585 rad/T^2`,
  and lowers peak planar force/yaw moment to `0.01883/0.00979`.
- The assigned parent's inherited logs supply the informative failures absent
  from the current all-capture sample: stronger scalar rate braking left 34
  speed contacts and increased clamp and load exposure, while terminal pulses,
  damping, recoil, deeper curvature, and beat-scale intercept holds retained
  coherent wakes but missed at roughly `0.828--1.096L` or diverged earlier.
  The latest terminal miss-gate union also reproduced capture at
  `0.749409L/27.5770T` without a semantic or safety improvement. These results
  do not support reopening terminal-waveform, scalar-governor, or navigation-
  threshold tuning while a sampled coordination-preserving envelope already
  improves arrival, integral distance, clipping, and loads.

## Policy hypothesis

Promote the evaluated coupled acceleration-envelope projection onto the
assigned speed- and angle-guarded line-of-sight controller without changing
its traveling-bend carrier, target/course selector, redirect, terminal release
logic, positive response-deficit steering, or joint-state viability guards.
Below a soft two-joint command band, pass both accelerations through exactly.
Above it, smoothly compress the larger requested magnitude toward the existing
policy limit and scale both commands by the same factor, preserving their
instantaneous direction and anterior/posterior ratio. Keep the angle and speed
guards downstream so emergency inward braking retains full authority.

The sampled CFD result makes repeat capture with the coherent wake, zero
angle/rate contacts, no hard acceleration clipping, earlier arrival, and lower
loads the evidence-backed expectation. Reject the mechanism if this independent
evaluation loses capture or wake coherence, changes sub-band commands, restores
joint contacts or hard clipping, weakens downstream braking, or increases
arrival time, distance integral, planar force, or yaw moment. The new formal
evaluation occurs after this worker exits and is not claimed as current-worker
evidence.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: directional anterior-to-posterior coordination sustains reactive propulsion while bounded feedback modulates rather than replaces the rhythmic carrier
transferable_invariant: when enforcing a shared actuator envelope on a productive two-joint traveling bend, preserve the instantaneous command direction and inter-joint ratio wherever state-safety feedback does not require braking
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body waveforms, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain normalized body-frame target-line feedback; apply one smooth common scale to the two requested joint accelerations only above a normalized soft command band, before the unchanged state-based angle and speed guards
falsification: reject if repeat capture or coherent propulsion is lost, sub-band commands change, downstream safety braking is weakened, joint contact or hard clipping returns, or arrival, distance integral, force, or yaw-moment exposure worsens

## Non-CFD implementation audit

- The required checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account. Its three exact checks were run directly and
  separately: the guidance semantic-delta/schema check, finite two-joint Julia
  policy contract, and solver editable-boundary check all pass. No CFD was run.
- Exactly one non-empty candidate exists under `solver/`. Its executable
  projection matches the completed sampled `solver_5de1fba6b9e8` mechanism;
  only the explanatory comment differs. The new direct parameter reference is
  owned by `target_policy_params()`, and the hard clamp remains the final
  bounded numerical guard after the unchanged angle and speed filters.
