# Wake-policy candidate diagnosis

## Evidence read before editing

- The four sampled rollouts, the assigned parent's completed step-11 rollout,
  and the other inherited step-11 log all report direct uniform still-water
  initialization with `U_infinity=[0,0,0]`, no cylinders, and no prewarm.
  Their translation and wakes are therefore self-propelled rather than
  ambient advection or reused-flow artifacts.
- Both rows of the combined sheets were inspected for the sampled `0.7493L`
  capture, the prefilled opposing-carrier failure, and the assigned parent's
  half-cycle-steering failure. The capture carries a coherent alternating
  top-down street and compact oblique Lambda2 structures through its
  `18.6065T` crossing. The assigned-parent failure also retains a substantial
  alternating wake through its pass and afterward, so its `1.7456L` miss is a
  steering-realization regression rather than a loss of propulsion. The
  prefilled policy instead stops laying down a substantial new terminal wake
  after its `1.2669L` pass and coasts into the same lower exit.
- The sampled capture remains a fragile positive mechanism demonstration: the
  same LOS-guarded policy bytes later missed at `1.7715L`. The inherited
  projected-intercept guard improved that repeat topology to `1.0509L` while
  preserving about `0.866L/T` speed and a coherent wake, so the candidate
  restores that controller rather than the prefilled carrier attenuation.
- The intercept-guard trace already had a saturated correct-sign route request
  near closest approach and action clipping on about `70.4%/69.7%` of rows.
  The assigned parent's half-cycle steering then worsened the closest pass to
  `1.7456L`, kept clipping at about `70.2%/72.3%`, and reached the exact
  `260 deg/T` joint-speed bound. A separately inherited posterior phase-lag
  transfer also missed at `1.6818L`. Together these results reject another
  half-cycle weight, phase-lag transfer, tighter intercept corridor, route-gain
  increase, or scalar cadence change.
- Across the sampled capture, prefilled miss, and assigned-parent miss, both
  joints reach the identical `4.537856 rad/T` speed ceiling. The capture and
  assigned-parent action histories also spend roughly seventy percent of rows
  at the acceleration envelope. This supports testing whether outward carrier
  effort that remains saturated near the speed ceiling is wasted authority,
  while the prefilled terminal collapse warns against attenuation based only
  on distance, turn sign, or beat side.

## Candidate mechanism and falsification

Start from the evaluated projected-intercept-guarded achieved-course policy.
Preserve its body-frame course error, phase-compensated yaw/LOS release,
projected-pass veto, cadence, traveling-bend target, and additive steering.
Add one terminal actuator-reserve mechanism. For each joint independently,
form continuous gates from normalized joint-speed magnitude, normalized
previous applied-acceleration magnitude, and their signed product. Inside the
existing terminal range, soften only the carrier component when the previous
action was near saturation and accelerated the joint outward near its speed
limit. Never soften restoring carrier acceleration or the additive steering
residual. This is state-conditioned anti-windup/wave shaping, not a lower
cadence, a larger steering gain, or carrier shutdown.

Expected test: retain the inherited far-field trajectory and alternating 3D
wake, reduce exact speed-limit residence and acceleration clipping near the
target, and let the existing saturated intercept correction act without
coasting. A capture or a pass below `1.0509L` with no load increase supports
the mechanism; one capture remains provisional until repeated.

Falsification: reject the reserve gate if it changes closure outside the
terminal range, weakens the alternating wake, repeats the prefilled carrier
collapse, fails to improve the `1.0509L` pass, retains the same lower-exit
topology without a useful trajectory change, increases force/moment peaks, or
does not materially reduce speed/envelope saturation. Then later workers
should avoid further carrier modulation and test a separately normalized
yaw/slip residual or a different joint-space steering allocation.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and reactive traveling-wave swimming
source_mechanism: preserve a rhythmic posterior-lagged carrier while state feedback modulates only actuation that is unusable at a measured envelope boundary
transferable_invariant: locomotor feedback should retain the traveling bend and reserve bounded authority by withdrawing only outward saturated effort, not by suppressing the rhythm globally
nontransferable_details: published CPG gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, exact vortex phases, and task-specific routes
policy_translation: use normalized joint speed and previous acceleration in the terminal body-frame intercept regime to soften only outward carrier acceleration while leaving restoring carrier and two-joint steering intact
falsification: reject if far-field closure changes, terminal wake production falls, the sub-1.0509L pass or termination class does not improve, speed and action saturation remain unchanged, or loads rise

## Non-CFD verification

- The designated guidance/provenance check, deterministic Julia two-joint
  contract, parameter-schema guard, and solver editable-boundary check pass.
- Synthetic lateral reflection negates both returned accelerations with zero
  residual. The reserve scale is exactly `1.0` outside the terminal gate,
  remains above `0.9999999` for restoring carrier acceleration at the tested
  envelope state, and falls to about `0.45` only for the matched near-limit,
  previously saturated outward condition.
- A recorded-trace projection (not a CFD prediction) activates relief on
  `199/3312` terminal joint rows of the inherited `1.0509L` intercept rollout
  and `111/1510` terminal joint rows of the sampled capture. Mean carrier
  scales remain about `0.9920` and `0.9889`, respectively. This confirms that
  the mechanism is sparse rather than distance-only carrier suppression; the
  next evaluation must determine its closed-loop hydrodynamic effect.
