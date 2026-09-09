# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled solver rollouts satisfy the frozen evidence contract: direct
uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm or
cylinders, finite moving-window dynamics, and `capture`. I inspected the
combined top-down vorticity and oblique body/Lambda2 rows for the best sampled
capture (`solver_a2a24e9e57f4`) and the inherited phase-qualified terminal
velocity failure (`solver_3b03b40c75c1`), then cross-checked the views against
their metrics, diagnostics, trajectories, executable policies, assigned-parent
guidance, and inherited optimization notes.

The best sample is self-propelled rather than advected. It retains a broad,
alternating top-down street and compact three-dimensional caudal structures as
its head follows the target-directed curve into first crossing. Its
joint-phase modulation multiplies both anterior and posterior steering shares
by one positive bounded factor, so target geometry still owns sign and the
traveling carrier remains intact. It captures at `0.74858L` in `19.00799T`,
with score `-0.211642` and mean scored distance `2.09994L`; these are all best
among the four current samples. Against the otherwise matched projected
terminal-lateral-velocity carrier at `19.01899T`, `2.11536L`, and `-0.226715`,
the phase-selective steering chiefly improves the distance integral. This is a
promising single-rollout mechanism result, not yet replicated proof.

The informative inherited failure remains wake-coherent but loses route
control after its `1.11459L` near miss: the top-down street tightens as the fish
straightens away from the target, and the oblique row continues to show
compact caudal structures through the eventual left-domain exit at
`32.07053T` and `8.90170L`. Its phase signal qualifies the instantaneous
terminal velocity release rather than the persistent geometry-owned steering
bias. This sharpens the mechanism boundary: joint phase may redistribute both
shares of existing mean curvature, but should not grant an instantaneous
velocity residual authority over the route.

The successful carrier still has a separate terminal demand issue. In its
trajectory, the far regime above `2.5L` averages speed `0.6546L/T` and contacts
the acceleration envelope on `60.2%/72.8%` of anterior/posterior rows. Below
`1.5L`, mean speed rises to `0.8724L/T` while acceleration contact remains
`66.8%/76.2%`. Rate contact does not rise, so the inherited failed pointwise
rate barriers are not an appropriate answer. The evidence instead supports a
continuous approach-envelope experiment that preserves carrier phase and
steering allocation.

## Single-candidate policy hypothesis

Use the best sampled phase-selective projected policy as the carrier. Reuse its
existing continuous terminal distance gate to reduce only the Van der Pol
oscillator amplitude envelope by at most `20%` on approach. Keep oscillator
frequency, posterior lag, differential mean-curvature shares, half-cycle
steering factor, terminal lateral-velocity lead, yaw-response release, and
final acceleration projection unchanged. Mean steering therefore remains
available while the propulsive limit cycle can shed terminal speed without a
pointwise rate barrier or a clocked mode switch.

Expect capture and the coherent wake class to survive while near-target speed
and acceleration contact fall. Treat route/load quality as primary: falsify
the mechanism if capture is lost; arrival or mean distance leaves the sampled
successful band; the high/left exit topology returns; near-target demand is
unchanged; target-owned steering sign or the anterior/posterior allocation is
altered; or the top-down street or oblique caudal structures lose coherence.
The new CFD outcome is unavailable to this worker and is not claimed as
evidence.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG gait modulation and terminal capture control
source_mechanism: continuously reduce rhythmic drive amplitude during approach while preserving geometry-owned steering and oscillator phase
transferable_invariant: normalized target range may smoothly schedule the propulsive envelope after a stable target-directed route exists, without changing the sign source, phase continuity, or posterior traveling-wave structure
nontransferable_details: published gains, dimensional frequencies, source duty ratios, motor models, species-specific amplitude envelopes, exact terminal distances, vortex phases, world-frame paths, and task-specific routes
policy_translation: preserve the evidenced two-joint carrier and reuse its bounded distance gate to reduce only the state-feedback oscillator amplitude envelope, leaving curvature shares, frequency, lag, and final command projection unchanged
falsification: reject if capture or coherent wake is lost, route or distance integral worsens outside finite repeat variability, terminal speed or demand does not fall, steering allocation changes, or returned acceleration exceeds the owned envelope
