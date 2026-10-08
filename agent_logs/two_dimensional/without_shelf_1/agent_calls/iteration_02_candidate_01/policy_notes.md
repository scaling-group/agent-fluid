# Wake-policy candidate notes

## Evidence diagnosis before policy edit

- The common prewarm sheet shows the fish released near the upper-right edge,
  downstream of four fully developed, mutually interacting vortex streets. The
  target is left and below the release, inside the second-row wake corridor.
- The target-blind seed is principally advected rather than productively
  steering: it moved `-13.30L` in y while mean fish y velocity (`-0.263`) nearly
  matched mean local-flow y (`-0.241`), reached only `8.61L`, saturated both
  joint-rate and acceleration limits, and left the domain after `50.13` time
  units.
- The strongest finite sample, `solver_b9e94cfd3232`, puts a positive bounded
  bearing bias only on the posterior tail tangent. Its keyframes show genuine
  leftward self-propulsion into the developed street and a much closer approach
  (`6.34L` minimum, `0.132` progress, `73.39` time units in-domain), followed by
  a broad looping turn and upper-boundary exit. The loop agrees with posterior
  joint-angle saturation (`|phi2|=45 deg`), both joint-rate caps, `196` RMS
  lateral force, and `2014` RMS moment; the dramatic wake interaction therefore
  is not a stable improvement through capture.
- The opposite-sign posterior bias in `solver_b4c9da0faece` turns away and is
  swept downstream (`+2.45L` head x, negative progress, exit at `17.26`), so its
  lower loads do not justify reversing the useful sign. Moving the steering
  bias into the first-joint oscillator in `solver_ca671fb4ee80` curled the fish
  immediately and produced unstable dynamics in `3.39` time units with
  `56162` RMS lateral force and `580120` RMS moment. That architecture should
  not be retained.

## Candidate policy hypothesis

Retain positive, target-relative steering only as a mean posterior-tail-tangent
bias. Reduce the bias authority and subtract a bounded heading-rate term so a
fast turn relaxes the bias before the large loop seen in the best sample.
Keep the useful state-phase oscillator, but use a modestly longer period and
slightly lower amplitude with explicit command limits to reduce posterior
saturation without falling to the underpowered `11 deg`, `1.10`-period failure.
Fade steering near capture as before. This candidate is supported if it keeps
upstream displacement and improves on the `6.34L` closest approach while
remaining in-domain longer with lower joint saturation and force/moment loads.
It is falsified if reduced propulsion loses upstream progress, or if the same
positive steering sign still makes bearing/heading rate diverge into an upper
exit; a later worker should then isolate steering authority from rate damping.
