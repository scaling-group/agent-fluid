# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared-prewarm sheet shows the fish held at the upper-right release pose
  while the four staggered cylinder streets develop and overlap through the
  target corridor. This is the certified common initial condition, not a
  candidate-ranking signal.
- The two strongest current samples reproduce the prefilled `0.08` body-frame
  lateral counter-drift gate exactly. Their released sheets show a broad
  self-propelled acquisition turn, productive crossings of the interacting
  wake bands, and first target entry by rendered frame `25`, without collision,
  domain exit, or instability. Capture occurs at `224.488`, mean distance is
  `6.311L`, and mean upstream head speed is `-0.04895` versus mean local-flow x
  `-0.03293`, leaving `0.01602` controller-relative upstream transport. RMS
  relative crossflow, lateral force, and moment are
  `0.13427/17.943/361.014`.
- The matched ungated anchor arrives at `244.547` with mean distance `6.452L`
  and only `0.00793` controller-relative upstream transport. Its sheet retains
  a longer sequence of large turn reversals before the central approach, and
  its RMS lateral force/moment rise to `18.263/362.214`. Thus the sign-gated
  translational correction is useful at `0.08`; reverting it is unsupported.
- Increasing only `lateral_velocity_lookahead` from `0.08` to `0.10` is the
  direct local negative result. Its sheet shows a more jagged corridor transit
  and does not capture until rendered frame `30`. Metrics confirm regression:
  arrival delays to `263.346`, mean distance rises to `6.974L`, score falls
  from `-4.311` to `-4.949`, controller-relative upstream transport drops to
  `0.00931`, and RMS force/moment rise to `18.310/361.415`. The slightly lower
  `0.13295` RMS relative crossflow is not a useful trade. Maximum lateral
  offset remains `4.293L` and maximum anterior acceleration remains `31.055`,
  so this is steering timing rather than propulsion, envelope, or clearance.
- The weakest sampled success is a complementary negative: alignment-gated
  heading-rate damping preserves capture but produces repeated wide reversals,
  arrives at `265.298`, raises mean distance to `7.822L` and force to `18.886`,
  and has negative controller-relative upstream transport (`-0.00282`). The
  inherited optimizer notes also report that sign-asymmetric bearing-rate
  steering missed the horizon at `3.632L` after a `3.290L` minimum. These
  controls rule out combining another rotational or rate decomposition with
  the translational gate in this candidate.

## Single candidate hypothesis

Preserve the demonstrated `20.25 deg`, `0.67`-period propulsion shell,
posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lookahead, `0.10` lateral-velocity clamp, and `31.2` acceleration
guard. Change only `lateral_velocity_lookahead` from `0.08` to `0.07`. The
tested points bracket a non-monotone response: zero correction is slower,
`0.08` improves arrival, mean distance, upstream margin, and loads, while
`0.10` loses those gains. The lower-side probe reduces the maximum added
pre-nonlinearity correction from `0.008` to `0.007 rad` while retaining the
same sign gate and exact return to the anchor during stationary or targetward
lateral translation.

The falsifiable expectation is that slightly less target-away counter-steering
will retain useful wake acquisition but reduce late reversal sensitivity,
improving mean distance or arrival relative to `0.08` without sacrificing its
positive upstream margin and load envelope. Reject the candidate on lost or
later-than-`224.488` capture, mean distance above `6.311L`, upstream margin
below `0.01602`, material crossflow/force/moment growth, guard contact, larger
lateral excursion, or visible chatter. No same-worker CFD result is claimed;
the current evaluation occurs only after this worker exits.
