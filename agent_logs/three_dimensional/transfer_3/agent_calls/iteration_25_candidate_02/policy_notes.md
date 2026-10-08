# Posterior phase-space-conditioned outer limiter coupling

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. The
  assigned parent is the new posterior-position-response limiter. It captures
  at `20.096998 T`, scores `-0.2975685868`, and has mean/final distance
  `2.188311614 L`/`0.747254848 L`, improving materially on two exactly
  reproduced direction-conditioned-limiter samples at `21.912008 T`,
  `-0.3246592933`, and `2.218947189 L`. The target-residual allocator also
  captures but is slower at `21.735992 T` and worse in score/mean distance
  (`-0.3012661700`, `2.194857233 L`) than the assigned parent. Thus retain the
  parent's combined carrier/turn command geometry and its posterior-response
  mechanism rather than substituting drive-first residual allocation.
- I inspected the complete combined keyframe sheets for the assigned parent,
  the target-residual sibling, and both byte-identical older-limiter samples,
  including the top-down mid-plane-vorticity and oblique body/Lambda2 rows
  from uniform release through capture. All fish self-propel rather than
  advect, follow compact target-directed arcs, form coherent alternating
  posterior wakes, and retain finite localized three-dimensional structures.
  There is no visible collision, boundary-exit precursor, loop, wake collapse,
  or out-of-plane instability. The assigned parent carries visibly stronger
  undulation to capture; the two older samples and target-residual sibling
  finish in a quiet held bend. Because no sampled rollout has a failure
  termination, the older limiter is the informative semantic failure: it
  lacks the newly validated response mechanism and reaches the same capture
  class about `1.815 T` later.
- Telemetry confirms that the parent's improvement is a different useful
  trajectory, not a cosmetic score change. It crosses `4/3/2/1 L` at about
  `15.873/17.116/18.398/19.728 T`, versus
  `16.110/18.012/19.789/21.472 T` for the reproduced older limiter, while
  retaining speed near `0.84 L/T` at `4 L` instead of `0.70 L/T`. The cost is
  unresolved phase-space carryover: below `4 L` the parent has `331/418`
  exact anterior/posterior acceleration-cap samples, `124/93` samples above
  `4.4 rad/T`, terminal force/moment maxima about `0.02566/0.01348`, and
  captures at joint rates `4.121/-3.221 rad/T` and yaw rate
  `-1.637 rad/T`. The reproduced older limiter has no terminal acceleration
  cap, only `13/0` high-rate samples, force/moment maxima
  `0.01271/0.00713`, and essentially settled joints at capture. These loads
  are downstream state consequences even though the parent's new limiter
  algebra is exactly dormant at and below `4 L`; identical-state terminal
  checks alone cannot establish rollout noninterference.
- The inherited rate-headroom attenuation is a complementary negative result:
  lowering commands solely when a joint rate was large delayed capture and
  did not remove rate contact. The next test therefore must not damp cadence,
  unload the mean bend, split joint roles, or treat saturation counts as its
  objective. The evidence instead supports refining the successful posterior
  tracking signal with an independently normalized coordination error.

## Policy hypothesis

Preserve the assigned parent's normalized body-frame guidance, state-feedback
oscillator, target-angle redirect, posterior lag target, combined raw-command
limiter, closure-previewed shared terminal bend, crossflow/intercept support,
paired terminal release, and position-error-conditioned common scaling. Add
one small outer-only phase-space contribution to that same limiter. Under a
locally constant slow equilibrium and cadence, the derivative of the existing
posterior lag target is the anterior joint's negative velocity plus the
lag-weighted anterior displacement term. Compare this state-derived target
velocity with observed posterior velocity and normalize the residual by
`drive_amplitude * omega`. Permit at most two additional percentage points of
common-scale blending only when clipping rotates the two-joint command and
both the already validated posterior position error and this new velocity
error are supported.

This tests whether limiting that preserves the requested traveling bend in
both position and velocity can keep the parent's faster target trajectory
while avoiding unstructured phase error; it is not a scalar-only increase and
does not attenuate commands merely because a rate is large. The existing
normalized distance gate makes the contribution exactly zero at and below
`4 L`; there is no clock, route, target identity, world coordinate, force
cancellation, cadence change, mean-curvature change, beat-side selector, or
terminal-algebra change. Falsify it in non-CFD checks on any terminal command
interference, nonfinite/over-limit output, broken reflection symmetry, or
dormant outer phase support. Later CFD should reject it on delayed or lost
capture, worse mean distance, changed compact path, loss of coherent wake,
greater cap/stop dwell or loads, instability, or failure to reduce the
parent's high-energy terminal carryover.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body propulsion together with sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: maintain a directed anterior-to-posterior bend while feedback corrects departure of the posterior oscillator from its commanded phase-space response
transferable_invariant: bounded joint coordination should respond to normalized posterior position and velocity mismatch together, because a traveling bend is a phase-space relation rather than an angle target alone
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, full-body waves, exact phase lags, actuator models, vortex phases, capture geometry, and task-specific routes
policy_translation: derive a posterior target velocity from the existing state-feedback lag target, normalize its residual by amplitude times instantaneous oscillator frequency, and gate one bounded outer common-scale contribution by velocity support, the validated position-error support, and clipping-direction distortion
falsification: reject on terminal-command interference, dormant or excessive outer activation, slower or lost capture, worse distance integral, changed path or mean bend, increased stop dwell or loads, instability, or degraded top-down or oblique wake coherence

The new candidate's CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.

## Non-CFD implementation audit

- The public Julia contract loads and returns two finite accelerations inside
  the declared command envelope. All `87` direct `params.FIELD` references
  resolve in the object returned by `target_policy_params()`; the version
  label is the only intentionally unused field.
- Comparing the candidate with the sampled parent on a `98,304`-state grid
  gives bit-identical commands for all `49,152` states at or below `4 L`. The
  phase-space contribution changes `32,180/49,152` outer states, with maximum
  sampled command difference `0.51609 rad/T^2`; all outputs remain finite and
  bounded. Direct limiter probes reach the intended `0.23` maximum blend and
  confirm sign-reflection symmetry. These checks establish implementation
  activity, boundedness, and identical-state terminal dormancy, not a CFD
  improvement or downstream terminal-state invariance.
- The material-guidance check and solver edit-boundary check pass. The rendered
  root `README.md` initially marked the same assigned parent twice; removing
  only that duplicate marker repaired parent resolution. The prescribed
  check-runner was invoked, but its pinned `gpt-5.4-mini` model is unsupported
  on this ChatGPT account and failed before executing a command. Its three
  configured non-CFD checks were therefore run directly and separately; all
  pass. No formal CFD was run in this workspace.
