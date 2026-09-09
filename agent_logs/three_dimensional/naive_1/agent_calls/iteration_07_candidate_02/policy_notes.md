# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled evaluations satisfy the frozen contract: direct uniform
initialization in still water with `U_infinity=[0,0,0]`, no cylinders or
prewarm, finite dynamics, and valid moving-window transport. I inspected the
combined top-down vorticity and oblique body/Lambda2 sheets for all four runs,
anchored them to `wake_observation.md`, and cross-checked the visual comparison
against `wake_metrics.csv`, `trajectory.csv`, `wake_diagnostics.json`, policy
sources, the assigned-parent guidance, and inherited optimizer notes. Every
sampled sheet is a capture, so the workspace contains no current failure image;
the informative failures below are available through inherited quantitative
and visual diagnoses rather than a newly sampled failure sheet.

The best-scored baseline capture (`-0.229933`) and the other sampled captures
all show self-propelled target approach: the top-down rows retain an orderly
alternating street, and the oblique rows retain compact paired caudal structures
through first crossing. The baseline package captures in `19.228--19.321T` in
the two sampled unprojected repetitions, with mean scored distance
`2.1185--2.1279L`. This reinforces the inherited lesson that coherent shedding
is useful propulsion but that the normalized target-side request,
opposite-sign anterior/posterior curvature, and one-sided yaw release provide
the route control.

The prefilled terminal lateral-velocity lead is now completed evidence. It
also captures with the same coherent wake at `19.129T`, mean scored distance
`2.1245L`, and score `-0.235878`. It ends on the upper-right side of the target
rather than the two unprojected baselines' lower-right crossing, but the exact
projection run—which is physically equivalent to the baseline—also ends
upper-right. The terminal-side difference therefore cannot be assigned to the
lead. The lead has evidence for semantic preservation, not for a scalar or
trajectory improvement. Do not increase its gain or add another slip term
based on this single crossing.

The assigned parent's exact output projection has also completed evaluation.
It captures at `19.135T`, mean scored distance `2.1220L`, and score `-0.233002`
with a visually indistinguishable coherent wake. Its returned accelerations
never exceed `1800 deg/T^2`, while the unprojected captures request above that
envelope on about `61.6--61.7%` / `72.0--72.3%` of rows. Rate contact remains
about `10.8%/14.5%`, as expected: the episode already applies the identical
hard clamp before integration, so projection fixes the public command contract
without claiming reduced physical effort. This positive result is sharply
different from the inherited `80%` and `85%` outward-rate tapers, which kept
coherent wakes but lost capture, reached only `5.34L` or `5.03L`, and exited
high near `21--22T`.

## Single-candidate policy hypothesis

Preserve the prefilled terminal velocity-lead redirect and its successful
joint-state oscillator exactly. Add only the assigned parent's policy-owned
hard projection of the two completed commands onto the episode's identical
acceleration envelope. The mechanisms are compatible by construction: the
projection cannot change the accelerations integrated by the episode for any
finite state, while it bounds the public output of the lead controller. This
one candidate should retain the lead run's capture, target-owned steering sign,
and traveling wake while eliminating out-of-envelope returned commands.

Falsify the combination if either returned command exceeds the owned envelope,
if a projected command differs from the episode's existing clamp for the same
finite state, if capture or the terminal trajectory topology is lost beyond
the repeat band, or if wake coherence, rate contact, or force/moment histories
degrade. The new candidate has not been evaluated, so no CFD outcome is
claimed here.

bookshelf_consulted: true
source_domain: actuator-limited robotic-fish sensor-feedback CPG control and classical traveling-bend propulsion
source_mechanism: preserve a low-dimensional target-modulated rhythmic carrier while projecting completed commands onto the physical actuator envelope
transferable_invariant: command bounding must preserve carrier phase and target-owned mean curvature; measured-rate tapering is a distinct mechanism that can change the route
nontransferable_details: published gains, dimensional beat rates, robot motor models, species-specific kinematics, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: retain normalized body-frame target and lateral-motion feedback around the two-joint state-feedback oscillator, then clamp only the completed joint accelerations at a policy-owned copy of the episode envelope
falsification: reject if output bounds fail, downstream-applied commands differ, capture or coherent posterior shedding is lost, or the inherited high-side failure topology returns
