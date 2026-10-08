# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned-parent prefill (`solver_e584ff748453`) is a direct-uniform
  still-water rollout, not a prewarm artifact. It captures at `23.375013T`
  with score/mean/final distance
  `-0.503415 / 2.400748L / 0.747085L`. The independent
  `solver_04760fa01847` is bit-identical evidence for the same policy.
- Both rows of the combined keyframe sheets show self-propulsion rather than
  advection: the body advances along a gently curving target approach while a
  coherent alternating vorticity street and paired oblique Lambda2 structures
  grow behind it. None of the samples loses thrust, exits, collides, or becomes
  numerically unstable. The terminal frames retain a strong lateral beat and
  visibly rotate through capture, so this is a carrier/route separation
  problem rather than a missing propulsion or redirect mechanism.
- Extending the parent's cadence handoff to the bounded union of its two
  existing stabilizers (`solver_ba129a83ae98`) retains the same `23.375013T`
  capture and improves score/mean/final distance to
  `-0.502603 / 2.400102L / 0.746257L`. It reduces inside-`3L` mean yaw and mean
  absolute moment from `1.71472 rad/T` and `0.006597` to `1.70656 rad/T` and
  `0.006564`, but increases peak yaw/cross-track speed/moment to
  `3.28817 rad/T / 0.62616U / 0.015118`. Thus the union is the better progress
  base, not a complete load remedy.
- The target-course observer sample (`solver_a95f7416a3de`) changes the slow
  route signal and has the best sampled score/mean distance
  (`-0.501691 / 2.399184L`), with lower inside-`3L` mean yaw/cross-track
  speed/moment (`1.68733 rad/T / 0.22592U / 0.006393`). It reaches `6L`
  `0.0605T` earlier than the union but then reaches `3L`, `2L`, and `1L`
  `0.0110T`, `0.0330T`, and `0.0990T` later and captures at `23.441015T`;
  peak yaw also rises to `3.34971 rad/T`. Its rate-only subtraction therefore
  contains useful route information but still leaks a quadrature carrier
  component into steering.
- Offline projection across the parent, union, and target-course traces gives
  stable phase-plane structure: target-line cross-track velocity is predicted
  by approximately `0.70*phi_dot1/omega - 0.24*phi1`. Using both coordinates
  instead of the sampled `0.80*phi_dot1/omega` alone reduces mean absolute
  carrier-rejected residual from about `0.116U` to `0.081--0.083U` outside
  `3L`, and from about `0.079--0.080U` to `0.028--0.035U` in `2--3L`, across
  all three distinct trajectories. This is diagnostic support for a mechanism,
  not same-worker CFD evidence.

## Policy hypothesis

Start from the evidence-positive stabilization-envelope union. Replace raw
body-lateral route feedback with a normalized target-line course residual whose
carrier estimate spans anterior oscillator velocity and displacement. Apply
that residual only to the slow geometric/route demand; retain the established
anterior-rate-only terminal stabilizer, posterior traveling wave, target-
progress cadence release, demand union, and smooth acceleration projection.
This tests whether phase-plane carrier rejection keeps the course observer's
early distance-integral benefit without its late arrival and peak-yaw defect.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG path following and adaptive swimming
source_mechanism: sensor feedback modulates a slow route residual around a rhythmic oscillator instead of treating carrier motion as route error
transferable_invariant: separate a joint-state rhythmic carrier from normalized target-relative course motion before feeding route steering
nontransferable_details: published CPG gains, oscillator frequencies, species envelopes, exact wake phases, and source-task paths
policy_translation: project target-line cross-track velocity onto anterior phi/phi_dot quadrature, subtract that bounded carrier estimate, normalize by swimmer speed, and use only the residual in route demand under the two-joint state-feedback contract
falsification: reject if CFD loses capture or coherent alternating propulsion, fails to retain union-scale pre-3L progress, repeats the 23.441T late approach, or worsens peak yaw, target-cross-track speed, moment, or actuator feasibility
