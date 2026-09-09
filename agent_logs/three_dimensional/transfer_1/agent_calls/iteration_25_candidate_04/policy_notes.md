# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts and the assigned-parent rollout report direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. Their translation and wakes are therefore self-propelled behavior,
  not ambient advection.
- I inspected both rows of the combined keyframe sheets for the strongest
  sampled finite rollout, `solver_6b0e320e2f55`, and the assigned-parent
  mean-curvature failure. The capture lays down a coherent alternating
  mid-plane vortex street and compact oblique Lambda2 structures through its
  `18.601T` arrival. The failure retains the same qualitative traveling wake
  and remains self-propelled through a lower turn and domain exit; it is not a
  stalled carrier or a numerical instability.
- The two exact prefilled speed-reserve samples capture at
  `0.7480--0.7494L`, and the two posterior-wave samples also capture at
  `0.7480--0.7492L`. All arrive with speed `0.827--0.908L/T`; action clamping
  remains about `68.2--68.6%/70.6--71.0%`, exact speed-limit residence about
  `10.4--10.6%/11.3--11.5%`, maximum planar force `0.0302--0.0319`, and maximum
  yaw moment `0.0157--0.0167`. These results preserve the active carrier but
  do not justify another propulsion, allocation, or scalar-gain edit.
- The assigned parent's new phase-independent mean-curvature servo is a
  concrete negative result. It remained stable and wake-coherent, but missed
  at `1.8818L` and exited below. Its head was already lower at the first `4L`
  crossing (`y=10.436L`, versus `10.946--11.164L` in the four captures) and
  fell to `y=9.787L` at `3L`, so a slow average-bend residual did not recover
  the branch and must not be tuned or replayed.
- The trace identifies a different observable defect. Over the `4L` to
  `2.75L` interval, all four captures independently give the same least-squares
  beat-scale body-frame sway relation,
  `velocity_y = -0.096*phi_dot_1 + 0.038*phi_dot_2`, with residual RMSE
  `0.019--0.030L/T`. The two exact baseline captures pooled have residual mean
  `-0.0023L/T`; the failed parent has persistent residual sway near
  `-0.085L/T`. Thus the existing achieved-course servo is steering on a sum of
  useful slow drift and a large, predictable carrier oscillation.

## One candidate hypothesis

Retain the exact speed-reserve carrier, additive steering realization,
response release, intercept guard, and all actuator handling. Add one
terminal course-demodulation mechanism: from `4L` inward, smoothly subtract
the joint-state-predicted carrier sway from only the lateral velocity used by
the achieved-course angle, reaching full demodulation at `3L`. Keep raw
velocity in speed, line-of-sight rate, projected miss, approach alignment, and
all physical guards. This changes the route observation rather than adding
curvature, changing a carrier half-cycle, or tuning route gain.

Expected test: the far-field trajectory must remain byte-for-byte equivalent
in control structure outside `4L`; inside, the course command should respond
to persistent lower-branch drift rather than alternate with tail-beat sway.
The candidate should retain an active traveling wake and capture while making
the `4L` to `2.75L` approach less phase-sensitive.

Falsification: reject course demodulation if it changes far-field closure,
weakens either wake view, produces the same lower pass or a new upper pass,
loses capture on exact repeats, or exceeds the sampled baseline actuator,
force, or moment envelope. Do not answer a miss by tuning the two fitted
coefficients alone; first test whether the residual-sway sign and scale repeat
in the failed trajectory.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and wake-disturbance rejection
source_mechanism: separate the slow route command from fast rhythmic lateral motion while preserving the propulsive oscillator
transferable_invariant: carrier-correlated sway should not be interpreted as persistent achieved-course error when joint state exposes that carrier component
nontransferable_details: published CPG gains, dimensional cadence, species or robot kinematics, explicit oscillator or vortex phase, and task-specific coordinates or routes
policy_translation: inside a normalized body-frame distance gate, subtract the evidence-fitted two-joint velocity projection from lateral course velocity while leaving raw geometric and actuator guards unchanged
falsification: reject if exact repeats lose capture, either wake weakens, the terminal branch merely flips sides, or actuator and load metrics leave the repeat-backed baseline envelope
