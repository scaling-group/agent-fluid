# Posterior wave-shape promotion

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, stable dynamics, and inertial
  moving-window transport. All capture, so the assigned parent is an
  informative failure only with respect to terminal control effect and capture
  margin, not termination class.
- Both combined visual rows were inspected for the assigned capture-corridor
  parent and the best finite posterior-modulation sample. The top-down rows
  show self-propulsion from rest, a coherent alternating wake through the long
  approach, and a smooth correct-sign hook into the capture circle. The
  oblique Lambda2 rows show the same compact three-dimensional wake through
  the turn. There is no visible advection, wake breakup, boundary interaction,
  or moving-window artifact.
- The two assigned-parent samples byte-match in policy, trajectory, and visual
  sheet and capture at `0.749090L` and `26.3010T`, establishing deterministic
  fixed-pose behavior. Their anterior capture-corridor residual changed the
  baseline centerline by at most `0.00277L` and did not materially change the
  wake, limits, or loads, so its gain and thresholds are not supported tuning
  targets.
- The posterior phase-lag allocation is the strongest sampled finite policy:
  it captures at `0.748829L` and `26.2955T` with score `-0.61684559`, versus
  the assigned parent's `0.749090L`, `26.3010T`, and `-0.61709111`. Mean
  distance improves only from `2.519875L` to `2.519671L`; 364 command rows
  differ and the maximum centerline displacement is only `0.002788L`.
  Maximum joint angle/rate/acceleration and peak planar force/yaw moment remain
  effectively unchanged (`0.77236`, `4.51281`, `29.72585`, and
  `0.018834/0.009789` in the recorded normalized units). Thus this is a
  bounded best-sample promotion, not evidence of a new capture-clearance
  mechanism or held-out robustness.
- The inherited optimizer notes predicted that posterior allocation should be
  rejected if it remained in the same milliscale route cluster. The completed
  result meets that falsification condition even though its scalar score is
  slightly better. This candidate therefore preserves the sampled policy
  exactly for a replication test; it does not increase the modulation or
  combine it with the similarly ineffective anterior corridor residual.

## Policy hypothesis

Replace the assigned parent's terminal anterior residual with the sampled
posterior phase-lag modulation while leaving the capture-proven traveling-bend
carrier, line-of-sight response, redirect, coordinated acceleration envelope,
and angle/rate viability guards unchanged. Gate the posterior modulation by
the already normalized approach-and-projected-miss veto, positive closing
speed, inadequate target-line response, and agreement between course and
line-of-sight turn sides. Infer beat phase only from anterior joint state.

The formal rollout should reproduce the coherent two-view wake, capture,
zero hard-limit contact, and the sampled `26.2955T` trajectory. Treat a repeat
capture as fixed-condition replication only. Reject the mechanism as a useful
terminal primitive if capture is lost, the route still differs from the
unmodulated carrier by only milliscale displacement, the wake loses coherence,
or limit/load exposure increases. A later worker should test a different
response-request mechanism rather than scalar-strengthening or blindly
combining the two terminal actuator allocations if this milliscale topology
repeats.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and closed-loop direction tracking
source_mechanism: bounded phase-lag or wave-shape modulation of a propulsive rhythm
transferable_invariant: preserve the productive carrier and change inter-joint wave shape only when observed course error and inadequate target-line response agree
nontransferable_details: published gains, dimensional frequency, robot-specific geometry, species kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame projected miss, closing speed, reconstructed inertial line-of-sight response, and joint-state phase to gate a posterior lag modulation inside the capture corridor
falsification: reject if capture or coherent self-propulsion is lost, hard-limit or load exposure increases, or the repeated route remains confined to the same sub-0.003L terminal cluster

## Non-CFD implementation audit

- The mandated checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three configured commands were then run
  directly and separately. The guidance semantic-delta check, finite Julia
  policy/schema contract, and solver editable-boundary check all pass.
- The rendered `README.md` contained the assigned guidance-parent marker twice;
  the duplicate line was removed so the semantic-delta checker could resolve
  exactly one parent. No task or evidence content was changed.
- The candidate byte-matches the strongest sampled finite policy and remains
  non-empty. No CFD rollout was run in this workspace.
