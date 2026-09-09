# Multi-wake target-policy candidate notes

## Evidence diagnosis before the policy edit

The common held-fish prewarm sheet shows four developed, interacting vortex
streets reaching the upper-right release location before every candidate starts.
The naive seed's released sheet then shows the fish curl from its initial
diagonal pose into a nearly vertical descent below the useful wake corridor. It
leaves the lower boundary after `50.127` released time with head displacement
`(-3.545, -13.300)L`, only `0.024` progress, and minimum/final target distance
`8.615/12.123L`. Mean fish velocity differs from mean local flow by only about
`0.038U`, while both joint-rate and acceleration caps are reached. The large
displacement is therefore mostly adverse advection plus an unproductive
target-blind curl, not evidence that more oscillator drive is useful.

The sampled bearing-biased policies provide the positive mechanism evidence.
Both copies of the compact `8 deg` body-frame bearing-to-mean-curvature
controller reach the `0.75L` target boundary after `93.032` time with about
`0.940` progress and `4.033L` mean distance. Their released sheets show an
immediate correct-sign redirect, a sustained upstream diagonal traverse into
the developed wake, and final target entry instead of a boundary exit. Mean
velocity relative to local flow is materially stronger than for the seed, so
the route is controlled self-propulsion rather than passive advection.

The successful route remains cap-dominated: maximum joint rates and
accelerations equal `260 deg/time` and `1800 deg/time^2`, and RMS lateral
force/moment are about `95.5/1147`. Inherited logs also bound unsafe changes. A
global period/amplitude reduction exits right after `17.457` time with `-0.145`
progress; increasing static turn bias to `12 deg` exits right after `16.791`
with `-0.147` progress; and a slow/narrow carrier with uncalibrated global
heading-rate damping becomes unstable. Preserve the demonstrated carrier and
mean-curvature route rather than retuning them globally.

The strongest sampled terminal variant reduces oscillator amplitude smoothly
inside `2.5L`. It preserves the same capture time and route and improves score
only from `-2.120251` to `-2.119281`; aggregate command effort, saturation,
force, and moment are effectively unchanged. This is weak positive evidence
for keeping its exactly localized envelope, but not evidence that more
amplitude-only scheduling will resolve the visible late curl or load peaks.

## Policy hypothesis

Start from that strongest sampled controller, including its terminal amplitude
envelope. Add one localized state-feedback mechanism: inside the same `2.5L`
approach region, add a smoothly bounded `bearing_window_rate` lead term to the
observed body-frame bearing before the existing curvature saturation. A bearing
rate opposite the bearing means alignment is already improving and reduces the
mean bend; a same-sign rate means the target error is worsening and briefly
reinforces the redirect. The correction is bounded in bearing units and fades
exactly to zero outside the approach region. Frequency, posterior lag, static
turn authority, and the entire demonstrated far/middle wake route remain
unchanged.

This candidate is falsified if the pre-approach actions differ from the sampled
success, first crossing is delayed or lost, terminal bearing oscillation or
curl is not reduced, or effort/load/saturation remain unchanged. Because the
available evidence has no sign-resolved force or moment events, the candidate
does not add a wake-load residual.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal target capture
source_mechanism: sensor feedback modulates a rhythmic gait while a bounded target-error-rate term damps final directional correction
transferable_invariant: separate the proven propulsive carrier from a localized feedback correction, using normalized target-error rate to reduce a converging turn and reinforce only a diverging turn
nontransferable_details: published gains, dimensional rate scales, species or robot kinematics, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: retain the sampled joint-state oscillator, posterior lag, bearing bias, and range envelope; inside the normalized approach region add a bounded `bearing_window_rate` prediction to `state.bearing` before mapping it to mean joint curvature
falsification: reject if far-route commands change, capture is delayed or lost, terminal bearing/curl does not improve, or actuator and load measures remain cap-dominated

## Pre-evaluation verification

Formula inspection confirms exact equality with the sampled successful
controller for every `distance_L >= 2.5`: approach weight and bearing-rate
correction are both zero, and oscillator amplitude is the original `28 deg`.
At the `0.75L` capture boundary, the inherited amplitude scale remains `0.804`
and the new predicted-bearing correction is bounded to about `3.14 deg`; the
curvature command itself remains bounded by the existing `8 deg` joint-center
limit. Every direct `params.FIELD` use has a matching returned parameter, the
prescribed no-CFD Julia contract check passes using the workspace-accessible
runtime, the guidance semantic check passes, and the solver boundary check
passes. CFD behavior remains intentionally unevaluated for the post-worker
rollout.
