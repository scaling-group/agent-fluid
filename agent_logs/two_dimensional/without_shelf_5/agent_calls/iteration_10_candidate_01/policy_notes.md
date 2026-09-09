# Wake-policy candidate diagnosis

## Evidence read before policy editing

- The shared prewarm sheets are byte-identical across all four sampled solvers.
  They show the fish held above and downstream of the staggered cylinders while
  the four interacting vortex streets develop, so release-state differences do
  not explain candidate ordering.
- The two fraction-`0.35` samples have byte-identical released keyframes and
  metrics. They visibly self-propel diagonally upstream and downward, enter the
  developed wake corridor, turn toward the target without collision or domain
  exit, and first cross the target circle at release time `38.362`. Their mean
  distance is `1.812L`; mean body speed components are `-0.2829/-0.1181`; RMS
  relative crossflow is `0.2244`; force/moment RMS are `40.73/637.79`; command
  energy and power proxy are `53487.3/4007.1`; and joint peaks are
  `0.494/0.521` rad. Both joints still touch the rate and acceleration caps.
- The two fraction-`0.30` samples are also exact repeats and preserve the same
  successful route topology, but the keyframes show a slightly flatter,
  slower target approach. Metrics confirm that this is not a favorable visual
  trade: arrival slows to `39.286`, mean distance rises to `1.850L`, mean speed
  weakens to `-0.2764/-0.1132`, RMS relative crossflow rises to `0.2447`,
  force/moment RMS rise to `42.06/662.67`, command energy and power proxy rise
  to `56145.5/4263.2`, and joint peaks rise to `0.512/0.583` rad.
- The assigned-parent logs bound the allocation trend on the other side. With
  the same gain-`1.7` gait, fraction `0.40` reached at `39.710` with mean
  distance `1.874L`, whereas `0.45` slowed sharply to `43.323/2.025L` and
  increased crossflow, force/moment, energy, and both joint peaks. Thus the
  combined `0.30`, `0.35`, `0.40`, and `0.45` evidence is non-monotonic and
  identifies `0.35`, not a direction for extrapolation, as the measured
  interior anchor for this certified wake phase.
- No sampled solver is a semantic failure: all four reach the target. The most
  informative contrast available in current visual evidence is therefore the
  lower-performing finite fraction-`0.30` pair. Inherited guidance separately
  reports target-blind domain escape and an unstable mixed-feedback controller,
  but this workspace contains no failure keyframe sheet to support a new visual
  diagnosis of either failure.

## Policy hypothesis

Change only `anterior_steering_fraction` from the prefilled `0.30` to `0.35`.
Retain the measured gain `1.7`, 12-degree steering bound, `0.55`-period
28-degree oscillator, and posterior lag/damping. This isolates allocation and
materializes the strongest already-observed finite controller rather than
extrapolating past the interior optimum or adding an unscaled wake signal. The
falsifiable expectation for the post-worker CFD evaluation is target capture
near the replicated `38.362` release time, mean distance near `1.812L`, joint
peaks near `0.494/0.521` rad, and no material increase beyond the recorded
crossflow/load/effort envelope. A miss or material departure from those values
would invalidate repeatability for the common certified initial condition;
none of this evidence establishes robustness to a different wake phase,
geometry, inflow, or start pose.
