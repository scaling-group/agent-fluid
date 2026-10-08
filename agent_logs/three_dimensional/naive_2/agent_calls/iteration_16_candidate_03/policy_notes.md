# State-triggered carrier-recruitment candidate

## Visual and metric diagnosis before the edit

- All four sampled solvers are byte-identical copies of the assigned
  joint-phase-demodulated policy. Their trajectories and combined sheets are
  also byte-identical, and each reports direct-uniform still-water
  initialization with `U_infinity=[0,0,0]`, no cylinders, and no prewarm.
  Thus the repeated `0.7477L` capture at `16.637T` is deterministic fixed-case
  replication, not evidence for a changed pose or flow.
- I inspected the sampled capture sheet and the inherited closure-loss burst
  failure sheet. In the capture, the top-down row develops a coherent
  alternating vortex street and bends the self-propelled trajectory through
  the target; the oblique row retains tail-connected three-dimensional
  Lambda2 structures through termination. The inherited failure also has an
  alternating, connected wake, but its intact carrier turns past the target
  and exits the upper boundary at `25.05T` after a `3.254L` minimum. This
  comparison makes route semantics, rather than advection or gross wake
  coherence, the reason to preserve the phase-demodulated incumbent.
- The sampled capture trajectory exposes one separable deficit before that
  proven route is established. The normalized anterior phase radius
  `hypot(q1/A, q1_dot/(omega*A))` starts at `0.285`, remains below `0.55` until
  `3.366T`, and reduces distance only from `12.328L` to about `12.15L` over
  that interval. Once the carrier is developed, radial closure is typically
  about `0.8--1.1U` from `7T` to capture. The visual rows agree: substantial
  alternating wake and forward translation appear after the early frames.
- The completed capture already spends `15.97%/19.83%` of samples above 95%
  of the two joint-speed limits and `30.64%/50.74%` above 95% of the two
  acceleration limits, while reaching peak planar force/moment
  `0.0369/0.0186`. Therefore a useful startup intervention must end before the
  mature gait instead of globally raising frequency, amplitude, or drive.

## Single policy hypothesis

Preserve the evaluated capture controller's full route architecture,
posterior lag, phase-selective steering, and joint-phase yaw demodulation.
Add one state-triggered carrier-recruitment channel to the anterior
state-feedback oscillator: derive a dimensionless phase radius from `q1` and
`q1_dot`, add bounded negative damping only below a declared recruitment
radius, and release it smoothly to exactly zero once that radius is reached.
The trigger uses joint state rather than time or route identity, so it can
also restore an underdeveloped carrier after a disturbance without changing
the established controller by construction.

Expected behavior is an earlier transition from the quiescent release into
productive self-propulsion, reducing arrival time and the observed distance
integral while retaining the captured route after recruitment releases.
Falsify the mechanism if the phase radius does not cross `0.55` earlier than
`3.366T`, capture does not repeat, the target-crossing topology or connected
wake changes materially, or joint-speed contact, acceleration residence,
force, or moment exceeds the incumbent envelope. This child has not been run
in CFD; those are next-generation tests, not claimed outcomes.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG residual modulation and traveling-wave reactive propulsion
source_mechanism: recruit an underdeveloped rhythmic carrier from observed oscillator state while keeping directional feedback in a separate bounded channel
transferable_invariant: add carrier energy only when normalized joint-state phase amplitude is deficient, then release the addition continuously once the propulsive rhythm is established
nontransferable_details: published CPG gains, dimensional frequencies, species or robot envelopes, exact vortex phases, prescribed startup durations, and task-specific routes
policy_translation: compute phase radius from normalized anterior angle and velocity, apply bounded state-dependent negative damping only below the recruitment radius, and leave the posterior lag and body-frame phase-demodulated steering unchanged
falsification: reject if startup phase growth is not earlier, fixed-case capture or the connected wake is lost, or velocity contact, acceleration residence, force, or moment worsens materially

## Evaluation boundary

Compare termination and capture first, then carrier-radius crossing time,
arrival, observed distance integral, route topology after release, joint-speed
contact, acceleration residence, peak force/moment, and both wake views against
the four identical completed captures. Changed-pose or changed-flow robustness
remains untested by the repeated fixed-case samples.
