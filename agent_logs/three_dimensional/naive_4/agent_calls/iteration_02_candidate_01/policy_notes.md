# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled evaluations and the assigned parent's inherited first-round
  optimizer logs use direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. All terminate
  `left_domain`; none is a numerical-instability failure or a success.
- The target-blind carrier creates real propulsion, not advection. Its
  top-down vorticity and oblique Lambda2 rows develop an alternating posterior
  wake, but it crosses the target centerline and exits the upper boundary at
  `8.547T` after improving distance only from `12.328L` to `12.078L`.
- The strongest finite sample, `solver_9391d49799dc`, leaves joint 1's carrier
  unshifted and biases only the posterior target. Its two visual rows retain a
  coherent, posterior-dominant alternating wake and about `1.92L` of leftward
  translation. It reaches `11.413L` at `9.29T`, but accumulated positive-y
  sway still carries the center through `y=15.200L` at `9.740T`; final distance
  is `11.421L` and body-frame bearing is about `-1.37 rad`.
- The prefilled common-curvature sample, `solver_835ca80b5e55`, is the most
  informative mechanism failure. Both visual rows show almost no organized
  wake through roughly `8T`, followed by a broad hooked trajectory rather than
  sustained travel. Centering joint 1 near the initial joint angle leaves both
  joint excursions below about `10 deg`, maximum force coefficient below
  `0.0028`, and distance nearly unchanged until the late hook; it exits at
  `13.288T` with minimum/final distances `12.286/13.411L`. The inherited
  common-bias sibling `solver_15c26ee8292f` repeats that topology with
  `12.296/13.495L` minimum/final distance and joint excursions below `8 deg`.
  In contrast, the two posterior-only variants retain the carrier and reach
  `12.091L` and `11.413L`. This is evidence against shifting the anterior
  oscillator equilibrium in this seed, not evidence for increasing its gains.
- The propulsive samples already touch the `260 deg/T` joint-rate limit and
  request accelerations beyond `1800 deg/T^2`; the strongest sample does so in
  about 70% of recorded rows. More scalar drive would worsen an existing
  limit-contact problem. Its local flow remains small (below about `0.028U`)
  compared with body speed (up to about `0.66U`), so no wake-advection
  correction is justified in this quiescent case.
- Both posterior-only policies map bearing to a same-sign posterior mean bend.
  Once bearing becomes negative, their cycle-mean posterior angles also become
  negative while negative yaw and upper-boundary sway continue. This does not
  prove a static input-output sign, but it supplies a concrete sign hypothesis
  to reverse and falsify rather than another same-sign gain trial.

## Single candidate hypothesis

Keep the seed's zero-centered joint-1 state oscillator and lagged posterior
traveling bend. Replace static mean-curvature steering with one state-phased
half-cycle-asymmetry mechanism: body-frame bearing plus a bounded short-window
bearing trend selects which half of the posterior carrier is emphasized. For
positive bearing, strengthen the negative posterior half-cycle; after the
bearing trend predicts a centerline crossing, strengthen the positive half.
This produces a target-dependent average turning effect without moving joint
1 near a low-energy equilibrium or retaining a constant tail offset between
beats. The returned accelerations and posterior target remain within explicit
bounds owned by `target_policy_params`.

Expected evidence is immediate preservation of the alternating wake, a joint-1
excursion comparable to the target-blind carrier, and a bearing reversal that
reduces positive-y sway after the first centerline crossing. Falsify the
candidate if it delays carrier growth like the common-bias pair, repeats the
negative-bearing/negative-yaw upper exit, increases joint limit residence, or
fails to beat the strongest sampled `11.413L` minimum distance or termination
class.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and classical posterior-emphasized fish propulsion
source_mechanism: target-driven half-cycle amplitude asymmetry superposed on a lagged posterior traveling bend
transferable_invariant: select and modestly strengthen one observed-state half-cycle to generate turning while preserving the oscillatory carrier and posterior thrust role
nontransferable_details: published gains, clocked CPG phase, duty ratios, species-specific kinematics, dimensional frequencies, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame bearing and its bounded observed trend to asymmetrically scale the positive and negative halves of the state-derived posterior target while leaving joint 1 zero-centered
falsification: reject if the alternating wake or anterior excursion collapses, actuator limiting grows, or negative bearing still develops into negative yaw and the same upper-boundary exit without better closest approach
