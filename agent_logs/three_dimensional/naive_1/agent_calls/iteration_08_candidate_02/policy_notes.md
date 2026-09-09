# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the edit

All four sampled evaluations satisfy the frozen evidence contract: direct
uniform initialization in still water with `U_infinity=[0,0,0]`, no cylinders
or prewarm, finite dynamics, and valid moving-window transport. I inspected
both the top-down vorticity and oblique body/Lambda2 rows for all four current
captures and compared them with the assigned parent's terminal-course failure.
I cross-checked the views against `wake_metrics.csv`, `trajectory.csv`,
`wake_diagnostics.json`, controller sources, assigned-parent guidance, and
inherited optimization notes.

The current sample separates three small mechanisms around the same captured
carrier. The unmodified normalized-lateral/differential-curvature controller
captures at `19.228T` with mean scored distance `2.1185L`. Adding only the hard
acceleration projection captures at `19.135T` and `2.1220L`; adding only the
terminal body-lateral-velocity lead captures at `19.129T` and `2.1245L`; and
combining that lead with hard projection captures at `19.140T` and `2.1277L`.
All four top-down rows show self-propelled target-directed travel with a
coherent alternating street through first crossing, and all four oblique rows
show compact finite caudal Lambda2 structures along essentially the same useful
trajectory. Their scalar differences are too small and inconsistent to claim
that the velocity lead improves the route.

The assigned parent's target-line transverse-course residual is a concrete
negative result. Despite a similarly coherent visible wake, it misses capture
at `0.9490L`, passes onto the high-side trajectory, and exits at `32.065T` with
final distance `8.7907L`. The fuller course projection therefore changed
terminal steering materially in a way the raw body-lateral lead did not. Later
policies should not infer that a geometrically richer velocity residual is
safer or more useful merely because its sign is clamped and its wake stays
coherent.

The isolated hard projection is the only current change with an unambiguous
effect and no semantic regression. It reduces logged over-envelope
acceleration rows from `61.70%/72.14%` in the baseline to zero while preserving
capture, arrival, outward-distance fraction, wake topology, and joint-rate
contact (`10.76%/14.39%` versus `10.81%/14.46%`) inside the sampled repeat
spread. This is command-interface ownership, not evidence of reduced physical
rate saturation or energetic efficiency.

## Single-candidate policy hypothesis

Preserve the sampled oscillator, posterior lag, normalized body-frame lateral
request, opposite-sign mean-curvature allocation, and one-sided yaw release
exactly. Add one policy-owned acceleration-envelope parameter and clamp only
the two completed acceleration commands immediately before return. This
candidate should retain the repeated capture and coherent traveling wake while
never exposing an unrealizable public command. It deliberately omits both
terminal velocity residuals and all rate-dependent tapering.

Falsify the candidate if either returned acceleration exceeds the policy-owned
limit, capture is lost, the high/low boundary topology returns, or arrival,
distance progress, wake coherence, rate contact, force, or moment histories
move materially outside the sampled capture band. The new CFD evaluation is
not available to this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: actuator-limited robotic-fish state-feedback CPG control and classical traveling-bend propulsion
source_mechanism: preserve a low-dimensional propulsive rhythm and target-owned mean curvature while projecting completed commands onto the physical actuator interface
transferable_invariant: command-envelope enforcement must leave the observed-state carrier, posterior lag, and normalized body-frame steering law unchanged
nontransferable_details: published gains, dimensional frequencies, motor models, species-specific envelopes, exact vortex phases, full-body kinematics, and task-specific routes
policy_translation: retain the sampled normalized lateral target request and two-joint differential curvature, then hard-clamp only the completed accelerations at a policy-owned limit already used by the episode
falsification: reject if output bounds fail, capture or coherent wake is lost, boundary-exit topology returns, or actuator contact and load histories worsen beyond repeat variability
