# Posterior counterstroke-relief candidate

## Evidence read before editing

- All four sampled rollouts report direct uniform, quiescent initialization
  (`U_infinity=0`) and terminate by leaving the upper virtual boundary. The
  closest sampled approach is the full-quadrant redirect at `2.999L`; the
  anterior half-cycle stiffness case is the most informative phase-aware
  failure at `4.859L`.
- In both the top-down vorticity row and oblique Lambda2 row, the `2.999L`
  case is visibly self-propelled and sheds an alternating three-dimensional
  wake during approach. Near the pass, its redirect suppresses the traveling
  wave: around minimum distance (`17.666T`) the joints have settled near
  `(-10.2,-12.1) deg`, speed remains `0.767U`, and local flow is only
  `0.001U`. It then hooks clockwise out of the upper boundary while the
  nearly fixed bend, rather than passive still-water advection, carries the
  failure.
- The anterior half-cycle stiffness case keeps alternating structures and
  moving joints through the pass, but its approach is already worse: peak
  speed is about `0.947U` rather than `1.034U`, minimum distance is `4.859L`,
  and near-acceleration-limit occupancy rises from about `35/44%` to
  `54/65%` for joints 1/2. Rhythmic motion alone is therefore insufficient;
  corrective work must not perturb the anterior restoring dynamics or demand
  stronger peaks from the already limit-heavy posterior joint.
- Distance-conditioned posterior relief and carrier-wide approach damping
  also worsen closest approach to `3.162L` and `3.592L`. The inherited score
  logs add a genuine near miss (`0.857L`) and another `3.532L` approach, but
  both still leave the domain and the available logs contain no policy or
  trajectory evidence from which to attribute their mechanisms. The near
  miss is evidence that materially different target geometry is attainable,
  not evidence for any undocumented controller edit.

## Policy hypothesis

Preserve the zero-centered anterior Van der Pol carrier exactly. Recover a
signed full-quadrant bearing from normalized `target_body_L`, combine it with
bounded body-frame lateral slip, and retain the sampled posterior mean
curvature. When bearing error becomes large, infer the posterior carrier side
from the observed joint-1 state and smoothly attenuate only the carrier
half-cycle whose bend opposes the requested turn. The desired half-cycle is
left unchanged, so the mechanism creates target-signed cycle asymmetry without
raising the carrier peak, moving the anterior center, or freezing either
joint. It releases continuously when alignment returns.

Expected evidence is preservation of the early alternating wake and roughly
the `2.960L` reference approach, followed by a visibly rhythmic recovery arc
rather than a held-bend upper exit. Reject the mechanism if it destroys the
alternating wake, raises posterior limit occupancy, worsens closest approach,
or repeats the same upper-exit topology without a distinct recovery arc.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG and asymmetric-flapping turning
source_mechanism: target-signed half-cycle amplitude or duty-ratio asymmetry within a propulsive rhythm
transferable_invariant: unequal corrective work across the two carrier half-cycles can turn while preserving a traveling wave
nontransferable_details: published gains, clock phase, robot linkage geometry, species envelopes, exact vortex phase, and prescribed routes
policy_translation: use normalized full-quadrant target geometry and body-frame slip for turn sign; use observed joint state for posterior carrier side; attenuate only the counter-turn posterior half-cycle
falsification: reject if the early wake loses coherence, limit occupancy rises, closest approach does not retain the 2.960L reference, or no distinct recovery arc appears before termination
```
