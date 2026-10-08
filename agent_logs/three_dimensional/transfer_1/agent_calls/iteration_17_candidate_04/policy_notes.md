# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts report direct uniform quiescent initialization
  (`U_infinity=[0,0,0]`), no prewarm, and capture.  The three v33 artifacts
  (`solver_03084da086f9`, `solver_8db4269d61aa`, and
  `solver_fe379fd20513`) differ only in comments/version strings: their
  trajectory CSVs and both visual sheets are byte-identical.
- The combined top-down/oblique sheets for the best sampled v33 rollout and
  the assigned v32 rollout show self-propulsion, not advection: a compact wake
  develops from still water into a coherent alternating reverse-vortex street.
  The fish keeps a productive posterior-lag wave and makes a smooth
  target-signed arc through capture; there is no visible wake collapse or
  instability.  The sampled set contains no multimodal termination failure,
  so the inherited step-14 `left_domain` result is used only as a scalar
  wrong-route boundary, not as a visual claim.
- v32 captures at `18.7550 T`, score `-0.17114`, distance integral
  `2.05886 L`, mean/max speed `0.686/0.949 L/T`, and any-joint acceleration
  residence `41.96%`.  The repeated v33 bidirectional-allocation rollout
  captures at `18.7660 T`, score `-0.17027`, integral `2.05835 L`, speed
  `0.686/0.940 L/T`, and limit residence `41.35%`.  Its route is slightly
  behind v32 at `12/16 T` (`0.003/0.018 L`) and it changes neither wake nor
  termination class; the small score gain is dominated by a slightly deeper
  discrete capture crossing.  Thus reverse transfer of tail-rejected steering
  is not a useful new route mechanism here.
- Reconstructing the assigned policy on its recorded state history shows the
  remaining geometric opportunity: de-gaited body-frame bearing moves from
  about `-0.31 rad` at `8 T` to `-0.35 rad` at `12 T`, crosses, and reaches
  about `+0.64 rad` by `18 T`.  Closure remains positive and the wake remains
  coherent, but the route spends long intervals increasing bearing magnitude
  before the existing pursuit feedback reverses it.  This broad sweep, rather
  than propulsion loss, is the candidate-specific target.

## One candidate mechanism

Keep the assigned v32 carrier, posterior lag, whole-wave pose projection,
closing-response cadence release, raw half-cycle detector, and proven
head-to-tail rejected-steering allocation.  Add one smooth bearing-divergence
recovery inside route feedback.  It contributes bounded target-signed
curvature only when the already de-gaited body-frame bearing lies outside the
existing centerline band and `bearing * bearing_trend > 0`; it vanishes during
contraction and is attenuated continuously inside the existing approach
distance.  This should shorten the broad middle/late sweep without changing
the propulsive carrier or reacting to each wake vortex.

Expected test: beat v32's `18.7550 T` / `2.05886 L` route and the repeated
v33's `2.05835 L` integral while retaining capture, the alternating 3D wake,
and approximately the sampled `0.949 L/T`, `41.96%`, `0.0307`, and `0.0157`
speed/saturation/force/moment envelope.  Falsify the mechanism if bearing
oscillation grows, the target-signed arc reverses, capture or middle/late
closure regresses, or saturation/load materially increases.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: large-error curvature is retained while observed target geometry worsens and released when the response contracts that error
transferable_invariant: use observed geometric response, rather than elapsed time or exact beat phase, to gate a bounded redirect contribution
nontransferable_details: published gains, species-specific C-start kinematics, full-body envelopes, clocked CPG phases, and task-specific routes
policy_translation: outside the centerline band, add smooth target-signed two-joint curvature only for positive de-gaited bearing divergence and fade it with normalized approach distance
falsification: reject if capture, closure, wake coherence, or the established speed/action/load envelope regresses, or if the extra term follows within-beat recoil instead of route divergence

## Non-CFD contract replay

Replaying the candidate and assigned v32 policy on the recorded v32 state
history changes at least one joint command on `46.42%` of states.  The added
route term is active on `41.07%`, has mean/max magnitude `0.1286/0.4486`, and
is never signed with the diverging bearing.  The largest two-joint command
difference is `1.4086 rad/T^2` (`4.5%` of the physical acceleration limit),
and every candidate command remains within `31.415927 rad/T^2`.  The mean
term magnitude is largest during `8--12 T` (`0.218`), the diagnosed broad
sweep.  This only establishes bounded semantic activity; it is not CFD
performance evidence and the next formal rollout must apply the falsification
criteria above.
