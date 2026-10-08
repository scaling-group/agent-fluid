# Geometry-conditioned anterior curvature redistribution candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen evaluation contract:
  direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, active moving-window
  transport, finite dynamics, and capture. Three policies are byte-identical;
  the fourth changes only comments/version text and produces the same rollout.
  The repeated baseline scores `-0.5283387731`, captures at `25.1185226 T`,
  and has mean/final distance `2.429293780/0.746410191 L`.
- I inspected the combined sheets for the repeated best finite baseline
  (`solver_6a17cfeee4e8`) and the assigned parent's informative weaker finite
  body-response candidate (`solver_078d203d57ff`) from release to capture,
  including the top-down mid-plane vorticity and oblique body/Lambda2 rows.
  Both are self-propelled along the same compact target-directed arc, shed a
  coherent alternating posterior wake with finite three-dimensional
  structures, and enter the capture sphere without collision, domain-exit
  precursors, wasteful terminal flailing, or visible instability. Blank early
  oblique panels in one duplicate baseline sheet are treated as missing visual
  evidence, not absence of a wake; the complete baseline and parent sheets
  support the comparison.
- The visual similarity is consistent with the numeric diagnostics. Inside
  `4 L`, the baseline has no command above `30 rad/T^2`, no joint-stop dwell,
  and peak force-norm/yaw-moment coefficients of about
  `0.015479/0.007995`. Its normalized body-frame target angle falls from
  `1.1677` to `0.7125 rad`, while targetward body-frame lateral velocity is
  already substantial (mean `0.2286 L/T`, final `0.2566 L/T`). Thus the
  remaining terminal error is not evidence for missing lateral motion,
  insufficient total bend, or a need for more raw actuation.
- The assigned parent's shared yaw-rate residual supplies the decisive
  negative result. Adding up to three degrees of total mean curvature reduces
  final target angle to `0.6938 rad`, preserves zero saturation/stop dwell,
  and slightly lowers peak terminal loads, but regresses score to
  `-0.5287818737`, mean distance to `2.429626137 L`, and final distance to
  `0.746908903 L`; its one-step-earlier crossing is not an improvement.
  Stronger inherited response-conditioned variants are weaker still at about
  `-0.52928`, `-0.52930`, and `-0.53122`. More total terminal curvature and
  another response-release gate are therefore rejected for this candidate.

## Policy hypothesis

Preserve the evaluated outer carrier, body-frame geometry redirect, positive
closure preview, total terminal mean curvature, damped two-joint equilibrium,
settlement-conditioned paired carrier release, and all actuator limits. Add
one geometry-conditioned allocation mechanism only inside the existing
terminal replacement: while absolute normalized redirect angle is large,
move a bounded fraction of the already-requested total mean bend from the
posterior target to the anterior target. Fade that zero-sum redistribution as
the target angle closes. This changes neither turn sign nor total requested
curvature and introduces no clock, route, world coordinate, gait-phase gate,
or extra carrier energy.

The anterior joint acts on more of the articulated body and is therefore a
plausible steering-leverage test, while retaining the posterior-lag carrier
outside the terminal allocator. The candidate is falsified if the outer
trajectory changes, capture is delayed or lost, mean/final distance regresses,
target-angle convergence does not improve without added total bend, coherent
wake continuity degrades, or command clipping, joint-stop dwell, and terminal
force/moment growth return. A one-step-earlier but shallower crossing is not
sufficient evidence of benefit.

bookshelf_consulted: true
source_domain: Lighthill-style posterior-thrust allocation and robotic-fish mean-curvature turning
source_mechanism: separate steering leverage from total bend by shifting limited-joint mean-curvature authority anteriorly while retaining posterior rhythmic propulsion
transferable_invariant: when propulsion and steering share few joints, preserve the proven traveling carrier and total target-signed mean curvature while body-frame geometry continuously allocates where that bend is formed
nontransferable_details: published gains, dimensional frequencies, species-specific anterior/posterior envelopes, exact vortex phases, full-body kinematics, and task-specific routes
policy_translation: inside the existing closure-gated terminal replacement, use normalized absolute redirect angle to fade a bounded zero-sum shift from the posterior curvature target to the anterior target without altering the shared mean tangent
falsification: reject if pre-terminal commands change, compact capture or distance metrics regress, target alignment fails to improve, or wake coherence, saturation, joint clearance, and load margins worsen

## Non-CFD implementation audit

- The deterministic schema scan resolves all 71 direct `params.FIELD`
  references in the object returned by `target_policy_params()`, and the
  configured lightweight contract state returns two finite commands.
- Synthetic states verify the allocation identity
  `head_target + tail_target == mean_tail_tangent` to numerical tolerance.
  At `6 L` the existing terminal gate is exactly zero, so the policy command
  is unaffected even though target misalignment is large. At a representative
  fully active `2.4 L`, `0.90 rad` state, the mechanism shifts about
  `3.29 deg` from posterior to anterior while leaving the approximately
  `-19.08 deg` total mean tangent unchanged. At a `0.8 L`, `0.70 rad` state,
  geometry fades the shift to about `0.81 deg`. These checks establish
  activation, boundedness, and zero-sum/noninterference structure only. A
  mirrored synthetic body-frame state also returns exactly sign-mirrored
  two-joint commands, preserving reflection equivariance. None of these
  non-CFD checks establishes a coupled-flow improvement.

The new CFD evaluation occurs only after this worker exits and is not claimed
as evidence here.
