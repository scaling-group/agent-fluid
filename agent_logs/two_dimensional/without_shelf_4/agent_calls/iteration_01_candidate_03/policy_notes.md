# Candidate wake-policy diagnosis

## Evidence read

The assigned parent is the fresh-lineage guidance in `guidance/`; its sampled
solver is the unchanged target-blind oscillator in `solver_f236e5345260`.
There are no separate inherited optimizer logs materialized in this workspace,
so the available inherited log evidence is the sampled evaluator observation,
metrics, diagnostics, and step output. No omitted bookshelf or neighboring
configuration was consulted.

The shared prewarm sheet shows a developed, asymmetric four-cylinder vortex
field before release, with the held fish well above and downstream of the
target marker. In the released sheet the fish initially points generally
toward the lower-left task direction, but then yaws sharply downward, develops
a tight high-amplitude body wave, and exits the lower boundary without entering
the target's wake corridor. The late frames show continued active bending, so
this is not a passive-advection or stalled-actuator failure.

The compact diagnostics agree with the pictures. The rollout ends
`left_domain` after only `50.1269` released time units. Head displacement is
`(-3.5452, -13.3003)L`, minimum target distance is `8.6150L`, and normalized
progress is only `0.0243`: lateral loss dominates the modest upstream motion.
Both rate limits are reached (`max_abs_phi_dot1/2 = 260 deg/time` and
`max_abs_phi_ddot1/2 = 1800 deg/time^2`) even though joint angles remain near
`26.5 deg`, below the `45 deg` bend limit. Mean command energy is high
(`1496.25`) and the run carries large lateral/moment loads (RMS `21.94` and
`541.70`). The aggregate local-flow and relative-crossflow metrics confirm a
strong unsteady environment, but they do not establish a calibrated causal
mapping from any instantaneous wake signal to a better action. Only one
sampled finite failure is available, so no best-versus-failure comparison can
support wake-phase feedback yet.

## Policy hypothesis

Preserve the state-feedback oscillator and traveling posterior lag, but make
the controller target-aware through the normalized body-frame bearing already
provided by the task contract. A bounded steering tangent will oppose bearing
error and measured body turn rate, split its mean bend across the two joints,
and leave the zero-error gait symmetric. This should arrest the one-sided yaw
before boundary exit without encoding coordinates, elapsed time, cylinder
identity, or a route. Slowing the rhythm and reducing its nominal acceleration
below the configured caps should prevent the actuator envelope from defining
the waveform while retaining active upstream propulsion.

The selected candidate uses a `0.90` period, `16 deg` oscillator scale,
`0.50` posterior lag, `0.90` tail damping, and an `18 deg` steering-tangent
limit. A deterministic joint-only integration of the same clamped update for
the full `300` horizon, with zero turn rate, produced no angle/rate/acceleration
clamps at either zero bearing or a constant `0.15 rad` bearing. The larger of
those two probes reached about `36.28 deg`, `223.70 deg/time`, and
`1579.99 deg/time^2`. This is only an actuator-envelope sanity check: changing
bearing and wake-driven turn rate can still raise commands, and it is not CFD
evidence of navigation quality.

The falsifiable expectation for the next CFD evaluation is survival beyond
`50.13`, substantially less than `13.30L` absolute vertical displacement at
that time scale, no persistent rate/acceleration saturation, and improved
minimum/mean target distance while retaining negative x displacement. If the
fish turns farther away from the target, the curvature-to-bearing sign is
wrong; if heading improves but upstream displacement collapses, later workers
should restore gait strength without removing bounded target feedback. If
heading remains controlled but wake entry causes a later failure, only then is
body-frame local-flow or force feedback supported as the next isolated test.
