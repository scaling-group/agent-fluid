# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts and the assigned parent's completed terminal
  redirect satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot, and no numerical
  instability. The combined sheets show self-propulsion rather than
  advection. Their top-down rows retain an alternating caudal vorticity street
  and their oblique rows retain compact three-dimensional Lambda2 structures
  through the approach.
- The sampled controllers share a long lower-going topology. Symmetric tail
  relief reaches `4.233L`; adding the anterior phase residual reaches
  `4.018L`; posterior half-cycle redistribution reaches `3.909L`; and their
  whole-body combination gives the strongest approach, `3.691L` at about
  `20.46T`. The combination preserves the wake and about `13.7/5.5%`
  anterior/posterior rate-cap occupancy, but full target error is still
  `1.364 rad` at the minimum and the fish exits low at `33.27T` and `9.294L`.
  It is useful trajectory shaping, not established route recovery.
- Two inherited completed tests close off semantic and terminal-gain variants.
  Full-target-angle descendants preserve the `3.691L` pre-abeam minimum
  exactly but still exit low near `9.33L`, so keeping a rear target distinct
  from alignment adds no yaw authority. The assigned parent's near-target
  curvature-capture controller regresses to `4.145L` and `27.79T`: by `18T`
  its posterior motion is nearly zero, by `20T` both joints are nearly static,
  and both wake views show the subsequent inertial coast. An approach mode
  must not extinguish the state-feedback carrier.
- The strongest trace exposes a phase-observation mismatch. Over `12--20T`,
  when positive target error calls for negative yaw, negative anterior angle
  carries mean normalized yaw moment `-0.00597` versus `+0.00327` for positive
  angle; negative anterior rate carries `-0.00095` versus `+0.00075` for
  positive rate. Yet the inherited posterior selector labels positive
  target-signed anterior rate as the useful stroke. The contemporaneous
  moment is not a causal proof because fluid response can lag joint state, but
  its sign and approximately `0.004--0.006` scale are directly evidenced and
  can test whether realized hydrodynamic response is a better selector than
  kinematics alone.

## One candidate hypothesis

Preserve the strongest whole-body half-cycle policy's anterior oscillator,
acceleration residual, and bounded tail scale, and retain the completed
full-angle variants' corrected release magnitude. Replace the purely
kinematic posterior half-cycle decision with a bounded blend of joint-rate
phase and measured target-signed yaw moment. A target-side moment retains more
lagged tail carrier; an opposing moment deepens relief. The blend keeps joint
state as a feed-forward phase cue while allowing the observed hydrodynamic
response to correct a phase label that is not consistent with the sampled
moment partition. It adds no acceleration residual and cannot expand the
inherited posterior carrier-scale envelope.

The hypothesis is falsified if the early alternating wake or `3.691L`
approach is lost, `12--20T` target-opposing mean moment is not reduced, full
target error still exceeds about `1.36 rad` at the minimum, the same lower
exit occurs without earlier target-side yaw, posterior rate-cap occupancy
materially exceeds `5.5%`, or moment feedback produces beat-scale chatter or
load spikes.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and hydrodynamic wake-disturbance feedback
source_mechanism: sensor feedback modulates a rhythmic gait while asymmetric flapping redistributes authority toward turn-producing phases
transferable_invariant: preserve the traveling propulsive rhythm, but use bounded target-relative hydrodynamic response to distinguish useful yaw production from a cancelling half-cycle instead of assuming joint phase is always a sufficient proxy
nontransferable_details: published gains, dimensional beat frequency, robot linkage geometry, species-specific kinematics, controller clocks, exact vortex phase, and task-specific routes
policy_translation: blend normalized anterior joint-rate phase with the sign of body-frame target request times normalized measured yaw moment; use that bounded blend only to redistribute the existing posterior carrier authority
falsification: reject if the coherent wake or 3.691L approach degrades, opposing yaw moment is not reduced, target error fails to improve before the miss, saturation or loads worsen, or direct moment feedback chatters
