# Far-to-near posterior wave-allocation candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled episodes satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite moving-
  window transport, stable dynamics, and `capture` termination. Their scores
  span `-0.20560-- -0.19989`, capture times span `19.360--19.552T`, and
  distance integrals span `2.08911--2.09458L`. This is a trajectory/effort
  refinement problem, not a missing-success problem.
- Both rows of the combined keyframe sheets were inspected for the strongest
  sampled response-gated bend (`solver_1af6c62469a7`), the phase-conditioned
  posterior-amplitude sample (`solver_31e8ebbf5bdb`), and the informative
  underperforming approach-authority composition (`solver_cb03d3cda781`). The
  top-down rows show self-propulsion from quiescent water and coherent
  alternating posterior vorticity; the oblique rows show compact 3D Lambda2
  structures following each fish without wake collapse, passive advection,
  collision, or instability. The amplitude sample visibly takes the wider
  late arc, while the response-gated and approach-authority tracks retain the
  shorter late hook. The views therefore localize the useful difference to
  wave allocation and approach geometry rather than wake class.
- The phase-conditioned posterior-amplitude policy is the only sampled
  mechanism with a clear far-field signature. Relative to the prefilled
  posterior-lag policy, it reaches `10/8/6L` at
  `6.892/9.680/12.342T` rather than `7.035/9.828/12.458T`, and lowers mean
  anterior command from `19.03` to `18.09 rad/T^2`. It then loses that lead:
  its path grows from `12.095L` to `12.549L`, sub-`2L` mean lateral speed
  rises from `0.085` to `0.200U`, and capture slips from `19.409T` to
  `19.552T`. Thus amplitude allocation is useful only before the approach
  correction, not as a global replacement for lag allocation.
- The sampled approach-authority composition is a concrete negative result.
  Adding an unconditional posterior carrier/lag multiplier to the response-
  gated bend changes neither wake class nor load envelope, but moves arrival
  from `19.360T` to `19.431T`, distance integral from `2.08911L` to
  `2.09458L`, and posterior near-command residence from `33.32%` to `34.16%`.
  Do not retain or tune that scalar.
- The assigned-parent log supplies an exact replication boundary for the
  apparently strongest response-gated bend. Its byte-identical rerun captures
  at `19.591T`, distance integral `2.09637L`, and score `-0.20651`, versus
  `19.360T/2.08911L/-0.19989` for the sampled copy. This overlaps the exact
  posterior-lag repeat envelope and does not establish a response-gate benefit.
  The new candidate therefore does not compose that extra terminal mean bend.

## One-candidate hypothesis

Start from the capture-proven scaffold and express one small compatible gait
handoff. Far from the target, use the sampled phase-conditioned posterior
carrier-amplitude asymmetry with constant base lag; it produced faster progress
and lower anterior command while the course was broad. As the existing
normalized approach weight rises, smoothly remove that amplitude asymmetry and
restore the sampled posterior-lag half-cycle allocation before the terminal
region. Preserve target mapping, mean curvature, drive relief, velocity-course
redirect, LOS-rate lead, anterior half-cycle steering, and smooth limits. Do
not add the unconfirmed wrong-sign-yaw bend or the falsified unconditional
posterior approach multiplier.

Expected signature: match the amplitude sample's earlier progress through
roughly `6L`, recover the lag scaffold's shorter approach path and low lateral
motion by `4--2L`, preserve capture, both coherent wake views, zero angle-limit
residence, and the sampled approximately `0.025/0.013` force/moment class, and
avoid raising command/rate-limit residence. Falsify the handoff if the far
progress advantage disappears, the wide terminal arc remains, arrival or
distance integral falls outside the capture scaffold's repeat envelope, or
joint margin, command residence, loads, or wake coherence regress. If
falsified, retain the plain lag scaffold and do not tune the transition scalar
without a held-out pose exposing the same far/near allocation split.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG amplitude and phase control combined with the qualitative far/middle/near capture structure
source_mechanism: change posterior wave allocation continuously with observed task geometry instead of imposing one gait modulation over the entire trajectory
transferable_invariant: use normalized body-frame distance to hand off from a propulsion-preserving posterior amplitude asymmetry to a turn-preserving posterior lag asymmetry while retaining one state-feedback traveling rhythm
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, full-body waveforms, clock phase, exact vortex phase, and task-specific coordinates or routes
policy_translation: blend the two sampled joint-phase allocations with the existing normalized approach weight, using anterior joint velocity times the equivariant body-frame turn request under the unchanged two-joint acceleration contract
falsification: reject if far progress is not retained together with shorter near-target path, capture, command headroom, joint margin, load class, and coherent top-down and oblique wakes
