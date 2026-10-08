# Candidate wake-policy notes

## Evidence diagnosis before the edit

- All four sampled evaluations satisfy the direct-uniform still-water
  contract (`U_infinity=[0,0,0]`), use no cylinders or prewarm snapshot,
  remain numerically finite, and terminate by leaving the virtual domain
  rather than by capture.
- The best finite sample, `solver_c039fddba4d9`, keeps the anterior mean
  curvature separate from a zero-mean posterior carrier and smoothly relieves
  that carrier at large bearing. Its top-down sheet shows sustained down-left
  self-propulsion rather than the inherited early upper hook, and its oblique
  Lambda2 row retains discrete alternating three-dimensional wake structures
  through termination. Relative to the no-relief anterior-center sample, it
  improves closest approach from `5.033L` to `4.233L` and extends survival
  from `28.59T` to `31.87T`; carrier relief is therefore useful, not merely a
  scalar-score artifact.
- Carrier relief alone does not redirect the miss. Reconstructed from the
  logged body transform, the best sample's bearing grows from about
  `0.67 rad` at `14T` to `1.01 rad` at `16T`, `1.33 rad` at `18T`, and
  `1.51 rad` near `20T`. It passes below the target, reaches its `4.233L`
  minimum at `19.25T`, and exits the lower boundary at `9.176L`. The existing
  `8 deg` anterior center is already essentially saturated in this regime,
  while the tail carrier is already relieved to 35 percent of cruise.
- The most informative visual failure is the assigned prefill
  `solver_9d206ee1d38c`. Its yaw-response term moves the oscillator center with
  a short-window, beat-scale signal: the top-down and oblique sheets show the
  alternating wake fading after `16T`, and by `24T` joint rates are only about
  `-0.04/+0.01 rad/T`. The fish then coasts to the same lower exit, reaching
  only `4.376L`. This falsifies feeding recent yaw response directly into the
  carrier center even though its scalar score is close to the other samples.
- Target-side-only slip unloading (`solver_5f0fbc8301e5`) preserves the wake
  and reaches `4.252L`, but still exits low at `9.201L`; it offers no semantic
  improvement over the signed slip residual used by the best sample. The
  inherited optimizer logs also show that always-active shared or tail-biased
  mean equilibria regress badly, while anterior-only steering and a centered
  posterior lag produced the first upper-to-lower trajectory change. Thus a
  new redirect should remain anterior and should not reintroduce a posterior
  steering mean.

## One candidate hypothesis

Start from the best sampled bearing-gated posterior carrier relief without
changing its evidenced cruise period, amplitude, slip feedback, lag, damping,
or relief schedule. Add a separate smooth anterior curvature reserve that is
zero below `0.75 rad` bearing and reaches an additional bounded `8 deg` by
`1.20 rad`. This preserves the early coherent cruise trajectory, intervenes
only after the logged bearing enters the repeated miss regime, and keeps the
maximum mean center at `16 deg` rather than globally increasing the ordinary
steering gain. The posterior target remains a scaled zero-mean carrier, so the
new authority cannot recreate the inherited opposite-mean or shared-curvature
failure.

The expected semantic change is target-directed yaw before the `19--20T`
closest-approach reversal, followed by automatic release of the extra bend and
restoration of the posterior carrier as bearing falls. Falsify the mechanism
if the early alternating wake is lost, either joint spends materially more
time at its angle/rate limits, closest approach fails to beat `4.233L`, bearing
does not fall earlier than in the best sample, or the same lower-boundary exit
survives without a useful trajectory change. The current candidate's CFD
result is not available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: biological burst redirects and closed-loop robotic-fish target-feedback modulation of rhythmic locomotion
source_mechanism: large observed route error recruits bounded curvature authority beyond cruise steering while the propulsive rhythm is temporarily unloaded and alignment releases the redirect
transferable_invariant: preserve the ordinary traveling-wave carrier for cruise, but let persistent large body-frame target error recruit a distinct bounded mean-curvature reserve that releases continuously with observed alignment
nontransferable_details: species-specific C-start shapes, published gains, dimensional beat frequencies, exact vortex phases, robot linkage geometry, and task-specific routes
policy_translation: absolute body-frame bearing smoothly adds a bounded reserve only to the anterior oscillator center while the evidenced bearing gate relieves the zero-mean posterior carrier; neither a clock nor recent beat-scale yaw moves the center
falsification: reject if the coherent 3D wake disappears before redirection, joint saturation worsens, closest approach does not beat 4.233L, bearing does not decline earlier, or the same lower-domain exit persists
