# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled rollouts satisfy the frozen direct-uniform still-water
contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
dynamics, and `capture`. I inspected every combined keyframe sheet, including
the top-down vorticity and oblique body/Lambda2 rows. The best-scoring
approach-amplitude candidate (`solver_072da2f3a45e`) and the weakest-scoring
finite repeat (`solver_2a49b91aea58`) are both visibly self-propelled rather
than advected. From release to first crossing they retain the same broad
target-directed curve, alternating caudal street, and compact three-dimensional
caudal structures; no wake collapse, collision, or instability precedes
capture. No current sample is a semantic failure, so the informative failure
boundary remains the inherited phase-qualified terminal-velocity policy: it
kept a coherent wake after a `1.1146L` near miss but lost route control and
exited left at `32.0705T` and `8.9017L`.

The three current phase-steered carriers without approach-amplitude relief
capture at `18.8650--19.0080T`, score at `-0.21654-- -0.21164`, and have
scored mean distance `2.09994--2.10468L`. Two are executable-identical terminal
lateral-velocity repeats, and the clean no-velocity-lead carrier lies inside
their outcome interval at `18.8815T` and `2.10234L`; this again does not
establish the instantaneous velocity lead as an improvement. Their overall
acceleration-envelope contact is about `67%` of joint samples and rate contact
about `13%`.

The assigned-parent approach-amplitude mechanism also preserves capture and
slightly leads this scalar sample at score `-0.210566` and mean distance
`2.09874L`, but its intended demand relief is falsified. Below `1.5L`, it has
mean speed `0.8863L/T`, anterior/posterior acceleration contact
`65.60%/77.98%`, and rate contact `11.93%/11.01%`. Those values remain inside
the matched phase-steered repeat ranges (`0.8724--0.8971L/T`,
`60.00--66.83%/76.24--78.24%`, and `8.91--10.00%/11.88--16.47%`, apart from a
small anterior-rate shift), while its maximum joint angle rises to `35.35 deg`
from `31.78--34.93 deg`. Changing only the Van der Pol amplitude parameter
acts through the weak nonlinear energy term and does not directly reduce the
harmonic restoring or posterior tracking rate within the roughly two-period
terminal interval. Preserve the successful phase-steered curvature carrier,
but do not retain or retune this failed amplitude-relief knob.

## Single-candidate policy hypothesis

Keep the prefilled target-signed differential curvature, joint-state
half-cycle redistribution, one-sided yaw-response release, posterior lag,
terminal lateral-velocity composition, and final acceleration projection.
Replace the disproven amplitude-envelope experiment with one distinct actuator
mechanism: smoothly reduce the oscillator cycle rate by at most `10%` from
`2.5L` to `1.5L`. Use the same effective rate consistently in the anterior
restoring term, posterior phase-lag normalization, and posterior tracker so the
traveling bend slows continuously without a clock, a pointwise joint-rate
barrier, or a change to target-owned steering sign and bias allocation.

The direct frequency change should act within the short terminal interval,
reduce near-target joint speed and acceleration contact, and retain the
captured route and coherent wake class. Falsify it if capture is lost; arrival
or scored mean distance leaves the current finite band; terminal speed,
rate/acceleration contact, or loads do not improve; the high/left exit returns;
the anterior/posterior traveling bend loses coherence; target-owned curvature
is altered; or the returned command exceeds the owned envelope. The new CFD
outcome occurs after this worker exits and is not claimed as evidence here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG gait modulation and terminal capture control
source_mechanism: continuous cycle-rate scheduling of a low-dimensional propulsive rhythm during approach
transferable_invariant: normalized target range may smoothly reduce propulsive cycle rate after a stable target-directed route exists while preserving phase continuity, posterior lag, and geometry-owned steering
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact terminal distances, vortex phases, motor models, world-frame paths, and task-specific routes
policy_translation: reuse the bounded body-frame range gate to reduce one owned effective oscillator rate consistently in the anterior and posterior state-feedback terms without changing curvature sign or allocation
falsification: reject if capture or wake coherence is lost, route quality leaves finite repeat variability, terminal speed or demand fails to fall, posterior phase structure changes materially, or returned acceleration exceeds the owned envelope
