# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes. It is identical across the
sampled solvers and therefore fixes the release disturbance rather than
distinguishing policies.

All four sampled solvers reach the target after `43.9505` released time with
the same `2.1391L` mean distance and the same visible topology: an immediate
correct-sign redirect followed by a compact, actively propelled upstream-left
diagonal through the wake corridor. Mean fish velocity
`(-0.2471,-0.1020)` differs materially from mean local flow
`(-0.1342,-0.1556)`, especially upstream, so the closure is not passive
advection. Three samples use the unguarded carrier. The assigned-parent sample
uses a distinct terminal-localized posterior outward-rate guard but reproduces
the carrier's trajectory, command, crossflow, force, and moment to the printed
precision (`53082.57`, `0.2111`, `49.44`, and `701.26`). The localized
rate/alignment gates therefore made no semantic intervention; further tuning
of their thresholds would not be evidence-led.

No current sampled solver is a termination failure. The most informative
sampled mechanism failure is the inherited alignment-gated half-cycle release:
its keyframes remain direct, but force/moment rise to `55.12/764.85` while
both actuator caps remain touched. Inherited notes also bound the architecture
against raw yaw-moment feedback (`71.51/957.29` loads and later capture) and
against excess static curvature, which suppressed the traveling bend and
produced an advection-dominated domain exit. Conversely, the globally active
outward-rate projection reached at `44.0220` with lower `44.86/663.89` loads;
its benefit was distributed intervention, not peak avoidance. The present
candidate should preserve the proven route and act often enough after
alignment to yield a measurable transition-level effect, while testing a new
actuator-feedback primitive rather than another rate threshold.

## Policy hypothesis before the edit

Preserve the anterior state-feedback oscillator, bounded body-frame bearing
curvature, target-favored posterior half-cycle, posterior phase lag, and smooth
range envelope. Replace the inert terminal rate guard with one posterior
acceleration slew constraint. Large bearing demand keeps the evaluated redirect
exactly unchanged. Once alignment is small, the observed previous posterior
action and the actual observation interval bound how quickly the new posterior
command may change in either direction. This directly smooths acceleration
transitions instead of predicting load from an uncalibrated force, moment, or
wake-phase sign.

Expected evidence is the same direct target-reaching topology and near-carrier
arrival with lower RMS force/moment or command power from softened posterior
switching. Falsify the mechanism if capture is lost or materially delayed, the
traveling bend or early redirect changes, load/effort remain indistinguishable,
or transition smoothing increases crossflow. Because the new CFD result is not
available until after this worker exits, this is a falsifiable candidate
hypothesis rather than a claimed improvement.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and adaptive swimming in unsteady wakes
source_mechanism: retain a rhythmic traveling-wave carrier while using observed state to make a small bounded actuator-level modulation
transferable_invariant: preserve posterior propulsion and steering during large normalized body-frame direction error, then condition a compact transition-shaping residual on observed alignment and actuator state
nontransferable_details: published gains, dimensional frequencies and slew limits, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: keep the joint-state carrier and body-frame bearing command; after alignment, use previous posterior action and observation `history_dt` to bound acceleration-command slew without reading flow phase or world position
falsification: reject if direct capture is delayed or lost, the coherent posterior bend degrades, or RMS force, moment, crossflow, and effort do not improve relative to the unguarded carrier

## Pre-evaluation verification

The required guidance semantic check and solver editable-boundary check pass.
Static schema inspection found all `14` direct `params.FIELD` references among
the `14` fields returned by `target_policy_params()`, with no missing or unused
field. By construction, the smooth alignment gate remains in `[0,1]`, becomes
exactly zero for `abs(turn_request) >= 0.75`, and blends between the raw action
and a command inside `previous_action[2] +/- slew_limit * history_dt`; thus the
large-error redirect is unchanged and the aligned command transition is
bounded for finite observations. The prescribed Julia include/assertion could
not run because this environment has no `julia` executable. This is a runtime
verification limitation, not a passed policy execution, and no formal CFD was
run.
