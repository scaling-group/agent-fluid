# Candidate diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled solver rollouts satisfy the direct-uniform still-water
contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
dynamics, and `termination=capture`. I inspected every combined keyframe sheet
from release to termination. Their top-down rows show genuine self-propulsion
and a coherent alternating street, while their oblique rows retain compact
caudal Lambda2 structures and a target-directed track through capture. The
assigned prefill (`solver_7c3c97939b32`) reaches capture at `19.0190T` with
mean scored distance `2.11536L` and score `-0.22671`; it is a terminal
body-lateral-velocity composition without joint-phase steering.

The clean displacement-half-cycle sample (`solver_2e35da543303`) adds a
positive phase factor to both geometry-owned curvature shares, retains the
one-sided correcting-yaw response release, and removes the terminal velocity
compound. It preserves both wake views, captures at `18.8815T`, and improves
mean scored distance to `2.10234L` and score to `-0.21389`. The current
half-cycle samples capture in the same visual and trajectory class at
`18.8815--19.0520T` and `2.09874--2.10234L`. Byte-identical terminal-velocity
versions vary enough to show that small score differences inside this band do
not support scalar tuning, terminal velocity, or range relief.

The informative failures are architectural. The assigned inherited log added
normalized joint velocity to the displacement phase coordinate. Its wake
remained coherent, but the top-down route rotated downward, reached only
`3.5687L`, and exited the lower boundary at `28.6495T`; the oblique row likewise
shows continued propulsion along the wrong route rather than wake collapse.
A sampled sibling removed correcting-yaw response release from displacement-
only half-cycle steering; it followed the same downward exit topology, reached
`2.9270L`, and exited at `28.9190T`. Thus joint-velocity phase prediction and
removal of response release are both falsified here. Reduced rate contact in
the latter failure does not compensate for loss of capture.

## Single-candidate policy hypothesis

Restore the isolated, already evaluated displacement-half-cycle architecture:
normalized body-frame lateral target fraction owns route sign; correcting yaw
may release but never invert the request; normalized anterior displacement
redistributes both opposite-sign mean-curvature shares with one positive
bounded factor; and the traveling-bend carrier and final acceleration
projection remain unchanged. Remove terminal body velocity, range scheduling,
and joint-velocity phase prediction. This is an evidence-backed restoration,
not a claim that a new CFD result is already known. Falsify it if the formal
rerun loses capture or either wake view, leaves the sampled
`18.865--19.052T` / `2.0987--2.1047L` capture band beyond repeat variability,
or materially worsens acceleration, rate, force, or moment histories.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping
source_mechanism: target-directed half-cycle amplitude asymmetry layered on a traveling propulsive rhythm
transferable_invariant: infer beat side from observed joint displacement and redistribute bounded steering toward the target-useful half-cycle without changing route sign or replacing the traveling wave
nontransferable_details: published gains, duty ratios, clock phase, species kinematics, dimensional frequency and amplitude, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target lateral fraction for curvature sign, retain one-sided measured-yaw release, and multiply both two-joint curvature shares by one positive factor derived from centered anterior displacement only
falsification: reject if capture is lost, the coherent top-down street or compact caudal 3D structures disappear, route metrics leave the sampled capture band beyond repeat variability, or load and saturation materially worsen
