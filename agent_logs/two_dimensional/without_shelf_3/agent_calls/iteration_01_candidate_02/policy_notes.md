# Multi-wake candidate diagnosis

## Evidence read before policy editing

Only one sampled solver rollout is present, so it is both the best available
finite physical trajectory and the most informative failure; there is no
successful comparator in this workspace. The common prewarm sheet shows the
fish held at the upper-right release pose while all four cylinder streets
develop across the downstream corridor and through the target. In the released
sheet the seed produces a clear traveling body wave, but it turns sharply
downward almost immediately, never enters the second-row target corridor, and
leaves through the lower boundary.

The compact metrics agree with the images: termination is `left_domain` after
only `50.1269` of the `300` release horizon; head displacement is
`(-3.545, -13.300)L`, so most motion is lateral rather than the required
upstream diagonal. Distance briefly improves to `8.615L` but ends at `12.123L`
with only `0.0243` reported progress. This is self-propelled motion, not passive
advection: mean fish velocity `(-0.0725, -0.2633)` differs from mean local flow
`(-0.0414, -0.2414)`, while the active joints reach the configured velocity and
acceleration caps (`4.5379 rad/time` and `31.4159 rad/time^2`). The simultaneous
`21.94` RMS lateral force and `541.70` RMS moment show that the visually large
yaw excursion is load-bearing, not merely a rendering artifact. Command energy
is correspondingly high (`75002.3`) despite failure.

## Candidate hypothesis

Preserve a state-encoded two-joint traveling wave because the rollout proves
it can propel the fish, but remove the target-blind neutral heading. Center the
oscillator on a bounded body-curvature bias derived from body-frame target
bearing, with body turn-rate and normalized moment feedback opposing the large
yaw/load excursion. Reduce the gait frequency and regulate oscillator energy
to a smaller explicit amplitude so nominal motion stays inside the actuator
caps instead of relying on clipping. The posterior joint retains a damped,
velocity-lagged target so propulsion remains a traveling bend rather than a
rigid steering pose.

The expected signature is sustained upstream-left travel with bounded heading
corrections, entry into the developed wake corridor, lower cap contact, and no
early lower-domain exit. Falsification is a repeated early downward turn (which
would challenge the chosen curvature sign or damping gains), loss of upstream
speed before meaningful distance reduction (gait too conservative), or renewed
joint saturation/load spikes (regulation or steering still too aggressive).
