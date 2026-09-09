# Whole-body course-bend candidate

## Evidence read before the policy edit

- Every sampled observation confirms direct uniform still-water initialization
  (`U_infinity=(0,0,0)`), no cylinders, finite dynamics, and `left_domain`
  termination. Displacement and wake formation are therefore self-generated,
  not imposed advection or a prewarm artifact.
- The combined top-down vorticity and oblique Lambda2 sheet for the strongest
  score, `solver_adc862529891`, shows a coherent alternating wake and genuine
  propulsion to the target's x station, but the fish rises to the upper exit at
  center `(9.451,15.202)L`. Metrics agree: `min=5.658L`, `final=5.843L`, and
  local head flow near exit is only about `0.03U`. This is a route-control
  failure, not weak thrust or wake advection.
- The informative long failure `solver_b22e8cf1f277` retains similarly coherent
  2D/3D wake structure, reaches the best sampled distance (`4.158L` at
  `19.77T`, center y `13.726L`), then continues past the target and exits left
  at `(0.798,12.202)L` with `9.037L` final range. Its posterior-only slip/yaw
  controller therefore changes lateral topology without achieving capture.
- The assigned prefill `solver_7108cd3d3374` tests low-speed-gated course
  feedback through the same posterior mean-curvature/yaw-residual actuator. It
  materially suppresses the earlier upper excursion: center y stays within
  `13.730--14.017L` and minimum distance improves over the strongest-score
  sample to `4.358L`. However, it retains a coherent wake while exiting left at
  `(0.795,13.873)L`, with `9.767L` final range and about `0.925 rad` body-route
  error. The course signal changed useful trajectory semantics, but posterior
  mean curvature did not supply the slow corrective yaw it continued to ask
  for.
- `solver_97bc3c03d55b` supplies the complementary early upper exit
  (`min=9.175L`), while inherited logs show that a `5%` target-gated posterior
  half-cycle imbalance also regressed to `12.054L` and a `-14.755` score. Thus
  neither another recoil coefficient, posterior static-bend gain, nor
  posterior half-cycle scaling is the supported next test.
- All four strong-carrier samples repeatedly exceed the raw acceleration
  envelope before runtime clamping, including `2534/4543` anterior and
  `3179/4543` posterior samples for the course-feedback prefill. This candidate
  must not claim effort improvement; its bounded mean shifts are instead kept
  within nominal joint-angle headroom and are falsified by worse saturation,
  loss of the alternating wake, or another unchanged boundary exit.

## Policy hypothesis recorded before editing

Preserve the evidenced `28 degree`, `0.55T` joint-state traveling-wave carrier
and the assigned parent's normalized target-course minus low-speed-gated
velocity-course signal. Remove the instantaneous phase-conditioned yaw loop,
which converts the slow course request back into beat-varying posterior bias.
Use the course request to shift both joint equilibria by small bounded shares:
recenter the anterior state-feedback oscillator on a target-driven mean bend,
and center the posterior lagged wave on a compatible posterior mean bend. This
tests whole-body curvature as one new steering actuator while leaving carrier
frequency, amplitude, lag, and damping unchanged.

Expected evidence is a coherent alternating wake plus a slow turn toward the
target whenever course error persists, especially after the prefill's route
error reverses, instead of nearly horizontal translation to the left boundary.
Falsify the mechanism if target reflection does not reverse both mean bends,
nominal joint peaks approach the `45 degree` limit, wake/translation weakens,
command clipping materially worsens, or the rollout fails to beat `4.158L`
while repeating an upper, lower, or left-exit topology.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG direction tracking and mean-curvature turning
source_mechanism: preserve a propulsive rhythm while a bounded sensory direction error shifts the mean body bend across more than the terminal joint
transferable_invariant: a persistent body-frame course error may modulate the mean equilibrium of a rhythmic gait, but the modulation must reverse with target side and vanish at course alignment while the traveling wave remains intact
nontransferable_details: published gains, dimensional beat rates, robot linkage geometry, species kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: form target and motion course only from normalized body-frame observations, suppress motion-course authority near rest, and map their bounded difference to small anterior and posterior equilibrium shifts in the two-joint state-feedback contract
falsification: reject if the course error remains large without slow yaw, reflection does not reverse the response, nominal angle headroom is lost, the coherent wake weakens, clipping worsens, or no closest-approach/topology improvement occurs
