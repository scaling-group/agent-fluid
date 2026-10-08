# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held at the upper-right release pose while four asymmetric cylinder streets
  develop and merge around the target. It cannot distinguish policy quality.
- The sampled `0.35`- and `0.40`-anterior policies and the inherited `0.45`
  negative comparator all visibly self-propel. Each turns left and down, leaves
  a dense alternating tail trail, enters the merged wake corridor, and reaches
  the `0.75L` ring without collision, exit, or instability. For the strongest
  `0.35` policy, mean x velocity `-0.283` exceeds mean local-flow x velocity
  `-0.170`, confirming that the early diagonal traverse is not passive
  advection.
- With gain, gait, total steering bound, and posterior phase law fixed, moving
  the anterior steering fraction from `0.45` to `0.40` to `0.35` improves
  capture time monotonically (`43.323`, `39.710`, `38.362`) and lowers mean
  distance (`2.025L`, `1.874L`, `1.812L`). The released sheets agree: `0.45`
  lags during the turn and wake approach, whereas `0.35` sustains the strongest
  left-down progress into the target.
- The improvement is not a free load reduction. Relative to `0.40`, fraction
  `0.35` lowers total command energy (`54703` to `53487`), power proxy (`4092`
  to `4007`), and relative-crossflow RMS (`0.2265` to `0.2244`), but raises
  force/moment RMS (`38.40/618.59` to `40.73/637.79`). Its maximum joint angles
  fall to `0.494/0.521` rad from `0.507/0.528`, and both variants still touch
  the same rate and acceleration caps. Thus static peak-angle balancing does
  not predict wake-coupled load, and extrapolating toward still less anterior
  steering must remain a bounded navigation-versus-load test.
- The assigned-parent and inherited logs retain outer boundaries: gain changes
  above the `1.7` anchor regressed non-monotonically, the target-blind seed left
  the domain, and a slower mixed velocity/moment controller became unstable.
  No evidence supports changing propulsion, steering gain, observation set, or
  more than one policy axis in this candidate.

## Candidate hypothesis

Preserve the evaluated `0.55`-period, 28-degree oscillator, gain-`1.7` bounded
bearing law, 12-degree total steering limit, posterior phase lag, and damping.
Change only `anterior_steering_fraction` from `0.35` to `0.30`. This moves at
most another `0.6` degree of the saturated steering center away from joint 1
without increasing total target curvature or adding an unscaled signal. The
hypothesis is that one more equal, bounded distribution step will retain the
visible self-propelled diagonal route and improve arrival or distance integral,
while revealing whether the force/moment tradeoff has already become limiting.

The later CFD evaluation falsifies this candidate if it loses capture, arrives
no earlier than `38.362`, raises mean distance above `1.812L`, exceeds the
`0.35` command-energy/power envelope, or materially worsens crossflow or the
`40.73/637.79` force/moment RMS load envelope. Even a faster capture with worse
loads is a tradeoff, not evidence that decreasing the anterior fraction is
generally optimal. All available tests share one wake phase and start pose, so
any positive result remains limited to that condition until held-out evidence
exists.
