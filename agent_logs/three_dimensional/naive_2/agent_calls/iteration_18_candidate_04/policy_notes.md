# Terminal transverse-course posterior-pulse candidate

## Evidence and visual diagnosis before editing

All four sampled evaluations satisfy the frozen flow contract: direct uniform
still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected
both the top-down vorticity and oblique body/Lambda2 rows in the combined sheets
for the highest-scoring capture (`solver_d32fb3a02de7`) and the informative
left-domain failure (`solver_1fbf1e40b119`), then cross-checked their summary,
trajectory, wake metrics, and diagnostics.

Both fish are self-propelled rather than advected. The capture advances directly
down-left behind a compact, body-connected alternating wake and retains discrete
three-dimensional Lambda2 structures through capture. It reaches `0.749982L` at
`15.983T` with low peak normalized planar force/moment near `0.0342/0.0173` and
without exceeding about `37.9 deg` joint angle. The failure initially generates
an organized wake and reaches `2.70327L`, but then curls away, pins both joints at
the `45 deg` bound, broadens the late wake, reaches peak normalized planar
force/moment near `0.713/0.300`, and exits left at `24.518T` with distance back at
`7.0563L`. Its missing capability is bounded target-course control, not thrust.

The prefilled policy is byte-identical to the best sampled capture and to a
second independent sampled evaluation (`solver_16135cb555bf`). The repeat also
captures, at `0.747234L` and `15.994T`, behind the same compact wake. This makes
the traveling-bend carrier, predicted-miss interception, carrier-separated yaw
handoff, and posterior phase-gated pulse the supported baseline. It does not
resolve the remaining geometry: both same-policy captures cross the lower-right
edge quickly, with head velocities about `(-1.052,-0.515)` and
`(-1.070,-0.490)L/T`. The sibling without the response/pulse composite also
captures with velocity `(-1.092,-0.408)L/T`, so the posterior pulse is not
isolated as the cause of success and scalar strengthening is unsupported.

The assigned parent proposed a transverse-course posterior residual and passed
dry schema, boundedness, reflection, and gate checks, but its worker timed out
before downstream CFD. That proposal is therefore inherited hypothesis, not
rollout evidence.

## Single candidate hypothesis

Preserve the prefilled policy's carrier and every far-field, predictive, mean-
curvature, and response-handoff path. Add exactly one mechanism: under the
ordinary near-target distance gate, blend a bounded sine of target-relative
body-frame course error into only the existing joint-speed-gated posterior
pulse. Unlike signed predicted miss, this dimensionless residual need not
contract merely because target distance contracts. It is zero outside the
terminal region, vanishes with the existing mid-stroke/closing gates, and does
not add carrier braking or persistent curvature.

Support requires another capture with a less tangential approach signature,
such as smaller target-normal velocity or a visibly more central crossing,
while preserving the roughly `16T` route, compact alternating wake, joint
reserve, and approximately `0.035/0.018` force/moment scale. Falsify on loss of
capture, lower-left escape, posterior pinning, greater rate/load occupancy,
far-field route change, wake degradation, or no terminal-geometry improvement.
The candidate's CFD evaluation occurs only after this worker exits, so no
outcome is claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and fish terminal-approach control
source_mechanism: preserve rhythmic propulsion while a bounded sensor residual reshapes posterior motion only during persistent target-relative transverse approach
transferable_invariant: keep an evidenced propulsive carrier intact and recruit a small observation-gated posterior correction only while measured approach misalignment persists
nontransferable_details: published gains, clock phase, robot linkage geometry, species-specific kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: blend the sine of body-frame target-versus-velocity course error into the existing near-target joint-speed-gated posterior target pulse
falsification: reject if capture and terminal course geometry fail to improve together or if wake coherence, far-field translation, joint reserve, loads, boundedness, or reflection symmetry degrade

## Dry validation only

The mandated guidance-materiality, lightweight Julia contract, deterministic
parameter-schema, and solver editable-boundary checks pass. A `19,440`-state
grid over target geometry, body-frame velocity, distance, both joint states,
and heading response produced finite commands strictly inside the smooth
`30 rad/T^2` envelope, with maximum magnitude `29.99804` and exact left/right
reflection error `0.0`. Disabling only the new residual changed a constructed
near-target posterior action by `0.020964 rad/T^2`; its effect at `12L` was
exactly `0.0`. These are algebraic contract and gate checks, not CFD evidence.
