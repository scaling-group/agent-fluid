# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled solver evaluations satisfy the frozen evidence contract:
direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
cylinders or prewarm, finite moving-window transport, and `capture`. I
inspected every combined keyframe sheet, including its top-down vorticity and
oblique body/Lambda2 rows, and compared the best-scored capture with the
assigned parent's completed line-of-sight-course failure. I cross-checked the
views against `wake_observation.md`, `wake_metrics.csv`, `trajectory.csv`,
`wake_diagnostics.json`, controller sources, parent guidance, and inherited
optimization notes.

The four sampled captures are one repeated physical family. From release to
first crossing, each fish self-propels along the same broad redirect, retains
a coherent alternating top-down street, and sheds compact finite 3D caudal
structures. The unmodified target-lateral redirect captures at `19.228T` and
mean distance `2.1185L`; its policy-projected form captures at `19.135T` and
`2.1220L`. The raw body-lateral terminal lead captures at `19.129T` and
`2.1245L`, while its projected form captures at `19.140T` and `2.1277L`.
These arrival, distance, force, moment, and visible-wake differences overlap
repeat variability, so the lateral lead is not a demonstrated improvement.
Final acceleration projection does establish the narrower interface result:
it bounds public commands at `31.416 rad/T^2` while preserving the captured
route, but leaves joint-rate contact near `10.8%/14.5%`.

The assigned parent's next target-line residual is the informative failure.
It replaced raw lateral speed with
`target_x_fraction * velocity_y - target_y_fraction * velocity_x`, added the
bounded result to steering magnitude only inside `2.5L`, and retained target
side as steering sign. Despite passing finite-state and symmetry sweeps, it
missed the capture circle at `0.9490L` near `20.014T`, with the head about
`0.90L` above the target, then continued left to domain exit at `32.065T` and
`8.7907L` final distance. Its top-down sheet keeps energetic alternating
shedding and its oblique sheet keeps finite caudal Lambda2 structures while
the trajectory passes above and leaves the target. The failure is therefore
terminal route geometry, not advection, wake collapse, initialization, or
numerical instability. Geometric normalization alone does not make a terminal
velocity residual compatible with this carrier's first-crossing trajectory.

## Single-candidate policy hypothesis

Remove the prefilled raw body-lateral terminal lead and do not inherit the
falsified line-of-sight residual. Preserve the sampled normalized lateral
target request, one-sided recent-yaw release, opposite-sign anterior/posterior
mean curvature, Van der Pol joint-state carrier, and lagged posterior target.
Add only the completed-command projection already validated by a captured
sample. This is a recovery ablation to the smallest replicated capture
architecture with explicit public-envelope ownership.

Expected result: reproduce capture and both coherent wake views inside the
observed `19.13--19.32T` repeat band while returning no acceleration outside
`1800 deg/T^2`. Falsify the recovery if capture is lost, the high pass or
lower-exit topology returns, mean distance or arrival leaves repeat
variability, wake coherence or loads worsen materially, or either returned
command exceeds the owned envelope. Unchanged joint-rate contact is expected;
the projection is not claimed as actuator relief.

bookshelf_consulted: true
source_domain: classical traveling-bend propulsion and sensor-feedback robotic-fish direction tracking under actuator limits
source_mechanism: preserve a low-dimensional joint-state rhythm with posterior lag while persistent body-frame target side modulates bounded mean curvature and completed commands respect the actuator envelope
transferable_invariant: carrier phase and posterior emphasis should remain separate from route feedback; target geometry owns steering sign, and a command projection removes only demand the plant cannot apply
nontransferable_details: published gains, dimensional frequencies, motor models, species-specific kinematics, full-body waveforms, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: retain the sampled target-lateral differential-curvature controller and joint-state carrier, remove unevidenced terminal velocity modulation, and clamp only the two completed accelerations at the policy-owned episode limit
falsification: reject if output bounds fail, capture or coherent wake is lost, boundary-exit topology returns, or trajectory and load histories leave the successful repeat band
