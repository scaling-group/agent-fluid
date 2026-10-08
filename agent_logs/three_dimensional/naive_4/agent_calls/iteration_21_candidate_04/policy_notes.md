# Alignment-conditioned redirect handoff candidate

## Evidence diagnosis before the edit

- All four sampled episodes satisfy the required direct-uniform still-water
  contract: `U_infinity=[0,0,0]`, no prewarm or cylinders, finite dynamics,
  and capture after about `16.0545T` and 239 moving-window shifts. There is no
  sampled failure-class sheet, so the useful comparison is among the three
  distinct terminal feedback laws and the inherited negative result.
- I inspected the best finite sample (`solver_4c5895307e4e`) and the distinct
  terminal-release and corridor-only alignment-escape samples in both rows of
  their combined sheets. From release, the top-down views develop a coherent
  alternating red/blue street behind a fish translating on the same smooth,
  target-directed arc. The oblique views retain compact alternating Lambda2
  structures behind the caudal region through capture. Nothing indicates
  passive advection, wake breakup, boundary contact, or out-of-plane
  instability. The established oscillator, posterior traveling wave, cruise
  route, and base steering sign should therefore remain intact.
- Metrics resolve effects too small for the rendered cadence. Releasing the
  supplemental carrier-yaw-residual correction only in the closing corridor
  captures at `16.05448T`, with distance integral `1.93077290L`, crossing
  distance `0.74695450L`, and peak lateral force coefficient `0.03324`.
  Extending that release to a measured near-alignment turnaround in the
  assigned parent preserves all reported milestones and hard-limit residence,
  improves the integral to `1.93014712L` and crossing to `0.74621189L`, and
  lowers the peak lateral force coefficient to `0.03223`; its score
  `-0.04728075` is the best sampled value. By contrast, the corridor-confined
  instantaneous escape changes only the final states (`1.93077154L`,
  `0.74695289L`) and is not a meaningful trajectory change.
- The inherited optimizer logs provide the negative control: adding active
  posterior counter-curvature during bearing reopening retained same-step
  capture but regressed to distance integral `1.93077780L`, crossing
  `0.74696016L`, and score `-0.04806087`. Thus terminal oversteer is evidence
  for removing excess target-signed authority, not for commanding a new
  opposite turn. Earlier predicted-corridor-only release of mean steering was
  also negative, so safe miss geometry alone must not trigger this handoff.

## One candidate mechanism

Retain the assigned parent's alignment-turnaround release of supplemental yaw
curvature. When that same response signal is active, continuously hand off only
the *increment* from high-authority redirect curvature toward the already
evaluated cruise-curvature branch. The target-directed turn sign is preserved,
the base cruise steering remains available, the posterior wave and its
one-sided relief retain their original selector, and the original redirect
duty continues to govern approach drive. The existing relief-only comparison
against the raw command remains the final allocator, so the handoff cannot
force a larger instantaneous posterior acceleration on the sampled state.

This tests whether the parent's positive response boundary generalizes one
control role beyond the supplemental yaw correction without repeating either
failed active counter-curvature or broad corridor-only steering release.
Expected evidence is unchanged cruise milestones and two-view wake coherence,
with a material reduction in terminal bearing rebound, distance integral, or
crossing distance. Falsify the mechanism if capture is delayed or lost, an
earlier milestone changes, the coherent wake weakens, a large unresolved
bearing error loses steering, or reduced command effort is not accompanied by
better route/crossing evidence.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological terminal capture control
source_mechanism: preserve rhythmic locomotion while measured directional response continuously reallocates only excess steering authority
transferable_invariant: a target-compatible response should hand supplemental correction back toward an established lower-authority steering mode without reversing the requested turn or suppressing propulsion
nontransferable_details: published gains, clock-driven phase, species-specific kinematics, dimensional frequencies, exact vortex phases, morphology, and source-task routes
policy_translation: use the normalized body-frame bearing-turnaround gate to blend only the high-authority posterior mean-curvature increment toward the existing cruise curvature; leave the two-joint carrier, steering sign, wave selector, and approach-drive duty unchanged
falsification: reject if cruise milestones or wake coherence change, capture regresses, the handoff persists for a large target error, or terminal distance and loads fail to improve over the assigned parent

## Non-CFD verification after the edit

- Candidate SHA-256:
  `331e7041e84b93d3fbe93acfed20f3140eec6d6eb726c48ad6b6bdacd23b9842`.
  The prescribed guidance/provenance check, lightweight Julia contract and
  parameter-schema check, and editable-boundary check all pass.
- A deterministic `30,000`-state sweep spanning joint state, target side,
  target-body geometry, bearing rate, body-frame course, and yaw response
  returned finite bounded commands, exact lateral-reflection equivariance,
  and no outward acceleration at either exact joint-speed boundary.
- Counterfactual evaluation on reconstructed assigned-parent states changes
  only seven posterior commands, all inside `0.848L`; anterior commands are
  identical. Every changed posterior command has no larger magnitude than the
  parent command on that state, and the maximum difference is
  `7.127 rad/T^2` versus the `31.416 rad/T^2` hard limit. This verifies the
  intended control-role scope, not a new closed-loop CFD outcome.
- The configured check-runner was invoked but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were then
  run directly and separately, and all passed. No formal CFD was run; the
  candidate hypothesis remains for post-worker evaluation.
