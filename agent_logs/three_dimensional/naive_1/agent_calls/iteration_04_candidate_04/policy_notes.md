# Candidate wake-policy notes

## Evidence diagnosis

- All four sampled rollouts satisfy direct uniform quiescent initialization
  (`U_infinity=[0,0,0]`) and terminate by leaving the upper virtual-domain
  boundary, not by instability or capture.
- The naive drive-only seed forms a visible alternating posterior wake in both
  the top-down vorticity and oblique Lambda2 views, so the primary deficit is
  directional control rather than failure to self-propel. It reaches only
  `12.078L`, ends at `12.380L`, and exits at `8.55T`.
- Anterior useful-half-cycle steering preserves that wake and improves the
  minimum/final distance to `11.782/11.797L`. Adding a large-error posterior
  redirect does not change the failure topology and regresses to
  `11.838/12.054L`.
- The assigned prefill's slip-damped signed anterior rectification is the
  strongest finite sample: it produces the longest coherent staggered wake,
  moves leftward from `x=21.0L` to `17.55L`, and improves distance monotonically
  to `10.062L` by `11.20T`. This is useful propulsion/progress evidence, but it
  still drifts from `y=14.0L` to `15.20L` and exits high while the body-frame
  bearing has reversed from about `+0.16 rad` initially to about `-1.0 rad`.
- In the strong sample, two-second window means after the bearing reversal
  show joint 1 acquiring negative mean bend while joint 2 acquires a larger
  opposite positive mean (`q1/q2` about `-0.081/+0.122 rad` near exit). Both
  joints reach the `260 deg/T` rate cap in every sample. The existing
  rectification therefore improves forward progress but passes its steering
  offset through the `-q1` posterior target as an opposite-mean S-bend; it does
  not establish target-directed yaw.
- The assigned-parent artifact contains inherited logs from four first-step
  mean-curvature variants. Shared joint-center biases, a smaller same-sign tail
  share, and a common phase-blind acceleration residual all preserved some
  oscillation but regressed final distance to `13.258--15.361L`; every one
  retained `left_domain`, and three exited high. Those logs falsify retrying a
  shared or tail-biased moving equilibrium by gain changes alone. Later
  inherited logs identify anterior useful-half-cycle steering as preferable to
  posterior-only or shared residuals and call for a slower target-motion signal
  or opposing-stroke braking. The prefill supplies the subsequent evidence that
  slip-aware opposing-stroke braking is useful but still directionally
  incomplete.

## Policy hypothesis

Use one bounded mean-curvature mechanism only on the anterior joint. Preserve
the prefill's period, amplitude, Van der Pol carrier, posterior phase lag,
damping, and slip-aware route signal. Replace signed acceleration
rectification with an explicit anterior oscillator center. Unlike the four
falsified first-step variants, do not share any steering mean with the tail.
Form the posterior traveling-wave target from the anterior deviation about
that center, rather than from the full joint angle, so target steering also
does not impose the prefill's equal-and-opposite posterior mean.

The falsifiable expectation is a changed trajectory topology: after the
body-frame bearing reverses sign, the anterior mean bend should create
corrective yaw while the posterior joint continues a zero-mean lagged carrier.
The candidate should retain a coherent alternating wake and leftward distance
progress but avoid or materially delay the common upper-boundary exit. Reject
the mechanism if the posterior wake collapses, the rate-limited fraction or
load spikes worsen, minimum distance fails to match the `10.062L` prefill, or
the same high-exit topology survives without sustained bearing correction.

bookshelf_consulted: true
source_domain: robotic-fish and biological turning by target-modulated mean curvature layered on an undulatory carrier
source_mechanism: bounded anterior mean-curvature bias while retaining a zero-mean traveling posterior wave
transferable_invariant: separate slow target-directed mean bend from the zero-mean propulsive oscillation
nontransferable_details: published gains, dimensional beat frequency, species-specific joint envelopes, exact vortex phase, and task-specific routes
policy_translation: map slip-corrected body-frame bearing to a bounded anterior oscillator center and construct the posterior lag from the centered anterior carrier
falsification: reject if the alternating 3D wake or current distance gain is lost, saturation/load behavior worsens, or the fish still exits high without sustained bearing reduction
