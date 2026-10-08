# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The assigned parent is the prefilled phase-selective terminal-reallocation
  policy, byte-identical to sampled `solver_6a46e49f8216`. It captured from
  direct uniform still water at `25.1130T`, scored `-0.52837563`, and had a
  normalized distance integral of `2.42929836L` with final distance
  `0.74651659L`.
- I inspected both rows of the combined keyframe sheets for the best finite
  sample `solver_89a97c83567b` and the lower-scoring distinct baseline
  `solver_b9538d7777ef`, plus the assigned parent's combined sheet. The
  top-down row begins from a wake-free release, develops a coherent
  alternating self-propelled trail by `5T`, retains that organized trail
  through `20T`, and bends continuously into the capture sphere near `25T`.
  The oblique row corroborates three-dimensional vortical structures behind
  the fish during approach and the strongly curved terminal body pose; blank
  or sparse early oblique panels are not treated as evidence of advection.
  Diagnostics confirm `uniform_direct`, `U_infinity=(0,0,0)`, no cylinders,
  and capture for every sample.
- The closure-previewed baseline (`solver_b9538d7777ef`, duplicated exactly by
  `solver_d5c9dea468e1`) captured at `25.1130T`, but scored `-0.53006032` with
  distance integral `2.43063592L` and final distance `0.74825221L`. The parent
  phase-selective allocator first changes commands near `4.176L`; it preserves
  capture while improving the integral and final crossing, and lowers mean
  absolute acceleration inside `4L` from about `4.07/3.96` to `3.77/3.60`
  rad/T^2 with no command-cap samples there.
- The response-released sibling `solver_89a97c83567b` first changes commands
  only after joint settling near `3.016L`. It also preserves the outer wake and
  captures at `25.1185T`; score `-0.52833877`, distance integral
  `2.42929378L`, and final distance `0.74641019L` are marginally best in the
  sample despite slightly higher terminal command effort. Thus its benefit is
  a terminal response/allocation effect, not faster propulsion. The inherited
  optimizer logs likewise show earlier capture-preserving terminal allocation
  improving from `-0.53064634` to `-0.53006032`, while course-based carrier
  restoration regressed to `-0.53148478`.

## Visual diagnosis

The useful mechanism is already self-propulsion with a posterior-lag wake and
geometry-gated redirection. There is no visible loss of wake coherence or
wrong-way turn to justify replacing that architecture. The remaining
variation is confined to how the carrier is traded for the shared curvature
equilibrium during the last roughly `4L`: more hold is useful while the joints
move away from the requested bend, but continuing the same hold after the bend
has settled removes a small amount of useful posterior motion. The phase-only
and settling-only siblings improve the same baseline from opposite sides of
the transition and begin acting in different response regimes.

## Policy hypothesis

Use one joint-error-energy allocation mechanism around the existing terminal
equilibrium: retain the parent's normalized positive error-derivative boost
during partial reallocation, then recover a bounded part of the carrier when
normalized two-joint tracking error is small. Both gates depend only on current
joint angle/velocity, carrier frequency, target-relative geometry, range, and
measured closure. The combination should leave the evidenced outer trajectory
bitwise unchanged, retain the parent's lower transition effort, and obtain the
settled sibling's slightly better terminal crossing. It is falsified by loss
of capture, any pre-`4.18L` trajectory change, renewed terminal command caps or
joint-stop dwell, or score/integral worse than both single-trigger siblings.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish CPG modulation
source_mechanism: strengthen a bounded redirect while the body is still forming the requested bend, then release smoothly into posterior rhythmic propulsion after observed response
transferable_invariant: use observed response magnitude and direction, rather than elapsed time, to allocate actuation between strong mean curvature and a traveling propulsive bend
nontransferable_details: published oscillator gains, dimensional cadence, species-specific C-start kinematics, exact vortex phase, and task-specific routes
policy_translation: normalize two-joint equilibrium error by drive amplitude and its positive time derivative by amplitude-squared times carrier frequency; use the former to release and the latter to reinforce only the existing target-relative terminal allocation
falsification: reject if the outer wake changes, capture is lost, terminal saturation or load spikes return, or the combined response gates do not beat both phase-only and settling-only sampled variants
