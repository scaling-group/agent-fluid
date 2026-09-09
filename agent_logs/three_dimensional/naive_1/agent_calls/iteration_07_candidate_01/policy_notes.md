# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the edit

All four sampled evaluations satisfy the frozen evidence contract: direct
uniform initialization in still water with `U_infinity=[0,0,0]`, no cylinders
or prewarm, finite dynamics, and valid moving-window transport. I inspected
their combined top-down vorticity and oblique body/Lambda2 sheets, and compared
the best-scored capture against the inherited outward-rate-guard failure. I
cross-checked those views against `wake_metrics.csv`, `trajectory.csv`,
`wake_diagnostics.json`, controller sources, assigned-parent guidance, and
inherited optimization notes.

The current sample is a repeated-capture family, not four independent gain
answers. The unmodified differential-curvature controller captures in both
sampled repeats at `19.228T` and `19.321T`, with mean scored distances
`2.1185L` and `2.1279L`. Its top-down rows retain a coherent alternating street
through first crossing, and its oblique row shows compact finite caudal
Lambda2 structures along a target-directed trace. The step-6 terminal raw
body-lateral-velocity lead also captures at `19.129T` and `2.1245L`, but those
values remain inside the baseline repeat band. Inside `1.5L`, its mean absolute
line-of-sight transverse speed is `0.251U`; the behaviorally equivalent hard-
projection baseline independently gives `0.249U`, while the other two baseline
repeats span `0.375--0.517U`. Thus neither scalar score nor one favorable
terminal trace isolates a benefit from the raw lateral-velocity lead.

The acceleration-projection rollout supplies a narrower positive result. It
hard-clamps only the completed public commands at `1800 deg/T^2`, captures at
`0.7464L` and `19.135T`, and preserves the same wake and route topology. It
eliminates raw acceleration over-request by construction while leaving joint-
rate contact (`10.81%/14.46%`) essentially unchanged from the unclamped
captures (`10.72--10.76%/14.32--14.46%`). This is output-envelope ownership,
not actuator relief. In contrast, the inherited rate-aware guard still shows
a coherent alternating top-down and compact 3D wake, but its oblique trace
continues along the high-side path: it reaches only `5.0277L` and exits at
`22.132T`. Wake coherence therefore cannot justify another rate taper.

The remaining terminal signal should be defined relative to the target line,
not the body axis. For target unit vector `(tx,ty)` and body velocity `(vx,vy)`,
`tx*vy-ty*vx` measures velocity transverse to the instantaneous line of sight.
It detects the large off-axis course caused by forward swimming even when raw
body-lateral velocity is near zero, which the step-6 lead misses. The current
captures show mean absolute values `0.249--0.517U` inside `1.5L`, supporting a
bounded terminal course residual while warning that any claimed improvement
must exceed this repeat variability.

## Single-candidate policy hypothesis

Preserve the evidenced oscillator, posterior lag, normalized lateral target
request, differential mean curvature, and one-sided yaw release. Replace the
step-6 raw body-lateral lead with a terminal line-of-sight course residual.
Project body velocity transverse to the normalized target vector, orient it by
the persistent target side, and use it only to increase curvature when the
course is adverse or release curvature when it is helpful. Ramp the residual
continuously inside `2.5L`, make it fully active inside `1.5L`, and clamp the
resulting steering magnitude so measured motion cannot reverse target-owned
turn sign. Finally apply the sampled behaviorally neutral hard projection to
the two completed acceleration commands.

This should retain the repeated capture and coherent traveling wake while
making the terminal correction geometrically valid when the body has large
forward speed. Falsify the course residual if capture is lost, high/low exit
topology returns, arrival or mean distance moves materially outside the repeat
band, or terminal line-of-sight transverse speed, actuator contact, force, or
moment histories worsen. Falsify envelope ownership if returned commands ever
exceed the policy-owned limit or if the applied trajectory differs from the
episode's existing projection for the same finite state. The new CFD outcome
is unavailable to this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking, residual CPG control, and actuator-limited rhythmic locomotion
source_mechanism: target-relative course correction around a low-dimensional propulsive rhythm with command-interface envelope projection
transferable_invariant: persistent body-frame target geometry owns steering sign, while target-relative transverse motion may modulate only steering magnitude and completed commands respect the physical envelope
nontransferable_details: published gains, dimensional speeds, motor models, species-specific kinematics, exact vortex phases, clocked CPG phase, full-body waveforms, and task-specific routes
policy_translation: form a normalized line-of-sight vector from `target_body_L`, project `velocity_body_U` transverse to it inside a continuous terminal-distance gate, add a bounded sign-preserving magnitude residual to differential curvature, and hard-project the completed two-joint accelerations
falsification: reject if capture or coherent wake is lost, boundary topology returns, terminal transverse course error or loads worsen beyond repeat variability, steering sign reverses, or returned acceleration exceeds the owned envelope
