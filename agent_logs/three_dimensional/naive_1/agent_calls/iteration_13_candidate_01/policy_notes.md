# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled evaluations satisfy the frozen evidence contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders
or prewarm, finite moving-window dynamics, and `capture`. I inspected the
combined sheets for the strongest-score assigned-parent rollout
(`solver_02eaf03fe1d2`) and the weakest-score current sample
(`solver_2e35da543303`), including both the top-down vorticity and oblique
body/Lambda2 rows, then cross-checked them against `wake_metrics.csv`,
`wake_diagnostics.json`, their trajectories and policies, sampled optimizer
guidance, and inherited worker notes. No current sample is a failed rollout;
the inherited phase-leading controller is the informative failure contrast.

The assigned parent is self-propelled rather than advected. It follows a
broad target-directed curve, develops a coherent alternating top-down street,
and retains compact paired caudal Lambda2 structures through capture. Its
geometry-scheduled gait relief captures at `0.74981L` in `18.65050T`, with
score `-0.206060` and mean scored distance `2.09340L`. The otherwise clean
displacement-half-cycle carrier captures in `18.88149T`, scores `-0.213890`,
and has mean distance `2.10234L`; the two terminal-velocity compositions are
also slower at `19.00799--19.05201T` and `2.09874--2.09994L`. The parent's
route improvement is promising but unreplicated. It is not demand relief:
its acceleration contact (`60.98%/73.19%`), joint-rate contact
(`11.12%/15.13%`), and RMS action (`27.147/28.620 rad/T^2`) overlap the clean
carrier (`60.68%/73.38%`, `11.13%/15.18%`, and `27.133/28.636 rad/T^2`).

The inherited logs bound the next change. Adding anterior joint velocity to
the displacement phase retained a coherent wake but turned down the wrong
route, approached only `3.56872L`, and exited at `28.64951T`; displacement,
not velocity lead, must continue to define the half-cycle. A bearing-progress
qualifier retained capture but worsened arrival and mean distance, so another
route release gate is not supported. Instantaneous terminal velocity and
range-only schedules likewise have no attributable improvement beyond repeat
spread. The useful unresolved opportunity is therefore not a new sign source
or phase estimate, but a coherent transition between the parent's redirect
and cruise envelopes.

## Single-candidate policy hypothesis

Preserve the assigned parent's normalized target geometry, correcting-yaw
release, differential mean curvature, displacement-only half-cycle steering,
traveling-bend carrier, and final acceleration projection. Multiply the
parent's raw lateral-fraction amplitude relief by the already bounded,
one-sided `response_gate`. An uncorrected route request therefore retains the
parent's schedule exactly, reducing rhythmic amplitude by at most `15%` while
preserving the mean-curvature shares; as measured correcting yaw releases the
turn request, the same gate restores the propulsive envelope toward cruise.
This couples redirect and cruise without a clock, extra response gate,
velocity-led phase, or new route authority.

Expect capture and both coherent wake views to survive while productive turn
response returns propulsion sooner and improves arrival or distance integral.
Falsify the mechanism if capture is lost; the inherited downward/left exit
returns; arrival or mean distance leaves the `18.650--19.052T` and
`2.0934--2.1024L` sampled capture band; acceleration/rate contact or planar
loads materially worsen; the wake loses coherence; or the schedule changes
target-owned sign, displacement phase, posterior lag, or the owned command
envelope. The new CFD result is unavailable to this worker and is not claimed
as evidence.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG control
source_mechanism: strong bounded curvature while directional error persists, followed by continuous release into the propulsive rhythm when useful turning response appears
transferable_invariant: persistent normalized body-frame target geometry may prioritize curvature over gait, but the same bounded state-feedback response should restore cruise as the redirect becomes effective without changing turn sign or oscillator phase
nontransferable_details: published gains, dimensional frequencies, C-start timing, duty ratios, motor models, species-specific kinematics, exact vortex phases, world-frame paths, and task routes
policy_translation: preserve the captured two-joint displacement-phase carrier and multiply its lateral-error oscillator relief by the existing one-sided correcting-response gate, leaving both curvature shares and posterior lag unchanged
falsification: reject if capture or coherent wake is lost, route or distance metrics leave finite capture variability, demand or planar loads worsen, steering sign or phase changes, or returned acceleration exceeds the owned envelope
