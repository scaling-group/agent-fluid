# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four sampled shared-prewarm sheets are byte-identical. They show the fish
  held at the common upper-right release pose while the four staggered-cylinder
  streets grow into an overlapping, unsteady corridor around and downstream of
  the target. This establishes the common initial condition and does not rank
  policies.
- All four current solver samples independently reproduce the symmetric pure
  rolling-closing-speed policy with a `0.015 L/time` transition. Their released
  sheets and metrics are identical: active body oscillation carries the fish
  through a broad release turn and several wake-band crossings before an almost
  horizontal target entry at `210.370`. Score/mean distance are
  `-3.528/5.519L`, mean controller-relative upstream transport is `0.01672`,
  command energy is `147846`, and RMS lateral force/moment are
  `18.426/363.057`. Maximum anterior acceleration remains `31.055 rad/time^2`
  below the `31.2` policy guard, so the route gain is not extra drive or a
  relaxed actuation envelope.
- No current sample is a semantic failure. The newest inherited controlled
  negative is therefore the informative comparison: it kept the `0.015`
  transition while closing but softened only zero/negative closing speed to
  `0.020`. It still captured, and did so earlier at `206.470`, but regressed to
  `-3.956/5.943L` score/mean distance. Controller-relative upstream transport
  fell to `0.01215`, below both the symmetric `0.015` anchor and the inherited
  symmetric `0.020` parent (`0.01261`). Its lower command energy (`142752`) and
  RMS force/moment (`18.368/356.178`) therefore do not compensate for the lost
  route integral.
- The two released sheets show self-propulsion rather than passive advection:
  mean upstream fish speed exceeds the magnitude of mean local-flow x in both
  runs, and both cross the interacting central wake without collision, exit,
  or instability. The receding-soft sheet looks less jagged during its late
  central approach, but its worse mean distance and upstream margin show that
  visible smoothness is not a route-quality proxy. Because propulsion and the
  lookahead endpoints were unchanged, the negative result specifically says
  not to soften the receding/recovery half merely to reduce load.
- The older inherited `75%` progress / `25%` drift-magnitude selector remains
  the semantic failure boundary: its repeated reversals and deep lower-corridor
  excursion ended in a horizon miss at `3.689L` final and `7.507L` mean
  distance. The new candidate therefore retains rolling closing speed as its
  sole schedule input and does not reintroduce mixed selectors.

## Single candidate hypothesis

Preserve the reproduced `20.25 deg`, `0.67`-period propulsion, posterior
lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25` bearing-rate
lead, sign-gated target-away lateral correction, `0.07--0.08` lookahead
envelope, `0.10` lateral-velocity clamp, and `31.2` acceleration guard. Keep
the evidence-backed `0.015 L/time` transition for zero or negative closing
speed, but use the gentler `0.020 L/time` transition only for positive closing
speed. This is the complementary sign split to the inherited negative. It is
continuous at zero, remains bounded by evaluated scales and lookahead
endpoints, and adds no coordinate, route, clock, prescribed inflow, remote wake
probe, target-station signal, or selector mixture.

The controlled hypothesis is that the symmetric `0.015` route improvement is
carried mainly by decisive receding/recovery selection, while part of its load
cost may be avoidable on the already-closing half. Count the candidate as an
improvement only if it retains capture with mean distance near or below
`5.519L`, arrival no later than `210.370`, upstream margin above the inherited
`0.020` parent's `0.01261`, and reduced force/moment or effort without larger
excursion, switching, or guard contact. Falsify the decomposition if capture is
later or lost, mean distance exceeds the symmetric `0.020` parent's `5.856L`,
or upstream transport/load worsens; that would establish that both signs need
the symmetric `0.015` transition. Scope is limited to the retained gait and
certified fixed-prewarm phase until later CFD or held-out-phase evidence is
available; no same-worker outcome is claimed.
