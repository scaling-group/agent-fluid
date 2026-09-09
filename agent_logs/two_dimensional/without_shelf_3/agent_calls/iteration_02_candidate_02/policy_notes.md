# Multi-wake candidate diagnosis and hypothesis

## Evidence diagnosis before policy editing

- The shared prewarm sheet shows the same held fish above and downstream of
  four fully developed, interacting cylinder streets for every candidate. It
  is a common initial condition, so none of the visible pre-release vortices is
  attributed to a controller.
- The target-blind seed is a finite but unproductive comparator. Its traveling
  bend briefly reaches `8.615L` range, then the fish turns almost vertically
  downward and exits after `50.127/300` release time. The keyframes and
  diagnostics agree: head displacement is `(-3.545,-13.300)L`, progress is
  only `0.0243`, mean y velocity (`-0.263`) nearly follows mean local y flow
  (`-0.241`), and both joints reach the velocity and acceleration caps. It
  demonstrates active propulsion but neither target-directed wake entry nor
  wake rejection.
- The prefilled positive-bearing-curvature controller is the strongest finite
  portion of the sampled rollouts. It visibly advances leftward rather than
  being carried out of the release corner, moves the head `-3.593L` in x with
  only `0.146L` net y displacement, reduces range from about `12.42L` to a
  `9.013L` minimum, and records `0.2589` progress. Its mean x velocity
  (`-0.149`) is more upstream than mean local x flow (`-0.077`), so this is
  self-propelled progress rather than passive advection. However, the final
  sheet shows the body folding into extreme curvature immediately before
  `unstable_dynamics` at `33.057` time. Both accelerations reach
  `31.416 rad/time^2`, joint-one velocity reaches `4.538 rad/time`, and RMS
  lateral force/moment explode to `20023.6/314391`; the progress is therefore
  useful mechanism evidence, not a viable incumbent.
- The amplitude-regulated negative-curvature controller stays below the joint
  rate and acceleration caps and keeps RMS force/moment at `21.13/430.32`, but
  it is carried rightward: head x displacement is `+2.744L`, progress is
  `-0.1702`, and it exits after `15.862` time without entering the useful wake
  corridor. The other negative-curvature controller becomes unstable after
  only `1.660` time with negligible progress, `3.863` RMS relative crossflow,
  and `59345.5/608198` RMS force/moment. Across the common snapshot, these two
  failures argue against reversing the curvature sign that generated the
  prefilled controller's upstream progress.
- The prefilled controller's nominal posterior target can combine `22 deg` of
  oscillation, roughly `12 deg` of velocity lag, and `10.4 deg` of posterior
  steering, leaving essentially no margin below the `45 deg` joint limit even
  before a wake disturbance. This is consistent with its visible terminal
  fold and measured cap contact. The inherited notes predicted directional
  improvement from bounded bearing steering but had no evaluation yet; the
  sampled result now supports the sign while falsifying the high combined
  curvature/demand as a stable setting.

## One candidate hypothesis

Retain the prefilled controller's positive, bounded body-frame bearing
curvature and two-joint traveling-wave structure. Replace its position-only
Van der Pol amplitude feedback with the sampled phase-radius energy regulator,
which damps joint-one motion whenever combined angle/velocity energy exceeds
the requested orbit. Reduce the orbit to `20 deg`, lengthen the period to
`0.80`, reduce the tail-lag gain to `0.45`, raise posterior damping slightly,
and cap total steering at `12 deg`. With a `0.35/0.65` steering split, the
nominal posterior target is then about `20 + 9 + 7.8 = 36.8 deg`, preserving a
meaningful margin below the hard joint-angle limit while retaining more of the
only gait that produced upstream progress than the weak wrong-way comparator.

The next CFD evaluation should support the hypothesis only if the fish keeps
the demonstrated upstream-left progress while remaining finite beyond
`33.1` release time with materially lower joint cap contact and force/moment
loads. A repeated rightward or steep downward departure would falsify the
preserved steering sign or show that wake advection still dominates; little
upstream displacement with low loads would mean the gait was over-derated; a
new terminal fold or instability would falsify the phase-energy regulation or
the remaining combined-curvature margin. The candidate has not been evaluated
in this workspace, so none of these outcomes is claimed.
