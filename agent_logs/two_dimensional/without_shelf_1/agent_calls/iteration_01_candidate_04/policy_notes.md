# Wake-policy candidate notes

## Evidence diagnosis

The only sampled solver, `solver_8f63ea428aae`, is the unchanged target-blind
seed. The shared prewarm sheet shows the common held fish above and downstream
of four established staggered vortex streets. In the released sheet the fish
initially points generally toward the target, then develops a strong clockwise
turn and follows an almost vertical path to the lower boundary. It never
enters the cylinder/target wake corridor. This is a finite but informative
failure (`left_domain` after 50.13 release-time units), not a collision or
numerical instability.

The scalar and diagnostic evidence agrees with the pictures: head displacement
is only `-3.55L` in x but `-13.30L` in y, final distance is `12.12L`, and the
brief minimum distance of `8.61L` produces only `0.0243` progress. Both joint
accelerations reach the `1800 deg/time^2` hard limit; the `0.55` period and
`28 deg` amplitude alone imply a harmonic acceleration scale above that limit.
The rollout also has large crossflow/load signatures (`0.175` RMS relative
crossflow and `541.7` RMS moment), so its lateral oscillation is not productive
target approach. The modest upstream displacement is the one useful behavior
to preserve. There is no inherited optimizer log in this workspace beyond
the assigned guidance and sampled evaluation artifacts.

## Candidate hypothesis

Retain the state-feedback traveling-bend oscillator, but lengthen its period
just enough that its nominal angular-speed and acceleration scales fit inside
the actuator envelope. Add a bounded tail-tangent bias from the body-frame
target bearing so a target above the fish's forward axis commands the opposite
correction to the observed downward turn. Fade the bias near the capture
radius to avoid circling caused by a poorly conditioned bearing at very short
range. A turn-rate term is deliberately deferred because the sampled evidence
does not establish that observation's numeric scale. All gains remain in
`target_policy_params`; the policy uses no global coordinate, target identity,
clock, route, or hidden flow probe.

The next CFD evaluation should falsify this mechanism if it still exits the
lower domain without materially reducing the y/x displacement imbalance, if
the steering sign increases target bearing, or if the slower oscillator loses
the seed's useful upstream propulsion. A horizon miss with better sustained
distance progress would nevertheless isolate steering as improved relative to
the sampled boundary exit; success is not claimed before that evaluation.
