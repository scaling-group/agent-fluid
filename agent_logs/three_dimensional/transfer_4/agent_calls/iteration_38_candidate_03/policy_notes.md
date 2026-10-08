# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- The assigned parent is the prefilled v31 course-consensus posterior-duty
  policy. `solver_1ef9ecb8352d` captures at `18.0125T`, scores `-0.0640004`,
  has mean/observed distance integrals `1.950346L/1.336756L`, and reaches
  `0.748395L`. `solver_24d38f4fb85b` and `solver_900814da599b` have the same
  policy hash, trajectory metrics, and score, so they are determinism evidence
  rather than independent mechanisms.
- All four sampled rollouts report `uniform_direct` initialization,
  `U_infinity=(0,0,0)`, no instability, and capture. There is no sampled
  failure to compare; the distinct v20 yaw-power policy
  (`solver_adfafc9b9f71`) is therefore the informative weaker comparator. It
  captures slightly earlier at `18.0070T` and has a slightly better observed
  distance integral (`1.336706L`), but its terminal alignment/yaw are worse
  (`0.1092/0.9840 rad/T`) than v31 (`0.1297/0.8077 rad/T`). The sub-`3e-5`
  score ordering is dominated by the discrete capture and hold terms, not a
  visibly different transit mechanism.
- In the top-down row, both policies self-propel smoothly toward the target;
  from release through `4T`, `8T`, `12T`, and `16T` the body leaves a coherent
  alternating wake rather than being advected. The final sheet shows capture
  after a broad, smooth target-directed arc, without collision or wake breakup.
  In the oblique Lambda2 row, linked three-dimensional structures remain
  organized around the posterior body and caudal fan and trail behind the
  translating fish. The two sampled policies are visually indistinguishable at
  the available keyframes, so vortex prominence does not explain their small
  scalar difference.
- The assigned trace enters `2.1L` at about `15.851T` and still carries roughly
  `0.90U` speed. Below `1.0L`, mean speed remains about `0.889U`, course
  alignment falls to about `0.403`, and mean absolute seven-sample yaw response
  is about `2.05 rad/T`; capture still occurs at `0.881U` with signed course
  error about `0.992`. Below `2.1L`, the anterior/posterior acceleration
  ceilings are occupied for about `69.3%/75.9%` of samples. This is a fast,
  laterally energetic crossing, not weak propulsion or a wrong-sign route.
- The inherited score logs after the parent remain captures but regress to
  `-0.064886` and `-0.065002` without trajectory evidence, so no mechanism is
  attributed to those scalars. The inherited completed cadence-governor result
  is more informative: common frequency relief improved the terminal
  alignment/yaw crossing but delayed arrival, worsened both distance integrals
  and path, and lowered mean near alignment. Cadence is therefore the wrong
  terminal allocation channel for this evidence.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control
source_mechanism: sensed amplitude-envelope modulation while rhythmic phase and frequency continue
transferable_invariant: reduce only excess oscillatory excursion when observed approach state shows surplus cross-course motion, without resetting cadence, phase lag, or mean turn
nontransferable_details: published gains, dimensional beat rates, species-specific envelopes, clock-driven oscillator phases, and task-specific routes
policy_translation: form a reflection-invariant closing-stride authority from normalized body-frame distance, center-speed course alignment, signed course slip magnitude, and positive radial closure; use it only to taper posterior gain above the base traveling wave while preserving the existing odd mean bend and joint-state oscillator
falsification: reject if pre-approach commands differ, capture or observed closure regresses materially, the coherent traveling wake weakens, limit residence migrates anteriorly, or terminal speed, alignment, yaw, path, and posterior ceiling residence do not improve together

## Candidate hypothesis

Keep v31 unchanged through transit. During only a moving, misaligned approach,
compute radial closure from the dot product of the normalized body-frame target
direction and body-frame center velocity. Combine positive closure with the
existing approach/speed gates and the magnitude of signed course slip. This
gate is independent of joint half-cycle sign and is invariant under lateral
reflection. Apply it to the excess part of `posterior_wave_gain` above `1.0`;
the base posterior wave, posterior lag, cadence, mean tangent, and v31 duty
surface remain intact.

Expected result: exactly reproduce the established transit until `distance <
2.1L`, then reduce surplus tail excursion and posterior acceleration residence
without the route-wide delay caused by frequency relief. The candidate is not
claimed improved until later CFD confirms capture and jointly checks observed
distance integral, path/cross-track, near alignment/yaw/speed, both joint limit
residences, and both wake views.

## Static post-edit audit

Projecting only the new selector over the assigned parent's stored trace gives
exactly zero authority at every sample with `distance >= 2.1L`. Within the
approach, authority averages `0.172` and peaks at `0.484`; the corresponding
effective posterior gain remains in `[1.086, 1.167]`, so the `1.0` base wave is
never removed. The solver boundary, parameter-schema ownership, and durable
guidance checks pass. This audit establishes gating and contract properties
only; it is not a rollout or performance result.
