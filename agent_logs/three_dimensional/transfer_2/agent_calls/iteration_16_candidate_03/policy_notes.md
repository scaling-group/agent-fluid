# Phase-conditioned posterior-amplitude candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled episodes satisfy the frozen rollout contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture` termination.
  The three byte-identical posterior-lag policies capture in
  `19.409--19.635T`, with distance integrals `2.09210--2.10246L` and scores
  `-0.20288-- -0.21272`. That repeat span is the comparison floor for a new
  mechanism, not evidence that the fastest allocation is a deterministic gain.
- Both rows of the combined sheets for the fastest identical-policy repeat
  (`solver_7ac67a265211`) and the slowest repeat
  (`solver_17ed583a64e1`) were inspected from release through capture. Their
  top-down rows show self-propulsion from quiescent water, compact alternating
  posterior vorticity, a direct target approach, and the same bounded late
  hook; neither shows passive advection, wasteful wandering, or collision.
  Their oblique rows show coherent three-dimensional Lambda2 structures
  following the fish without wake collapse or numerical instability. The
  sheets are visually the same useful trajectory class, so the slow repeat is
  an informative mechanism-level underperformer rather than a semantic
  failure.
- Scalar and trajectory diagnostics agree with the visual comparison. Across
  the identical repeats, head path ranges `12.095--12.222L`, peak planar
  force/yaw-moment coefficients remain `0.02460--0.02486/0.01303--0.01322`,
  and maximum joint angles remain about `0.530/0.587 rad`, below the
  `0.785 rad` envelope. Both joint rates touch the hard limit, however, and
  command residence above 90% of the smooth bound remains approximately
  `36.3--36.9%/33.8--33.9%`; the carrier has angle headroom but not a basis
  for simply increasing drive.
- The response-gated posterior counterturn variant
  (`solver_37425e4b74e2`) captures at `19.486T`, distance integral
  `2.09523L`, and score `-0.20571`, all inside the byte-identical repeat
  envelope. Its `12.098L` head path and coherent wake are useful, but mean
  absolute commands rise to `18.99/17.72 rad/T^2`, versus
  `18.55--19.03/17.44--17.72` for the repeats, and its sub-`1L` course and
  lateral residuals do not improve together. This supplies no evidence for
  tuning another lag or wrong-sign-yaw scalar.
- Inherited logs also reject projected-miss corridor tuning, unfiltered
  relative-crossflow mean curvature, unsigned lag compression, and
  previous-action feasibility gates on this release. The supported invariant
  is the target-derived, joint-state half-cycle allocation itself. The next
  clean test should change how that phase signal is expressed at the posterior
  joint while leaving base lag, mean curvature, propulsion relief, and
  terminal redirect intact.

## One-candidate hypothesis

Start from the evaluated posterior-lag parent and preserve its state-feedback
carrier, fore/aft-aware body-frame target mapping, distance/positive-closing
drive relief, velocity-course redirect, LOS-rate lead, bounded mean curvature,
anterior half-cycle steering, and smooth action limit. Remove only the
unconfirmed phase modulation of posterior lag. Instead, use the same bounded
product of normalized anterior-joint velocity and body-frame turn request to
slightly increase the posterior carrier amplitude on the useful steering
stroke and decrease it symmetrically on the return stroke, while holding mean
posterior lag and static curvature unchanged.

This is a mechanism change rather than a lag-gain edit: it tests whether
phase-conditioned posterior amplitude can convert existing angle headroom into
a more effective turn-producing traveling bend without increasing the
anterior oscillator or adding route memory, a clock, crossflow cancellation,
or a terminal gate. Expected signature: preserve capture and the coherent
two-view wake; retain the approximately `0.025/0.013` force/moment class and
zero angle-limit residence; and improve arrival or distance integral beyond
the `19.409--19.635T`/`2.09210--2.10246L` repeat envelope, or achieve a clear
command/rate-residence benefit at comparable trajectory quality. Falsify if
capture is lost, the late hook or path grows, posterior rate/command residence
increases without a repeat-resolved trajectory benefit, joint margin or wake
coherence regresses, or loads leave the sampled class.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and robotic-fish CPG asymmetric-flapping control
source_mechanism: preserve a traveling bend while allocating posterior amplitude asymmetrically between useful and return steering strokes
transferable_invariant: express a bounded target-derived half-cycle request by redistributing posterior wave amplitude around an unchanged mean instead of adding static curvature or more anterior drive
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, full-body waveforms, exact vortex phases, and task-specific routes or coordinates
policy_translation: modulate the anterior-angle contribution to the posterior joint target with bounded normalized anterior-joint velocity times the equivariant body-frame turn request, while retaining constant base lag and the two-joint state-feedback contract
falsification: reject if capture timing or distance integral does not clear the byte-identical repeat envelope without an effort benefit, or if path topology, wake coherence, joint/rate margin, command residence, force, or moment regresses
