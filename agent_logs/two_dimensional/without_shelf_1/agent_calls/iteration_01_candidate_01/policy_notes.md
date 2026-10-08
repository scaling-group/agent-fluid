# Multi-Wake Candidate Diagnosis

## Evidence used

- Assigned parent guidance describes the seed as a target-blind, joint-state
  oscillator and asks for bounded, normalized body-frame feedback. The
  inherited optimizer artifact has only its initial Elo record and no prior
  candidate-specific optimizer log, so it supplies no additional positive
  mechanism evidence.
- The sole sampled solver is therefore both the only finite reference and the
  informative failure example; there is no successful or near-miss example to
  compare against. Its score is `-14.294201` and it terminates by leaving the
  domain after `50.1269` released time units.
- The shared prewarm sheet shows the common held fish already immersed in the
  developed, interacting four-cylinder streets. This is initial-condition
  evidence, not evidence for the seed controller.

## Visual and metric diagnosis

From release to termination, the rollout sheet shows the fish rotate into a
near-vertical descent on the right side of the domain. It never enters the
useful target/cylinder region; repeated body waves continue while its path
curves down and out through the lower boundary. The motion is not purely a
propulsion failure: the head advances `-3.545L` in x and the distance first
falls to `8.615L`. It is primarily an uncontrolled lateral-advection failure.
The mean y velocity (`-0.2633`) closely tracks mean local-flow y (`-0.2414`),
whereas mean relative-flow y is only `0.0219`; this supports the visible
advection interpretation. The resulting `-13.300L` head displacement in y and
maximum `9.007L` lateral target offset explain the early domain exit and the
near-zero net progress (`0.0243`). RMS relative crossflow (`0.1747`), force y
(`21.94`), and moment z (`541.70`) also show that wake disturbances are large
enough that a target-blind oscillator cannot be expected to preserve heading.

The seed demands an aggressive gait at `0.55` period and `28 deg` amplitude.
The measured maxima equal the configured speed and acceleration bounds
(`4.5379 rad/time` and `31.4159 rad/time^2`), while command energy is
`75002.3` and the estimated tailbeat/shedding frequency ratio is `32.83`.
Thus the realized gait is actuator-clipped; its nominal oscillator parameters
do not describe the executed waveform cleanly. This evidence does not prove
that clipping caused the lateral exit, but it makes adding steering on top of
the same saturated demand a poor first test.

## Policy hypothesis

Keep a state-encoded limit-cycle gait, but lengthen the period to `0.90` and
reduce its amplitude to `22 deg` so the nominal first-joint velocity and
spring acceleration remain inside the formal caps. Center that oscillator on
a bounded mid-body steering setpoint computed only from target bearing,
windowed bearing rate, and recent body turn rate. The sign is chosen so a
positive body-frame bearing requests negative bend; the target observation
defines forward as body `-x`, so body `+y` is the right side. Limit mean bend
to `12 deg` and retain a lagged second-joint target around the centered
oscillator. This gives the controller a way to oppose wake-driven heading
loss without hard-coded coordinates, time, route, inflow, or remote probes.

Expected evidence is a finite rollout lasting substantially beyond `50` time
units, smaller absolute lateral displacement/offset, joint acceleration below
the cap for most of the episode, and continued negative x displacement with
better final or mean target distance. Falsify the mechanism if bearing error
grows with the requested steering sign, if the dynamic steering center itself
causes renewed saturation, or if the slower gait loses the seed's modest
upstream progress. A later worker should then reverse/test steering sign or
separate drive and steering changes using evaluated variants rather than add
unscaled wake-flow feedforward.
