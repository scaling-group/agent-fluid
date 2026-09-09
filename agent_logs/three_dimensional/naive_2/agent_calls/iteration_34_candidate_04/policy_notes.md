# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent preserves the unified predicted-miss handoff and asks for
  a separately scheduled terminal residual that vanishes on centered courses;
  it specifically rejects another residual-gain, line-rate, broad drive-relief,
  or static-curvature iteration.
- All four sampled rollouts report direct uniform still-water initialization,
  `U_infinity=[0,0,0]`, and capture. In both the score-best tail-only residual
  (`solver_e749afa61520`) and the weakest-score drive-relief capture
  (`solver_902d980c2b63`), the top-down sheets show self-propelled direct
  approach with a compact alternating vortex street. Their oblique Lambda2
  sheets show a bounded planar wake without visible advection or 3D breakdown.
  Vortex appearance and route topology are nearly identical, so the scalar
  spread is not evidence for a different wake mechanism.
- Reconstructed terminal constant-course miss separates the samples. The
  tail-only residual reached `0.651L` at `15.1403T/-0.01094` but incurred
  `1.269%` posterior `>40deg` dwell and about `0.04041/0.01902` peak normalized
  planar force/moment. Miss-conditioned drive relief retained essentially the
  same `0.635L` miss and `1.229%` posterior dwell at a worse `-0.01891` score.
  Response-releasing the residual improved miss only to `0.573L`, increased
  posterior dwell to `1.551%`, and reached `0.04162/0.01968` peaks, so release
  consensus alone did not supply actuator reserve.
- The joint-reserve allocator (`solver_bcdc57eba4e8`) is the informative
  geometric result: it captured with a `0.363L` reconstructed miss and slightly
  reduced posterior dwell to `0.996%`. It did not solve reserve quality because
  the authority transferred into `0.285%` anterior `>40deg` dwell; arrival also
  slowed to `15.4464T` and score to `-0.01764`. This supports state-dependent
  allocation, but falsifies unconditional transfer to the receiving joint.
- Sampled optimizer logs corroborate capture for the response-release and
  reserve-allocation children. Inherited guidance additionally records that
  line-rate remapping, phase selection, force re-engagement, broad drive relief,
  and corridor-wide release did not establish terminal margin, so none is
  reintroduced here.

## Policy hypothesis

Preserve the evidenced carrier, predicted-miss geometry, shared response
handoff, mean bend, and tail pulse. Replace the always-tail cubic terminal
residual with the sampled posterior-reserve allocator, but gate its transferred
anterior share by the anterior joint's own normalized angle/rate reserve. Thus
the extra redirect remains tail-dominant while the posterior has reserve,
moves only into an available anterior rhythmic channel, and otherwise sheds
authority instead of transferring saturation. This is a new allocation
mechanism, not a residual-gain change.

The rollout falsifies the candidate if it loses capture/direct routing/compact
wake; fails to improve the `0.651L` tail-only course boundary; retains or
exceeds the allocator's `0.285%/0.996%` anterior/posterior `>40deg` dwell; or
exceeds the tail-only residual's approximate `0.04041/0.01902` load class.
Slower arrival is acceptable only with a material terminal-margin and joint
reserve improvement. No outcome for this unevaluated candidate is claimed.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and biological burst redirect turning
source_mechanism: preserve rhythmic propulsion while sensor-gated redirect authority is recruited and returned as observed geometry, response, and kinematic state change
transferable_invariant: route correction should remain a bounded residual on the propulsive rhythm and should not command authority through a joint that lacks observed kinematic reserve
nontransferable_details: published gains, dimensional beat timing, species-specific C-start shapes, full-body envelopes, exact vortex phases, and prescribed routes
policy_translation: use normalized body-frame predicted miss plus absolute two-joint angle/rate reserve to keep the cubic redirect posterior-dominant, transfer it only to an available anterior half-cycle, and shed it when neither receiving path has reserve
falsification: reject unless capture and the compact direct wake survive while terminal predicted miss improves beyond 0.651L and both joint dwell and peak load improve relative to the sampled tail-only and unconditional-transfer variants
