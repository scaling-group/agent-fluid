# Phase-coherent co-injection guard candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  moving-window transport, stable dynamics, and `capture` at
  `15.560--15.730T`. There is no failed termination, so the informative
  negative is an actuator/load tradeoff inside the successful class.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows from
  release through capture for the highest-scoring common full-demand guard
  (`solver_6dada5e7a98a`) and the lowest-scoring posterior-priority guard
  (`solver_7d26cc24fc23`). Both self-propel from blank quiescent water on a
  shallow target-directed arc. Alternating caudal vorticity and discrete 3D
  Lambda2 structures remain coherent through terminal straightening; neither
  fish is advected, collides, exits, flails, or becomes unstable. The views do
  not support changing the carrier cadence, amplitude, lag, or steering gain.
- Metrics distinguish the governor mechanisms. The common full-demand guard
  is the progress leader at `15.604T/1.79354L`, but has the largest sampled
  planar-force/yaw-moment peaks (`0.04226/0.02076`) and anterior/posterior
  greater-than-90%-rate residence (`17.45/6.66%`). The carrier-only
  joint-local guard is slower at `15.730T/1.80572L`, but shortens path to
  `12.848L` and lowers peaks to `0.03558/0.01724` and rate residence to
  `17.10/5.77%`.
- The assigned parent's joint-local full-demand policy now has two completed
  semantic repeats: `solver_d00ba28cf8bc` and `solver_975697fcab1b` capture at
  `15.560/15.708T`, with `12.994/13.132L` paths, `0.03909/0.03833` peak force,
  `0.01916/0.01868` peak moment, and anterior greater-than-90%-rate residence
  `17.43/17.16%`. Thus its timing overlaps the common leader and its load
  reduction repeats, but neither a path nor a rate-residence gain is stable.
  The inherited logs also reject instantaneous force/moment relief, scalar
  onset tuning, and response-gated steering release because they did not buy a
  material load/path benefit without slowing or hooking the approach.
- Peak-load states show why one more local/common structural comparison is
  useful. The current repeats include both a simultaneous positive-work event
  (`solver_d00ba28cf8bc`, both applied joint powers positive near the peak) and
  a mixed reversal/injection event (`solver_975697fcab1b`, anterior applied
  power negative while posterior power is positive). A common guard should
  preserve phase only for the former; propagating one joint's guard during the
  latter would unnecessarily remove the other joint's useful traveling-wave
  work.

## One-candidate policy hypothesis

Preserve the corrected body-frame target vector, distance/closing drive
relief, full velocity-course redirect, joint-phase steering, posterior wave
allocation, full-demand rate previews, carrier/steering decomposition,
negative-work reversal release, smooth command bounds, and public two-joint
contract. Add one phase-coherent carrier mechanism: keep each rate-triggered
positive-work guard local, then form a smooth co-injection signal from the
product of both normalized positive carrier powers. Apply that signal equally
to both positive carrier components, while leaving steering and negative-work
reversal outside it. This preserves posterior thrust during a single anterior
bottleneck but withdraws a genuinely coupled energetic burst even below the
98% rate onset, without reading force or tuning that scalar threshold.

Expected signature: retain capture, early progress, the short-path envelope,
and both coherent wake views; reduce force/moment peaks and preferably rate
residence relative to the common full-demand sample without moving timing or
distance integral outside the two current semantic-repeat envelope. Falsify
if the common coupling slows a mixed-work stroke, destroys posterior lag,
widens the late hook, or regresses capture, timing/integral, path, joint
margin, command effort, load, rate residence, terminal course, finite action,
or either wake view. The new CFD result occurs only after this worker exits and
is not evidence claimed here.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: anterior and posterior oscillators form a coordinated traveling bend while feedback modulates rhythmic effort without erasing lagged posterior thrust
transferable_invariant: preserve local actuator authority for a single-joint bottleneck, but attenuate simultaneous positive rhythmic work phase-coherently when the coupled traveling wave approaches its actuation envelope
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, clocked oscillator phase, full-body waveforms, exact vortex phases, and task-specific coordinates or routes
policy_translation: infer joint phase and energy direction from normalized joint rates and carrier acceleration; retain local full-demand rate previews and add a smooth product of the two positive carrier-power alignments as equal attenuation of only the coupled injecting components, while passing target steering and negative-work reversal unchanged
falsification: reject if load or rate residence does not improve while capture, timing/integral, short path, joint margin, terminal course, finite action, and coherent top-down and oblique wakes remain in the sampled useful class
