# Slip-balanced posterior duty candidate

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, all four sampled scores,
  observations, summary metrics, diagnostics, trajectories, policies, and the
  inherited optimizer notes. Every sampled episode is a finite capture from
  direct uniform still water with U_infinity=[0,0,0], no prewarm, no
  cylinders, and no boundary interaction.
- I inspected the combined sheets for the best-scoring v31 duty-ratio rollout
  and the assigned v26 parent, including their top-down mid-plane vorticity and
  oblique Lambda2 rows from release through capture. Both visibly self-propel
  from rest, build a coherent alternating reverse wake, retain compact
  three-dimensional posterior structures, and turn directly toward the target.
  Neither shows passive advection, a reciprocal standing wiggle, wake breakup,
  or out-of-plane instability. Their sampled wake topology is effectively
  unchanged; the informative difference is terminal half-cycle allocation.
- Relative to the v20 scalar baseline, the assigned v26 one-sided
  slip-synchronous feathering improves final course alignment from 0.1092 to
  0.1728, lowers absolute yaw from 0.9840 to 0.6545 rad/T, lowers
  target-normal speed from 0.8767U to 0.8493U, narrows head cross-track
  from 0.7317L to 0.7265L, shortens center path from 13.2108L to
  13.2064L, and reduces near posterior acceleration-ceiling residence from
  75.83% to 74.11%. This is evidence that observed target-normal slip
  times summed joint-rate phase selects a counterproductive half-cycle.
- The v26 benefit is not free: capture is 0.0055T later, mean distance
  regresses from 1.950358L to 1.950469L, and score falls from -0.064028
  to -0.064149. Conversely, the sampled v31 modulation redistributes
  posterior authority around unity and attains the best sampled
  score/mean-distance pair (-0.064000/1.950346L), but its course/turn
  selector gives back part of v26's damping: final alignment/yaw are
  0.1297/0.8077 rad/T, target-normal speed is 0.8732U, and cross-track is
  0.7327L. The completed load-power variants and shared yaw/course loops in
  the inherited logs do not improve closure and terminal attitude together, so
  another load placement or scalar turn gain is not supported.

## Single policy hypothesis

Preserve the assigned v26 odd body-frame route controller, state-feedback
anterior oscillator, posterior lag and emphasis, conserved forward mean-bend
allocation, phase-consistent reserve, half-cycle steering, and
reversal-preserving rate governor. Change only its terminal posterior
half-cycle mechanism: retain the evidenced signed product of normalized
target-normal velocity and normalized summed joint rate, but use that signed
product to center posterior wave authority around unity. The half-cycle whose
motion reinforces current cross-course slip is weakened, while the opposite
half-cycle is strengthened by the same bounded rule. This converts chronic
one-sided relief into state-feedback duty redistribution without adding a
course-error bend, changing cadence, or altering mean curvature.

The factor is exactly unity at and beyond 2.10L, at zero target-normal slip,
or at zero observed joint-rate phase. It remains bounded in [0.84,1.16].
Under lateral reflection both signed inputs reverse, so their product and the
duty factor remain invariant while joint targets and accelerations reverse.
Expected evidence is v26-class terminal alignment, yaw, cross-track, and
coherent two-view wake with v31-class closure and distance integral. Falsify
the mechanism if transit output changes, the factor is biased away from unity
over complete near beats, capture or score regresses materially, terminal
slip/alignment/yaw/path do not improve together, posterior saturation rises
without closure benefit, reflection fails, or either wake row deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and half-cycle amplitude asymmetry
source_mechanism: retain a traveling propulsive rhythm while redistributing bounded posterior effort between opposing stroke half-cycles in response to sensed lateral error
transferable_invariant: preserve cadence, posterior lag, and mean bend while weakening the observed half-cycle that reinforces target-normal slip and strengthening the opposite half-cycle around unit mean authority
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, full-body kinematics, world coordinates, target location, capture radius, and task-specific routes
policy_translation: multiply normalized body-frame target-normal velocity by normalized summed joint rate and use the signed product only during a moving, misaligned approach to form a bounded reflection-invariant posterior duty factor around unity
falsification: reject if pre-approach output changes, near-beat authority is chronically biased, capture or distance integral worsens materially, slip/alignment/yaw/path fail to improve together, saturation rises without closure benefit, reflection fails, or either coherent wake view worsens

## Lightweight validation after editing

- The mandated dedicated checker was invoked, but its pinned gpt-5.4-mini
  model is unsupported on this account. Running its immutable checks directly
  gives PASS for guidance materiality and solver boundary. The guidance check
  first exposed two identical assigned-parent listings in the rendered
  workspace README; deleting only the duplicate made the parent comparison
  unambiguous.
- Julia is not installed, so the executable include/action probe cannot run.
  Deterministic static checks find one definition of each public function,
  resolve all 63 direct params.FIELD references among the 65 fields returned
  by target_policy_params, confirm balanced delimiters and a nonempty
  candidate, and find no explicit elapsed time, step count, randomness, file
  I/O, cylinder coordinates, target coordinates, or memorized route input.
- Offline replay of only the new selector on the assigned v26 trace leaves all
  2,881 samples at or beyond 2.10L at exactly unit duty. Across the 394
  approach samples, the factor has mean/minimum/maximum
  0.98959/0.92693/1.06151; it weakens 50.25% and strengthens 29.19% of samples,
  with mean absolute deviation 0.02336. The formula is algebraically bounded
  in [0.84,1.16], becomes unity at zero slip or phase, and preserves its factor
  under simultaneous lateral reflection because both signed inputs reverse.
  These are contract and activation checks on a completed trace, not a claim
  about the pending CFD response.
