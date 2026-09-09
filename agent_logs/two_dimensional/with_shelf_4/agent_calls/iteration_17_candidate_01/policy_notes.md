# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed staggered-cylinder streets. The streets merge around the
  target before release, so their phase and geometry are common initial-
  condition evidence rather than a transferable route or timing signal.
- Every sampled rollout reaches the target through active upstream swimming
  with the alternating posterior-lagged bend intact; no semantic failure was
  sampled. The prefilled both-joint previous-action response is the fastest at
  `130.729` released units and `3.754L` mean distance, but its sheet shows
  sharp midcourse heading reversals. It also has the highest sampled command
  energy (`115750`), reaches the anterior acceleration cap, and raises RMS
  relative crossflow/force/moment to `0.1543/18.30/359.97` from the inherited
  direct-action scaffold's `0.1296/14.75/303.02`. Its `-10.922L` upstream head
  displacement against `-0.0659` mean local streamwise flow confirms that the
  result is self-propelled rather than passive advection.
- Applying the same response only to the anterior joint gives the strongest
  sampled score and mean distance: capture at `135.019`, `3.685L` mean
  distance, and `110448` total command energy. Direct posterior tracking lowers
  posterior angle and velocity peaks relative to the both-joint filter, but
  RMS force/moment remain high at `18.53/362.61`. Thus joint placement changes
  the useful trajectory, but neither filtered variant validates the inherited
  claim that the response is an effort or load smoother.
- The assigned-parent course-alignment branch is the informative low-load
  contrast. Its sheet retains a smoother broad redirect and capture at
  `137.247`, with `4.077L` mean distance, `91401` energy, and
  `0.1336/14.91/306.50` RMS crossflow/force/moment. It does not recover the
  filtered variants' distance topology. Deeper inherited failures already
  reject unconditioned flow/target residuals, bearing smoothing, posterior
  route sharing, and tail-lag relief, so the present test preserves route,
  wake rejection, and the raw traveling-wave equations.

## Policy hypothesis

Retain the prefilled body-frame bearing route loop, closing-qualified bearing-
rate damping, direct bounded moment residual, state-inferred half-cycle
steering, regulated oscillator, posterior lag, and short two-joint action
response. Make one mechanism change at the actuator interface: measure the
instantaneous normalized joint power added by action history relative to each
raw state-feedback acceleration. Use the response when that lag is neutral or
removes kinetic energy, but continuously bypass it when the lag would keep
adding kinetic energy after the raw oscillator requests less drive. This
preserves action continuity without allowing phase lag to postpone braking and
inflate the traveling bend.

The formal expectation is preserved capture, upstream translation, and the
fast filtered trajectory, with lower bend/acceleration peaks, command effort,
and force/moment load. Falsify the mechanism if capture is lost or delayed
beyond the sampled `135.019` anterior-only response, mean distance regresses
beyond `3.754L`, alternating propulsion or upstream displacement weakens, or
effort/load and actuator-cap contact do not fall materially below the
both-joint response. CFD evaluation occurs only after this worker exits, so
these are testable expectations rather than claims about this candidate.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated robotic-fish CPG actuator control
source_mechanism: preserve a coherent traveling wave while shaping actuator commands without allowing command lag to reinforce the wrong energetic phase
transferable_invariant: stateful actuator continuity should not add joint kinetic energy when the current rhythmic state feedback is already requesting less drive
nontransferable_details: published gains, servo time constants, species-specific kinematics, dimensional beat settings, exact vortex phase, cylinder layout, and task-specific routes
policy_translation: retain normalized body-frame route and load feedback plus the two-joint traveling bend, then blend each previous-action response back to its raw acceleration according to normalized signed joint power added by the lag
falsification: reject if capture, upstream translation, or alternating propulsion is lost, if arrival or mean distance regresses beyond the sampled filtered variants, or if effort, load, bend peaks, and actuator-cap contact do not improve together
