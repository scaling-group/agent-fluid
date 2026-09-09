# Multi-wake candidate diagnosis

## Evidence read before editing

- The four sampled solvers contain two duplicated successful policies. The
  assigned parent with bounded bearing-rate damping is the stronger distinct
  result: target capture at `149.605`, mean distance `4.358L`, mean command
  energy `647.93`, RMS relative crossflow `0.1321`, RMS lateral force `15.49`,
  and RMS yaw moment `308.48`. The otherwise identical undamped route request
  captures at essentially the same time (`149.572`) but has worse mean distance
  (`4.384L`), mean effort (`681.91`), crossflow (`0.1362`), force (`16.22`),
  and moment (`314.99`).
- The common prewarm sheet shows a developed, interacting four-street wake and
  the held fish well downstream and above the target. Both released sheets
  show self-propelled upstream motion on the same broad targetward arc, entry
  into the mixed wake, continued alternating bends, and capture from the right.
  The rate-damped path is better centered vertically but still has a broad
  initial redirect and visible late zig-zag; its unchanged arrival time shows
  that bearing-rate damping is a load/route-smoothing mechanism, not a faster
  propulsion mechanism.
- No sampled solver in this workspace is a failure, so no failure keyframe was
  available to inspect. The inherited evidence supplies the failure boundary:
  static-curvature variants loop or exit right, and a confounded faster-period,
  stronger/gated residual bundle exits the top after `126.43` with only
  `-1.12L` upstream progress. This candidate therefore preserves the successful
  zero-mean half-cycle route scaffold and changes only steering allocation.
- The best diagnostics show anterior acceleration already near its hard cap
  (`30.826` versus `31.416 rad/time^2`), while posterior acceleration remains
  lower (`25.524`), with joint excursions (`0.402/0.345 rad`) well inside the
  `0.785 rad` angle limit. More anterior authority is not a credible next step;
  the posterior joint has the clearer actuation margin.

## Policy hypothesis

Retain the assigned parent's state-inferred oscillator phase, body-frame
bearing and bearing-rate route request, small normalized moment residual, and
posterior lag. Add one mechanism: apply a small copy of the bounded,
target-relative half-cycle envelope to the posterior traveling-wave target.
This should distribute turning through the body wave, tighten the broad redirect
and reduce arrival/distance integral without increasing the nearly saturated
anterior request. It remains zero-mean when aligned and does not prescribe a
world route or vortex phase.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping plus Lighthill-style posterior reactive-wave emphasis
source_mechanism: distribute target-directed half-cycle asymmetry into the posterior traveling bend instead of steering only at the anterior oscillator
transferable_invariant: a lagged posterior wave with bounded side-dependent strength can share turning while preserving alternating propulsion and zero steering bias at zero target error
nontransferable_details: published gains, species envelopes, dimensional frequencies, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: multiply the lagged second-joint target by a small envelope built only from bounded body-frame turn request and joint-state beat side; retain the existing two-joint state-feedback scaffold
falsification: reject if capture or roughly `-10.93L` upstream translation is lost, the path returns to loop/domain-exit topology, tail acceleration approaches the cap without earlier capture, or distance/load/effort metrics worsen

The new CFD rollout is not available to this worker. Later workers should test
the mechanism against target capture, release time, mean distance, upstream
translation, both acceleration peaks, and force/moment/effort—not infer success
from the code change itself.

## Static validation

- The prescribed Julia contract and parameter-schema check passes.
- The editable-boundary check passes; no solver file outside
  `candidate_target_policy.jl` changed.
- A non-CFD grid probe over 2,187 representative finite joint, bearing,
  bearing-rate, and moment states produced finite actions. The posterior
  multiplier is algebraically bounded to `[0.88, 1.12]`; episode safety limits
  remain the final acceleration envelope.
