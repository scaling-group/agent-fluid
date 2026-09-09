# Target-relative redirect-release candidate

## Visual and metric diagnosis before editing

All sampled and inherited episodes used direct uniform initialization in still
water with `U_infinity=(0,0,0)`, no cylinders, no prewarm, and a moving
window. I inspected both the top-down vorticity and oblique body/Lambda2 rows
of the best-score capture and two informative `left_domain` failures. The
capture is self-propelled on a nearly direct down-left route, retains a compact
body-connected alternating vorticity street and localized paired 3D tail
structures, and reaches `0.74998L` at `15.983T`. The response-released sibling
failure follows the same coherent, low-load approach and is still just outside
the sphere at about `16T`, but passes at `1.01175L`, turns down after the target
station, and exits at `27.533T`. The phase-separated failure similarly misses
at `0.82926L` before the same late exit. These are terminal geometry failures,
not passive advection, wake loss, load instability, or insufficient far-field
translation.

The four current samples all capture at `15.983--16.044T` and
`0.7472--0.7500L`. They have no joint dwell beyond `40 deg`, about
`16.9--17.2%` occupancy per joint in the last `10 deg/T` of the rate envelope,
and peak normalized planar force/moment of `0.0332--0.0367/0.0166--0.0185`.
The assigned response-released parent accounts for one capture, but a
byte-identical inherited execution misses at `1.01175L`; the three sampled
always-pulse executions capture, yet inherited evidence already shows that
pulse presence alone is not a reliable separator. Preserve the carrier,
constant-course predictor, direct route, and load class rather than retune
propulsion or pulse amplitude.

The inherited mechanism tests sharpen what to change. Subtracting an
evidence-fitted joint-rate sway model from terminal course prediction misses
at `1.02506L`; extending the pulse through the lagged posterior stroke misses
at `0.92803L`; and subtracting the two-joint angle-domain carrier estimate
from terminal bearing misses twice at `0.82926L` and `1.10362L`. Each retains
the direct low-load approach before exiting. Thus neither another fitted
carrier decomposition nor more pulse phase allocation has survived the
semantic test.

Offline replay of the evaluated trajectories identifies a narrower response
signal. Below `1.5L`, the existing modeled-yaw release gate averages `0.438`
in the parent capture and `0.360` in its identical-policy near miss, whereas a
bounded target-bearing window-response gate separates them more strongly at
`0.455` versus `0.328`. At the near miss's closest point, the target request
is still `0.910` and the body-frame bearing is worsening rather than closing,
so a yaw response is not sufficient evidence to release steering. This replay
only diagnoses command allocation; it is not CFD validation of the candidate.

## Single candidate hypothesis

Preserve the complete state-feedback traveling-bend carrier, far-field
pursuit/course blend, constant-course predicted miss and time gate, terminal
mean bend, posterior mid-stroke pulse, and bounded acceleration. Change one
feedback mechanism: use the available short-window body-frame target-bearing
rate, rather than a fitted combination of joint rates subtracted from raw yaw,
to decide when the response-gated half-cycle authority and posterior pulse can
be released. A response is corrective only when it actually reduces the
signed target request. This leaves the evaluated route and carrier unchanged
and keeps terminal steering active when body rotation looks corrective but the
target geometry is still opening.

Support requires repeated capture or a closer non-capture than the inherited
`0.829--1.104L` band, with the same direct compact-wake route, no material
joint dwell beyond `40 deg`, and sampled normalized planar force/moment near
or below `0.037/0.019`. Falsify on unchanged `left_domain` topology, a worse
closest pass, terminal oscillation from the bearing-rate signal, route or wake
class change, greater joint/load occupancy, nonfinite action, or loss of
reflection equivariance.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological redirect-to-cruise transitions
source_mechanism: release a bounded redirect when sensor feedback confirms that task-relative directional error is responding, while preserving the propulsive rhythm
transferable_invariant: task-error response, rather than rhythmic body rotation alone, should determine when steering authority returns to the established traveling-bend carrier
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, species-specific redirect timing and curvature, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use the normalized short-window body-frame bearing rate to gate release of the existing two-joint terminal half-cycle and posterior redirect; retain raw target/course prediction and all carrier dynamics
falsification: reject if capture or closest approach and termination do not improve together, or if the direct route, compact 3D wake, joint reserve, low normalized loads, boundedness, or reflection equivariance degrades

The candidate's CFD evaluation occurs only after this worker exits. Every
rollout and replay result above is inherited or sampled prior evidence.
