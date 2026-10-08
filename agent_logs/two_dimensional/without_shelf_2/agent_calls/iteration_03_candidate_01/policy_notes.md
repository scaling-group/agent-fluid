# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The shared prewarm sheet shows the common held fish at the upper-right start
  while four developed vortex streets occupy the route to the target. It is an
  identical initial condition, not evidence for any candidate-specific gain.
- The strongest finite sample is the positive-bearing/positive-curvature,
  energy-regulated controller. Its released keyframes show active upstream and
  downward motion from the start, entry into the developed wake, a wide
  excursion below the direct route, then reorientation and first crossing of
  the target circle. It reached the target in `130.229` release-time units with
  `0.939668` progress and mean/final distance `3.516/0.750L`. Mean body velocity
  `(-0.0835,-0.0362)` differs materially from local flow
  `(-0.0455,-0.0508)`, so the upstream closure is not passive advection. Loads
  remained finite (`26.34` force-y RMS and `427.54` moment-z RMS), joint speed
  stayed below its hard cap, and the candidate-owned acceleration limit was
  reached. The visible inefficiency is lateral: maximum target offset was
  `5.425L` before capture.
- The target-blind seed visibly turns almost straight downward and exits the
  lower domain after `50.127` units. Its mean velocity nearly matches local
  flow, it reaches both evaluator acceleration and velocity caps, and it makes
  only `0.0243` progress. The low-effort positive-curvature sample has too
  little gait authority (`0.218` mean command energy): it is swept right and
  exits after `16.725` units with negative progress. Inherited logs show two
  comparable slow descendants repeating that right-boundary topology, so they
  do not isolate steering sign from insufficient propulsion.
- The prefilled negative-curvature controller adds heading-rate lead while
  increasing the oscillator to `30 deg` at period `0.82`. Its second keyframe
  already shows a tight high-curvature upset, followed by unstable termination
  at `4.451` units. It hits the `260 deg/time` joint-speed cap and produces
  `5.50e4` force-y RMS and `5.68e5` moment-z RMS. This coupled sign/drive/lead
  change is not a safe basis for refinement.

## Single candidate hypothesis

Start from the only successful policy without changing its demonstrated
propulsive mechanism: retain period `0.75`, amplitude `22 deg`, energy gain
`2.0`, positive curvature for positive bearing, posterior traveling-bend
coupling, damping, and the `28` acceleration guard. Add only a small, bounded
windowed-bearing-rate term to the steering request. When bearing is returning
toward zero, its rate has the opposite sign and should unload mean curvature
before the fish crosses into the wide lower excursion; when wake motion drives
bearing away from zero, it should add a limited corrective bias. A `2.5 deg`
maximum rate contribution at a `0.35 rad/time` scale remains subordinate to the
existing `8 deg` steering bound and is zero during padded startup history.

The candidate is supported if it still reaches the target while lowering the
`5.425L` maximum lateral offset, the `130.229` arrival time, or the `3.516L`
mean distance without approaching the hard joint-speed cap or producing a
load spike. It is falsified by loss of capture, downstream/domain exit,
unstable dynamics, or route/load metrics no better than the successful anchor.
Because no sampled run isolates bearing-rate damping at matched propulsion,
the derivative term must remain bounded and its value should not yet be
generalized beyond this common prewarm comparison.
