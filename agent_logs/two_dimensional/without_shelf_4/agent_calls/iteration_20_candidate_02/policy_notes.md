# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the final policy edit

- All four current sampled solvers reproduce the sign-symmetric
  `0.015 L/time` pure closing-speed selector exactly. They capture at
  `210.370`, with score/mean distance `-3.528/5.519L`, upstream head
  displacement `-11.040L`, controller-relative upstream transport near
  `0.01672`, effort `147846.5`, and RMS lateral force/moment
  `18.426/363.057`. Their prewarm and released sheets are byte-identical.
- The common prewarm sheet shows the fish held above and downstream of the
  four asymmetric staggered cylinders while their interleaved vortex streets
  develop through the target corridor. In the successful released sheet, the
  fish makes a broad downward far-field turn, crosses into the middle wake
  band, and then self-propels almost horizontally upstream to the target. The
  displacement and mean local flow x (`-0.03551`) confirm that this is active
  swimming rather than passive advection.
- The inherited `0.015`-closing / `0.020`-receding sign split is a controlled
  negative: it captures earlier at `206.470` and lowers effort/load to
  `142752/18.368/356.178`, but worsens score/mean distance to
  `-3.956/5.943L` and reduces upstream transport to `0.01215`. Its visually
  smoother middle-band route therefore does not justify softening recovery.
- The reciprocal inherited split is the informative semantic failure that was
  not present among the four surface-level samples. With `0.015` while
  receding and `0.020` while closing, the fish never enters the useful central
  corridor: its sheet shows a large downward loop, reversal, and upward escape
  through the top boundary. It terminates `left_domain` at `214.528`, score
  `-13.428`, minimum/final/mean distances `7.316/12.542/11.062L`, negative
  progress, only `-0.651L` upstream head displacement, and effort/moment
  `151816/368.309`. Lower RMS force (`17.753`) and crossflow (`0.13118`) are
  not useful when navigation is lost.
- Together, the two complementary sign splits show that selector-scale
  asymmetry is a fragile route switch: relaxing either half of the successful
  `0.015` schedule loses route quality, and relaxing the closing half causes
  domain exit. The older progress/drift blend also missed the horizon, so the
  selector must remain sign-symmetric and purely driven by rolling closing
  speed.

## One candidate hypothesis

Preserve the demonstrated `20.25 deg`, `0.67`-period propulsion shell,
posterior lag/damping, `0.30` bearing scale, `0.25` bearing-rate lead,
target-away translation gate, `0.07--0.08` lookahead envelope, and `31.2`
acceleration guard. Restore one sign-symmetric transition scale and make only a
modest sharpening from `0.015` to `0.014 L/time`. The earlier symmetric
`0.020 → 0.015` change improved capture, mean distance, upstream margin, and
effort, while both one-sided relaxations regressed; `0.014` tests the remaining
evidence-supported direction in a much smaller step without adding a branch,
signal, coordinate, route, or clock.

Count this as an improvement only if it retains capture and beats the
`-3.528/5.519L` anchor without arriving after `210.370`, losing positive
controller-relative upstream transport, enlarging the `4.293L` excursion, or
materially exceeding `18.426/363.057` force/moment, `147846.5` effort, or the
`31.055 rad/time^2` observed anterior acceleration. Falsify further sharpening
on a route-topology change, switching, guard contact, later/lost capture, or a
load increase that outweighs distance-integral gain. The hypothesis is local
to this retained gait and certified fixed prewarm phase; evaluation after
worker exit must decide it.
