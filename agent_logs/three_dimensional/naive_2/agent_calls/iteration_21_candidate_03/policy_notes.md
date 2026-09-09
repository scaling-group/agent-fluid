# Wake-policy candidate diagnosis

## Evidence read before the edit

- All four sampled evaluations report `uniform_direct`, zero background
  velocity, no cylinders, and capture at `15.983--16.044 T`. The combined
  sheets show the same targetward topology: a compact alternating top-down
  vorticity wake and paired oblique Lambda2 structures trail a self-propelled
  fish. There is no visible wake breakup, collision, passive advection, or
  numerical instability before capture.
- The ungated posterior-pulse policy captured in three sampled executions;
  the assigned response-released parent captured at `16.016 T`. Across the
  four samples, maximum planar force/moment remained
  `0.0332--0.0367 / 0.0166--0.0185`, joint angles stayed below `37.9 deg`, and
  the rate envelope was occupied near its limit for about `29.3--29.6%` of
  logged steps. This is evidence to preserve the traveling-bend carrier and
  predicted-miss route rather than tune propulsion or apply broad braking.
- The parent and its three close replicates are visibly almost
  indistinguishable, but their raw constant-course prediction is strongly
  beat-phase dependent. At about `4L` range the instantaneous predicted miss
  varies from `1.41L` to `2.41L`; at about `2L` it varies from `-0.37L` to
  `-0.17L`. At about `1L`, all executions have a large `0.93--0.96L`
  instantaneous miss and `1.20--1.29 rad` course error even though they cross
  the capture boundary one beat fraction later.
- A body-frame least-squares audit of every sampled trajectory after `2T`
  finds that `-0.13*phi_dot[1] + 0.0685*phi_dot[2]` explains `92.1--92.5%`
  of far-field lateral-velocity variance. Subtracting that carrier component
  reduces the sampled `4L` miss magnitude to `0.26--0.67L` while leaving the
  streamwise course untouched. This stable relation across all four results
  is stronger evidence than any one threshold-level capture.
- No sampled visual rollout is a failure. The inherited optimizer logs supply
  the informative failure class instead: related approaches missed at
  `0.810L`, `0.963L`, `1.012L`, and `1.216L`, then exited left. The failure
  evidence is scalar-only, so it supports the need for capture margin but no
  claim about its unseen wake appearance.

## Candidate hypothesis

Preserve the parent's far-field pursuit/course steering, full oscillator,
response-released posterior pulse, and all carrier gains. Add one mechanism:
a joint-state estimate of beat-induced body-frame sway used only by the
constant-course terminal predictor. The predictor will subtract the evidenced
carrier sway before computing time-to-closest, alignment, and signed miss;
ordinary navigation will continue to use measured velocity. This should stop
the terminal handoff from treating productive beat-scale lateral motion as a
persistent route miss, recruit curvature from the slower course residual, and
retain the established wake and translation.

Falsify this candidate if it loses capture, changes the direct trajectory or
compact wake class, increases loads/limit occupancy, or fails to improve
repeat capture margin under perturbed/reflected evaluation. A nominal capture
alone cannot establish improvement because the parent already captures.

An offline counterfactual command replay on the four saved trajectories (not
a CFD evaluation) confirms the intended scope. Relative to the assigned
parent, mean two-joint acceleration-vector change is only `0.092--0.103` for
samples above `5L`, rises to `2.44--2.58` through the `3--5L` prediction
handoff, and falls to `0.84--0.90` below `3L`. Thus the edit mainly reallocates
interception authority where the raw miss estimate was phase-contaminated; it
does not establish a hydrodynamic outcome for the new candidate.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and wake-disturbance residual control
source_mechanism: separate the rhythmic locomotor carrier from slower sensor-feedback navigation before modulating the CPG
transferable_invariant: navigation feedback should respond to residual course motion, not a predictable lateral component phase-locked to the propulsive joint state
nontransferable_details: published CPG gains, robot geometry, species kinematics, exact vortex phase, dimensional frequency, and task routes
policy_translation: subtract an evidence-fitted bounded linear two-joint-rate sway estimate from normalized body-frame lateral velocity only inside the terminal constant-course predictor
falsification: reject if capture/closest approach, termination, wake coherence, rate occupancy, or planar loads worsen together, or if held-out carrier/geometry data do not preserve the joint-rate-to-sway relation
