# Response-released terminal traveling-wave candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts and the relevant assigned-parent rollouts satisfy
  the frozen contract: direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and `horizon`
  termination at `100T`. I inspected both rows of their combined keyframe
  sheets. The top-down mid-plane views show self-propelled loops with coherent
  alternating wakes, while the oblique Lambda2 views retain compact
  three-dimensional structures through the turns. Advection, wake collapse,
  collision, boundary exit, and instability do not explain the misses.
- The current sampled rear selector, equilibrium unbend, fixed-sign restart,
  and phase-balanced/posterior-response variants reach only `2.366L`,
  `2.215L`, `2.369L`, and `2.439L`. Their late views share a broad return below
  the target; the first three settle near a common negative C-bend with little
  joint motion despite finite speed and coherent propulsion. They are
  informative failures, not alternative scaffolds.
- The assigned-parent history identifies the two-sided phase-balanced activity
  regulator as the useful scaffold. It reaches `1.175/4.041/3.243L`
  minimum/mean/final distance, remains inside `1.25L` for about `2.35T`, keeps
  mean near-target `|phi_dot|` near `0.775/0.360 rad/T`, and lowers clamp
  residence to about `0.227/0.103`. Its visibly tighter loop and active 3D wake
  survive where a requested-sign half-cycle pulse (`1.702L`), requested-side
  energy asymmetry (`2.362L`), and a stronger repeated activity regulator
  (`1.366L`) do not.
- The latest inherited counterphase burst is a concrete negative control. It
  increases useful signed yaw rate near the miss from about `0.061` to
  `0.335 rad/T`, but reaches only `1.192/4.043/3.222L`, reduces residence inside
  `1.25L` from `2.35T` to `1.24T`, and leaves the translational course
  tangential. Coordinated joint acceleration can produce yaw without producing
  the inward course change needed for capture; its burst magnitude and phase
  gates should not be retuned.

## Policy hypothesis

Return to the completed `1.175L` phase-balanced controller and preserve its
body-frame course hold, moving C-turn equilibrium, two-sided low-activity
energy regulator, posterior lag/brake, wave envelope, and command limit. Add
one nonsteady response transition rather than another acceleration burst. The
existing target-behind terminal geometry continues to request the strong
C-turn. Once measured yaw has the requested course-correction sign and exceeds
a bounded response onset, continuously release a limited fraction of the
redirect equilibrium. Because the same release restores the traveling-wave
envelope, the controller converts demonstrated body rotation into a stronger
propulsive wave instead of continuing to wind around the C-bend. Release fades
if useful yaw, terminal geometry, or course error disappears; no timer, hidden
stage, static residual, or world-frame route is introduced.

Support requires preservation of the coherent first return plus capture, a
pass below `1.175L`, longer residence inside `1.25L`, or a tighter final loop
with inward course response and comparable activity/load margins. Reject the
mechanism if it releases before terminal geometry, enlarges the loop, raises
speed without rotating course inward, parks either joint, disrupts the wake,
or worsens minimum, near-target residence, mean, and final distance together.

```text
bookshelf_consulted: true
source_domain: nonsteady biological C-start redirection and sensor-modulated robotic-fish coupled-oscillator control
source_mechanism: a strong body bend is released into a propulsive counterstroke after measured turning response appears, rather than holding static curvature or applying a clocked burst
transferable_invariant: separate bend formation from response-triggered release, and preserve a traveling anterior-to-posterior wave so achieved body rotation can redirect propulsion
nontransferable_details: published gains, dimensional beat frequency, species-specific C-start stages and kinematics, full-body joint counts, robot duty ratios, clocked CPG phase, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized target-behind and target-ray/course geometry select the bend; signed measured heading rate confirms useful response, then a bounded scalar releases part of both two-joint moving equilibria while restoring the existing state-feedback wave envelope
falsification: reject if cruise or the first return changes, useful yaw still fails to rotate translational course, the orbit expands, either joint parks, wake or load margins degrade, or closest, residence, mean, and final-distance evidence fail to improve over the 1.175L phase-balanced scaffold
```

## Evaluation boundary

The candidate's coupled CFD result is unavailable until this worker exits.
Static checks and frozen-trace replay can establish parameter ownership,
boundedness, reflection symmetry, selector locality, and action reserve, but
cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate restores the completed phase-balanced policy and adds three
owned response-release parameters. The useful-yaw gate releases at most `3%`
of the redirect weight; all curvature, oscillator, activity-regulator,
posterior-lag, brake, and command-limit parameters remain those of the
completed `1.175L` scaffold.

Frozen replay over all `18182` states of that scaffold changes the maximum-
joint action by `0.141/2.586 rad/T^2` mean/maximum overall, by only
`0.00018/0.0052 rad/T^2` beyond `3L`, and by `1.258/2.586 rad/T^2` inside
`1.5L`. At the parent minimum the replayed pair changes from approximately
`(6.151,-0.133)` to `(6.731,0.537) rad/T^2`. Replayed base/candidate clamp
fractions are unchanged to within `0.00006` on either joint, and a full-trace
lateral reflection probe has zero numerical error. These establish locality,
reserve, and equivariance only; they do not predict the coupled trajectory.
